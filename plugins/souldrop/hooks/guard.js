#!/usr/bin/env node
// SoulDrop safety net — PreToolUse hook on the Bash and PowerShell tools.
// (On Windows, Claude Code may route shell commands through its PowerShell
// tool instead of Bash, so hooks.json matches "Bash|PowerShell".)
// Blocks a SHORT list of obviously catastrophic commands so a beginner's
// assistant can never wipe their machine, and asks first on `git reset --hard`.
//
// Design rules (keep them when editing):
// - FAIL OPEN: any internal error -> exit 0 (never break the user's flow).
// - Tight patterns only: block "rm -rf /", never "rm -rf ./build".
// - Bilingual, friendly denial reason — the user is a beginner.
// - Cross-platform: pure Node (no shell), works on Windows + macOS + Linux.

'use strict';

function decide(cmd) {
  const DENY_MSG =
    'SoulDrop safety net: this command could permanently wipe important files, ' +
    'so your assistant blocked it to protect you. / ' +
    'Lệnh này nguy hiểm — trợ lý đã chặn để bảo vệ bạn.';

  // Targets that mean "everything": filesystem root, home, or a bare drive.
  const isWipeTarget = (tok) => {
    const t = tok.replace(/^["']|["']$/g, '');
    return /^(\/|\/\*|~|~[\\\/]|~[\\\/]\*|\$HOME[\\\/]?|"\$HOME"[\\\/]?|\$env:USERPROFILE[\\\/]?|\$env:HOMEDRIVE[\\\/]?|%USERPROFILE%\\?|[A-Za-z]:[\\\/]?(\*)?)$/i.test(t);
  };

  // Split into simple command segments; naive but enough for a safety net.
  const segments = cmd.split(/(?:&&|\|\||[;|\n])/);
  for (let seg of segments) {
    seg = seg.trim();
    if (!seg) continue;
    let toks = seg.split(/\s+/);
    if (toks[0] === 'sudo') toks = toks.slice(1);
    // cmd /c rd /s /q C:\  ->  look at the wrapped command
    if (/^cmd(\.exe)?$/i.test(toks[0] || '') && /^\/c$/i.test(toks[1] || '')) toks = toks.slice(2);
    const head = (toks[0] || '').toLowerCase();
    const args = toks.slice(1);

    // rm -rf / (any flag order/spelling: -rf, -fr, -r -f, -R, --recursive)
    if (head === 'rm') {
      const recursive = args.some((a) => /^-[a-zA-Z]*[rR]/.test(a) || a === '--recursive');
      if (recursive && args.some(isWipeTarget)) return { deny: DENY_MSG + ' (rm on / or home)' };
    }

    // Windows deltree equivalents on a drive root: del/rd/rmdir /s X:\
    if (head === 'del' || head === 'rd' || head === 'rmdir') {
      const hasS = args.some((a) => /^\/s$/i.test(a));
      if (hasS && args.some(isWipeTarget)) return { deny: DENY_MSG + ' (delete drive root)' };
    }

    // PowerShell: Remove-Item -Recurse ... on / ~ or a drive root
    // (rm/del/rd/rmdir/erase are Remove-Item aliases inside PowerShell)
    if (['remove-item', 'ri', 'rm', 'del', 'rd', 'rmdir', 'erase'].includes(head)) {
      // PowerShell accepts any unambiguous prefix: -r, -rec, -Recurse
      const hasRecurse = args.some((a) => /^-r(e(c(u(r(s(e)?)?)?)?)?)?(:\$true)?$/i.test(a));
      if (hasRecurse && args.some(isWipeTarget)) return { deny: DENY_MSG + ' (Remove-Item on root/home)' };
    }

    // Disk destroyers
    if (head === 'diskpart') return { deny: DENY_MSG + ' (diskpart)' };
    if (/^mkfs(\.|$)/.test(head)) return { deny: DENY_MSG + ' (mkfs)' };
    if (head === 'format-volume' || head === 'format-disk' || head === 'clear-disk')
      return { deny: DENY_MSG + ' (format disk)' };
    if (head === 'format' && args.some((a) => /^[A-Za-z]:$/.test(a.replace(/^["']|["']$/g, ''))))
      return { deny: DENY_MSG + ' (format drive)' };
  }

  // Classic fork bomb — match the shape, not just ":" names.
  if (/(\S+)\s*\(\)\s*\{\s*\1\s*\|\s*\1\s*&\s*\}\s*;\s*\1/.test(cmd))
    return { deny: DENY_MSG + ' (fork bomb)' };

  // git reset --hard: not catastrophic, but it silently destroys uncommitted
  // work — surface the permission prompt so the human decides.
  if (/\bgit\s+([^;|&]*\s)?reset\s+([^;|&]*\s)?--hard\b/.test(cmd)) {
    return {
      ask:
        'This throws away un-saved (uncommitted) changes for good. OK to run? / ' +
        'Lệnh này xóa vĩnh viễn các thay đổi chưa lưu (chưa commit). Bạn đồng ý chạy chứ?',
    };
  }

  return null;
}

function main() {
  let raw = '';
  process.stdin.on('data', (d) => (raw += d));
  process.stdin.on('end', () => {
    try {
      const input = JSON.parse(raw || '{}');
      if (input.tool_name && input.tool_name !== 'Bash' && input.tool_name !== 'PowerShell') return process.exit(0);
      const cmd = String((input.tool_input && input.tool_input.command) || '');
      if (!cmd) return process.exit(0);
      const verdict = decide(cmd);
      if (verdict) {
        const out = {
          hookSpecificOutput: {
            hookEventName: 'PreToolUse',
            permissionDecision: verdict.deny ? 'deny' : 'ask',
            permissionDecisionReason: verdict.deny || verdict.ask,
          },
        };
        process.stdout.write(JSON.stringify(out));
      }
      process.exit(0);
    } catch (e) {
      process.exit(0); // fail open — the safety net must never break the flow
    }
  });
}

if (require.main === module) main();
module.exports = { decide }; // exported for tests
