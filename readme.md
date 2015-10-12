# Code review

## Instructions

Do you have a github account?

### No

Create one and follow the steps below, but if you don't really want to
have an account, it's fine too, send me an email with the code.

### Yes

1. Fork the repository (click in the button above in the right hand side)

2. Download the repository to your machine

```bash
$ cd where/I/put/my/code
$ git clone https://github.com/YOURUSERNAME/MSSLCodeReview.git
$ cd MSSLCodeReview/20151014/
```

If your code sample is in one of the languages there then copy the file into it

```bash
$ cp path/to/my/original/myfile.pro idl/
```

If not, create a new folder and add your file to it

```bash
$ mkdir haskell
$ cp path/to/my/original/myfile.hs haskell/
```

add the file to the repository, comit it and push it to your repo online

```bash
$ git add idl/myfile.pro
$ git commit -m 'This is my contribution, it does X, Y, Z'
$ git push
```

Check that there's no error messages, if this is your first time using git
you will have to introduce yourself to git before being able to commit.
Just read the messages git shows you.

Finally we do a pull-request.

Go to the original repository website:
[https://github.com/dpshelio/MSSLCodeReview](https://github.com/dpshelio/MSSLCodeReview)

and you will see a green banner in the top saying if you want to do a Pull-Request.
Click in the menus, change the title if desired and click "Create Pull Request"

Then you are ready for the session.

You feel you are in trouble? then let me know and I will help you with it.

## Why code review is important?

Code review is like paper review, you expose your code to others, they will
have to undersrtand it and they will give you comments.  Either way, as reviewer or
author, you will learn.

## On the day

We will separate in groups by language and use github to review the pull-requests.
