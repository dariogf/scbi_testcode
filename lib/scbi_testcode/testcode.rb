#!/usr/bin/env ruby

class Testcode


  attr_accessor :testcode_value,:coding_conclusion
  
  def initialize(sequence)

    @testcode_value=testcode_calculation(sequence)
    @coding_conclusion=getConclusion(@testcode_value)
  end
  
  def testcode_calculation(sequence)
    sequence.downcase!
    basesOne = [0,0,0,0];
    basesTwo = [0,0,0,0];
    basesThree = [0,0,0,0];

    #for (j = 0; j < sequence.length; j = j + 3)
    0.step(sequence.length-1,3) do |j|
      if (sequence[j].chr == "g")
        basesOne[0] = basesOne[0] + 1;
      elsif (sequence[j].chr == "a")
        basesOne[1] = basesOne[1] + 1;
      elsif (sequence[j].chr == "t")
        basesOne[2] = basesOne[2] + 1;
      elsif (sequence[j].chr == "c")
        basesOne[3] = basesOne[3] + 1;
      else
      end
    end

    #for (j = 1; j < sequence.length; j = j + 3)
    1.step(sequence.length-1,3) do |j|
      if (sequence[j].chr == "g")
        basesTwo[0] = basesTwo[0] + 1;
      elsif (sequence[j].chr == "a")
        basesTwo[1] = basesTwo[1] + 1;
      elsif (sequence[j].chr == "t")
        basesTwo[2] = basesTwo[2] + 1;
      elsif (sequence[j].chr == "c")
        basesTwo[3] = basesTwo[3] + 1;
      else
      end
    end


    #for (j = 2; j < sequence.length; j = j + 3)
    2.step(sequence.length-1,3) do |j|
      if (sequence[j].chr == "g")
        basesThree[0] = basesThree[0] + 1;
      elsif (sequence[j].chr == "a")
        basesThree[1] = basesThree[1] + 1;
      elsif (sequence[j].chr == "t")
        basesThree[2] = basesThree[2] + 1;
      elsif (sequence[j].chr == "c")
        basesThree[3] = basesThree[3] + 1;
      else
      end
    end

    paramG = calcParam(basesOne[0],basesTwo[0],basesThree[0]);
    contentG = countBases(basesOne[0],basesTwo[0],basesThree[0]) / sequence.length.to_f;
    posProbG = usePosParam(paramG,"g");
    contProbG = useContParam(contentG,"g");
    paramA = calcParam(basesOne[1],basesTwo[1],basesThree[1]);
    contentA = countBases(basesOne[1],basesTwo[1],basesThree[1]) / sequence.length.to_f;
    posProbA = usePosParam(paramA,"a");
    contProbA = useContParam(contentA,"a");
    paramT = calcParam(basesOne[2],basesTwo[2],basesThree[2]);
    contentT = countBases(basesOne[2],basesTwo[2],basesThree[2]) / sequence.length.to_f;
    posProbT = usePosParam(paramT,"t");
    contProbT = useContParam(contentT,"t");
    paramC = calcParam(basesOne[3],basesTwo[3],basesThree[3]);
    contentC = countBases(basesOne[3],basesTwo[3],basesThree[3]) / sequence.length.to_f;
    posProbC = usePosParam(paramC,"c");
    contProbC = useContParam(contentC,"c");
    valueY = posProbG * 0.31 + contProbG * 0.15 + posProbA * 0.26 + contProbA * 0.11 + posProbT * 0.33 + contProbT * 0.14 + posProbC * 0.18 + contProbC * 0.12;
    valueY = ((valueY*1000.0).round/1000.0);
    # return 'The TestCode value is <b>' + valueY.to_s + '</b>, which indicates that the sequence ' + getConclusion(valueY) + '.';
    return valueY
  end


  def calcParam (valueOne,valueTwo,valueThree)
    paramArray = [valueOne,valueTwo,valueThree];
    paramArray = paramArray.sort#{|a,b| return a-b}#(compareNumbers);
    paramValue = paramArray[2] / (paramArray[0] + 1.0);
    #puts paramArray.to_json
    return paramValue;
  end

  def countBases (valueOne,valueTwo,valueThree)
    return valueOne + valueTwo + valueThree;
  end

  def usePosParam (paramValue,base)
    arrayOfCodingProb = [];
    codeProb = 0;
    if (base == "g")
      arrayOfCodingProb = [0.08,0.08,0.16,0.27,0.48,0.53,0.64,0.74,0.88,0.90]
    elsif (base == "a")
      arrayOfCodingProb = [0.22,0.20,0.34,0.45,0.68,0.58,0.93,0.84,0.68,0.94]
    elsif (base == "t")
      arrayOfCodingProb = [0.09,0.09,0.20,0.54,0.44,0.69,0.68,0.91,0.97,0.97]
    elsif (base == "c")
      arrayOfCodingProb = [0.23,0.30,0.33,0.51,0.48,0.66,0.81,0.70,0.70,0.80]
    end


    if (paramValue >= 0 and paramValue < 1.1)
      codeProb = arrayOfCodingProb[0];
    elsif (paramValue >=1.1 and paramValue < 1.2)
      codeProb = arrayOfCodingProb[1];
    elsif (paramValue >=1.2 and paramValue < 1.3)
      codeProb = arrayOfCodingProb[2];
    elsif (paramValue >=1.3 and paramValue < 1.4)
      codeProb = arrayOfCodingProb[3];
    elsif (paramValue >=1.4 and paramValue < 1.5)
      codeProb = arrayOfCodingProb[4];
    elsif (paramValue >=1.5 and paramValue < 1.6)
      codeProb = arrayOfCodingProb[5];
    elsif (paramValue >=1.6 and paramValue < 1.7)
      codeProb = arrayOfCodingProb[6];
    elsif (paramValue >=1.7 and paramValue < 1.8)
      codeProb = arrayOfCodingProb[7];
    elsif (paramValue >=1.8 and paramValue < 1.9)
      codeProb = arrayOfCodingProb[8];
    elsif (paramValue >=1.9)
      codeProb = arrayOfCodingProb[9];
    end

    return codeProb;
  end
  def useContParam (paramValue,base)
    arrayOfCodingProb = [];
    codeProb = 0;
    if (base == "g")
      arrayOfCodingProb = [0.29,0.33,0.41,0.41,0.73,0.64,0.64,0.47,0.54,0.40]
    elsif (base == "a")
      arrayOfCodingProb = [0.21,0.81,0.65,0.67,0.49,0.62,0.55,0.44,0.49,0.28]
    elsif (base == "t")
      arrayOfCodingProb = [0.58,0.51,0.69,0.56,0.75,0.55,0.40,0.39,0.24,0.28]
    elsif (base == "c")
      arrayOfCodingProb = [0.31,0.39,0.44,0.43,0.59,0.59,0.64,0.51,0.64,0.82]
    end

    if (paramValue >= 0 and paramValue < 0.17)
      codeProb = arrayOfCodingProb[0];
    elsif (paramValue >=0.17 and paramValue < 0.19)
      codeProb = arrayOfCodingProb[1];
    elsif (paramValue >=0.19 and paramValue < 0.21)
      codeProb = arrayOfCodingProb[2];
    elsif (paramValue >=0.21 and paramValue < 0.23)
      codeProb = arrayOfCodingProb[3];
    elsif (paramValue >=0.23 and paramValue < 0.25)
      codeProb = arrayOfCodingProb[4];
    elsif (paramValue >=0.25 and paramValue < 0.27)
      codeProb = arrayOfCodingProb[5];
    elsif (paramValue >=0.27 and paramValue < 0.29)
      codeProb = arrayOfCodingProb[6];
    elsif (paramValue >=0.29 and paramValue < 0.31)
      codeProb = arrayOfCodingProb[7];
    elsif (paramValue >=0.31 and paramValue < 0.33)
      codeProb = arrayOfCodingProb[8];
    elsif (paramValue >=0.33)
      codeProb = arrayOfCodingProb[9];
    end

    return codeProb;
  end


  def getConclusion (testCode)
    codeProb = :non_coding;
    if (testCode < 0.74)
      codeProb = :non_coding;
    elsif (testCode >=0.74 and testCode < 0.95)
      codeProb = :unknown;
    elsif (testCode >=0.95)
      codeProb = :coding;
    end

    return codeProb;
  end
  
  
end

#The Sequence Manipulation Suite: TestCode
#Results for 1329 residue sequence "sample sequence" starting "gcagcccagc".
#The TestCode value is 1.236, which indicates that the sequence is coding.
