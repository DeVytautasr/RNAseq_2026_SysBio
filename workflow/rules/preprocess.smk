input_path = config["input_path"]

rule fastp:
    input:
        # one raw fastq per sample
        lambda wc: f"{input_path}/{wc.sample}_raw.fastq"
    output:
        # ALL outputs must share the same wildcard set: {sample}
        filtered = f"{input_path}" + "/{sample}_filtered.fastq",
        html     = "results/fastp/{sample}_fastp.html",
        json     = "results/fastp/{sample}_fastp.json"
    conda: "../envs/rnaseq_preprocess.yaml"
    shell:
        """
        fastp -i {input} \
              -o {output.filtered} \
              -h {output.html} \
              -j {output.json}
        """

rule fastqc:
    input:
        # one file per (sample, stage) pair
        lambda wc: f"{input_path}/{wc.sample}_{wc.stage}.fastq"
    output:
        html = "results/fastqc/{sample}_{stage}_fastqc.html",
        zip  = "results/fastqc/{sample}_{stage}_fastqc.zip"
    conda: "../envs/rnaseq_preprocess.yaml"
    shell:
        """
        fastqc {input} --outdir results/fastqc
        """
