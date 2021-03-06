#!/bin/bash

# Get location of this script
DIR_REPO="$( cd "$(dirname $0)" ; pwd -P )"

# Record directories for future use
DIR_APP="$DIR_REPO/aic"
DIR_AIC="$DIR_APP/aic"

# Install dependencies
cd "$DIR_APP";

carthage checkout --no-use-binaries;
carthage build --platform ios;
pod update;

# Create dummy plists
if [ ! -f "$DIR_AIC/Config.plist" ]; then

	echo "No existing Config.plist found, one will be created..."

	OPTIONS=`cat <<- EOF
	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
	<dict>
	    <key>Testing</key>
	    <dict>
	        <key>printDataErrors</key>
	        <true/>
	    </dict>
	    <key>DataConstants</key>
	    <dict>
	        <key>feedFeaturedExhibitions</key>
	        <string>http://localhost:8888/featuredExhibitions.json</string>
	        <key>appDataJSON</key>
	        <string>http://localhost:8888/appData.json</string>
	        <key>appDataExternalPrefix</key>
	        <string>http://localhost:8888/</string>
	        <key>appDataInternalPrefix</key>
	        <string>http://localhost:8888/</string>
	        <key>memberCardSOAPRequestURL</key>
	        <string>http://localhost:8888/api/1?token=foobar</string>
	        <key>ignoreOverrideImageCrop</key>
	        <true/>
		</dict>
	</dict>
	</plist>
	EOF`

	echo "$OPTIONS" > "$DIR_AIC/Config.plist"
	chown $(logname) "$DIR_AIC/Config.plist"

	echo "Created stub /aic/aic/Config.plist"

fi

# Create dummy GoogleServices plist
if [ ! -f "$DIR_AIC/GoogleService-Info.plist" ]; then

	echo "No existing GoogleService-Info.plist, one will be created..."

	OPTIONS=`cat <<- EOF
	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
	<dict>
	    <key>TRACKING_ID</key>
	    <string>UA-96171322-1</string>
	    <key>PLIST_VERSION</key>
	    <string>1</string>
	    <key>BUNDLE_ID</key>
	    <string>edu.artic.anon-mobile-app</string>
	    <key>PROJECT_ID</key>
	    <string>AnonMobileApp</string>
	    <key>IS_ADS_ENABLED</key>
	    <false/>
	    <key>IS_ANALYTICS_ENABLED</key>
	    <true/>
	    <key>IS_APPINVITE_ENABLED</key>
	    <false/>
	    <key>IS_GCM_ENABLED</key>
	    <false/>
	    <key>IS_SIGNIN_ENABLED</key>
	    <false/>
	    <key>GOOGLE_APP_ID</key>
	    <string>1:364666648134:ios:18dac0682c0e18fd</string>
	</dict>
	</plist>
	EOF`

	echo "$OPTIONS" > "$DIR_AIC/GoogleService-Info.plist"
	chown $(logname) "$DIR_AIC/GoogleService-Info.plist"

	echo "Created stub /aic/aic/GoogleService-Info.plist"
	echo "Edit it with your Firebase app and tracking id's when ready"

fi

# Open the workspace in Xcode
cd "$DIR_APP" && open aic.xcworkspace
