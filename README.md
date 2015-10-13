# KamcordProject

Supports iOS 8.0 and above

Notes:
1. Since the video metadata and video thumbnails may take some time to download over network, when app starts, it first shows "Video loading". When all data has been downloaded, we reload the table and show main screen. This is a common technique used in apps like Yelp and Yik Yak.
2. I created a custom segue to disable the push animation to "Video loading" screen. It is the first screen user sees and a push animation looks awkward. Starting iOS 9.0, we can disable segue animation from storyboard directly, but not for iOS 8. The other option is to push this viewcontroller from code directly and get rid of segue on storyboard, which is a good alternative. The only downside to that is that Xcode will give a warning about presenting Detached view controller. Apparently if we want to push a viewcontroller that is on storyboard, Xcode will prefer us to do it from segue rather than code.

Possible improvements (if I have more time)
1. Dealing with bad network
Right now if the phone is not connected to the Internet, the app will hang at "Video loading" screen forever, which is not ideal. Possible solution to that is to check if the phone is connected to the Internet before making network call, and warning user if device is offline. We can use either Apple's "Reachability" code or third party "Reachability" code.
2. Popping more fields into the cell.
Such as number of views, number of likes, etc. This can be done easily.
