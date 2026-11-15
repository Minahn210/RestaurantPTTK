#!/bin/sh
# build7.sh - Dong goi web Restaurant7 (macOS/Linux). Chay: sh build7.sh
set -e
cd "$(dirname "$0")"
JAR_NAME=mysql-connector-java-8.0.13.jar
JAR_URL=https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.13/$JAR_NAME
LIB_DIR=src/main/webapp/WEB-INF/lib
OUT=target/restaurant7
JAVAC=javac; JARTOOL=jar
if [ -n "$JAVA_HOME" ]; then JAVAC="$JAVA_HOME/bin/javac"; JARTOOL="$JAVA_HOME/bin/jar"; fi

mkdir -p "$LIB_DIR"
if [ ! -f "$LIB_DIR/$JAR_NAME" ]; then
  echo "[1/4] Dang tai $JAR_NAME ..."
  curl -L -s -o "$LIB_DIR/$JAR_NAME" "$JAR_URL"
else
  echo "[1/4] Da co $JAR_NAME"
fi

echo "[2/4] Chep thu muc webapp ..."
rm -rf "$OUT"; mkdir -p target
cp -R src/main/webapp "$OUT"
mkdir -p "$OUT/WEB-INF/classes"

echo "[3/4] Bien dich Java ..."
RELEASE="--release 8"
if "$JAVAC" -version 2>&1 | grep -q " 1\.8"; then RELEASE=""; fi
"$JAVAC" $RELEASE -nowarn -encoding UTF-8 -d "$OUT/WEB-INF/classes" src/main/java/model7/*.java src/main/java/dao7/*.java

echo "[4/4] Dong goi target/restaurant7.war ..."
rm -f target/restaurant7.war
"$JARTOOL" -cf target/restaurant7.war -C "$OUT" .
echo "XONG. Deploy target/restaurant7.war len Tomcat, roi mo http://localhost:8080/restaurant7/"
