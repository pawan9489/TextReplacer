VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ediLineEPS20"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
' ===========================================================================
' Name:         ediLineEPS20
'
' Version:
'
' Description:  The definition of a EPS EDI Line
'
' History:
'
' Legal Notice: � Copyright 2013, ADP, Inc. - All rights reserved.
'
' ===========================================================================
Option Explicit

'**************************************************************************************
'PRIVATE MEMBER VARIABLES
Private IoLineRecords As ediRecords

'**************************************************************************************
'PRIVATE MEMBER CONSTANTS
Private Const strLINE_TYPE As String = "EPS"
Private Enum RecordIdentifiers
    recSummarySectionIdentifier = 1
    recTaxMonth
    recNoPayThisPeriod
    recEmploymentAllowanceIndicator
    recFinalSubCeasedIndicator
    recFinalSubForYear
    recEmployerBankAccountName
    recEmployerBankAccountNumber
    recEmployerBankAccountSortCode
    recEmployerBankAccountBuildingSociety
    recAppLevyMonth
    recNoPaymentFromDate
    recNoPaymentToDate
    recPeriodInActFromDate
    recPeriodInActToDate
    recDateSchemeCeased
    recSMPRecovered
    recSMPRecoveredAmount
    recOSPPRecovered
    recOSPPRecoveredAmount
    recSAPRecovered
    recSAPRecoveredAmount
    recASPPRecovered
    recASPPRecoveredAmount
    recNICCompOnSMP
    recNICCompOnSMPAmount
    recNICCompOnOSPP
    recNICCompOnOSPPAmount
    recNICCompOnSAP
    recNICCompOnSAPAmount
    recNICCompOnASPP
    recNICCompOnASPPAmount
    recCISDeductions
    recCISDeductionsAmount
    recAppLevyYTD
    recAppLevyYTDAmount
    recAppLevyAlloc
    recAppLevyAllocAmount
End Enum
'**************************************************************************************
'INTERFACE IMPLEMENTATION
Implements ediLine

Private Function ediLine_Deserialise(ByVal strData As String, ByRef oExceptionHandler As ediExceptionHandler) As Boolean
    ediLine_Deserialise = Deserialise(strData, oExceptionHandler)
End Function

'Rollback
Private Property Let ediLine_LineNumber(ByVal RHS As String)
    LineNumber = RHS
End Property


Private Property Get ediLine_LineNumber() As String
    ediLine_LineNumber = LineNumber
End Property

Private Property Get ediLine_LineTypeName() As String
    ediLine_LineTypeName = LineTypeName
End Property
Private Function ediLine_Serialise(ByRef oFile As ediFile, ByRef oExceptionHandler As ediExceptionHandler) As Boolean
    ediLine_Serialise = Serialise(oFile, oExceptionHandler)
End Function

Private Function ediLine_ValidLine(oExceptionHandler As ediExceptionHandler) As Boolean
    ediLine_ValidLine = ValidLine(oExceptionHandler)
End Function
Public Function ValidLine(ByRef oExceptionHandler As ediExceptionHandler) As Boolean
    ValidLine = ValidateLineRecords(IoLineRecords, oExceptionHandler)
End Function
Private Property Get LineTypeName() As String
    LineTypeName = strLINE_TYPE
End Property
Public Property Get LineNumber() As String
    Dim oRecord As ediRecordLIN1
    Set oRecord = IoLineRecords(1)
    LineNumber = oRecord.LineNumber
    Set oRecord = Nothing
End Property
Public Property Let LineNumber(ByVal Line As String)
    Dim oRecord As ediRecordLIN1
    Set oRecord = IoLineRecords(1)
    oRecord.LineNumber = Line
    Set oRecord = Nothing
End Property
Public Property Get NoPayThisPeriod() As Boolean
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recNoPayThisPeriod)
    FinalSubForYear = oRecord.Include
    Set oRecord = Nothing
End Property
Public Property Let NoPayThisPeriod(ByVal indicator As Boolean)
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recNoPayThisPeriod)
    oRecord.AttributeValue = "Y"
    oRecord.Include = indicator
    Set oRecord = Nothing
End Property
Public Property Get FinalSubCeasedIndicator() As Boolean
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recFinalSubCeasedIndicator)
    FinalSubCeasedIndicator = oRecord.Include
    Set oRecord = Nothing
