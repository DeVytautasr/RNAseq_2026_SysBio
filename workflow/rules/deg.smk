rule deg:
    input:
        count_matrix = "data/count_matrix.RDS",
        samplesheet  = config["samplesheet"]
    output:
        "results/DEG/DEG_report.html"
    params:
        samples = config["samples"]
    conda:
        "../envs/deg.yaml"
    script:
        "../../src/deg.Rmd"
