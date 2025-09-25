# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Database Agent: get data from various databases using NL2SQL."""

import os

from google.adk.agents import LlmAgent
from google.adk.agents.callback_context import CallbackContext
from google.genai import types

from . import tools
from .prompts import process_database

db = os.getenv("DATABASE_TYPE", "MYSQL")
print(db)
def setup_before_agent_call(callback_context: CallbackContext) -> None:
    """Setup the agent."""

    if "database_settings" not in callback_context.state:
        callback_context.state["database_settings"] = \
            tools.get_database_settings()


root_agent = LlmAgent(
    model=os.getenv("AGENT_MODEL", ""),
    name="database_agent",
    instruction=process_database(db),
    output_key = "agent_output",
    tools=[
        tools.alloydb_nl2sql,
        tools.mysql_nl2sql,
        tools.run_query,
        #tools.get_toolbox_toolset(),
    ],
    before_agent_callback=setup_before_agent_call,
    generate_content_config=types.GenerateContentConfig(temperature=0.01),
)