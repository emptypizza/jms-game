#!/usr/bin/env bash
# netlify-deploy.zip 을 소스에서 결정적으로 재생성한다.
# 이전 버전은 refer/ 자산이 누락돼 Netlify 배포 시 CASE 3 키아트가 404였다(QA H1).
# 배포 파일이 소스와 어긋나지 않도록 반드시 이 스크립트로 zip 을 만든다.
set -euo pipefail
cd "$(dirname "$0")"

OUT="netlify-deploy.zip"

# 배포에 필요한 파일 목록 (사이트 루트 기준 상대경로 유지)
FILES=(
  index.html
  jms_cases.html
  case3.html
  .nojekyll
  refer/G4Q5qW.png   # case3.html 이 로드하는 유일한 외부 이미지
)

# 존재 확인
for f in "${FILES[@]}"; do
  [[ -e "$f" ]] || { echo "누락: $f" >&2; exit 1; }
done

rm -f "$OUT"
zip -q -X "$OUT" "${FILES[@]}"
echo "생성됨: $OUT"
unzip -l "$OUT"
