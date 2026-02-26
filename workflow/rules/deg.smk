rule deg:
    input:
        counts  = expand(
            "results/counts/{sample}.featureCounts.txt.summary",
            sample=config["samples"]
        ),
        samplesheet = config["samplesheet"]
    output:
        "results/DEG/DEG_report.html"
    conda:
        "../envs/deg.yaml"
    script:
        "../../src/deg.Rmd"