End Property
Public Property Let FinalSubCeasedIndicator(ByVal indicator As Boolean)
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recFinalSubCeasedIndicator)
    oRecord.AttributeValue = "Y"
    oRecord.Include = indicator
    Set oRecord = Nothing
End Property
Public Property Get FinalSubForYear() As Boolean
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recFinalSubForYear)
    FinalSubForYear = oRecord.Include
    Set oRecord = Nothing
End Property
Public Property Let FinalSubForYear(ByVal indicator As Boolean)
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recFinalSubForYear)
    oRecord.AttributeValue = "Y"
    oRecord.Include = indicator
    Set oRecord = Nothing
End Property
Public Property Get NoPaymentFromDate() As Date
    Dim oRecord As ediRecordDTM2
    Set oRecord = IoLineRecords(recNoPaymentFromDate)
    NoPaymentFromDate = UnPackDate(oRecord.DateValue)
    Set oRecord = Nothing
End Property
Public Property Let NoPaymentFromDate(ByVal TermDate As Date)
    Dim oRecord As ediRecordDTM2
    Set oRecord = IoLineRecords(recNoPaymentFromDate)
    oRecord.DateFormat = strDATE_FORMAT_CCYYMMDD
    oRecord.DateValue = PackDate(TermDate, strDATE_FORMAT_CCYYMMDD)
    oRecord.Include = True
    
    Set oRecord = Nothing
End Property
Public Property Get NoPaymentToDate() As Date
    Dim oRecord As ediRecordDTM2
    Set oRecord = IoLineRecords(recNoPaymentToDate)
    NoPaymentToDate = UnPackDate(oRecord.DateValue)
    Set oRecord = Nothing
End Property
Public Property Let NoPaymentToDate(ByVal TermDate As Date)
    Dim oRecord As ediRecordDTM2
    Set oRecord = IoLineRecords(recNoPaymentToDate)
    oRecord.DateFormat = strDATE_FORMAT_CCYYMMDD
    oRecord.DateValue = PackDate(TermDate, strDATE_FORMAT_CCYYMMDD)
    oRecord.Include = True
    Set oRecord = Nothing
End Property
Public Property Get PeriodInActivityFromDate() As Date
    Dim oRecord As ediRecordDTM2
    Set oRecord = IoLineRecords(recPeriodInActFromDate)
    PeriodInActivityFromDate = UnPackDate(oRecord.DateValue)
    Set oRecord = Nothing
End Property
Public Property Let PeriodInActivityFromDate(ByVal TermDate As Date)
    Dim oRecord As ediRecordDTM2
    Set oRecord = IoLineRecords(recPeriodInActFromDate)
    oRecord.DateFormat = strDATE_FORMAT_CCYYMMDD
    oRecord.DateValue = PackDate(TermDate, strDATE_FORMAT_CCYYMMDD)
    oRecord.Include = True
    Set oRecord = Nothing
End Property
Public Property Get PeriodInActivityToDate() As Date
    Dim oRecord As ediRecordDTM2
    Set oRecord = IoLineRecords(recPeriodInActToDate)
    PeriodInActivityToDate = UnPackDate(oRecord.DateValue)
    Set oRecord = Nothing
End Property
Public Property Let PeriodInActivityToDate(ByVal TermDate As Date)
    Dim oRecord As ediRecordDTM2
    Set oRecord = IoLineRecords(recPeriodInActToDate)
    oRecord.DateFormat = strDATE_FORMAT_CCYYMMDD
    oRecord.DateValue = PackDate(TermDate, strDATE_FORMAT_CCYYMMDD)
    oRecord.Include = True
    Set oRecord = Nothing
End Property
Public Property Get DateSchemeCeased() As Date
    Dim oRecord As ediRecordDTM2
    Set oRecord = IoLineRecords(recDateSchemeCeased)
    DateSchemeCeased = UnPackDate(oRecord.DateValue)
    Set oRecord = Nothing
End Property
Public Property Let DateSchemeCeased(ByVal TermDate As Date)
    Dim oRecord As ediRecordDTM2
    Set oRecord = IoLineRecords(recDateSchemeCeased)
    oRecord.DateFormat = strDATE_FORMAT_CCYYMMDD
    oRecord.DateValue = PackDate(TermDate, strDATE_FORMAT_CCYYMMDD)
    oRecord.Include = True
    Set oRecord = Nothing
