(ns domcode.raffler
  (:require [clojure.string :as str])
  (:gen-class))

(defn -main [file]
  (-> file
      slurp
      (str/split #"\n")
      rand-nth
      println))
