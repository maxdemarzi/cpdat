# cpdat
Chemical and Products Database as a Graph

Data Sources:

- [CPDat](https://gaftp.epa.gov/COMPTOX/Sustainable_Chemistry_Data/Chemistry_Dashboard/CPDat/CPDat2020-12-16/)

Schema:

File: chemical_dictionary_20201216.csv

    Chemical(chemical_id)
        name:string
        casrn:string
        preferred_name:string
        preferred_casrn:string
        DTXSID:string
        curation_level:string

File: document_dictionary_20201216.csv

    Document(document_id)
        title:string
        subtitle:string
        date:string // Not date because formatting is not standard, would have to clean up before proper import as date
                    // "06.20.2016", "13-May-2015", "13/08/2014"

File: HHE_data_20201216.csv

    HAS_CHEMICAL(document_id, chemical_id)

File: functional_use_dictionary_20201216.csv

    Function_Category(oecd_function)
    Function(report_funcuse)
    Function_Use(functional_use_id)

    HAS_FUNCTION(oecd_function, report_funcuse)
    HAS_USE(report_funcuse, functional_use_id)
    USES_CHEMICAL(functional_use_id, chemical_id)

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

    HAS_FAMILY(gen_cat, prod_fam)
    HAS_TYPE(prod_fam, puc_id)