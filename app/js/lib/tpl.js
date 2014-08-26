define(['text'], function(text) {
  var r = {
      interpolate: /<%=([\s\S]+?)%>/g,
      path: /(.+)\/([^/]+)/
    },
    buildMap = {},      // store dependencies' contents, since onLoad returns undefined in build phase
    buildMapFinal = {}, // store resulting templates, which will be written as modules to the final build file
    recurLvl = 0;       // since optimization is in synchronous mean, it is safe to use this to detect if the call is from dependent template or from resulting template

  return {
    load : function(name, req, onLoad, config) {
      function toUrl(n) {
        return req.toUrl('html/'+n) + '.html'; // change the basePath to html folder
      }
      text.get(toUrl(name), function(mod) {
        var m = mod.match(r.interpolate);
        if (m && m.length > 0) {
          m = m.filter(function (elem, pos) {
            return m.indexOf(elem) == pos;
          });

          for(var i = 0, ii = m.length, deps = []; i < ii; i++) {
            deps.push(
              m[i].replace(r.interpolate, function (m, c) {
                c = c.trim();
                if (c.charAt(0) == '/') { // it means absolute path
                  c = c.substring(1); // remove the first '/'
                } else {
                  c = name.match(r.path)[1] + '/' + c; // include the relative base path
                }
                return 'tpl!' + c;
              })
            );
          }
          recurLvl++;
          req(deps, function () {
            recurLvl--;
            for (var i = 0, ii = deps.length; i < ii; i++) {
              if (config.isBuild) {
                mod = mod.replace(new RegExp(m[i], 'g'), buildMap[deps[i].replace('tpl!', '')]);
              } else {
                mod = mod.replace(new RegExp(m[i], 'g'), arguments[i]);
              }
            }
            if (config.isBuild) {
              if (recurLvl > 0)
                buildMap[name] = mod;
              else
                buildMapFinal[name] = mod;
            }
            onLoad(mod);
          });
        } else {
          if (config.isBuild) {
            if (recurLvl > 0)
              buildMap[name] = mod;
            else
              buildMapFinal[name] = mod;
          }
          onLoad(mod);
        }
      });
    },
    write: function (pluginName, moduleName, write, config) {
      if (buildMapFinal.hasOwnProperty(moduleName)) {
        var content = text.jsEscape(buildMapFinal[moduleName].replace(/[\r\t\f ]+/g, " ")); // remove extra white spaces, except new line character
        write.asModule(pluginName + "!" + moduleName, "define(function () { return '" + content + "';});\n");
      }
    }
  };
});
