Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73C6A9E08
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 18:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjCCRyn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCCRym (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 12:54:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CA15C13C
        for <linux-acpi@vger.kernel.org>; Fri,  3 Mar 2023 09:54:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a9so3486847plh.11
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2023 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677866070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyGeqDHq6Ny12ok/XvC/X+CJrGuXB9thVKVbW4U0UKY=;
        b=D6/mkWCgosGOpX82owl742M9CHqrqyVkLBU93clvXbUHXKauFhAPIIZBiUCK0zsggX
         8wytq5A6Ce3iTli82Cw/yF+HSfJNVm07qvLSg3P9nOJPN5PFKw3UcdIr/YV8YDvYVdxz
         0VhXkyHEnSTTh+HHACWWcDPWTOo/UCXNYLJ8H+TaDbQT6DoOBrPkwUTtxpgpcs2Cr2HL
         CXdy+4X1tlYoeR38yLDersrVtYjzBk+kIXuJmIBz5d0oqjQRAEUCgZYkSoEYUNuxMaPK
         lpjGZeaEKLiBwvTa1nWS8d9CT9fAdjWOzyvj38IX1tRnd7mOI+2cVNlEoO3dulOHnzMC
         iMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677866070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyGeqDHq6Ny12ok/XvC/X+CJrGuXB9thVKVbW4U0UKY=;
        b=t9BvTZqfNtVxKRQmXdoPZzzG6Bzmkoa2ubJULyprRgbK1bvTrqn58V8IS3fm6ougec
         UdKAO/mfT413Ui/1YNZYn9i32eENLXk6JxcLNfAmN2tz40830idNxQXH8aM+sP6918dY
         bHH+bxIstgjE+EF6wMT1ZvoJ2Wc9i+0Fa09oNDmiWYv15Iml9G89yHpkiBMk6GOpWWw/
         NghmfXJCvcWDriPkhkZyrkL/FYb/xFyKAJHmN6X0hK/q2AerrpPoHihEOJGpxW1Jn1uP
         NGpaVy/fSzr7H4gkXcR4JYXddG+2firo2ObfbtlrOOR+9xC3j+4y/lyWL8BpdOmaX5Zo
         m4og==
X-Gm-Message-State: AO0yUKV6+YOCbMQNBEw8LbdBgUx6MpU1kINHzuW02VmcamMF/rjTaxqF
        o7L9iAoDpZe08sVTQP4UT28iuQ==
X-Google-Smtp-Source: AK7set9vHBCQJ7h+vdlqizbt+ZSJ3GqdX/r5qDWOAVIIqwGCsNyifO0uoAw8S+kLaOzaf7Gum4o1Eg==
X-Received: by 2002:a17:902:f541:b0:19c:d97f:5d16 with SMTP id h1-20020a170902f54100b0019cd97f5d16mr2744289plf.3.1677866069810;
        Fri, 03 Mar 2023 09:54:29 -0800 (PST)
Received: from sunil-laptop ([49.206.8.117])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b001963a178dfcsm1780000plb.244.2023.03.03.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:54:29 -0800 (PST)
Date:   Fri, 3 Mar 2023 23:24:21 +0530
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
Subject: Re: [PATCH V3 10/20] RISC-V: smpboot: Add ACPI support in smp_setup()
Message-ID: <ZAI0TaskDCDz7bB/@sunil-laptop>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-11-sunilvl@ventanamicro.com>
 <20230303154920.dq65hkcivpv7zyev@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303154920.dq65hkcivpv7zyev@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 03, 2023 at 04:49:20PM +0100, Andrew Jones wrote:
> On Fri, Mar 03, 2023 at 07:06:37PM +0530, Sunil V L wrote:
> > Enable SMP boot on ACPI based platforms by using the RINTC
> > structures in the MADT table.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/kernel/smpboot.c | 72 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 71 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 26214ddefaa4..27047322d3bb 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -8,6 +8,7 @@
> >   * Copyright (C) 2017 SiFive
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/arch_topology.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> > @@ -70,6 +71,72 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_ACPI
> > +static unsigned int cpu_count = 1;
> > +
> > +static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const unsigned long end)
> > +{
> > +	unsigned long hart;
> > +	static bool found_boot_cpu;
> > +	struct acpi_madt_rintc *processor = (struct acpi_madt_rintc *)header;
> > +
> > +	/*
> > +	 * Each RINTC structure in MADT will have a flag. If ACPI_MADT_ENABLED
> > +	 * bit in the flag is not enabled, it means OS should not try to enable
> > +	 * the cpu to which RINTC belongs.
> > +	 */
> > +	if (!(processor->flags & ACPI_MADT_ENABLED))
> > +		return 0;
> > +
> > +	if (BAD_MADT_ENTRY(processor, end))
> > +		return -EINVAL;
> > +
> > +	acpi_table_print_madt_entry(&header->common);
> > +
> > +	hart = processor->hart_id;
> > +	if (hart == INVALID_HARTID) {
> > +		pr_warn("Invalid hartid\n");
> > +		return 0;
> > +	}
> > +
> > +	if (hart == cpuid_to_hartid_map(0)) {
> > +		BUG_ON(found_boot_cpu);
> > +		found_boot_cpu = true;
> > +		early_map_cpu_to_node(0, NUMA_NO_NODE);
> 
> We should have kept
> 
>  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> 
> and only dropped the
> 
>  #ifdef CONFIG_ACPI_NUMA
>  int acpi_numa_get_nid(unsigned int cpu);
>  #else
>  ...
>  #endif
> 
Okay, I thought we better add it when we enable NUMA with ACPI. 

> > +		return 0;
> > +	}
> > +
> > +	if (cpu_count >= NR_CPUS) {
> > +		pr_warn("NR_CPUS is too small for the number of ACPI tables.\n");
> > +		return 0;
> > +	}
> > +
> > +	cpuid_to_hartid_map(cpu_count) = hart;
> > +	early_map_cpu_to_node(cpu_count, NUMA_NO_NODE);
> > +	cpu_count++;
> > +
> > +	return 0;
> > +}
> > +
> > +static void __init acpi_parse_and_init_cpus(void)
> > +{
> > +	int cpuid;
> > +
> > +	cpu_set_ops(0);
> > +
> > +	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_rintc, 0);
> > +
> > +	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
> > +		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
> > +			cpu_set_ops(cpuid);
> > +			set_cpu_possible(cpuid, true);
> > +		}
> > +	}
> > +}
> > +#else
> > +#define acpi_parse_and_init_cpus(...)	do { } while (0)
> > +#endif
> > +
> >  static void __init of_parse_and_init_cpus(void)
> >  {
> >  	struct device_node *dn;
> > @@ -118,7 +185,10 @@ static void __init of_parse_and_init_cpus(void)
> >  
> >  void __init setup_smp(void)
> >  {
> > -	of_parse_and_init_cpus();
> > +	if (acpi_disabled)
> > +		of_parse_and_init_cpus();
> > +	else
> > +		acpi_parse_and_init_cpus();
> >  }
> >  
> >  static int start_secondary_cpu(int cpu, struct task_struct *tidle)
> > -- 
> > 2.34.1
> >
> 
> Thanks,
> drew
