# nl2sql-setup-steps

Below are the set of instructions to install MCP Toolbox for databases, ADK and core toolbox libraries on localhost (terminal).

1. git clone https://github.com/jainsourabh2/nlp2sql-databases.git

2. Create an AlloyDB for PostgreSQL or Cloud SQL MySQL database instance in your GCP tenancy.

3. Use the dataset to create the sample financial dataset schema, data. Use the AlloyDB or MySQL flavor as appropriate. (https://github.com/jainsourabh2/nlp2sql-databases/tree/main/datasets)

4. Install the ADK by following the below steps:

5. python3 -m venv .venv

6. source .venv/bin/activate

7. pip install google-adk toolbox-core
 
8. pip3 install -r requirements.txt

9. Navigate to the main MCP toolbox directory.
     cd database-chat-bot

10. Install the latest version of MCP Toolbox for databases as a binary (https://github.com/googleapis/genai-toolbox?tab=readme-ov-file#installing-the-server)

      export VERSION=0.16.0
      curl -O https://storage.googleapis.com/genai-toolbox/v$VERSION/linux/amd64/toolbox
      chmod +x toolbox

11. Copy the .env-example file and rename it to .env . Relace the values appropriately in .env file and toolbox-alloydb.yaml

12. Start a terminal session and run start the toolbox server
      ./toolbox --tools-file "toolbox-alloydb.yaml"

15. Navigate to the parent folder/directory and start a fresh terminal session to initiate the adk web server. Source env.sh file to ensure the DB engine and project related variables are initiated in the shell.
      cd ..
      adk web --port 7860

16. Open http://localhost:7860
