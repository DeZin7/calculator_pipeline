# calculator_pipeline

First Phase:
- First phase is the commit pipeline which will consist in the most basic continuous integration process containing three stages:
    1) Checkout: This stage downloads the source code from the repository.
    2) Compile: This stage compiles the source code.
    3) Unit test: This stage runs a suite of unit tests.

Second Phase:
- Second phase is the Automated Acceptance Test. The Acceptance Test phase is performed to determine if the business requirements are met. It involves black-box testing against a complete system from a user perspective, thats why it can be also called by User Acceptance Testing. Some challenges are going to be faced while trying to implement Automated Acceptance Tests:
    - User-facing: they need to be written together with a user, requiring that the user understand technical and non-technical knowledges;
    - Dependencies integration: the tested application should run together with its dependencies in order to check that the system as a whole works properly;
    - Staging environment: the staging environment needs to be identiacal to the production environment to ensure the same functional and non-functional behavior;
    - Application identity: applications should be build just once and the same binary should be transferred to production, eliminating the risk of different building environments;
    - Relevances and consequences: if the acceptance test passes, the application is ready for be released from the user's perspective.

I order the ensure application identity we are going to build the Docker image of our application only once and using the Docker Registry for its storage and versioning. The artifact repository plays a special role in the CD process because it guarantees that the same binary is used throughout all pipeline steps. For artifact repository, in this project, we are choosing Docker Hub.
The developer pushes a change to the source code repository and it will trigger the pipeline build. As the last step of the commit stage, a binary is created and stored in the artifact repository. Afterwards, during all the other stages of the delivery process, the same binary is pulled and used.
The accpetance test in our Jenkins pipeline will be like this:
    1. The developer pushes a code change to GitHub;
    2. Jenkins detects the change, triggers the build, and checks out the current code;
    3. Jenkins executes the commit phase and builds the Docker image;
    4. Jenkins pushes the image to the Docker Registry;
    5. Jenkins runs the Docker container in the staging environment;
    6. The Docker Host on the staging environment pulls the image from Docker Hub;
    7. Jenkins runs the acceptance test suite against the application running in the staging environment.
