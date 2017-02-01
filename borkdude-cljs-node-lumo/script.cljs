(ns domcode.raffler
  (:require [clojure.string :as str]
            [lumo.core :as lumo]))

(defn slurp [f]
  (let [fs (js/require "fs")]
    (.readFileSync
     fs f
     (clj->js
      {:encoding "UTF-8"}))))

(if-let [file (first lumo/*command-line-args*)]
  (-> file
      slurp
      (str/split #"\n")
      rand-nth
      println)
  (println "No file argument provided."))
