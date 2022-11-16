set -e

rm -rf student-submission
git clone $1 student-submission
cd student-submission
cp ListExamples.java ../
FILE= "list-examples-grader/ListExamples.java"
if [ -f "$FILE" ]
then
        echo "ListExamples.java exists."
else
        echo "ListExamples.java does not exist"
        exit 1
fi
CPATH= ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"
javac -cp $CPATH *.java

java -cp $CPATH org.junit.runner.JUnitCore TestListExample 2 > out-err.txt > out.txt

grep -n -i "FAILURE" out.txt > final.txt
grep "2" final.txt > final1.txt
grep "1" final.txt > final2.txt
if [ -s final1.txt ]
then
        echo "You failed all test!"
else if [ -s final2.txt ]
then
        echo "You failed 1 test and passed 1 test!"
else
        echo "You passed all test"