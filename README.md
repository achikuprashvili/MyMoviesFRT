# MyMoviesFRT

App architecture is MVVM+R
Each module contains VC - ViewController, VM - ViewModel, Router and Storyboard if needed.

App has several dependencies:

AppDependencies - is a protocol which contains main dependecies.

BackendManager - each Manager has own BackendManager wrapped into protocol. BackendManager contains main send request / decodable request which you sould use to send any requests. All requests should be declared under RequestRouter as enum.

Coordinator - controls initial screens flow.

# Short description

Language: Swift 5

Architecture: MVVM+R

Dependencies (CocoaPods):

-RxSwift/RxCocoa (for reactive programming, Binding View to ViewModel, for subtitution delegates, ect.)

-Alamofire (Rest API)

-MaterialComponents/ActivityIndicator (just loader)

-SDWebImage (fetching and caching images from server)

-ReachabilitySwift (for network monitoring)

-RangeSeekSlider (handsome UI component )

Frameworks: UIKit, CoreData
Deployment Target: iOS 13.0


# Managers:

DataManager - CoreData manager responsible for stroring and fetching favourite movies in database.

NetworkManager - used for monitoring network availability.

TMDBManager - Backend manager used for retrieving discovery data from server.

# Scenes: 

DiscoveryScene - Data retrieved from discovery API are show as a grid using collection view. You can switch segment controller to see favourited movies. DiscoveryScene contains filterview which you can see via tapping icon on the top navigation bar on the right side. FilterView is separated from scene and is located under Sources->UIHelper group. 

MovieScene - detailed view of movie. Here you can add movie as favourite in local database.

# Assets:

All colors and fonts used in application is defined in the extension under UIColor and UIFond class as static members.


UIViewController+Extension - all methods which maybe used by another scenes are declared here. (showActivityIndicator, showPlaceholder, handleError)
