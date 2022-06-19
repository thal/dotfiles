// Add this file or link to it in root of profile directory
// Hide VPN ad
user_pref("browser.privatebrowsing.vpnpromourl", "" );
user_pref("browser.promo.focus.enabled", false );
user_pref("browser.vpn_promo.enabled", false );
// Disable remote setting of preferences
user_pref("app.normandy.enabled", false );
// Re-enable compact density
user_pref("browser.compactmode.show", true );
user_pref("dom.serviceWorkers.enabled",	false);
user_pref("extensions.pocket.enabled", false);
user_pref("mousewheel.system_scroll_override.enabled", false);
// Disable third-party cookies
user_pref("network.cookie.cookieBehavior", 1);
// Delete cookies when browswer closes
user_pref("network.cookie.lifetimePolicy", 2);
user_pref("privacy.history.custom", true);
user_pref("network.dns.disablePrefetch", true);
user_pref("pdfjs.viewerCssTheme", 2);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
// Enable userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// Use system GTK theme (Doesn't work anymore :( )
//user_pref("widget.content.allow-gtk-dark-theme", true);
//user_pref("widget.content.gtk-theme-override", "Greybird");
//user_pref("widget.non-native-theme.enabled", false);

// Always use transparent scrollbar background, rather than getting some random color from gtk theme
user_pref("ui.themedScrollbar", "#00000000");
user_pref("ui.themedScrollbarInactive", "#00000000");
// Inactive scrollbar a bit too light with default gtk theme. Make it a bit darker.
user_pref("ui.themedScrollbarThumbInactive", "#969696");

// No tab previews when dragging
user_pref("nglayout.enable_drag_images", false");

// Remove all recommendations from new tab page
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

// Disable Pocket
user_pref("extensions.pocket.enabled", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("extensions.pocket.oAuthConsumerKey", "");
user_pref("extensions.pocket.api", "");
user_pref("extensions.pocket.showHome", false);
user_pref("extensions.pocket.site", "");

// Disable all urlbar suggestions except open tabs, history, and bookmarks
user_pref("browser.urlbar.suggest.bookmark", true);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.history", true);
user_pref("browser.urlbar.suggest.openpage", true);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.suggest.topsites", false);
// No search suggestions
user_pref("browser.search.suggest.enabled", false );
// No contextual suggestions
user_pref("browser.urlbar.suggest.quicksuggest", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
// Don't show the "Firefox Suggest" label, since there's only one group
user_pref("browser.urlbar.groupLabels.enabled", false);
