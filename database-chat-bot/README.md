# nlp2sql-databases

1. git clone https://github.com/jainsourabh2/nlp2sql-databases.git

2. python3 -m venv .venv

3. source .venv/bin/activate

4. pip3 install -r requirements.txt

5. cd database-chat-bot

6. See releases page for other versions (https://github.com/googleapis/genai-toolbox?tab=readme-ov-file#installing-the-server)

export VERSION=0.14.0
curl -O https://storage.googleapis.com/genai-toolbox/v$VERSION/linux/amd64/toolbox
chmod +x toolbox

7. Relace the value appropriately in .env file and toolbox-alloydb.yaml

8. Start a terminal session and run start the toolbox server
./toolbox --tools-file "toolbox-allloydb.yaml"

9. cd ..

10. Start another terminal session and start the adk web server
adk web --port 7860

11. Open http://localhost:7860
