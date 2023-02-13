Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4AA694E38
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBMRjh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 12:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjBMRjg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 12:39:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C100F1C7CF
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:39:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h4so6409208pll.9
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6a6ybMdzwmsAq2eExsLYksMr5wMk1cwEz6ueJMHefY=;
        b=S1al247gcEL4BcZ/hYaKhkRKclAN/d/Ale6FwEo92a2U4NKMQGnnZfv/pQtwbomCPn
         xel0nlpjF31S2OXDqLyxhZ1GBfszQEiHN9drHwhUOHzllXGvtfWZlupGXFOEfcdKpbGN
         aCrGK03AEEhPOslZVns+Z2YoYJIz8kuUgJrMPX9B6PAfhNx6Imq9wt2yJtpu47XE4Knw
         BOuESdlY9sH87qSdwOTocsIj1/gwgVmY33KepTg0WN/atyjyCQPVEoGwSKxtaFrSNLw+
         ODBFjQJyrvM+d+JUUB2AwCMsuVYZcZ9KHmn/LoJWrDLEmkwBVR/EZPk8K+Mvb4RfmSlb
         bklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6a6ybMdzwmsAq2eExsLYksMr5wMk1cwEz6ueJMHefY=;
        b=DerXJA+1nyxPz96fIvJNuqyjsaslU6n+JMwDLFf7Qg8mR+yv2u+XAp9eyd9yzK4wBB
         VNFonhjkh+GHUY80cp3yt/G3sLaiT5tw+gZTrGWy5XJRAqrQPBGPyaqoSD/aklm9EBov
         v9Ltsz2At2ClsEyp+EnfIIPPOmnvcbhVpy3n4+2YZbBB7TLuAh3lNYw8ZUqhLhknZ2/5
         SoASo4H62Iy4pTjkWC090UsCaD7gb0GWkr0v2D7etSguFuvxURNurzs68UNmjfm0707A
         4D9p+A+NX4gGhGmUX9/xnQNnOC7InPCmh4LadCwOrNZCobeHW6WwKxXxlJlrSYtWKBEO
         2IHQ==
X-Gm-Message-State: AO0yUKWhY0aW29j0TX8uHrTIUciapRfG0hZV1q1IySnry6+xlF7ygmPA
        R5St52jPFUPfbISYFlHTLqSz/w==
X-Google-Smtp-Source: AK7set9smglHbeeBmhpcAdaBTlzB7n3/yd6cTJIGHGINpq27eZbXzJHju43D2BUxrMc4rZ6rGghP6Q==
X-Received: by 2002:a05:6a21:3397:b0:c2:e30c:9be5 with SMTP id yy23-20020a056a21339700b000c2e30c9be5mr25971400pzb.12.1676309974325;
        Mon, 13 Feb 2023 09:39:34 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n6-20020a637206000000b004fbb6200482sm1646779pgc.41.2023.02.13.09.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 09:39:33 -0800 (PST)
Date:   Mon, 13 Feb 2023 23:09:26 +0530
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
Subject: Re: [PATCH 16/24] RISC-V: ACPI: clocksource/timer-riscv: Add ACPI
 support
Message-ID: <Y+p1zjFDcPpgFxuw@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-17-sunilvl@ventanamicro.com>
 <Y+VecXd9PVpkDggY@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+VecXd9PVpkDggY@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 09, 2023 at 08:58:25PM +0000, Conor Dooley wrote:
> On Mon, Jan 30, 2023 at 11:52:17PM +0530, Sunil V L wrote:
> > timer-riscv driver needs to get the timebase-frequency from
> > RISC-V Hart Capabilities Table (RHCT) on ACPI platforms. Add
> > support to read the information from RHCT.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/clocksource/timer-riscv.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > index 4016c065a01c..8079666753a6 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -10,6 +10,7 @@
> >  
> >  #define pr_fmt(fmt) "riscv-timer: " fmt
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/clocksource.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/cpu.h>
> > @@ -198,3 +199,11 @@ static int __init riscv_timer_init_dt(struct device_node *n)
> >  }
> >  
> >  TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
> > +
> > +#ifdef CONFIG_ACPI
> > +static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
> > +{
> > +	return riscv_timer_init_common();
> 
> I feel like I need to ask as it was deleted in the previous patch, how
> does ACPI determine whether the arch timer can wake the CPUs?
> 
We have plans to add a flag in RHCT. But that still needs approval.

Thanks
Sunil