End Property

Public Property Get SMPRecovered() As Double
    SMPRecovered = GetMonetaryAmount(recSMPRecoveredAmount)
End Property
Public Property Let SMPRecovered(ByVal SMP As Double)
    SetMonetaryAmount recSMPRecoveredAmount, SMP
End Property

Public Property Get OSPPRecovered() As Double
    OSPPRecovered = GetMonetaryAmount(recOSPPRecoveredAmount)
End Property
Public Property Let OSPPRecovered(ByVal SPP As Double)
    SetMonetaryAmount recOSPPRecoveredAmount, SPP
End Property
Public Property Get SAPRecovered() As Double
    SAPRecovered = GetMonetaryAmount(recSAPRecoveredAmount)
End Property
Public Property Let SAPRecovered(ByVal ASPP As Double)
    SetMonetaryAmount recSAPRecoveredAmount, ASPP
End Property
Public Property Get ASPPRecovered() As Double
    ASPPRecovered = GetMonetaryAmount(recASPPRecoveredAmount)
End Property
Public Property Let ASPPRecovered(ByVal SSP As Double)
    SetMonetaryAmount recASPPRecoveredAmount, SSP
End Property

Public Property Get NICCompOnSMP() As Double
    NICCompOnSMP = GetMonetaryAmount(recNICCompOnSMPAmount)
End Property
Public Property Let NICCompOnSMP(ByVal StudentLoan As Double)
    SetMonetaryAmount recNICCompOnSMPAmount, StudentLoan
End Property

Public Property Get NICCompOnOSPP() As Double
    NICCompOnOSPP = GetMonetaryAmount(recNICCompOnOSPPAmount)
End Property
Public Property Let NICCompOnOSPP(ByVal Tax As Double)
    SetMonetaryAmount recNICCompOnOSPPAmount, Tax
End Property

Public Property Get NICCompOnSAP() As Double
    NICCompOnSAP = GetMonetaryAmount(recNICCompOnSAPAmount)
End Property
Public Property Let NICCompOnSAP(ByVal TaxFreeIncentiveAmount As Double)
    SetMonetaryAmount recNICCompOnSAPAmount, TaxFreeIncentiveAmount
End Property

Public Property Get NICCompOnASPP() As Double
    NICCompOnASPP = GetMonetaryAmount(recNICCompOnASPPAmount)
End Property
Public Property Let NICCompOnASPP(ByVal TaxCredit As Double)
    SetMonetaryAmount recNICCompOnASPPAmount, TaxCredit
End Property

Public Property Get CISDeductions() As Double
    CISDeductions = GetMonetaryAmount(recCISDeductionsAmount)
End Property
Public Property Let CISDeductions(ByVal Tax As Double)
    SetMonetaryAmount recCISDeductionsAmount, Tax
End Property

Public Property Get EmployerBankAccountName() As String
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recEmployerBankAccountName)
    EmployerBankAccountName = oRecord.AttributeValue
    Set oRecord = Nothing
End Property
Public Property Let EmployerBankAccountName(ByVal Value As String)
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recEmployerBankAccountName)
    oRecord.AttributeValue = Value
    Set oRecord = Nothing
End Property

Public Property Get EmployerBankAccountNumber() As String
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recEmployerBankAccountNumber)
    EmployerBankAccountNumber = oRecord.AttributeValue
    Set oRecord = Nothing
End Property
Public Property Let EmployerBankAccountNumber(ByVal Value As String)
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recEmployerBankAccountNumber)
    oRecord.AttributeValue = Value
    Set oRecord = Nothing
End Property

Public Property Get EmployerBankAccountSortCode() As String
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recEmployerBankAccountSortCode)
    EmployerBankAccountSortCode = oRecord.AttributeValue
    Set oRecord = Nothing
End Property
Public Property Let EmployerBankAccountSortCode(ByVal Value As String)
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recEmployerBankAccountSortCode)
    oRecord.AttributeValue = Value
    Set oRecord = Nothing
End Property

Public Property Get EmployerBankAccountBuildingSociety() As String
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recEmployerBankAccountBuildingSociety)
    EmployerBankAccountBuildingSociety = oRecord.AttributeValue
    Set oRecord = Nothing
