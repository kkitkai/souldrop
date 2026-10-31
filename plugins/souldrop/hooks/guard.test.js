// Self-test for the SoulDrop safety net. Run: node guard.test.js
// Exits non-zero on any miss — used by CI and by hand before every release.
'use strict';
const path = require('path');
const { spawnSync } = require('child_process');
const { decide } = require('./guard.js');

const deny = [
  'rm -rf /', 'rm -fr ~', 'sudo rm -rf /*', 'rm -r -f $HOME', 'rm --recursive --force /',
  'del /s /q C:\\', 'rd /s /q C:\\', 'Remove-Item -Recurse -Force C:\\', 'Remove-Item -Recurse ~/',
  'diskpart', 'mkfs.ext4 /dev/sda1', 'Format-Volume -DriveLetter C', 'format C:',
  ':(){ :|:& };:', 'bomb(){ bomb|bomb& };bomb',
  // PowerShell tool shapes (v0.7.0)
  'Remove-Item -Path C:\\ -Recurse -Force', 'Remove-Item -r -fo $env:USERPROFILE', 'rm -Recurse -Force ~\\',
  'ri -Recurse D:\\', 'Remove-Item -LiteralPath "C:\\" -Recurse', 'cmd /c rd /s /q C:\\',
  'Get-Date; Remove-Item -Recurse -Force $HOME', 'Clear-Disk -Number 0 -RemoveData',
];
const ask = ['git reset --hard', 'git reset --hard HEAD~1', 'cd repo && git reset --hard origin/main'];
const allow = [
  'rm -rf ./build', 'rm -rf node_modules', 'rm file.txt', 'rm -rf /tmp/x', 'rm -rf ~/old-notes/tmp',
  'del /s /q .\\dist', 'Remove-Item -Recurse -Force .\\out', 'git reset --soft HEAD~1',
  'git checkout main', 'format-list', 'echo "rm -rf /" > warning.txt',
  'npm run format', 'ls -la /', 'mkdir -p ~/second-brain', 'ollama pull llama3.2:3b',
  // PowerShell tool shapes that must stay allowed
  'Remove-Item -Recurse -Force $env:TEMP\\build', 'Remove-Item C:\\Users\\alex\\old.txt',
  'Get-ChildItem -Recurse C:\\', 'Format-Table', 'rm -r .\\dist', 'Remove-Item -Recurse ~\\Downloads\\old',
];

let fail = 0;
for (const c of deny)  { const v = decide(c); if (!v || !v.deny) { console.log('MISSED DENY :', c); fail++; } }
for (const c of ask)   { const v = decide(c); if (!v || !v.ask)  { console.log('MISSED ASK  :', c); fail++; } }
for (const c of allow) { const v = decide(c); if (v)             { console.log('FALSE BLOCK :', c, JSON.stringify(v)); fail++; } }
let total = deny.length + ask.length + allow.length;

// End-to-end through stdin, exactly as Claude Code calls the hook.
const run = (input) => spawnSync(process.execPath, [path.join(__dirname, 'guard.js')], { input, encoding: 'utf8' });
const e2e = [
  // [name, stdin, expected decision ('' = allowed, no output)]
  ['Bash tool deny', JSON.stringify({ tool_name: 'Bash', tool_input: { command: 'rm -rf ~' } }), 'deny'],
  ['PowerShell tool deny', JSON.stringify({ tool_name: 'PowerShell', tool_input: { command: 'Remove-Item -Recurse -Force C:\\' } }), 'deny'],
  ['PowerShell tool ask', JSON.stringify({ tool_name: 'PowerShell', tool_input: { command: 'git reset --hard' } }), 'ask'],
  ['PowerShell tool allow', JSON.stringify({ tool_name: 'PowerShell', tool_input: { command: 'Get-ChildItem' } }), ''],
  ['other tool ignored', JSON.stringify({ tool_name: 'Write', tool_input: { command: 'rm -rf /' } }), ''],
  ['bad JSON fails open', '{not json', ''],
];
for (const [name, stdin, want] of e2e) {
  total++;
  const r = run(stdin);
  let got = '';
  try { got = r.stdout ? JSON.parse(r.stdout).hookSpecificOutput.permissionDecision : ''; } catch (e) { got = 'unparsable'; }
  if (r.status !== 0 || got !== want) { console.log('E2E FAIL    :', name, 'exit', r.status, 'got', JSON.stringify(got)); fail++; }
}

// hooks.json must use exec form, cover both shell tools, and fail open.
total++;
try {
  const hj = JSON.parse(require('fs').readFileSync(path.join(__dirname, 'hooks.json'), 'utf8'));
  const entry = hj.hooks.PreToolUse[0];
  const h = entry.hooks[0];
  const okShape = entry.matcher === 'Bash|PowerShell' && h.command === 'node' && Array.isArray(h.args)
    && h.args[0] === '${CLAUDE_PLUGIN_ROOT}/hooks/guard.js' && h.onFailure === 'continue';
  if (!okShape) { console.log('HOOKS.JSON  : wrong shape', JSON.stringify(entry)); fail++; }
} catch (e) { console.log('HOOKS.JSON  : unreadable', e.message); fail++; }

console.log(fail === 0
  ? 'GUARD TESTS: all ' + total + ' pass'
  : 'GUARD TESTS: ' + fail + ' failure(s) of ' + total);
process.exit(fail === 0 ? 0 : 1);
