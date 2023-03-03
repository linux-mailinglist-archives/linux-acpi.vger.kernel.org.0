Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046F66A9E1D
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 19:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjCCSE5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 13:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCCSE4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 13:04:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF8A2A9BA
        for <linux-acpi@vger.kernel.org>; Fri,  3 Mar 2023 10:04:55 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cw28so13683405edb.5
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2023 10:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6PGBxbef8RfwLWpglkSiRpT2ogJxqi2W1pXgvcnSEk=;
        b=DJ6R+FP+M9a06ijJncLGiwWhO9IewdpMg+lWM7rC9Mok2esD1sRBSfUAuPBhnpLZed
         5f8Snv+6c8n3oX4ymBT1sNNl+QN/gIN0/XhfBM2E9ho/uHZDTgdEBzJgafUmdIe7kTpP
         aRzInJnCMy3q5lgCTe/Hbjn/A8h8tBC/lRYECh3fdR6LdoE3QDSgG3pJDxKcNk2g1QHf
         6Vxjay/KC9zyCyDwTYprTkHGsY/ZohiOHs81loGZHsPv1ssErj5Q5fDj5U/BbWswkqE/
         NrGtNX41YdKDJ4k03sYs9UfOVbYGnZEwg3L5GQcq4gKaM/PrYIg+66S4ctLz+XuC12fM
         MQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6PGBxbef8RfwLWpglkSiRpT2ogJxqi2W1pXgvcnSEk=;
        b=selaMl4RetAILeHMAaaDrXWwuW64foVJnc2jdwGZ9BjgkMKx16FwjuwBrTuDaP9WJT
         QrMBKuQs4hdWimmytS6OciSwUiqGf/nnTKb1VE7ccOLNtV6LJhirpzPhe5WHgoB4BXVj
         i+sf8OnWlYBds1mBevY/cU6LNe7iCug4LHWx4g1jSvePDM//1LpIP3ysiCZMCQw2tS7B
         XTLSVGH+cfDz4RWm6/8OWLulj/eoadk9OENrN+oMf42BDgbfRXLHhjh2VAUQCfgfFZNW
         YWkGc2NQ2XqKikDkJetNdd5Zq/Bpon+dwVOUT1mzI/CLgqO5F3MBBEePyNhgqAuaAjjB
         t+rw==
X-Gm-Message-State: AO0yUKXrExr1GUwc8hLFtItvrEchnpmC7tQaPybj78yilNRtz2wcX0PK
        bXeFmIH2hLssmBqbZgWF5ViumQ==
X-Google-Smtp-Source: AK7set/05ycNoRJEK60f6oDdi/lvcvv1302FPAChNw8f8cIik+ciVykZyBA3yigdfxoNQ/lVZkrJHw==
X-Received: by 2002:a17:907:c0c:b0:8af:2cf7:dd2b with SMTP id ga12-20020a1709070c0c00b008af2cf7dd2bmr3132280ejc.13.1677866693509;
        Fri, 03 Mar 2023 10:04:53 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id y21-20020a50ce15000000b004af71e8cc3dsm1417814edi.60.2023.03.03.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 10:04:53 -0800 (PST)
Date:   Fri, 3 Mar 2023 19:04:52 +0100
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
Message-ID: <20230303180452.qzzjdwpgvqqxdqz5@orel>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-12-sunilvl@ventanamicro.com>
 <20230303160556.lezccmwa7ymymxws@orel>
 <ZAI1PbEfo1Gyco1n@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAI1PbEfo1Gyco1n@sunil-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 03, 2023 at 11:28:21PM +0530, Sunil V L wrote:
> On Fri, Mar 03, 2023 at 05:05:56PM +0100, Andrew Jones wrote:
> > On Fri, Mar 03, 2023 at 07:06:38PM +0530, Sunil V L wrote:
> > > RINTC structures in the MADT provide mapping between the hartid
> > > and the CPU. This is required many times even at run time like
> > > cpuinfo. So, instead of parsing the ACPI table every time, cache
> > > the RINTC structures and provide a function to get the correct
> > > RINTC structure for a given cpu.
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  arch/riscv/include/asm/acpi.h |  9 ++++++
> > >  arch/riscv/kernel/acpi.c      | 56 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 65 insertions(+)
> > > 
> > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > > index 111a8ed10af1..8be16c1ef7da 100644
> > > --- a/arch/riscv/include/asm/acpi.h
> > > +++ b/arch/riscv/include/asm/acpi.h
> > > @@ -61,6 +61,10 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> > >  
> > >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >  		       unsigned int cpu, const char **isa);
> > > +
> > > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > > +
> > > +u32 get_acpi_id_for_cpu(int cpu);
> > >  #else
> > >  static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >  				     unsigned int cpu, const char **isa)
> > > @@ -68,6 +72,11 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >  	return -EINVAL;
> > >  }
> > >  
> > > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > > +{
> > > +	return -1;
> > > +}
> > 
> > Why do we need this stub? I wouldn't expect non-ACPI code to need an ACPI
> > ID.
> > 
> > > +
> > >  #endif /* CONFIG_ACPI */
> > >  
> > >  #endif /*_ASM_ACPI_H*/
> > > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > > index 81d448c41714..8b3d68d8225f 100644
> > > --- a/arch/riscv/kernel/acpi.c
> > > +++ b/arch/riscv/kernel/acpi.c
> > > @@ -24,6 +24,62 @@ EXPORT_SYMBOL(acpi_disabled);
> > >  int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
> > >  EXPORT_SYMBOL(acpi_pci_disabled);
> > >  
> > > +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> > > +
> > > +static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> > > +{
> > > +	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
> > > +	int cpuid;
> > > +
> > > +	if (!(rintc->flags & ACPI_MADT_ENABLED))
> > > +		return 0;
> > 
> > Why not cache the data even when its disabled? We also cache the flags so
> > we can always check later too.
> > 
> Okay, doesn't harm.
> 
> > > +
> > > +	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
> > > +	if (cpuid >= 0 && cpuid < NR_CPUS)
> > 
> > What does it mean for the above check to fail? Bad ACPI tables?
> > 
> This can happen when SMP is disabled but platform has more CPUs.

Ah yes, NR_CPUS can be too small for the platform. Maybe a comment
explaining that we ignore all additional cpus in the ACPI tables that
we can't manage with the kernel's limits would be helpful here.

Thanks,
drew
