import UIKit

var input = """
NBOKHVHOSVKSSBSVVBCS

SN -> H
KP -> O
CP -> V
FN -> P
FV -> S
HO -> S
NS -> N
OP -> C
HC -> S
NP -> B
CF -> V
NN -> O
OS -> F
VO -> V
HK -> N
SV -> V
VC -> V
PH -> K
NH -> O
SB -> N
KS -> V
CB -> H
SS -> P
SP -> H
VN -> K
VP -> O
SK -> V
VF -> C
VV -> B
SF -> K
HH -> K
PV -> V
SO -> H
NK -> P
NO -> C
ON -> S
PB -> K
VS -> H
SC -> P
HS -> P
BS -> P
CS -> P
VB -> V
BP -> K
FH -> O
OF -> F
HF -> F
FS -> C
BN -> O
NC -> F
FC -> B
CV -> V
HN -> C
KF -> K
OO -> P
CC -> S
FF -> C
BC -> P
PP -> F
KO -> V
PC -> B
HB -> H
OB -> N
OV -> S
KH -> B
BO -> B
HV -> P
BV -> K
PS -> F
CH -> C
SH -> H
OK -> V
NB -> K
BF -> S
CO -> O
NV -> H
FB -> K
FO -> C
CK -> P
BH -> B
OH -> F
KB -> N
OC -> K
KK -> O
CN -> H
FP -> K
VH -> K
VK -> P
HP -> S
FK -> F
BK -> H
KV -> V
BB -> O
KC -> F
KN -> C
PO -> P
NF -> P
PN -> S
PF -> S
PK -> O
"""

var inputStrings = input
    .split(separator: "\n")
    .map({ String($0) })
    .filter({ $0.isEmpty == false })

var inputLine = Array(inputStrings.removeFirst())
var dict: [String: String] = [:]

inputStrings.forEach { string in
    let splitted = string
        .replacingOccurrences(of: " -> ", with: "-")
        .split(separator: "-").map({ String($0) })
    dict[splitted[0]] = splitted[1]
}

var pairCountDict: [String: Int] = [:]

for index in 0..<(inputLine.count - 1) {
    let pair = String(inputLine[index]).appending(String(inputLine[index + 1]))
    if let value = pairCountDict[pair] {
        pairCountDict[pair] = value + 1
    }
    else {
        pairCountDict[pair] = 1
    }
}

print(pairCountDict)

let stepCount = 40

for _ in 0..<stepCount {
    var nextStepPairCountDict: [String: Int] = [:]

    for (pair, pairCount) in pairCountDict {
        let newLetter = dict[String(pair)]
        let newPair1 = String(String(pair.first ?? " ") + (newLetter ?? ""))
        let newPair2 = String((newLetter ?? "") + String(pair.last ?? " "))

        if let value = nextStepPairCountDict[newPair1] {
            nextStepPairCountDict[newPair1] = value + pairCount
        }
        else {
            nextStepPairCountDict[newPair1] = pairCount
        }

        if let value = nextStepPairCountDict[newPair2] {
            nextStepPairCountDict[newPair2] = value + pairCount
        }
        else {
            nextStepPairCountDict[newPair2] = pairCount
        }
    }
    pairCountDict = nextStepPairCountDict
}

var resultDict: [String: Int] = [:]

for (pair, pairCount) in pairCountDict {
    let firstLetter = String(pair.prefix(1))
    if let firstLetterCount = resultDict[firstLetter] {
        resultDict[firstLetter] = firstLetterCount + pairCount
    }
    else {
        resultDict[firstLetter] = pairCount
    }

    let secondLetter = String(pair.suffix(1))
    if let secondLetterCount = resultDict[secondLetter] {
        resultDict[secondLetter] = secondLetterCount + pairCount
    }
    else {
        resultDict[secondLetter] = pairCount
    }
}

let resultArray = resultDict.values.map({ ($0 + 1) / 2 })
print((resultArray.max() ?? 0) - (resultArray.min() ?? 0))

