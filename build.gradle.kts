import org.springframework.boot.gradle.tasks.bundling.BootBuildImage

plugins {
    java
    id("org.springframework.boot") version "3.0.5" apply false
    id("io.spring.dependency-management") version "1.1.0"
}

subprojects {
    apply(plugin = "java")
    apply(plugin = "org.springframework.boot")
    apply(plugin = "io.spring.dependency-management")

    group = "eai"
    version = "0.1"
    java.sourceCompatibility = JavaVersion.VERSION_17

    configurations {
        compileOnly {
            extendsFrom(configurations.annotationProcessor.get())
        }
    }

    repositories {
        mavenCentral()
    }

    tasks.named<BootBuildImage>("bootBuildImage") {
        imageName.set("eai/${project.name}")
        environment.set(environment.get() + mapOf("BP_JVM_VERSION" to "17"))
        if (project.name == "api") {
            environment.set(environment.get() + mapOf("SPRING_PROFILES_ACTIVE" to "PROD"))
        }
    }

    tasks.withType<Test> {
        useJUnitPlatform()
    }
}