(def version "0.1.0-SNAPSHOT")

(set-env!
 :dependencies '[[org.clojure/clojure "1.8.0"]]
 :source-paths #{"src"})

(deftask build
  "Builds an uberjar of this project that can be run with java -jar"
  []
  (comp
   (aot :namespace '#{domcode.raffler})
   (pom :project 'domcode-raffler
        :version version)
   (uber)
   (jar :file "raffler.jar" :main 'domcode.raffler)
   (sift :include #{#"raffler.jar"})
   (target)))