End Property
Public Property Let EmployerBankAccountBuildingSociety(ByVal Value As String)
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recEmployerBankAccountBuildingSociety)
    oRecord.AttributeValue = Value
    Set oRecord = Nothing
End Property

Public Property Get EmploymentAllowance() As Boolean
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recEmploymentAllowanceIndicator)
    EmploymentAllowance = (oRecord.AttributeValue = "Y")
    Set oRecord = Nothing
End Property
Public Property Let EmploymentAllowance(ByVal indicator As Boolean)
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recEmploymentAllowanceIndicator)
    oRecord.AttributeValue = IIf(indicator = True, "Y", "N")
    oRecord.Include = True
    Set oRecord = Nothing
End Property
Public Property Get TaxMonth() As String
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recTaxMonth)
    TaxMonth = oRecord.AttributeValue
    Set oRecord = Nothing
End Property
Public Property Let TaxMonth(ByVal Value As String)
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recTaxMonth)
    oRecord.AttributeValue = Value
    Set oRecord = Nothing
End Property
Public Property Get AppLevyYTD() As Double
    AppLevyYTD = GetMonetaryAmount(recAppLevyYTDAmount)
End Property
Public Property Let AppLevyYTD(ByVal ALYTD As Double)
    SetMonetaryAmount recAppLevyYTDAmount, ALYTD
End Property
Public Property Get AppLevyMonth() As String
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recAppLevyMonth)
    TaxMonth = oRecord.AttributeValue
    Set oRecord = Nothing
End Property
Public Property Let AppLevyMonth(ByVal Value As String)
    Dim oRecord As ediRecordATT2
    Set oRecord = IoLineRecords(recAppLevyMonth)
    oRecord.AttributeValue = Value
    Set oRecord = Nothing
End Property
Public Property Get AppLevyAlloc() As Double
    AppLevyAlloc = GetMonetaryAmount(recAppLevyAllocAmount)
End Property
Public Property Let AppLevyAlloc(ByVal ALAlloc As Double)
    SetMonetaryAmount recAppLevyAllocAmount, ALAlloc
End Property

'**************************************************************************************
'PUBLIC METHODS
Public Function Serialise(ByRef oFile As ediFile, ByRef oExceptionHandler As ediExceptionHandler) As Boolean
    Dim oRecord As ediRecord

    'are we good to go?

    'yes, then lets serialise
    For Each oRecord In IoLineRecords
        If OutputRecord(oRecord) Then
            oFile.WriteLine oRecord.Serialise
        End If
    Next

End Function

Public Function Deserialise(ByVal strData As String, ByRef oExceptionHandler As ediExceptionHandler) As Boolean
    'not implemented
    Dim oRecord As ediRecord
    
    Set oRecord = CreateRecordFromString(strData, oExceptionHandler)
    Deserialise = AssignRecord(oRecord, IoLineRecords, strData)
    
End Function





