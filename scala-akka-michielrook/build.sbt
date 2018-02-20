name := """raffler"""

version := "1.0"

scalaVersion := "2.11.8"

scalacOptions ++= Seq("-feature", "-language:reflectiveCalls")

val akkaVersion = "2.4.7"
libraryDependencies ++= Seq(
  "com.google.inject" % "guice" % "4.1.0",
  "net.codingwell" %% "scala-guice" % "4.0.1",
  "ch.qos.logback" % "logback-classic" % "1.1.3",
  "com.typesafe.akka" %% "akka-actor" % akkaVersion,
  "com.typesafe.akka" %% "akka-slf4j" % akkaVersion,
  "com.typesafe.akka" %% "akka-testkit" % akkaVersion % Test,
  "org.scalatest" %% "scalatest" % "2.2.6" % "test",
  "org.mockito" % "mockito-core" % "1.10.19" % Test
)

coverageExcludedFiles := ".*Main.*"
