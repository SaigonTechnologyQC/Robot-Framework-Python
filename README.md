# Robot-Framework-Python
A demo of Robot Framework With Python and Playwright


## Installation & Environment
1. Installing python3.8 and pip
2. Installing virtual environment by below command

>pip install --user virtualenv

>python -m venv env

>.\env\Scripts\activate

If you got trouble related to UnauthorizeAccess, run below command:

> Set-ExecutionPolicy Unrestricted -Scope Process

3. Install all needed python libraries and Robot Framework by below command
>pip install -r requirements.txt
 [View more](https://github.com/robotframework/robotframework/blob/master/INSTALL.rst)
 
4. Initialize the Browser module
- Install node.js e.g. from https://nodejs.org/en/download/
- Open Commandline run:
> pip install robotframework-browser
- Install the node dependencies run: 
> rfbrowser init
IF the rfbrowser is not found, please try 
>python -m Browser.entry init

# Build and Test
TODO: Describe and show how to build your code and run the tests.
## Execution
### Running tests & modules

All test cases should be run in the root of the project, also some modules should be run in the root of the project.
[Configuration files](configfiles) are used to define some variables. If tests are run against new environment or there is other changes needed, new configuration file can be created.

Use configuration file when executing tests:

>robot -A configfiles\regression_web.txt