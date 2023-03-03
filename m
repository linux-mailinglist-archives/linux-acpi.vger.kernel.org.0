Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5456A9B58
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 17:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCCQGC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 11:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCCQGB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 11:06:01 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CC616305
        for <linux-acpi@vger.kernel.org>; Fri,  3 Mar 2023 08:05:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s11so12208042edy.8
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2023 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdqrjc1pgikpMKF5PbXM2gjCoZe2CVGirbF1d+RRhCY=;
        b=JeQfAioo6oFj+KRaBzFsCj5bb9x3TRw3wgo0wrhMuuQvMR9U2Au84lRqsjAG2iu3C4
         fwmjjpgNn2ru5NY0KhiRIcK0EzA/rz2IAaqwebg1j5n664NCL5jGZZrsp863P3xXASWK
         7PXuZE988cbbV3B2xjgokMIWShOseKXguLUmq9rzC1OiWW4MrdVyCLNNyYzK1RSQ3cCW
         VJo3LOLgIVd507nXL4J8q7nCP84NCXhIJu2wuo4UnB34FsJWfpijy6YkhZiQOUwCT+Ei
         B0dVCW4ASjoFHqR1afRvAZSequHTxekW21McCWa2wrdNJGfVxFuLGWnHKKTkkTMhmGEw
         lgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdqrjc1pgikpMKF5PbXM2gjCoZe2CVGirbF1d+RRhCY=;
        b=3T9hO/zoEIMhqDQoeTXnY2pnpMPM2TpQCxGjTD4GaENpsOQyIiKtdGUGI+RznFWr8k
         7MBJuMPHJW4HDxGicHi0iC9hLn5YKsN1RDJFu2c6wMITQNIQgMVmqIMWYmlHiwwtQ/Ew
         J0H1wPsyx6BsedFNeQzgHSYmwR4Sb3h1s4e/tx1AOKZVAjF60J6EKTM7L5R4XJ+7W1bx
         JLK7dLhbxdLlcqL6Ybicz+yjXx6YLSGwsHmdfOTzznCKhpLpyl3oEqk8SDdANDNU+ASK
         1T6n50wOkwtkZXMD6eD0xF2MwbNr4pSfmGkmYTMvKy+2EdtUPwksjBg9zoZebMJNoNRW
         /fSg==
X-Gm-Message-State: AO0yUKVZo2ojZegMZ24/RHOLzkmcdO+o03kpOoHGNX3IecWnKDbLuT9o
        QdjAy3Rpe8DsXp1QUZ36KJ6oZQ==
X-Google-Smtp-Source: AK7set8EfOP27papyNPQmRFQWhUVEaWFLkUJ0APxQYh53vl+XhNDfZeeHrfzIrq11w3kaokKnHWDWA==
X-Received: by 2002:a17:907:b15:b0:872:27cb:9436 with SMTP id h21-20020a1709070b1500b0087227cb9436mr1927396ejl.43.1677859557288;
        Fri, 03 Mar 2023 08:05:57 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ga1-20020a170906b84100b008b17879ec95sm1089916ejb.22.2023.03.03.08.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 08:05:56 -0800 (PST)
Date:   Fri, 3 Mar 2023 17:05:56 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 11/20] RISC-V: ACPI: Cache and retrieve the RINTC
 structure
Message-ID: <20230303160556.lezccmwa7ymymxws@orel>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-12-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-12-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 03, 2023 at 07:06:38PM +0530, Sunil V L wrote:
> RINTC structures in the MADT provide mapping between the hartid
> and the CPU. This is required many times even at run time like
> cpuinfo. So, instead of parsing the ACPI table every time, cache
> the RINTC structures and provide a function to get the correct
> RINTC structure for a given cpu.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/include/asm/acpi.h |  9 ++++++
>  arch/riscv/kernel/acpi.c      | 56 +++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 111a8ed10af1..8be16c1ef7da 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -61,6 +61,10 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>  
>  int acpi_get_riscv_isa(struct acpi_table_header *table,
>  		       unsigned int cpu, const char **isa);
> +
> +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> +
> +u32 get_acpi_id_for_cpu(int cpu);
>  #else
>  static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
>  				     unsigned int cpu, const char **isa)
> @@ -68,6 +72,11 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
>  	return -EINVAL;
>  }
>  
> +static inline u32 get_acpi_id_for_cpu(int cpu)
> +{
> +	return -1;
> +}

Why do we need this stub? I wouldn't expect non-ACPI code to need an ACPI
ID.

> +
>  #endif /* CONFIG_ACPI */
>  
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 81d448c41714..8b3d68d8225f 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -24,6 +24,62 @@ EXPORT_SYMBOL(acpi_disabled);
>  int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
>  EXPORT_SYMBOL(acpi_pci_disabled);
>  
> +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> +
> +static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> +{
> +	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
> +	int cpuid;
> +
> +	if (!(rintc->flags & ACPI_MADT_ENABLED))
> +		return 0;

Why not cache the data even when its disabled? We also cache the flags so
we can always check later too.

> +
> +	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
> +	if (cpuid >= 0 && cpuid < NR_CPUS)

What does it mean for the above check to fail? Bad ACPI tables?

> +		cpu_madt_rintc[cpuid] = *rintc;
> +
> +	return 0;
> +}
> +
> +static int acpi_init_rintc_array(void)
> +{
> +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0) > 0)
> +		return 0;
> +
> +	return -ENODEV;
> +}
> +
> +/*
> + * Instead of parsing (and freeing) the ACPI table, cache
> + * the RINTC structures since they are frequently used
> + * like in  cpuinfo.
> + */
> +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> +{
> +	static bool rintc_init_done;
> +
> +	if (!rintc_init_done) {
> +		if (acpi_init_rintc_array()) {
> +			pr_err("No valid RINTC entries exist\n");
> +			return NULL;
> +		}
> +
> +		rintc_init_done = true;
> +	}
> +
> +	return &cpu_madt_rintc[cpu];
> +}
> +
> +u32 get_acpi_id_for_cpu(int cpu)
> +{
> +	struct acpi_madt_rintc *rintc = acpi_cpu_get_madt_rintc(cpu);
> +
> +	if (!rintc)
> +		return -1;

Is -1 defined as an invalid ACPI ID? I'm wondering if we shouldn't just
BUG in acpi_init_rintc_array() if we fail to initialize and then we can
unconditionally return rintc->uid here.

> +
> +	return rintc->uid;
> +}
> +
>  /*
>   * __acpi_map_table() will be called before paging_init(), so early_ioremap()
>   * or early_memremap() should be called here to for ACPI table mapping.
> -- 
> 2.34.1
>

Thanks,
drew
