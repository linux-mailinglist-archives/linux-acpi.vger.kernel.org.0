Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E216B0352
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Mar 2023 10:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCHJpi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Mar 2023 04:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCHJpL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2023 04:45:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D10B9BC5
        for <linux-acpi@vger.kernel.org>; Wed,  8 Mar 2023 01:44:03 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p20so17066015plw.13
        for <linux-acpi@vger.kernel.org>; Wed, 08 Mar 2023 01:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1678268641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bv6GQABTyvlUo8n5V+5AOScxA1OJXslTI0WCdpQtyc4=;
        b=lsdiFEmzBt55hVroblb079wHiV07NNRRrmXMwYMFoADw16GE8O2BiYk8f4FmyVrnJj
         HXphoOrakUNIHGGPmkToOU2wQ9PAzQsWjfrdepMWhQbBThTbIpvMKPZcvGhz3CXlIOaB
         Tm3oilEr6EM3DuawtYrOFEUz+iuTQyasqqEwmn0mtpuv3BJEnXoiRPzMPgxWnGioPJ+2
         7alSFZTHit7Wd/Z63Ro1i3Q6mTKL43o6dK4br2KcaGvnEXhqCBsBZt/7iuMttOaIf9MV
         aVQs9imzjlulAr3Sxa3mzHIXS0i6FqUkQrkwpEYoVWc4NF2ng4ZO7kXytYIvmBNC+SJV
         3bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678268641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv6GQABTyvlUo8n5V+5AOScxA1OJXslTI0WCdpQtyc4=;
        b=Oa0yV82WWisvkcWEPLbv0i74Qhxsjw2qv3Fhu/HwI4Qw6JXy74rlWSTU1sGimiZaeT
         NJk6vAj/d3NRrHnDrWOiUBjxBCjKREobl0BiuNyvvaMI1jXmjV4TKZkq8Rjrom3IFgqy
         9o8nUHc3PDCOx5+aaQBx6jcu4C5pWw/XDGbw1bLF4CHUqhvzIr/xviQRnUCrG2ECWBcK
         cpyCIV64SBSMANOzp8HFmXmvYAlGWUl3IjRsOkFhFr7hwNDhox0Xy2otSuJ/F+T2U/lx
         fMNXVEjbFLbfZdVYZHPxCfP9bY5h0Rv5+KMo0JFa7LF5LPWSm2ZZUSSh7aHr3Q6FVqJM
         I08g==
X-Gm-Message-State: AO0yUKUlOfaOZv3LNVw6GmD+/ZFgc4sE6euLKID1gDdnTmU8piiobP4u
        41C7VWUny8GzY52G/XJoMNkDkA==
X-Google-Smtp-Source: AK7set8+7oXejOnlrwNi7JTHrVcEN9fDrM3oo4Jq00Uh/vXOHeP1adEYP5gSS2Al/s5ESn312YharQ==
X-Received: by 2002:a17:903:32d2:b0:19a:7d73:ef47 with SMTP id i18-20020a17090332d200b0019a7d73ef47mr22273674plr.17.1678268640954;
        Wed, 08 Mar 2023 01:44:00 -0800 (PST)
Received: from sunil-laptop ([49.206.8.117])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b0019926c77577sm4759989plg.90.2023.03.08.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:44:00 -0800 (PST)
Date:   Wed, 8 Mar 2023 15:13:51 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
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
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 17/20] RISC-V: time.c: Add ACPI support for time_init()
Message-ID: <ZAhY10oQ6uwVIlb8@sunil-laptop>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-18-sunilvl@ventanamicro.com>
 <0cceafc3-522b-4ce0-9016-e931c818adec@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cceafc3-522b-4ce0-9016-e931c818adec@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 06, 2023 at 09:09:11PM +0000, Conor Dooley wrote:
> On Fri, Mar 03, 2023 at 07:06:44PM +0530, Sunil V L wrote:
> > On ACPI based platforms, timer related information is
> > available in RHCT. Add ACPI based probe support to the
> > timer initialization.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/kernel/time.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> > index babaf3b48ba8..2c29543549c3 100644
> > --- a/arch/riscv/kernel/time.c
> > +++ b/arch/riscv/kernel/time.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (C) 2017 SiFive
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/of_clk.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/clocksource.h>
> > @@ -18,17 +19,27 @@ EXPORT_SYMBOL_GPL(riscv_timebase);
> >  void __init time_init(void)
> >  {
> >  	struct device_node *cpu;
> > +	struct acpi_table_rhct *rhct;
> > +	acpi_status status;
> >  	u32 prop;
> >  
> > -	cpu = of_find_node_by_path("/cpus");
> > -	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> > -		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
> > -	of_node_put(cpu);
> > -	riscv_timebase = prop;
> > +	if (acpi_disabled) {
> > +		cpu = of_find_node_by_path("/cpus");
> > +		if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> > +			panic("RISC-V system with no 'timebase-frequency' in DTS\n");
> 
> I appreciate that it was like this before, but a newline here (and in
> the corresponding spot below) would be nice.
Sure!. Will update in next revision.

Thanks,
Sunil
