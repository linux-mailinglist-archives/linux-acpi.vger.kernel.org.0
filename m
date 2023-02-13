Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42231694B01
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 16:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBMPX5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 10:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjBMPX4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 10:23:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA9C9018
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 07:23:55 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gd1so1472878pjb.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 07:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIG79omTuAqh92FYqalRSBErGwvaWBx/kFaBBIuHnJI=;
        b=RkzvbBqCzhcJq+aCvWqxW0ulR29Msgdt+7aIn1JRBsFQoncmghs+GZc7d6YCR4iGkS
         TDgqJ8VaI/QQAxI2uyjQ4hdzy2T8OqrZHYhP7SLLaryY09RagnCpfl1kVP5LYDinXD5b
         yHNCpg3Aaw/RfOjSWwaHpUe7QRkbs0SJNEtalDt+w9awYarvdRhnPxAXWRa6D8EywR6P
         HW7+/l8ILedEd4ocGvSKTpKtj1YsVohZhldYRn41xQelvMv+ODbyDhRDDXhhEDjvtzu9
         wjiYwWF4k2lgiTecS+Vugi7ZOdbzcm9WBS5ZXjyY2DbfdwG/ZXrqOnIfL/kaaM8GTSci
         AlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIG79omTuAqh92FYqalRSBErGwvaWBx/kFaBBIuHnJI=;
        b=0YNHOEXr+ifYRl8dXEbdIxjeO4bMQz/D16lCqa9SlfVbY4DDQNJU6ldpa9xY9XEFpx
         mqLeBZSRZqEc4lnKtazhgRGa11f8jZmjwyWzCo+aVwRyhhvTqLhY4xTXR09FxqwkdmAi
         zEKtXTnPWeukmZrZ8tWrMqdo3UdjjA3aF4GfduFuKvguQMXFA4L6gT8T9WDwLx2ZO9Jp
         +o5lR0buyXTzj86WaFWo/Xw+IW4qMl6F/qVZlbpd1d36ojpb8/KH5AGQ1DaqBszEscMR
         r9Z930sH9yqPPc4tDMRkertj0t3LzMeZm/e601zVDsodJIaAqi4dXlL1XF6nueIVspY4
         eEJw==
X-Gm-Message-State: AO0yUKVK/px+aEJJxJAnqA8gi5UOLEjd3/WDT8ExlVYIIP8YwFHCMO+0
        j5HirvBoV2Cjrfi7HB3QTdRHW9V8djLYxrZH
X-Google-Smtp-Source: AK7set+hb1XmMLJh/78y4oD9MeKNqlA8guKewewIHXEIqcAaBoXEVpek0ge/MjnZYOUUPYr2o5Tjbg==
X-Received: by 2002:a17:903:120c:b0:197:35fc:6a5d with SMTP id l12-20020a170903120c00b0019735fc6a5dmr26864926plh.30.1676301835225;
        Mon, 13 Feb 2023 07:23:55 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903120300b00196053474a8sm8365196plh.53.2023.02.13.07.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:23:54 -0800 (PST)
Date:   Mon, 13 Feb 2023 20:53:46 +0530
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
Subject: Re: [PATCH 07/24] RISC-V: ACPI: Enable ACPI build infrastructure
Message-ID: <Y+pWAhdFHSzq5SOR@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-8-sunilvl@ventanamicro.com>
 <Y+QUwFIIj7tvrHpM@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QUwFIIj7tvrHpM@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 08, 2023 at 09:31:44PM +0000, Conor Dooley wrote:
> On Mon, Jan 30, 2023 at 11:52:08PM +0530, Sunil V L wrote:
> > Enable build infrastructure to add ACPI support for
> > RISC-V.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/Kconfig | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d153e1cd890b..f664350679bc 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -12,6 +12,9 @@ config 32BIT
> >  
> >  config RISCV
> >  	def_bool y
> > +	select ACPI_GENERIC_GSI if ACPI
> > +	select ACPI_MCFG if (ACPI && PCI)
> 
> These brackets are not needed, right?
> 
Okay.

> > +	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> >  	select ARCH_CLOCKSOURCE_INIT
> >  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> >  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> > @@ -598,6 +601,7 @@ config EFI_STUB
> >  config EFI
> >  	bool "UEFI runtime support"
> >  	depends on OF && !XIP_KERNEL
> > +	select ARCH_SUPPORTS_ACPI if 64BIT
> >  	select LIBFDT
> >  	select UCS2_STRING
> >  	select EFI_PARAMS_FROM_FDT
> > @@ -703,3 +707,4 @@ source "drivers/cpufreq/Kconfig"
> >  endmenu # "CPU Power Management"
> >  
> >  source "arch/riscv/kvm/Kconfig"
> > +source "drivers/acpi/Kconfig"
> 
> For consistency with the rest of the file, a newline before drivers
> would be in order here.
>
Sure.

Thanks
Sunil 


