  #!/usr/bin/env bash
  set -euo pipefail

  out="${1:-all_combined.js}"

  find . -maxdepth 1 -type f ! -name "$out" -print0 \
    | sort -z \
    | xargs -0 cat -- \
    > "$out"
