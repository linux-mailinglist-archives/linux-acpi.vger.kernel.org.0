Return-Path: <linux-acpi+bounces-407-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638B57B7D32
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 74DB31C208CB
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439A211199
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:32:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D471FD9
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 08:33:37 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE031C6
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 01:33:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso3180794a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696408413; x=1697013213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESJK41d6OgR3seh2ygAk4MlFIHKl40A8SsuP64iwTcA=;
        b=jYhf+MF52bILhuLEoUu1mLqPNjCIC+W+TJae5eYCN0nlEZeim8Jzpctr6k6U7WGmyw
         15oWtSpHGF7Njob+3o+7WTgaJn4FfS2FiE7LQntORR5qkPeyNnELyFd0fOkzINWW9QrH
         C9Xlw92txGykMY+FyRfXzJZEq1SgvCf+idYYWCn32JbNeymJPb8gvwEOgaaT4tZb2pur
         7xOe0rFPB0ADTZbca0PEnPpT3Ep1oBpOLNIVhzi8DYH/SzNXmR/sDgmWzwZidXLUdYuk
         +iWRyy8PtllPa9O8VFIO6KIJN328mYIkYBEK38G/1GIIe7ye6BLo030clbtTyVauHTt+
         88tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408413; x=1697013213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESJK41d6OgR3seh2ygAk4MlFIHKl40A8SsuP64iwTcA=;
        b=OgrFvXTYSWA4qQaeHHxFE9I11NODzOm3ihpyAXwNu516YYwYYocaCV0xIWk0cnAQrR
         5iKo4kkR538Ri0s42gbrj/rPHttvMOKOlMcS1ycU8gXf8xleqDWdE6Da9timLULgqwp2
         wqQdNlVqDyuexfes3Sb6VDHZxZD8dYsYxTZIPqOVLWJGeiI5RhTVFr7/qpBmgV4EHPRF
         IGlqR0nivjknBGyruo/7F5Og1D7Da/5RyKmVrxhhxg8PVXe7BqGrcexaGIFPNqCBniGS
         Wt6nDLbRfWVVw7HtLe510iW9e3sz/w1n+o03AoKaUqI+zmapJm1nN9O5K7bgeeKVzakj
         Uk7w==
X-Gm-Message-State: AOJu0YzhuhW7B6QAuqwWTZ4jbFQYuZVluEdrILA3H62P0rE5zRyPweh1
	NSfx6a/VAnsVG6ZOfsa4klnrPg==
X-Google-Smtp-Source: AGHT+IHsdVSR3lB99ndZrLstTMj2simAYzH+/ZkHt3CEzPElAq0jjok3rxxGVIpBP3HZkwlLU0Q4TA==
X-Received: by 2002:a05:6402:1843:b0:522:580f:8c75 with SMTP id v3-20020a056402184300b00522580f8c75mr1245485edy.17.1696408412466;
        Wed, 04 Oct 2023 01:33:32 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id w9-20020aa7dcc9000000b00537708be5c6sm2069890edu.73.2023.10.04.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:33:32 -0700 (PDT)
Date: Wed, 4 Oct 2023 10:33:31 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 -next 3/4] RISC-V: cacheflush: Initialize CBO
 variables on ACPI systems
Message-ID: <20231004-58af76b11b3db2e64a93fd55@orel>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-4-sunilvl@ventanamicro.com>
 <f4ab7464-3dfb-4d10-8bed-76e7084abd3e@sifive.com>
 <ZRzof1sH/GJNQp4V@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRzof1sH/GJNQp4V@sunil-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 09:52:23AM +0530, Sunil V L wrote:
> On Tue, Oct 03, 2023 at 02:50:02PM -0500, Samuel Holland wrote:
> > On 2023-09-27 12:00 PM, Sunil V L wrote:
> > > Using new interface to get the CBO block size information in RHCT,
> > > initialize the variables on ACPI platforms.
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >  arch/riscv/mm/cacheflush.c | 37 +++++++++++++++++++++++++++++++------
> > >  1 file changed, 31 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > > index f1387272a551..8e59644e473c 100644
> > > --- a/arch/riscv/mm/cacheflush.c
> > > +++ b/arch/riscv/mm/cacheflush.c
> > > @@ -3,7 +3,9 @@
> > >   * Copyright (C) 2017 SiFive
> > >   */
> > >  
> > > +#include <linux/acpi.h>
> > >  #include <linux/of.h>
> > > +#include <asm/acpi.h>
> > >  #include <asm/cacheflush.h>
> > >  
> > >  #ifdef CONFIG_SMP
> > > @@ -124,15 +126,38 @@ void __init riscv_init_cbo_blocksizes(void)
> > >  	unsigned long cbom_hartid, cboz_hartid;
> > >  	u32 cbom_block_size = 0, cboz_block_size = 0;
> > >  	struct device_node *node;
> > > +	struct acpi_table_header *rhct;
> > > +	acpi_status status;
> > > +	unsigned int cpu;
> > > +
> > > +	if (!acpi_disabled) {
> > > +		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> > > +		if (ACPI_FAILURE(status))
> > > +			return;
> > > +	}
> > >  
> > > -	for_each_of_cpu_node(node) {
> > > -		/* set block-size for cbom and/or cboz extension if available */
> > > -		cbo_get_block_size(node, "riscv,cbom-block-size",
> > > -				   &cbom_block_size, &cbom_hartid);
> > > -		cbo_get_block_size(node, "riscv,cboz-block-size",
> > > -				   &cboz_block_size, &cboz_hartid);
> > > +	for_each_possible_cpu(cpu) {
> > > +		if (acpi_disabled) {
> > > +			node = of_cpu_device_node_get(cpu);
> > > +			if (!node) {
> > > +				pr_warn("Unable to find cpu node\n");
> > > +				continue;
> > > +			}
> > > +
> > > +			/* set block-size for cbom and/or cboz extension if available */
> > > +			cbo_get_block_size(node, "riscv,cbom-block-size",
> > > +					   &cbom_block_size, &cbom_hartid);
> > > +			cbo_get_block_size(node, "riscv,cboz-block-size",
> > > +					   &cboz_block_size, &cboz_hartid);
> > 
> > This leaks a reference to the device node.
> > 
> Yep!. I missed of_node_put(). Let me add in next revision. Thanks!
> 
> > > +		} else {
> > > +			acpi_get_cbo_block_size(rhct, cpu, &cbom_block_size,
> > > +						&cboz_block_size, NULL);
> > 
> > This function loops through the whole RHCT already. Why do we need to call it
> > for each CPU? Can't we just call it once, and have it do the same consistency
> > checks as cbo_get_block_size()?
> > 
> > In that case, the DT path could keep the for_each_of_cpu_node() loop.
> > 
> I kept the same logic as DT. Basically, by passing the cpu node, we
> will fetch the exact CPU's CBO property from RHCT. It is not clear to me
> why we overwrite the same variable with value from another cpu and
> whether we can return as soon as we get the CBO size for one CPU.
> 
> Drew, can we exit the loop if we get the CBO size for one CPU?

We want to compare the values for each CPU with the first one we find in
order to ensure they are consistent. I think Samuel is suggesting that
we leave the DT path here the same, i.e. keep the for_each_of_cpu_node()
loop, and then change acpi_get_cbo_block_size() to *not* take a cpu as
input, but rather follow the same pattern as DT, which is to loop over
all cpus doing a consistency check against the first cpu's CBO info.

Thanks,
drew

