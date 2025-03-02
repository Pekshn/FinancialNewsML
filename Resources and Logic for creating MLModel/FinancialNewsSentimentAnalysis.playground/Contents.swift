import Cocoa
import CreateML
import CoreML
import TabularData

let csvFile = Bundle.main.url(forResource: "all-data", withExtension: "csv")!
let dataFrame = try DataFrame(contentsOfCSVFile: csvFile)
let classifier = try MLTextClassifier(trainingData: dataFrame, textColumn: "text", labelColumn: "sentiment")
let metadata = MLModelMetadata(author: "Petar", shortDescription: "Predicts the sentiments for financial news", version: "1.0")
let newFilePath = "/Users/petarnovakovic/Desktop/FinancialNewsSentimentAnalysis.mlmodel"
try classifier.write(toFile: newFilePath, metadata: metadata)
print(dataFrame)
