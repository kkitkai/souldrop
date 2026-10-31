# assets/media — tutorial videos / video hướng dẫn

Drop zone for the SoulDrop tutorial videos (VN voice-over).

**GitHub README embed rule (verified 2026-07):** only videos uploaded through
the GitHub web editor (drag-and-drop → a `https://github.com/user-attachments/assets/...`
URL pasted on its own line) render an **inline player** in READMEs.
`.mp4` files committed to the repo do **not** render inline — GitHub strips them.

So the working recipe per video:

1. Put the master `.mp4` here (kept in the repo as the downloadable source).
2. Export a short preview `.gif` (< 10 MB) here — GIFs DO render inline.
3. Best option: edit the README on github.com, drag the `.mp4` into the editor,
   and paste the generated `user-attachments` URL on its own line in the
   "🎬 Video hướng dẫn" section — that gives a real inline player.

Files expected (to be added by the maintainers):

- `tutorial-install-vn.mp4` + `tutorial-install-vn-preview.gif` — cài đặt từ đầu
- `tutorial-onboard-vn.mp4` + `tutorial-onboard-vn-preview.gif` — chạy /onboard
