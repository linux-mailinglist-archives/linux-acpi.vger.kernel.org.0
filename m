Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718F86A9E11
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 18:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjCCR6c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 12:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCCR6b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 12:58:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32A61631F
        for <linux-acpi@vger.kernel.org>; Fri,  3 Mar 2023 09:58:30 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p20so3492706plw.13
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2023 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677866310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Cg/YaccXt9BVimh0sJvQg45Ng1kPKLiUeFiukAx3mI=;
        b=fsZm0F5xJBvzGCmg2YA4aKJsrHqbZdqvaBPwcmU24A2rc34KTvBqcuOTYGhO0HEd+b
         PuFhsBFn2tMpj1csGjrXPuaOUy+ocHeTIXWeFLlwKpkEig6Xcs2aEt8uZnHDz+2KNXeA
         vbWUvJBn9yhXEdHeMFwpQs1ncStO+GddmsZl1A6r94my0byHWQFEMNsa8u+ajc/YGLM6
         BowCzWrkOk75+vXdWY2sGR0gLU4izSd+kG9M53B6H4fHVpTiWG/c/xkubVT3fMwnO9j4
         CQJUTivfbCeQz77T1dhHjg8jJeSiixDMke2GTE0bRkMoH/ZreIgQsHpud5vwSZgy33JW
         KEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677866310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Cg/YaccXt9BVimh0sJvQg45Ng1kPKLiUeFiukAx3mI=;
        b=iDCDxfuYLreHIBsAeCdrNG3gOY/zAypM1UjKsMirMG53+2WavYcDql5rz1Qr4WziJ3
         /wVaKnc4RYFMHfVAbNRResK3EWKCp7MvBhmMPECDAlxEs4RMMZ3BWynpRi84aWNEouMp
         bBHAlmhRZS5q/4vhwH0prmVqafO1u+w3d0JkDjuCMknsG7Nl4zBnf99T+BfLbSV5ORkt
         YTN46AvX9pzyrAqY+6DujTTVNbo/83zU2u5TOdrXKIMUaIMjWH6e5ITRemsenDsMmolZ
         SEllJhyTtHPHDtvBrcoCQqXbviouRnY5bs/YI2wvkivzFa4/pFtkhifXeFeWkKxP303m
         QWOA==
X-Gm-Message-State: AO0yUKXn7HfNXbzkGOUvZ1GL4jzztEA6kejO+fsHVJI1i7780B9SfAGo
        1tVELQnmcOA4xbKcW8LwIq6g9g==
X-Google-Smtp-Source: AK7set+Qy8Ubck7LjKovgkMCa8jJA63wlDYq9pBqNh624i74daJ2JrXhCOe699UXsZLxFFk2f4hWFw==
X-Received: by 2002:a17:902:ec91:b0:19b:2332:18cb with SMTP id x17-20020a170902ec9100b0019b233218cbmr2878889plg.1.1677866310101;
        Fri, 03 Mar 2023 09:58:30 -0800 (PST)
Received: from sunil-laptop ([49.206.8.117])
        by smtp.gmail.com with ESMTPSA id kn13-20020a170903078d00b00189e7cb8b89sm1797207plb.127.2023.03.03.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:58:29 -0800 (PST)
Date:   Fri, 3 Mar 2023 23:28:21 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andrew Jones <ajones@ventanamicro.com>
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
Message-ID: <ZAI1PbEfo1Gyco1n@sunil-laptop>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-12-sunilvl@ventanamicro.com>
 <20230303160556.lezccmwa7ymymxws@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303160556.lezccmwa7ymymxws@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 03, 2023 at 05:05:56PM +0100, Andrew Jones wrote:
> On Fri, Mar 03, 2023 at 07:06:38PM +0530, Sunil V L wrote:
> > RINTC structures in the MADT provide mapping between the hartid
> > and the CPU. This is required many times even at run time like
> > cpuinfo. So, instead of parsing the ACPI table every time, cache
> > the RINTC structures and provide a function to get the correct
> > RINTC structure for a given cpu.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  9 ++++++
> >  arch/riscv/kernel/acpi.c      | 56 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 65 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > index 111a8ed10af1..8be16c1ef7da 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -61,6 +61,10 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> >  
> >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> >  		       unsigned int cpu, const char **isa);
> > +
> > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > +
> > +u32 get_acpi_id_for_cpu(int cpu);
> >  #else
> >  static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> >  				     unsigned int cpu, const char **isa)
> > @@ -68,6 +72,11 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> >  	return -EINVAL;
> >  }
> >  
> > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +	return -1;
> > +}
> 
> Why do we need this stub? I wouldn't expect non-ACPI code to need an ACPI
> ID.
> 
> > +
> >  #endif /* CONFIG_ACPI */
> >  
> >  #endif /*_ASM_ACPI_H*/
> > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > index 81d448c41714..8b3d68d8225f 100644
> > --- a/arch/riscv/kernel/acpi.c
> > +++ b/arch/riscv/kernel/acpi.c
> > @@ -24,6 +24,62 @@ EXPORT_SYMBOL(acpi_disabled);
> >  int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
> >  EXPORT_SYMBOL(acpi_pci_disabled);
> >  
> > +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> > +
> > +static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> > +{
> > +	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
> > +	int cpuid;
> > +
> > +	if (!(rintc->flags & ACPI_MADT_ENABLED))
> > +		return 0;
> 
> Why not cache the data even when its disabled? We also cache the flags so
> we can always check later too.
> 
Okay, doesn't harm.

> > +
> > +	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
> > +	if (cpuid >= 0 && cpuid < NR_CPUS)
> 
> What does it mean for the above check to fail? Bad ACPI tables?
> 
This can happen when SMP is disabled but platform has more CPUs.

> > +		cpu_madt_rintc[cpuid] = *rintc;
> > +
> > +	return 0;
> > +}
> > +
> > +static int acpi_init_rintc_array(void)
> > +{
> > +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0) > 0)
> > +		return 0;
> > +
> > +	return -ENODEV;
> > +}
> > +
> > +/*
> > + * Instead of parsing (and freeing) the ACPI table, cache
> > + * the RINTC structures since they are frequently used
> > + * like in  cpuinfo.
> > + */
> > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> > +{
> > +	static bool rintc_init_done;
> > +
> > +	if (!rintc_init_done) {
> > +		if (acpi_init_rintc_array()) {
> > +			pr_err("No valid RINTC entries exist\n");
> > +			return NULL;
> > +		}
> > +
> > +		rintc_init_done = true;
> > +	}
> > +
> > +	return &cpu_madt_rintc[cpu];
> > +}
> > +
> > +u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +	struct acpi_madt_rintc *rintc = acpi_cpu_get_madt_rintc(cpu);
> > +
> > +	if (!rintc)
> > +		return -1;
> 
> Is -1 defined as an invalid ACPI ID? I'm wondering if we shouldn't just
> BUG in acpi_init_rintc_array() if we fail to initialize and then we can
> unconditionally return rintc->uid here.
>
Thanks!. Will update this.
