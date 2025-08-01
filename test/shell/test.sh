#!/bin/bash

ROOT_PATH=test-vercelkeep
VERCEL_KEEP_FILE_NAME=.vercelkeep

cd "$ROOT_PATH"

echo "🔄 Setting up the test environment..."
if [ ! -f "$VERCEL_KEEP_FILE_NAME" ]; then
  echo "❌ Error: $VERCEL_KEEP_FILE_NAME file not found!"
  exit 1
fi

if [ ! -f ../test/clean-unwanted-files.sh ]; then
  echo "❌ Error: ../test/clean-unwanted-files.sh not found!"
  exit 1
fi

echo "✅ All required files found. Starting the test..."

echo "🚀 Running ../test/clean-unwanted-files.sh..."
bash ../test/clean-unwanted-files.sh

if [ $? -eq 0 ]; then
  echo "🎉 Test script executed successfully!"
else
  echo "❌ Test script encountered errors!"
  exit 1
fi

# status
echo "🔎 Verifying repository state after test..."
EXPECTED_FILES=("important.txt" "keep-me.js" ".vercelkeep")
ACTUAL_FILES=$(git ls-files)

for file in "${EXPECTED_FILES[@]}"; do
  if echo "$ACTUAL_FILES" | grep -qxF "$file"; then
    echo "✅ $file is present as expected."
  else
    echo "❌ $file is missing!"
    exit 1
  fi
done

for file in $ACTUAL_FILES; do
  if ! printf '%s\n' "${EXPECTED_FILES[@]}" | grep -qxF "$file"; then
    echo "❌ Unexpected file found: $file"
    exit 1
  fi
done

# finish
echo "🎊 All done!"