'**************************************************************************************
'PRIVATE IMPLEMENTATION
Private Function DefineRecord()
    Dim oRecord As ediRecord
    
    Set IoLineRecords = New ediRecords
    With IoLineRecords
    
        'section identifier
        Set oRecord = New ediRecordUNS2
        With oRecord
            .RecordStatus = ediRecordMandatory
        End With
        .Add oRecord
        
        'Tax Month
        Set oRecord = New ediRecordATT2
        With oRecord
            .RecordStatus = ediRecordMandatory
            .Qualifier = strQUALIFIER_ATT_EPS_TAX_MONTH '241
        End With
        .Add oRecord
        
        'No payment This Period
        Set oRecord = New ediRecordATT2
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_ATT_NO_PAY_THIS_PERIOD '200
        End With
        .Add oRecord
        
        'Employment allowance indicator
        Set oRecord = New ediRecordATT2
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_ATT_EMPLOYMENT_ALLOWANCE
        End With
        .Add oRecord
                
       'Final Submission Ceased Indicator
        Set oRecord = New ediRecordATT2
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_ATT_FINAL_SUBMISSION_CEASED '220
            .Name = "Final Submission Ceased Indicator"
        End With
        .Add oRecord
        
         'Final submission for the year
        Set oRecord = New ediRecordATT2
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_ATT_FINAL_SUBMISSION_FOR_YEAR '221
            .Name = "Final submission for the year"
        End With
        .Add oRecord
        
        'Employer bank account name
        Set oRecord = New ediRecordATT2
        With oRecord
            .RecordStatus = ediRecordConditional
            .Qualifier = strQUALIFIER_ATT_EMP_BANK_ACCOUNT_NAME
            .Name = "Employer bank account name"
        End With
        .Add oRecord

         'Employer bank account number
        Set oRecord = New ediRecordATT2
        With oRecord
            .RecordStatus = ediRecordConditional
            .Qualifier = strQUALIFIER_ATT_EMP_BANK_ACCOUNT_NUMBER
            .Name = "Employer bank account number"
        End With
        .Add oRecord
        
         'Employer bank account sort code
        Set oRecord = New ediRecordATT2
        With oRecord
            .RecordStatus = ediRecordConditional
            .Qualifier = strQUALIFIER_ATT_EMP_BANK_SORT_CODE
            .Name = "Employer bank account sort code"
        End With
        .Add oRecord
        
         'Employer bank account - building society reference
        Set oRecord = New ediRecordATT2
        With oRecord
            .RecordStatus = ediRecordConditional
            .Qualifier = strQUALIFIER_ATT_EMP_BANK_BUILDING_SOC_REF
            .Name = "Employer bank account - building society reference"
        End With
        .Add oRecord
        
          'Apprenticeship Levy Month
        Set oRecord = New ediRecordATT2
        With oRecord
            .RecordStatus = ediRecordMandatory
            .Qualifier = strQUALIFIER_ATT_EPS_APP_LEVY_MONTH '251
        End With
        .Add oRecord
        
         'No payment From date
        Set oRecord = New ediRecordDTM2
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_ATT_NO_PAYMENT_FROM_DATE '351
            .Name = "No payment From date"
        End With
        .Add oRecord
        
         'No payment To date
        Set oRecord = New ediRecordDTM2
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_ATT_NO_PAYMENT_TO_DATE '352
            .Name = "No payment To date"
        End With
        .Add oRecord
        
        'Period of inactivity from date
        Set oRecord = New ediRecordDTM2
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_ATT_PERIOD_INACTIVITY_FROM_DATE '353
            .Name = "Period of inactivity from date"
        End With
        .Add oRecord
        
        'Period of inactivity To date
        Set oRecord = New ediRecordDTM2
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_ATT_PERIOD_INACTIVITY_TO_DATE '354
            .Name = "Period of inactivity To date"
        End With
        .Add oRecord
        
       'Date scheme ceased
        Set oRecord = New ediRecordDTM2
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_ATT_DATE_SCHEME_CEASED '338
            .Name = "Date scheme ceased"
        End With
        .Add oRecord
    
        'SMP Recovered
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_TOTAL_SMP '36
            .HasChildRecord = True
            .Name = "SMP Recovered"
        End With
        .Add oRecord
    
        'SMP Recovered
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recSMPRecovered)
            .Name = "SMP Recovered"
        End With
        .Add oRecord
    
        'SPP recovered
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_TOTAL_SPP '128
            .HasChildRecord = True
            .Name = "SPP recovered"
        End With
        .Add oRecord
    
        'SPP recovered
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recOSPPRecovered)
            .Name = "SPP recovered"
        End With
        .Add oRecord
    
    
        'SAP Recovered
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_TOTAL_SAP '130
            .HasChildRecord = True
            .Name = "SAP Recovered"
        End With
        .Add oRecord
    
        'SAP Recovered
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recSAPRecovered)
            .Name = "SAP Recovered"
        End With
        .Add oRecord
    
    
        'ASPP Recovered
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_TOTAL_ASPP '138
            .HasChildRecord = True
            .Name = "ASPP Recovered"
        End With
        .Add oRecord
    
        'ASPP Recovered
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recASPPRecovered)
            .Name = "ASPP Recovered"
        End With
        .Add oRecord
    
    
        'NIC Compensation on SMP
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_NICS_COMPENSATION_FOR_SMP '33
            .HasChildRecord = True
            .Name = "NIC Compensation on SMP"
        End With
        .Add oRecord
    
        'NIC Compensation on SMP
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recNICCompOnSMP)
            .Name = "NIC Compensation on SMP"
        End With
        .Add oRecord
    
    
        'NIC Compensation on SPP
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_NICS_COMPENSATION_FOR_SPP '129
            .HasChildRecord = True
            .Name = "NIC Compensation on SPP"
        End With
        .Add oRecord
    
        'NIC Compensation on SPP
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recNICCompOnOSPP)
            .Name = "NIC Compensation on SPP"
        End With
        .Add oRecord
    
    
        'NIC Compensation on SAP
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_NICS_COMPENSATION_FOR_SAP '131
            .HasChildRecord = True
            .Name = "NIC Compensation on SAP"
        End With
        .Add oRecord
    
        'NIC Compensation on SAP
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recNICCompOnSAP)
            .Name = "NIC Compensation on SAP"
        End With
        .Add oRecord
    
    
        'NIC Compensation on ASPP
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_NICS_COMPENSATION_FOR_ASPP '139
            .HasChildRecord = True
            .Name = "NIC Compensation on ASPP"
        End With
        .Add oRecord
    
        'NIC Compensation on ASPP
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recNICCompOnASPP)
            .Name = "NIC Compensation on ASPP"
        End With
        .Add oRecord
    
    
        'CIS Deductions Suffered
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_CIS_DEDUCTIONS '122
            .HasChildRecord = True
            .Name = "CIS Deductions Suffered"
        End With
        .Add oRecord
    
        'CIS Deductions Suffered
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recCISDeductions)
            .Name = "CIS Deductions Suffered"
        End With
        .Add oRecord
        
        'Apprenticeship Levy YTD
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_APP_LEVY_YTD '184
            .HasChildRecord = True
            .Name = "Apprenticeship Levy YTD"
        End With
        .Add oRecord
        
        'Apprenticeship Levy YTD
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recAppLevyYTD)
            .Name = "Apprenticeship Levy YTD"
        End With
        .Add oRecord
        
        'Apprenticeship Levy Allocated
        Set oRecord = New ediRecordTAX1
        With oRecord
            .RecordStatus = ediRecordDependent
            .Qualifier = strQUALIFIER_TAX_APP_LEVY_ALLOC '185
            .HasChildRecord = True
            .Name = "Apprenticeship Levy Allocated"
        End With
        .Add oRecord
        
        'Apprenticeship Levy Allocated
        Set oRecord = New ediRecordMOA1
        With oRecord
            .RecordStatus = ediRecordDependent
            Set .ParentRecord = IoLineRecords(recAppLevyAlloc)
            .Name = "Apprenticeship Levy Allocated"
        End With
        .Add oRecord
        
    End With
