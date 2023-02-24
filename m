Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951026A1C1C
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Feb 2023 13:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBXM2A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Feb 2023 07:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBXM17 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Feb 2023 07:27:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D21F149A8
        for <linux-acpi@vger.kernel.org>; Fri, 24 Feb 2023 04:27:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so280672pjp.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Feb 2023 04:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwYpSkYarWM8KK06DmjpU0SsZ80bpXD8ml+czU18ph4=;
        b=oTGbRFBV85WT/P+apuKTFB8ImIliAlw8Q1W+9qFq7T1rquTOiN7YtSjiu7ZSPKsbtz
         3TdWTwd8QJ5wX1ZII1KsmMnSOJhZliUJOv9OCs6BBYn+xlnJ6XCpllseBFj4NuicmRTt
         CIx1TZO6K1zeMl45l5bADxsZOnD281Hh4DMRbtZA6/y2Qonv7MjwQDV94kdFo3um9h1X
         9SURMFmrw6khKTBjyc9/m7ktkJtr1QH6lmbxGLxu9pXbjFhG/mZBv8U/vygcRGRvyE3g
         geryxmJTxC84mhl0ev42ge6nYequ28IDr4X3PRj3p1Dzp/6o9FRH18i6+WcZrjUuxpSt
         g7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwYpSkYarWM8KK06DmjpU0SsZ80bpXD8ml+czU18ph4=;
        b=O0F1LQVq5LloTbAWE2eNUXMBcvgKg4azava9+iDq5DwCjCX5ON+rOxMSfLnJsZXRoK
         gqbV4EoIxGpuyEkwPDehBJ+NkVLqn7/NyucUOG11d/+qg/mrfuXs2dRVDifYK/Rxu4zr
         RsT3Xb6oKwTL18ju0nvnD2omVFefn79mKPxFvenYkG3r79MmVr7LA7DzKskVLL0cqjMU
         5MIVTgAstzJ2CSn7XnBc+dHR3ZPa7soA+h5izC+4m/ZhzzjgkEf4pTf8QHpqS6GNDUsC
         gakTrFnFEhP+JDDpN0bFg5AECTaqhpvuBnLuLT37yyNO87F19BoB4tClsRG8dPmH67cP
         T78Q==
X-Gm-Message-State: AO0yUKXbxHN4UkUCq9u/3rQMxKxK+oQNhHNLykuxu+/yqtpt29SVtoLI
        a5nFeoDxoSAT2Ww5AF/I/k3jtA==
X-Google-Smtp-Source: AK7set/jhV4LyEc2Pc7U9dYmeepbpGtwrM+HLOiB2J748SFbDrW80kFfcTA8PubYOPn/br7Mj7juCA==
X-Received: by 2002:a05:6a20:8f10:b0:cb:a66b:3a88 with SMTP id b16-20020a056a208f1000b000cba66b3a88mr12686571pzk.1.1677241677760;
        Fri, 24 Feb 2023 04:27:57 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id h18-20020a656392000000b004fbe302b3f6sm1047553pgv.74.2023.02.24.04.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 04:27:57 -0800 (PST)
Date:   Fri, 24 Feb 2023 17:57:48 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andrew Jones <ajones@ventanamicro.com>
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
Subject: Re: [PATCH V2 13/21] RISC-V: cpu: Enable cpuinfo for ACPI systems
Message-ID: <Y/itRLrYiWCJjCcc@sunil-laptop>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-14-sunilvl@ventanamicro.com>
 <20230220175429.dzojoryw2dhhbodl@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220175429.dzojoryw2dhhbodl@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 20, 2023 at 06:54:29PM +0100, Andrew Jones wrote:
> On Thu, Feb 16, 2023 at 11:50:35PM +0530, Sunil V L wrote:
> > On ACPI based platforms, few details like ISA need to be read
> > from the ACPI table. Enable cpuinfo on ACPI based systems.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/riscv/kernel/cpu.c | 31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 1b9a5a66e55a..a227c0661b19 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -3,10 +3,12 @@
> >   * Copyright (C) 2012 Regents of the University of California
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/cpu.h>
> >  #include <linux/init.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/of.h>
> > +#include <asm/acpi.h>
> >  #include <asm/csr.h>
> >  #include <asm/hwcap.h>
> >  #include <asm/sbi.h>
> > @@ -256,26 +258,41 @@ static void c_stop(struct seq_file *m, void *v)
> >  {
> >  }
> >  
> > +static void acpi_print_hart_info(struct seq_file *m, unsigned long cpu)
> > +{
> > +	const char *isa;
> > +
> > +	if (!acpi_get_riscv_isa(NULL, get_acpi_id_for_cpu(cpu), &isa))
> > +		print_isa(m, isa);
> > +}
> > +
> >  static int c_show(struct seq_file *m, void *v)
> >  {
> >  	unsigned long cpu_id = (unsigned long)v - 1;
> > -	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
> >  	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
> > +	struct device_node *node;
> >  	const char *compat, *isa;
> >  
> >  	seq_printf(m, "processor\t: %lu\n", cpu_id);
> >  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
> > -	if (!of_property_read_string(node, "riscv,isa", &isa))
> > -		print_isa(m, isa);
> > +
> > +	if (acpi_disabled) {
> > +		node = of_get_cpu_node(cpu_id, NULL);
> > +		if (!of_property_read_string(node, "riscv,isa", &isa))
> > +			print_isa(m, isa);
> > +		if (!of_property_read_string(node, "compatible", &compat) &&
> > +		    strcmp(compat, "riscv"))
> > +			seq_printf(m, "uarch\t\t: %s\n", compat);
> > +		of_node_put(node);
> > +	} else {
> > +		acpi_print_hart_info(m, cpu_id);
> 
> I don't think we need the helper function for the two lines which would
> otherwise nicely complement the two similar DT lines above.
> 
Agree. Let me remove it.

> > +	}
> > +
> >  	print_mmu(m);
> > -	if (!of_property_read_string(node, "compatible", &compat)
> > -	    && strcmp(compat, "riscv"))
> > -		seq_printf(m, "uarch\t\t: %s\n", compat);
> 
> This will now print uarch before mmu for DT systems.
> 
Yeah. Let me fix it.

Thanks,
Sunil
