# Galakei: Japanese feature phone support

[Japanese feature phones](http://www.mobalean.com/en/keitai_web_technology_guide) (a.k.a., keitai, galakei) have a number of restrictions over normal web browsers.  This library adds support for them.

## Goals

 * Provide support for 3G handsets from the major 3 carriers in Japan (docomo, au, SoftBank)
 * Avoid modifying Rails internals as much as possible

## Examples

### Inlining Styles

Old docomo handsets [don't support external stylesheets](http://www.keitai-dev.net/CSS). Additionally, only very limited CSS is supported. galakei/docomo_css automatically inlines CSS and manipulates markup to overcome these limitations.

    # css file
    h1 { color: red; background-color: blue}

    # source html
    <h1>Foo</h1>

    # outputted html
    <div style="background-color: blue;"><h1><span style="color:red;">Foo</span></h1>/div>

## Thanks

 * To [jpmobile](https://github.com/jpmobile/jpmobile) for offering the most mature Rails plugin for Rails
 * To [docomo_css](https://github.com/milk1000cc/docomo_css) for providing the inspiration for galakei/docomo_css
