Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47811694B1C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjBMP2C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 10:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjBMP2A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 10:28:00 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB97DAA
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 07:27:54 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d2so12235740pjd.5
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 07:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H64bCErxHeGPwaoRHUI0dfKS4AtwcUXkbh45HCez6bg=;
        b=SYvMjLr4yDh8WyGRc0k/LjOIHPYr1cPeLUKGMw9rxER/6OkNu6qD6ShC5hQmEy7g2v
         1sw6Sy81TOpdbyY5inbR4XBH9cTfvZQOD5mYDGeJ/RXi5thu+ZpgZNJmdI8wnq1EnPBJ
         B3DmXn9IFnE63hLT/KZs3UUri+rp6+QP3SPuSyH8ubhS1UIX4sLXaHZZSX7WPXwgtQRT
         o4twUj6POMJxSOxd/JgCI1a9KlJmO4d7R8s1o8a39Sfz8HWHnE4mbhG4Boi/UWFYXI7x
         mp/kb9tJxEc7FnTFCe3kkiKoG2xB2YYoYiA8Ei5DJUXuQoW3Na32syXgDNHM2EW6CwEj
         5VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H64bCErxHeGPwaoRHUI0dfKS4AtwcUXkbh45HCez6bg=;
        b=UxhSSB6d0U3q4g9sCsuSOmN4WII0YI0bPDIfVSMmXvk9jFH9tJoblLQe8SkMa7dC8Z
         ZwuZwJiRShGyUuMkp6KG5v5sSCU0TRvbUV6SVSdh90sffYw8QZUycv56HJbZCcdLu7iC
         B1x1xTiT4cVcZV/pvfTFDRE/Q5CCPP2d5u8J8exBuX1L4i3DJFXOtI1oho4WAD8jokop
         nPcncOqKpjLaYEdcZ4Xnw1W4iHSUsuzWkZ7B5ESIl28LVizMdDEjgvj0YoBuwe2YzOqC
         xKBwcKMyWGSHZXn+FsWKlIFJrTK5fIcjiIJHX5YE7Qf8liPurNOvbMyk90e9atsc3QNj
         HapA==
X-Gm-Message-State: AO0yUKW/ZXJ8zLqUmhEaLsB3mAxUZBev1Z7c1733+lPzjEOlx0xTcNl+
        gzZ5cHmaZP7gJLWKlxNxHWahnQ==
X-Google-Smtp-Source: AK7set+Umi3K9fZWNzNGTrbdJhbBEdIzCaTYmeadC2jJa0vq3VZDuZB5gM/RzsQ/hG22EUBBztLQTw==
X-Received: by 2002:a17:903:11c3:b0:196:3ecd:c39a with SMTP id q3-20020a17090311c300b001963ecdc39amr28512081plh.43.1676302073657;
        Mon, 13 Feb 2023 07:27:53 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0019aa7d89f06sm1482224plg.30.2023.02.13.07.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:27:53 -0800 (PST)
Date:   Mon, 13 Feb 2023 20:57:44 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH 13/24] RISC-V: ACPI: smpboot: Add ACPI support in
 smp_setup()
Message-ID: <Y+pW8NWaOW1gom7d@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-14-sunilvl@ventanamicro.com>
 <Y+Qdxg8LBs5mbl4+@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Qdxg8LBs5mbl4+@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 08, 2023 at 10:10:14PM +0000, Conor Dooley wrote:
> On Mon, Jan 30, 2023 at 11:52:14PM +0530, Sunil V L wrote:
> > Add function to parse the RINTC structure in
> > the MADT table and create the required initializations to
> > enable SMP boot on ACPI based platforms.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  7 ++++
> >  arch/riscv/kernel/smpboot.c   | 73 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 79 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > index c5cb9f96d404..d1f1e53ec657 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -58,6 +58,13 @@ static inline bool acpi_has_cpu_in_madt(void)
> >  }
> >  
> >  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> > +
> > +#ifdef CONFIG_ACPI_NUMA
> > +int acpi_numa_get_nid(unsigned int cpu);
> > +#else
> > +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> > +#endif /* CONFIG_ACPI_NUMA */
> > +
> >  #endif
> >  
> >  #endif /*_ASM_ACPI_H*/
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 26214ddefaa4..e48cf88d0bc1 100644
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
> > @@ -70,6 +71,73 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_ACPI
> > +static unsigned int cpu_count = 1;
> > +
> > +static int __init
> > +acpi_parse_rintc(union acpi_subtable_headers *header,
> > +			     const unsigned long end)
> 
> This all fits on one line. And also avoids the checkpatch complaint from
> what you have currently done...
> 
Okay.

> > +{
> > +	unsigned long hart;
> > +	bool found_boot_cpu = false;
> > +
> > +	struct acpi_madt_rintc *processor;
> > +
> > +	processor = (struct acpi_madt_rintc *)header;
> 
> Why not combine the above two lines?
> 
> > +	/* RINTC entry which has !ACPI_MADT_ENABLED is not enabled so skip */
> 
> This comment is a bit -ENOPARSE. Please reword it in a way that is
> understandable to mere mortals like myself.
>
Okay, let me try :-).
 
> > +	if (!(processor->flags & ACPI_MADT_ENABLED))
> > +		return 0;
> > +
> > +	hart = processor->hart_id;
> > +	if (hart < 0)
> > +		return 0;
> 
> Newline here please
> 
> > +	if (hart == cpuid_to_hartid_map(0)) {
> > +		BUG_ON(found_boot_cpu);
> > +		found_boot_cpu = 1;
> 
> This is a bool, why not assign a bool value to it so it looks more
> intentional? I know this is copied from the dt code, but that should
> really be on too IMO.
>
Okay.
 
> > +		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
> > +		return 0;
> > +	}
> 
> And a newline here too...
>
Okay. 
> > +	if (cpu_count >= NR_CPUS) {
> > +		pr_warn("Invalid cpuid [%d] for hartid [%lu]\n",
> > +			cpu_count, hart);
> > +		return 0;
> > +	}
> > +
> > +	cpuid_to_hartid_map(cpu_count) = hart;
> > +	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
> > +	cpu_count++;
> 
> ...and also here please!
>
Okay.

> > +	return 0;
> > +}
> > +
> > +static void __init acpi_parse_and_init_cpus(void)
> > +{
> > +	int cpuid;
> > +
> > +	cpu_set_ops(0);
> 
> While I'm at it suggesting newline additions, adding them before
> comments would be great too.
>
Okay.
 
> > +	/*
> > +	 * do a walk of MADT to determine how many CPUs
> > +	 * we have including disabled CPUs, and get information
> > +	 * we need for SMP init.
> > +	 */
> > +	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC,
> > +				      acpi_parse_rintc, 0);
> > +
> > +	/*
> > +	 * NUMA - TODO
> > +	 */
> 
> TODO before merging, or TODO at some indeterminate point in the future?
>
Will remove this comment. We need to add NUMA after basic support is
done.
 
> Anyways, this is all nits & this largely seem to resemble the dt code,
> so with the nits fixed (and an s/ACPI: // in $subject):
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
Thanks!
Sunil
