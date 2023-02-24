Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5D6A2041
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Feb 2023 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjBXRG3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Feb 2023 12:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXRG1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Feb 2023 12:06:27 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63736686AC
        for <linux-acpi@vger.kernel.org>; Fri, 24 Feb 2023 09:06:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q16so4275560wrw.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Feb 2023 09:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Am7UTsrrLl5LeWU1phk06r4aR+aojXRx8nt3c68UlzA=;
        b=T8uUCWgFONTHlUy4fcf1OtN163guOpfDSvC9cRpeQQm8mOTkqbWJjpPowNk66P8aNL
         ZiGxi3v5PAdjNAlneDE1HI89mAAkmRx//62ebbndeI1ULCrhcDnTJIq1Dxf8jbGhIeFR
         wSruzc2Rw5xjIC/KNVlZVMNlz1/0Ju35kRnQduhUV1+rBY2K6M757XELJ0aSi2wceClc
         0AS7Zi75IA+FQld6Nr6zpIOGrv4RrhAuWXBZGSBX6FtgENkABF7N4Iaj25rXyeGEivYK
         C8mU9beKrjf3rsbed9ZG/jfyBcRuoasDsbLpScBbm+nVwgXYCTuFMdNg0ulgPgGd+nxS
         aL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Am7UTsrrLl5LeWU1phk06r4aR+aojXRx8nt3c68UlzA=;
        b=YFSQlA6LJ+a39PraQp8RoGrOWrE/NokDU0UokMsgLZHxeCuTuunAl+X9tgkvacnbtg
         B87AwTqkD1prlO/+t2zXdYAhsMg685zycCUNiHFfCtOiJujpa/KRV5R5uow8FH4deYbU
         HqzJhOp5+jBQnaLRs0q0bDy1wT5vMfHibjktaq4xVzXyorM5p5+hvYL4UeYeMU89zuNr
         vN8AN6XRth39jwcUxiI+pHNelCAA4nZELgPRK2VELUyKhvERy3xCL947GpQbrKWybJZ4
         RxiPW/TkteuTuh8k91YeFFAmtVD0NcelJUANQ95r5Phwj9aqs7lplMRLVte3DJ/Sjl/g
         s6oA==
X-Gm-Message-State: AO0yUKVzSY6tEX/USx2BQ7URoiYjy00LBTwjAeXVitnpFGLpky6dlj3+
        giPhiOAK3+zYdQ+4N61zwsf7JA==
X-Google-Smtp-Source: AK7set88uoDBhcGuMYfhYqWOmL9+KmCBxlE31bBrR7wtdw0dI+ThATqK199/etDNQtfA8PwDynkLKA==
X-Received: by 2002:adf:f946:0:b0:2c5:617a:5023 with SMTP id q6-20020adff946000000b002c5617a5023mr14388379wrr.71.1677258384848;
        Fri, 24 Feb 2023 09:06:24 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id x4-20020adfdd84000000b002c556a4f1casm13292847wrl.42.2023.02.24.09.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:06:24 -0800 (PST)
Date:   Fri, 24 Feb 2023 18:06:23 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V2 10/21] RISC-V: smpboot: Add ACPI support in smp_setup()
Message-ID: <20230224170623.d6ubdmatqfromjjm@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-11-sunilvl@ventanamicro.com>
 <20230220170843.2zkrqcnqcwbruea6@orel>
 <Y/jqye85kKU8KfDU@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/jqye85kKU8KfDU@sunil-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 24, 2023 at 10:20:17PM +0530, Sunil V L wrote:
> On Mon, Feb 20, 2023 at 06:08:43PM +0100, Andrew Jones wrote:
> > On Thu, Feb 16, 2023 at 11:50:32PM +0530, Sunil V L wrote:
> > > Enable SMP boot on ACPI based platforms by using the RINTC
> > > structures in the MADT table.
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  arch/riscv/include/asm/acpi.h |  7 ++++
> > >  arch/riscv/kernel/smpboot.c   | 70 ++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 76 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > > index 7bc49f65c86b..3c3a8ac3b37a 100644
> > > --- a/arch/riscv/include/asm/acpi.h
> > > +++ b/arch/riscv/include/asm/acpi.h
> > > @@ -60,6 +60,13 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> > >  
> > >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >  		       unsigned int cpu, const char **isa);
> > > +
> > > +#ifdef CONFIG_ACPI_NUMA
> > > +int acpi_numa_get_nid(unsigned int cpu);
> > > +#else
> > > +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> > > +#endif /* CONFIG_ACPI_NUMA */
> > 
> > The #ifdef stuff seems premature since we're not providing an
> > implementation for acpi_numa_get_nid() or selecting ACPI_NUMA, but OK.
> > 
> Yes, will remove it. We can add as part NUMA enablement.
> 
> > > +
> > >  #else
> > >  static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >  				     unsigned int cpu, const char **isa)
> > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > > index 26214ddefaa4..77630f8ed12b 100644
> > > --- a/arch/riscv/kernel/smpboot.c
> > > +++ b/arch/riscv/kernel/smpboot.c
> > > @@ -8,6 +8,7 @@
> > >   * Copyright (C) 2017 SiFive
> > >   */
> > >  
> > > +#include <linux/acpi.h>
> > >  #include <linux/arch_topology.h>
> > >  #include <linux/module.h>
> > >  #include <linux/init.h>
> > > @@ -70,6 +71,70 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> > >  	}
> > >  }
> > >  
> > > +#ifdef CONFIG_ACPI
> > > +static unsigned int cpu_count = 1;
> > > +
> > > +static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const unsigned long end)
> > > +{
> > > +	unsigned long hart;
> > > +	bool found_boot_cpu = false;
> > 
> > I guess found_boot_cpu should be static?
> > 
> Good catch!. Thanks!
> 
> > > +	struct acpi_madt_rintc *processor = (struct acpi_madt_rintc *)header;
> > > +
> > > +	/*
> > > +	 * Each RINTC structure in MADT will have a flag. If ACPI_MADT_ENABLED
> > > +	 * bit in the flag is not enabled, it means OS should not try to enable
> > > +	 * the cpu to which RINTC belongs.
> > > +	 */
> > > +	if (!(processor->flags & ACPI_MADT_ENABLED))
> > > +		return 0;
> > > +
> > > +	hart = processor->hart_id;
> > > +	if (hart < 0)
> > > +		return 0;
> > 
> > A valid hart ID is anything up to INVALID_HARTID, right? Shouldn't we only
> > be checking for INVALID_HARTID here? And what does it mean to have an
> > invalid hart ID here? It's not an issue to error/warn about?
> > 
> Yes, will check for INVALID_HARTID (though I am not really sure how it
> can be invalid). Will add a warning.
> 
> > > +	if (hart == cpuid_to_hartid_map(0)) {
> > > +		BUG_ON(found_boot_cpu);
> > 
> > Do we really want to BUG due to bad, but potentially bootable ACPI tables?
> > I'd BUG for things that can only happen when we break the code, but broken
> > ACPI tables might be something we want to complain loudly about and then
> > attempt to limp along.
> > 
> Okay. I used same logic as in DT. It may be better to use BUG instead of
> debugging weird symptoms later, right?

Maybe? I guess it depends on how obvious the symptoms are, how much they
mess things up, and how easy it is to correct the ACPI tables. I'll leave
this one up to you :-)

Thanks,
drew
