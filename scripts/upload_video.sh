if [ -x "$(command -v python3)" ]; then
  PYTHON=python3
else
  PYTHON=python
fi
youtube_ids=$($PYTHON -c "import json; print('\n'.join([account['id'] for account in json.load(open('.mp/youtube.json'))['accounts']]))")
echo "What account do you want to upload the video to?"
for id in $youtube_ids; do
  echo $id
done
read -p "Enter the id: " id
if [[ " ${youtube_ids[@]} " =~ " ${id} " ]]; then
  echo "ID found"
else
  echo "ID not found"
  exit 1
fi
$PYTHON src/cron.py youtube $id
