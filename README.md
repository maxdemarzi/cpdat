# cpdat
Chemical and Products Database as a Graph

Data Sources:

- [CPDat](https://gaftp.epa.gov/COMPTOX/Sustainable_Chemistry_Data/Chemistry_Dashboard/CPDat/CPDat2020-12-16/)

Schema:

File: list_presence_dictionary_20201216.csv

    Reason_Listed(list_presence_id)
        name:string
        definition:string
        kind:string



File: PUC_dictionary_20201216.csv

    PUC_Category(gen_cat)
    PUC_Family(prod_fam)
    PUC_Type(puc_id)
        name:String
        description:string
        code:String
        kind:String