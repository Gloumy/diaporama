
  

# Diaporama (for Reddit)

  

<img  src="https://raw.githubusercontent.com/Gloumy/diaporama/master/assets/images/diaporama-logo-inapp.png"  width="150">

  

## A pretty simple Flutter app to browse Reddit with swiping gestures

You select your content source (list of subreddits) and you just have to swipe right/left to navigate between threads. Ain't it easy ?

  

### Features (as of 2020-04-07)

  

-  [x] Retrieve content from Front Page/Popular/All

-  [x] Anonymous/Authenticated mode

-  [x] Manage your content sources (add/remove)

-  [x] Search subreddits with autocomplete

-  [x] PageView display of threads

-  [x] Comments display

-  [x] Dark Theme (actually that's the only theme)

-  [x] Implemented design (at least to me it doesn't look that ugly)
- [x] Improve the handling of different submissions types

- [x] Improve comments display

- [x] Implement comment actions (votes, reply, copy content, save)

- [x] Implement thread actions (votes, reply, share, save)
- [x]  Sync your multrireddits as content sources

  

### Next steps

  
- [ ] Refactor / clean up 

- [ ] Implement settings page

- [ ] Improve miscellaneous things and implement a lot of other things that are still missing to look like a real Reddit client !

  

  

### Contribute

  

Well, don't hesitate to share feedback and/or ideas !

  

  

### Running the app

You need to get an api key for the Reddit oAuth. You can get one from your Reddit settings. 
Then, copy the secrets.example file and replace the redditSecret with this api key.

  ``cp lib/utils/secrets.dart.example lib/utils/secrets.dart``
``sed -i -e "s/changeRedditSecret/$redditSecret/g" lib/utils/secrets.dart
``
There's also a secret for Sentry, but you shouldn't need that.
Once those secrets are configured, you just need to ``flutter run`` and voilà !

---

Thanks to TheNightmanCodeth for his DitRA work, i've taken inspiration and copied some code for the comments part. That part got reworked, but it allowed me to not be stuck and continue the development early on.
