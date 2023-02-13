Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51684694D8C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 18:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBMRAo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 12:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBMRAn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 12:00:43 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66970193E9
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:00:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bg2so3233060pjb.4
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOr10dVQbwIfzRH4wxSUN+tKAOUvGyW77RFxYDyWSw4=;
        b=Xk36lugwkefIX90CnHzFXRA2f1HXASTndOD4qPGSoj03JXeST2jZYc/msSMfare3wt
         62MADYzitn+/RB0O0f/LMln+42KaNpohSTwnAZzxcZhLRAzeFNRRls4nsVvP04A4NvPJ
         ejJTS9PLdybPtkMBCJOQ4mYKUFcsKl7ie7DTzI+P0Osa1txj1TU51lEVUKc/SyFzzCB3
         YJDFzOlLotAFvXr+Y7Vf3EslcJ7ir+IrynEkttlIxOMEkYLAAVMrDkJogT289hMVXwYp
         9GaZKvWd/kSdG9pRkPq7hwHYAN6UcpBbCG1rMehOKUfH90hqcZ+ZbuxvxljTgT6ysRu1
         7B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOr10dVQbwIfzRH4wxSUN+tKAOUvGyW77RFxYDyWSw4=;
        b=QAOp7tUxHv12Po/qexv6QfFvDEutnroGiqS5JlxXnX88v4Yc0PWq3OdfvFP+YB0Cv6
         8aF64ZqQ7FD1ctm9nZGGOlfyuRzweM8++9q1FHdmpVkr11cbDKGYPfCj8R5SbiME1f5b
         zXF/E/oHuzyRSudUW2rPdOqDta5eJ7NYlvtBjpEdCdX56a10ar5ZEAY61F8ARFYF5TP+
         yTjyhkk6wJMR/6VUm60LyKaz6WCQW5GpWd9dEKfOk/mTtC3nQkAKoFA7NT4Cq2+kDzPI
         lvyTx2myxdzROuPeueADHQ13BZWdMYjjnAMR/pJs+639mB5NruvljlebLEVpPfpRWi/+
         nh6g==
X-Gm-Message-State: AO0yUKW4cyL3tWdHGfMc3hcOYaxztrjXl6/WD2RU9EwhdWby95jSSt/n
        3qtjmz4ZM1D3Sv4+v8dtfDK+UQ==
X-Google-Smtp-Source: AK7set+tXR5i3JgVKgzvBSZ6MCb2c+hLPyLbC7HBzkafBheEhsQIPS/rB1Goy5hWggPnOhYK1EIjuQ==
X-Received: by 2002:a17:902:e313:b0:19a:a39b:a88b with SMTP id q19-20020a170902e31300b0019aa39ba88bmr2587418plc.37.1676307641914;
        Mon, 13 Feb 2023 09:00:41 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902ed4d00b00198fc0a191bsm646134plb.160.2023.02.13.09.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 09:00:41 -0800 (PST)
Date:   Mon, 13 Feb 2023 22:30:33 +0530
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
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 14/24] RISC-V: ACPI: smpboot: Add function to retrieve
 the hartid
Message-ID: <Y+pssW1GCMW3oZjL@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-15-sunilvl@ventanamicro.com>
 <Y+VX8EclC1cE2fdI@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+VX8EclC1cE2fdI@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 09, 2023 at 08:30:40PM +0000, Conor Dooley wrote:
> Hey Sunil, Drew,
> 
> @drew, a question below that I'm sorta aiming at you...
> 
> On Mon, Jan 30, 2023 at 11:52:15PM +0530, Sunil V L wrote:
> > hartid is in RINTC structuire in MADT table. Instead of parsing
> 
> Nit: missing articles before RINTC and MADT. Also typo "structure".
> 
> Perhaps you'd benefit from a spell checker in your git editor.
> 
Okay.

> > the ACPI table every time we need for a cpu, cache it and provide
> > a function to read it.
> > 
> > This is similar to acpi_get_madt_gicc() in arm64.
> 
> -ENOTFOUND, do you mean acpi_cpu_get_madt_gicc()?
>
Yes. Will update.

> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/acpi.h | 14 +++++++++++++-
> >  arch/riscv/kernel/smpboot.c   | 21 +++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > index d1f1e53ec657..69a880b7257a 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -65,6 +65,18 @@ int acpi_numa_get_nid(unsigned int cpu);
> >  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> >  #endif /* CONFIG_ACPI_NUMA */
> >  
> > -#endif
> > +struct acpi_madt_rintc *acpi_get_madt_rintc(int cpu);
> > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +	return	acpi_cpu_get_madt_rintc(cpu)->uid;
> > +}
> > +#else
> > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +	return -1;
> > +}
> > +
> > +#endif /* CONFIG_ACPI */
> >  
> >  #endif /*_ASM_ACPI_H*/
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index e48cf88d0bc1..3a8b7a9eb5ac 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -73,6 +73,25 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> >  
> >  #ifdef CONFIG_ACPI
> >  static unsigned int cpu_count = 1;
> > +static unsigned int intc_count;
> > +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> > +
> > +struct acpi_madt_rintc *acpi_get_madt_rintc(int cpu)
> > +{
> > +	return &cpu_madt_rintc[cpu];
> > +}
> > +
> > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> > +{
> > +	int i;
> 
> Since we are C11 now, you don't even need to declare this outside of the
> loop, right?
>
Okay.
 
> > +
> > +	for (i = 0; i < NR_CPUS; i++) {
> 
> @drew, perhaps you know since you were fiddling not too long ago with
> cpumask stuff - at what point does for_each_possible_cpu() become
> usable?
> I had a bit of a poke & couldn't immediately tell if it'd be okay to use
> it here.
>
It should be possible. Thanks!
 
> > +		if (riscv_hartid_to_cpuid(cpu_madt_rintc[i].hart_id) == cpu)
> > +			return &cpu_madt_rintc[i];
> > +	}
> > +	return NULL;
> 
> Another nit: newline before return please :)
>
Sure.

Thanks,
Sunil 
