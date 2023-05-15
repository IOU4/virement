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

  dependencyManagement {
    imports {
      mavenBom("org.springdoc:springdoc-openapi:2.1.0")
      mavenBom("org.springframework.security:spring-security-bom:6.0.3")
    }
  }

  tasks.named<BootBuildImage>("bootBuildImage") {
    imageName.set("eai/${project.name}")
    environment.set(environment.get() + mapOf("BP_JVM_VERSION" to "17"))
  }

  tasks.withType<Test> {
    useJUnitPlatform()
  }
}
