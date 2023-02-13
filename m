Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E96694E42
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 18:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjBMRmz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 12:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBMRmy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 12:42:54 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8CB473
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:42:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gd1so1869604pjb.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63tgpONA5oEu3r5P/vFkJgnRoA403HiDXnWl8FkdsxY=;
        b=CVfpMPtijfInoSnQpBF8R6F6pOwoURmAmUhAO0Ls5W0RJ19Kqny2+q9xHUtsqxuMFE
         4VoIyg7DLnr/Kv1UtH8rj/8j/Ef50RH/8nHsHONO1lJ8ORhIQjnSUpnu1Q/i2fJwhJTu
         dYyCbgxrwmZIZh/+bCnMDaB7q38U9Yb75ltIpkZwIMSUUAmAdPPb+clSG24WmGTeRgV5
         kkHmwES5ttEJkxeYuw6x5nORJIV2GsQMk0RauPIsYPg/j3ebpXAUGVpTG4REF1wXYfOK
         AeypvyUChsBD3cBxc5x/hEohE1TT5FpPtaVATqkfdiR29VOpLKsfZTK3tSEArG9s1W80
         dgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63tgpONA5oEu3r5P/vFkJgnRoA403HiDXnWl8FkdsxY=;
        b=zFIJ5HQBUHOpy3ObY3Gu8ZXHcFwDPtZ3TLmsf/CMdedo/TSk3k8oiGezz3/E3Ly6/3
         yGcJLHomdDMY/S+IadPSHSgYiyD9SNSt962Dc+MVgDqlSE5RwdXOOmCLEDvn0p2I8yU6
         7uxab1xwBaRzD1elALuDJ2HUFEfWu4VUZ2dgEV/FzB9UdBxSlhVithfl/NcOfneQv+tY
         PG6fcqEfb8sdG6xHhqWUYXqvys33k7/Em6JoW5r/HVmo1o5PUnbOpJkiZwmiW4/DhMCd
         wU5EvZiWoWQAcg12FY/VQbtsuPxg5ttP2AXTqy7ibIlhBpy6asDCPHX9r8GQpgFS4pn0
         U/Gg==
X-Gm-Message-State: AO0yUKV8sZ0K9zvismvwtIQPvbXhG9+Ul8yyPMyFV7DrIVNb2MHfxd7p
        A4WMZycqgOM7VJLC93RyXO7gmw==
X-Google-Smtp-Source: AK7set86hl+mztS6xB+aIB6Jg2wbDUvNJaUXGkDMvsSk3YuBBmWG2qIWwzDKoxBGkz7EE3uL9bZIbA==
X-Received: by 2002:a05:6a20:6d27:b0:bc:80bd:462d with SMTP id fv39-20020a056a206d2700b000bc80bd462dmr13919386pzb.46.1676310171263;
        Mon, 13 Feb 2023 09:42:51 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090a890500b0023086d280c5sm7609169pjn.3.2023.02.13.09.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 09:42:50 -0800 (PST)
Date:   Mon, 13 Feb 2023 23:12:40 +0530
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
Subject: Re: [PATCH 20/24] RISC-V: ACPI: cpu: Enable cpuinfo for ACPI systems
Message-ID: <Y+p2kKdfogLkhkj2@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-21-sunilvl@ventanamicro.com>
 <Y+ViASnch0Fp1rju@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+ViASnch0Fp1rju@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 09, 2023 at 09:13:37PM +0000, Conor Dooley wrote:
> On Mon, Jan 30, 2023 at 11:52:21PM +0530, Sunil V L wrote:
> > On ACPI based platforms, few details like ISA need to be read
> > from the ACPI table. Enable cpuinfo on ACPI based systems.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/kernel/cpu.c | 36 +++++++++++++++++++++++++++++-------
> >  1 file changed, 29 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 1b9a5a66e55a..bd6c0fcfe4ce 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (C) 2012 Regents of the University of California
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/cpu.h>
> >  #include <linux/init.h>
> >  #include <linux/seq_file.h>
> > @@ -256,26 +257,47 @@ static void c_stop(struct seq_file *m, void *v)
> >  {
> >  }
> >  
> > +#ifdef CONFIG_ACPI
> > +void acpi_print_hart_info(struct seq_file *m,
> > +			  unsigned long cpu)
> 
> Surely this fits on one line?
> 
Okay

> > +{
> > +	const char *isa;
> > +
> > +	if (!acpi_get_riscv_isa(NULL, get_acpi_id_for_cpu(cpu), &isa))
> > +		print_isa(m, isa);
> 
> Do you really need to guard this function? Aren't there nop'ed versions
> of acpi_get_riscv_isa() and get_acpi_id_for_cpu() in acpi.h?
> 
> IMO, basically any use of ifdeffery you can cleanly remove from a c file
> is a worthwhile change.
> 
You are right. Let me remove ifdef.

> > +
> 
> Extra blank line here FYI.
> 
> > +}
> > +#endif
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
> > +		if (!of_property_read_string(node, "compatible", &compat)
> > +		    && strcmp(compat, "riscv"))
>                     ^^ this should be on the line above
> TBH the whole series is in need of a checkpatch --strict run IMO,
> there's a bunch of coding style issues throughout.
> 
I just moved this line as is. Sure, let me fix it. Thanks.

> > +			seq_printf(m, "uarch\t\t: %s\n", compat);
> > +		of_node_put(node);
> > +	}
> > +#ifdef CONFIG_ACPI
> > +	else
> > +		acpi_print_hart_info(m, cpu_id);
> 
> Delete the ifdeffery here too please :)
> 
Okay

Thanks,
Sunil
