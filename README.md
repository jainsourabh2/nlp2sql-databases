# NL2SQL Setup Steps
### Below are the set of instructions to install MCP Toolbox for databases, ADK and core toolbox libraries on localhost (terminal).

1. git clone https://github.com/jainsourabh2/nlp2sql-databases.git  
2. Create an AlloyDB for PostgreSQL or Cloud SQL MySQL database instance in your GCP tenancy.  
3. Use the dataset to create the sample financial dataset schema, data. Use the AlloyDB or MySQL flavor as appropriate. (https://github.com/jainsourabh2/nlp2sql-databases/tree/main/datasets)  
4. Set the Python Virtual environment  
4.1 python3 -m venv .venv  
4.2 source .venv/bin/activate  
5. Install the ADK by following the below steps:  
5.1 pip3 install google-adk  
6. Install the dependancies  
6.1 pip3 install -r nlp2sql-databases/requirements.txt  
7. Navigate to the main MCP toolbox directory.  
7.1 cd nlp2sql-databases/database-chat-bot  
8. Install the latest version of MCP Toolbox for databases as a binary (https://github.com/googleapis/genai-toolbox?tab=readme-ov-file#installing-the-server)  
8.1 export VERSION=0.16.0  
8.2 curl -O https://storage.googleapis.com/genai-toolbox/v$VERSION/linux/amd64/toolbox  
8.3 chmod +x toolbox  
9. Start a terminal session to start the toolbox server.  
Set the session variables. Uncomment the variables appropriately in the toolbox_env.sh file and populate it with the appropriate values and then run the below command.  
9.1 chmod +x toolbox_env.sh  
9.2 source toolbox_env.sh  
9.3 Replace the db value appropriately below before running the command.  
./toolbox --tools-file "toolbox-<<db>>.yaml"  
This will start the toolbox server at "http://localhost:5000"  
10. Copy the .env-example file and rename it to .env .  
Replace the values appropriately in .env file. SERVER_URL will be the toolbox server obtained in the above step.  
11. Navigate to the parent folder/directory and start a fresh terminal session to initiate the adk web server  
11.1 cd ..  
11.2adk web --port 7860  
12. Open http://localhost:7860  