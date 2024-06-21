## RADIUS Stress Test
This Docker container provides a straightforward method for performing a RADIUS stress test. Upon deployment, it installs the most recent version of the Alpine Linux operating system along with the WPA Supplicant package, which includes the eapol_test utility. The eapol_test is specifically engineered to execute a single RADIUS EAP authentication challenge with a RADIUS server.

For load testing purposes, the eapol_test is invoked using an ash shell script, which triggers multiple instances of the eapol_test based on configurations set within the radius.sh file. These tests will persist until the Docker container is manually stopped.

By default, the container is configured to attempt EAP PEAP with MS-CHAPv2 authentication. It's important to note that there is no internal logging or indication that the eapol_test is running, other than the authentication attempts observed on your RADIUS server.  This is to try and make the container as efficient as possible to increase the number of auth's per second it can handle. 

## Build Process

Prior to proceeding with the build and installation of the container, it is essential to confirm that Docker is installed on the system intended for use. Docker Desktop is not a necessity for this operation, as the forthcoming instructions are designed to utilize the command-line interface (CLI) for the construction and deployment of the Docker container.

Please ensure that the Docker engine is properly set up and functioning on your machine. You can verify the installation and check the version of Docker by executing the following command in your terminal or command prompt:

```
docker --version
```

If Docker is not installed, you will need to download and install the appropriate version for your operating system. Detailed instructions for installing Docker can be found on the official Docker documentation website. Once Docker is successfully installed, you may proceed with the build and run instructions for the Docker container as outlined below.

## Downloading Build Files

To clone this GitHub repository to your device using Git, you can follow these steps:
1.	Open a terminal window (on Linux or macOS) or command prompt/PowerShell (on Windows).
2.	Navigate to the directory where you want the cloned repository to be placed using the cd (change directory) command.
3.	Use the git clone command followed by the repository's URL. 

```
git clone https://github.com/PubSec-Security-DevNet/radius-stress-test.git
```

Alternatively, you can also download a zip file from the GitHub repository for this project and unzip it in the directory you want to use.

## RADIUS client arguments

Edit the configuration section of the radius.sh file.  Enter in the RADIUS server, RADIUS secret key, username, and password.  You can also modify the port if needed and the authentications a second aa well as the timeout of each spawned process.

## Build Docker Image

To build the Docker image on your system, please follow these steps:
1.	Open a command-line interface (CLI) on your computer. This could be Terminal on macOS or Linux, or Command Prompt or PowerShell on Windows.
2.	Navigate to the base directory of the Docker repository that you have either cloned or downloaded. Use the cd command to change directories to the location where the repository resides on your system. For example:

```
cd /path/to/radius-stress-test
```

3.	Once you're in the correct directory, run the following Docker build command to build the image with default options, other examples are below:

```
docker build -t radius-stress-test-image . --no-cache
```

## Running Docker Image

To start the docker image open a CLI and enter the following command

```
docker run -d --name radius-stress-test radius-stress-test-image
```

## Stopping Docker Image

To stop the docker image open a CLI and enter the following command

```
docker stop radius-stress-test
```