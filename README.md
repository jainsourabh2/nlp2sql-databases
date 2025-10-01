# NL2SQL Setup Steps

An Agentic AI agent to converse naturally with the databases like MySQL / AlloyDB or PostgreSQL.

## Features

- **MCP ToolBox Connection**: Leverages google published MCP Toolbox Server for connecting to RDBMS.
- **Easy Configuration**    : Dynamic setup that can connet across various databases.
- **Dynamic Data Loading**  : Build the schema dynamically based on the database configured.

## Prerequisites

- Python 3.13+ and pip3 installed
- Google ADK (`pip install google-adk`)
- Access to Google Cloud environment

## Setup

1. **Clone the repository**:
    ```bash
    git clone https://github.com/jainsourabh2/nlp2sql-databases.git 
    ```

1. git clone https://github.com/jainsourabh2/nlp2sql-databases.git  
2. Create an AlloyDB for PostgreSQL or Cloud SQL MySQL database instance in your GCP tenancy.  
3. Use the dataset to create the sample financial dataset schema, data. Use the AlloyDB or MySQL flavor as appropriate. (https://github.com/jainsourabh2/nlp2sql-databases/tree/main/datasets) 4. Navigate to the main MCP toolbox directory.  
   ```bash
   cd nlp2sql-databases/database-chat-bot
   ```
5. Install the latest version of MCP Toolbox for databases as a binary (https://github.com/googleapis/genai-toolbox?tab=readme-ov-file#installing-the-server)  
   ```bash
    export VERSION=0.16.0  
    curl -O https://storage.googleapis.com/genai-toolbox/v$VERSION/linux/amd64/toolbox  
    chmod +x toolbox
   ```
6. Start a terminal session to start the toolbox server. Set the session variables. Uncomment the variables appropriately in the toolbox_env.sh file and populate it with the appropriate         values and then run the below command.  
   ```bash
     chmod +x toolbox_env.sh  
     source toolbox_env.sh  
7. Replace the db value appropriately below before running the command. It starts the toolbox server at "http://localhost:5000" 
   ```bash
    ./toolbox --tools-file "toolbox-<<db>>.yaml"
   ```
8. Copy the .env-example file and rename it to .env  
   Replace the values appropriately in .env file to reflect the concerned DATABASE and TOOLSET. SERVER_URL will be the toolbox server obtained in the above step. 
9. Set the Python Virtual environment
   ```bash
    python3 -m venv .venv   
    ```
10. Activate the virtual environment
    ```bash
    source .venv/bin/activate
    ```
11. Install the ADK by following the below steps:  
    ```bash
    pip3 install google-adk
    ```
12. Install the dependancies  
    ```bash
    pip3 install -r nlp2sql-databases/requirements.txt
    ```
13. Navigate to the parent folder/directory and start a fresh terminal session to initiate the adk web server  
    ```bash
    cd ..  
    adk web --port 7860
    ```
14. Open http://localhost:7860  
