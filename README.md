# Galakei: Japanese feature phone support

[Japanese feature phones](http://www.mobalean.com/en/keitai_web_technology_guide) (a.k.a., keitai, galakei) have a number of restrictions over normal web browsers.  This library adds support for them.

## Goals

 * Provide support for 3G handsets from the major 3 carriers in Japan (docomo, au, SoftBank)
 * Avoid modifying Rails internals as much as possible

## Features

### Inlining Styles

Old docomo handsets [don't support external stylesheets](http://www.keitai-dev.net/CSS). Additionally, only very limited CSS is supported. galakei/docomo_css automatically inlines CSS and manipulates markup to overcome these limitations.

    # css file
    h1 { color: red; background-color: blue}

    # source html
    <h1>Foo</h1>

    # outputted html
    <div style="background-color: blue;"><h1><span style="color:red;">Foo</span></h1>/div>

Furthermore, the css border property is supported through the "spacer.gif" technique.

    # css file
    div { border-bottom: 5px solid #000000; }

    # source html
    <div>Foo</div>

    # outputted html
    <div>Foo</div>
    <img src="/galakei/spacer/000000" width="100%" height="5">

This will generate a 1px by 1px image, emulating the effect of borders on old docomo handsets.

### Maintaing sessions

Old docomo handsets [don't support cookies](http://www.keitai-dev.net/Cookies). Furthermore, although Softbank and Au handsets support cookies, when accessing SSL pages, different cookies may be used. Galakei works around this by injecting a session id parameter into your URLs and forms (as long as you use a standard rails method for creating them). To enable this functionality, you will need to modify your session_store.rb initializer to allow the use of session parameters and use a non cookie-based store.

     MyApp::Application.config.session_store :active_record_store, :key => '_sid', :cookie_only => false

You'll also need to enable this option in galakei

    config.galakei.session_id_parameter = true

### Emoji

Easily use [Emoji](http://www.keitai-dev.net/Emoji) in your templates with emoji_table! emoji_table will return the correct emoji for your browser, including normal PC browsers:

    emoji_table.white_smiling_face # "☺"

### Alternate galakei views

Have a PC site that you want to add galakei templates for? Put your views in app/views.galakei and they'll be used in preference to your normal app/views

### haml

haml is great for building galakei sites, as it enforces well formed markup. galakei takes care of setting the haml template format for you, so you'll generate xhtml.

### Zenkaku to Hankaku Katakana Conversion

For galakei, zenkaku katakana such as カタカナ will be converted to hankaku like ｶﾀｶﾅ automatically when rendering html. This is standard practice, as zenkaku katakana taxes up too much screen space.

## Thanks

 * To [jpmobile](https://github.com/jpmobile/jpmobile) for offering the most mature Rails plugin for Rails
 * To [docomo_css](https://github.com/milk1000cc/docomo_css) for providing the inspiration for galakei/docomo_css
