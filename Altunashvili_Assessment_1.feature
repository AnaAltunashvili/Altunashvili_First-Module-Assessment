Feature: 2.1.1 View the Start Page

Background:
	Given application URL https://qa.ddso-spot.quantori.com/ is opened
	And user clicked on "Sign in with Google" button
	And user signed in with Google account

Scenario: 2.1.1.1_01 User can see the upload dataset window
	When user opens a start page
	Then "Start Page" should become visible
	And upload dataset window should become visible
	And "Drop your CSV file here or click to browse" text in the dataset window should become visible

Scenario: 2.1.1.2_02 User can see the upload dataset list
	Given user uploaded several dataset CSV files
	When user opens a start page
	Then upload dataset window should become visible
	And uploaded dataset list should become visible
	And "Sorting buttons" should become visible
	And dataset files should be sorted by upload date

#I have created those test cases to check more functionalities and coverage.
Scenario: 2.1.1.2_03 User uploads CSV file successfully
	Given user <action> on "Upload dataset" window
	When user uploads <file> file from the local folder
	Then "<file> was successfully uploaded and is ready for use" notification should be visible in the green pop-up window
	And <file> file should be visible in the dataset list
	And "edit" and "delete" buttons on the Dataset Card should become visible

Examples:
	| action           | file      |
	| clicked          | CSV.csv   |
	| drag and dropped | CSV_2.csv |

Scenario: 2.1.1.2_04 Uploading several CSV files
	Given user <action> on "Upload dataset" window
	When user uploads <file1> file from the local folder
	And user uploades <file2> file from the local folder
	And user uploads <file3> file from the local folder
	Then new <file1>, <file2> and <file3> files should be visible in the dataset list
	And "<file1> was successfully uploaded and is ready for use" notification should be visible in the green pop-up window
	And "<file2> was successfully uploaded and is ready for use" notification should be visible in the green pop-up window
	And "<file3> was successfully uploaded and is ready for use" notification should be visible in the green pop-up window
	And "Delete" and "Edit" buttons should be active
	And "Search box" should become visible
	And "Sorting buttons" should become visible
	And dataset files should be sorted by upload date

Examples:
	| action           | file1   | file2     | file3     |
	| clicked          | CSV.csv | CSV_2.csv | CSV_3.csv |
	| drag and dropped | CSV.csv | CSV_2.csv | CSV_3.csv |

Scenario: 2.1.1.2_05 Upload files with the same file names
	Given user clicked on "Upload dataset" window
	And user uploaded "CSV.csv" file from the local folder
	And new "CSV.csv" file should be visible in the dataset list
	When user clicks on "Upload dataset" window
	And user uploads "CSV.csv" file from the local folder
	Then "Couldn't upload CSV.csv, Please check the following: Dataset name must be unique" error message should be displayed in the red pop-up window

# This scenario should be clarified with BA, because there wasn't information about the expected result
Scenario: 2.1.1.2_06 On the start page, no more 20 Dataset Cards are visible
	Given user uploaded 20 different CSV dataset files
	And user clicked on "Upload dataset" window
	When user uploads "CSV_21.csv" file from the local folder
	Then new second "Start page" should become visible
	And Start page numbers should be clickable

Scenario: 2.1.1.2_07 Uploading non-valid format dataset files
	Given user clicked on "Upload dataset" window
	When user uploads <file>  from the local folder
	Then "Could't upload <file>, Please check the following: Unsupported file type. Please upload a CVS file." error message should be displayed in the red pop-up window

Examples:
	| file      |
	| pdf.pdf   |
	| tsv.tsv   |
	| xls.xls   |
	| xlsx.xlsx |
	| txt.txt   |
	| ods.ods   |
	| doc.doc   |
	
	#This scenario should be clarified with BA, 
	#because in the upload dataset window and on the mockup is mentioned that valid CSV file size is 100MB, 
	#but in the requirements the maximum valid CVS file size is 80 MB.
Scenario: 2.1.1.2_08 Uploading exceed dataset files
	Given user clicked on "Upload dataset" window
	When user uploads <file>  from the local folder
	Then error message should be displayed: <file> can't be uploaded,Please check the following: <message> :

Examples:
	| file                | message                                     |
	| more_than_80MB.csv  | The upload file size must not exceed 80 MB. |
	| more_than_200.csv   | Not exceed 200 columns                      |
	| more_than_50000.csv | Not exceed 50 000 rows                      |

Scenario: 2.1.1.2_09 Uploading valid sized dataset files successfully
	Given user clicked on "Upload dataset" window
	When user uploads <file>  from the local folder
	Then message should be displayed: "<file> was successfully uploaded and is ready for use"

