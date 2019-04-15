from flask import Flask,render_template,url_for,request
import re
import pandas as pd
import spacy
from spacy import displacy

nlp = spacy.load('en_core_web_md')

app = Flask(__name__)

@app.route('/')
def index():
	return render_template("index.html")

@app.route('/process',methods=["POST"])
def process():
	if request.method == 'POST':
		rawtext = request.form['rawtext']
		rawtext2 = request.form['rawtext2']
		doc1 = nlp(rawtext)
		doc2 = nlp(rawtext2)
		sim_score = doc1.similarity(doc2)

	return render_template("index.html",results=sim_score)


if __name__ == '__main__':
	app.run(debug=True)