End Function

Private Function GetMonetaryAmount(ByVal lRecordNumber As RecordIdentifiers) As Double
    Dim oRecord As ediRecordMOA1
    Set oRecord = IoLineRecords(lRecordNumber)
    With oRecord
        If .MonetaryAmount = vbNullString Then
            If .Include Then
                GetMonetaryAmount = 0#
            Else
                GetMonetaryAmount = CStr(dblNULL_DOUBLE)
            End If
        Else
            GetMonetaryAmount = .MonetaryAmount / 100
        End If
    End With
    Set oRecord = Nothing
End Function

Private Sub SetMonetaryAmount(ByVal lRecordNumber As RecordIdentifiers, ByVal Value As Double)
    Dim oChild As ediRecord
    Dim oRecord As ediRecordMOA1
    Set oRecord = IoLineRecords(lRecordNumber)
    With oRecord
        If Value < 0 Then
            .MonetaryAmount = 0
        Else
            .MonetaryAmount = Value * 100
        End If
        
        'decide whether or not to include the record in the output file
        Select Case Value
        Case -999
            .Include = False
        Case Else
            .Include = True
        End Select
        
        'show the indicator if applicable
        Set oChild = oRecord
        oChild.ParentRecord.Include = oChild.Include
        Set oChild = Nothing
    End With
    
    Set oRecord = Nothing
End Sub


'**************************************************************************************
'PRIVATE MEMBER EVENTS
Private Sub Class_Initialize()
    'set up the records collection
    DefineRecord
End Sub

Private Sub Class_Terminate()
    Set IoLineRecords = Nothing
End Sub




