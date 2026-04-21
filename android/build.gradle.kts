<<<<<<< HEAD
=======
plugins {
    id("com.google.gms.google-services") version "4.4.2" apply false
}

>>>>>>> f6fc9b2 (Initial commit)
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
<<<<<<< HEAD
=======

>>>>>>> f6fc9b2 (Initial commit)
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
<<<<<<< HEAD
}
=======
}
>>>>>>> f6fc9b2 (Initial commit)