Examples:
	| file                |
	| 80MB.csv            |
	| 79MB.csv            |
	| less_than_200.csv   |
	| 200_columns.csv     |
	| less_than_50000.csv |
	| 50000_rows          |

Scenario: 2.1.1.2_10 Uploading valid named dataset files successfully
	Given user clicked on "Upload dataset" window
	When user uploads <file>  from the local folder
	Then message should be displayed: "<file> was successfully uploaded and is ready for use"

Examples:
	| file          |
	| 1234.csv      |
	| CSV.csv       |
	| ccssvv.csv    |
	| csv1.csv      |
	| CsV2.csv      |
	| csv-.csv      |
	| CSV_.csv      |
	| 123-.csv      |
	| CsV_1-2-3.csv |

Scenario: 2.1.1.2_11 Uploading dataset file name containing only valid special characters
	Given user clicked on "Upload dataset" window
	When user uploads "-_.csv"  from the local folder
	Then error message should be displayed: "Couldn't upload -_.csv, Please check the following: Dataset name must contain at least one letter or digit. Got '-_'"
	And "-_.csv" file shouldn't be visible in the dataset list
	
Scenario: 2.1.1.2_12 Uploading dataset file name containing valid and invalid characters together
	Given user clicked on "Upload dataset" window
	When user uploads <file>  from the local folder
	Then message should be displayed: "Couldn't upload <file> Please check the following:Valid characters: Latin letters, digits, spaces, underscores, hyphens, and periods. Got <'file'>"
	And <file> file shouldn't be visible in the dataset list

Examples:
	| file        |
	| 123!.csv    |
	| CSV=.csv    |
	| csv&.csv    |
	| Aa-_&.csv   |
	| Csv-1&2.csv |

Scenario: 2.1.1.4_13 Search box, sorting buttons and upload dataset list are visible
	Given user <action> on "Upload dataset" window
	When user uploads <file> file from the local folder
	Then <file> file should be visible in the dataset list
	And "<file> was successfully uploaded and is ready for use" notification should be visible in the green pop-up window
	And "Search box" should become visible
	And "Sorting buttons" should become visible
	And upload dataset list should become visible
	And upload dataset window should become visible

Examples:
	| action           | file      |
	| clicked          | CSV.csv   |
	| drag and dropped | CSV_2.csv |
	
Scenario: 2.1.1.5_14 Searching the dataset with using the search box
	Given user uploaded several files from local folder: datasetfile.csv, oldDatasetFile.csv, setdatafile.csv, file-123-_dataset.csv
	When user writes three <letters> from the dataset names in the search box
	Then user should see the matched <results>
	And user should see the searched three <letters> in dark blue color

Examples:
	| letters | results                                                                     |
	| dat     | datasetfile.csv, oldDatasetFile.csv, setdatafile.csv, file-123-_dataset.csv |
	| Dat     | datasetfile.csv, oldDatasetFile.csv, setdatafile.csv, file-123-_dataset.csv |
	| ile     | datasetfile.csv, oldDatasetFile.csv, setdatafile.csv, file-123-_dataset.csv |
	| -12     | file-123-_dataset.csv                                                       |


Scenario: 2.1.1.6_15 Search a not uploaded dataset file in the search box
	Given user uploaded "datasetfile.csv" dataset file from the local folder
	And the "datasetfile.csv" dataset was uploaded successfully
	When user writes "non" in the search box
	Then no files should appear in the dataset list
	And "Search results for “non”, We couldn’t find a match for “non”. Please try another search." notification should be visible in the dataset list

Scenario: 2.1.1.6_16 Search deleted dataset file in the search box
	Given user uploaded "datasetfile.csv" and "file-123-_dataset.csv" dataset files from the local folder
	And the "datasetfile.csv" and "file-123-_dataset.csv" dataset files were uploaded successfully
	And user deleted "file-123-_dataset.csv" dataset file from dataset list
	When user writes "123" digits in the search box
	Then no files should appear in the dataset list
	And "Search results for “123” We couldn’t find a match for “123”. Please try another search." notification should be visible in the dataset list

Scenario: 2.1.1.7_17 Search deleted dataset file
	Given user uploaded "datasetfile.csv" dataset file from the local folder
	And the "datasetfile.csv" dataset was uploaded successfully
	When user writes <letters> in the search box
	Then no files should appear in the dataset list
	And "Search results for <letters>, We couldn’t find a match for <letters>. Please try another search." notification should be visible in the dataset list

Examples:
	| letters |
	| daa     |
	| Seb     |
	| 123     |
	| F-i     |
