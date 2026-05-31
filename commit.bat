@SET userInput=(empty)
@SET /P userInput=Message:
cd \Dropbox\PhillipSenn\wwwroot\Claude
git status
git add .
git commit -m "%userInput%"
git push origin HEAD
