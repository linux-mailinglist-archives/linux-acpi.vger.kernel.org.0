Return-Path: <linux-acpi+bounces-413-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4516B7B7D3A
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 6AA5E1C2081F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359F111A2
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:33:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5D883D
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 10:13:23 +0000 (UTC)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4348A9
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 03:13:21 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79fa425855cso71365439f.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696414401; x=1697019201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=naQ12yZY9bgpmnWgAWPGFuKak0Xrn0cHsB8SeG3i588=;
        b=Nyxc6dnU3QMl/pHc5kV/9b5JF64rxD5/Z3dhLn30RJ0rpcSP8WSzbO6CIo2oczD/eI
         IQrVmqzOyoMQhX6pCB0Pz9Na+sezwT2BdT9nBBWT/HNoIShMMwkodoxjHbdAlC9hkl7I
         LZzKA9RQ1pMKCdop+5PErXsxDsMByZWK0lfZlMENhHmaTqPKRLso9g9JX4RCuDo5DV5S
         qba1CERsHjXp3FUwM6mpIO/M2i8VB44IpQIYAYpJoxJX1vSmuAmvR6wsoLs9tEIOpavB
         1CCHey7DpG2Zy/524b9UiHTGA/PXIwdBh8av0lJF1RU3DL7avw0QjDX2uLSxybfyX7C2
         UilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696414401; x=1697019201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naQ12yZY9bgpmnWgAWPGFuKak0Xrn0cHsB8SeG3i588=;
        b=bea+StbHRx47+jwdj1kQ97mF+ySbxRa17XhKD0FQf3u6OPejYZQbuaVKCiOEP5aH47
         Pv8IGYoMzGQVpMYwWVwKujAjwsPymlJHeRf0OpH/NVCnSaIhbO7/p/QUUlnkD2eAczr1
         PrW1m8iJ+ilkmXzd9Hb0AMbkQ/LgqUAAeJpJvNF2iZFy6gdjAErjL0kbDKx+D+8mhFjx
         raBk1ahK8+Tgr2qJQ2BsdHuha+fFOfQwam23gvOR4hdpiIq8zhIDD7v8h6szS8zkAGqQ
         NPoLxm26hoeOm94WjaKCFFF9J5ZfL6dqq/jFzGl3kywPG4m29fUNAh2MJliLJHX3rkbR
         /zuA==
X-Gm-Message-State: AOJu0YwXpT5juVUIuX3HIa9lUUGhJtxC0Ht9l+Qk9LVOoOrKDCdI4+3B
	6pPnhXOJt7Ob41MKg7FY/YNgOA==
X-Google-Smtp-Source: AGHT+IEbM48u0GUrbP675tX7PYXIUL94dARAyy9rnprgPNaHW3R5wUSTDSKo4NbADnyrnWBlyy8OOg==
X-Received: by 2002:a6b:7b05:0:b0:791:280:839e with SMTP id l5-20020a6b7b05000000b007910280839emr1987378iop.16.1696414401162;
        Wed, 04 Oct 2023 03:13:21 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id ep10-20020a0566384e0a00b0042b09bde126sm861366jab.165.2023.10.04.03.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 03:13:20 -0700 (PDT)
Date: Wed, 4 Oct 2023 15:43:07 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 -next 3/4] RISC-V: cacheflush: Initialize CBO
 variables on ACPI systems
Message-ID: <ZR06s5ZvK1S5XtIJ@sunil-laptop>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-4-sunilvl@ventanamicro.com>
 <f4ab7464-3dfb-4d10-8bed-76e7084abd3e@sifive.com>
 <ZRzof1sH/GJNQp4V@sunil-laptop>
 <20231004-58af76b11b3db2e64a93fd55@orel>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004-58af76b11b3db2e64a93fd55@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 10:33:31AM +0200, Andrew Jones wrote:
> On Wed, Oct 04, 2023 at 09:52:23AM +0530, Sunil V L wrote:
> > On Tue, Oct 03, 2023 at 02:50:02PM -0500, Samuel Holland wrote:
> > > On 2023-09-27 12:00 PM, Sunil V L wrote:
> > > > Using new interface to get the CBO block size information in RHCT,
> > > > initialize the variables on ACPI platforms.
> > > > 
> > > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > ---
> > > >  arch/riscv/mm/cacheflush.c | 37 +++++++++++++++++++++++++++++++------
> > > >  1 file changed, 31 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > > > index f1387272a551..8e59644e473c 100644
> > > > --- a/arch/riscv/mm/cacheflush.c
> > > > +++ b/arch/riscv/mm/cacheflush.c
> > > > @@ -3,7 +3,9 @@
> > > >   * Copyright (C) 2017 SiFive
> > > >   */
> > > >  
> > > > +#include <linux/acpi.h>
> > > >  #include <linux/of.h>
> > > > +#include <asm/acpi.h>
> > > >  #include <asm/cacheflush.h>
> > > >  
> > > >  #ifdef CONFIG_SMP
> > > > @@ -124,15 +126,38 @@ void __init riscv_init_cbo_blocksizes(void)
> > > >  	unsigned long cbom_hartid, cboz_hartid;
> > > >  	u32 cbom_block_size = 0, cboz_block_size = 0;
> > > >  	struct device_node *node;
> > > > +	struct acpi_table_header *rhct;
> > > > +	acpi_status status;
> > > > +	unsigned int cpu;
> > > > +
> > > > +	if (!acpi_disabled) {
> > > > +		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> > > > +		if (ACPI_FAILURE(status))
> > > > +			return;
> > > > +	}
> > > >  
> > > > -	for_each_of_cpu_node(node) {
> > > > -		/* set block-size for cbom and/or cboz extension if available */
> > > > -		cbo_get_block_size(node, "riscv,cbom-block-size",
> > > > -				   &cbom_block_size, &cbom_hartid);
> > > > -		cbo_get_block_size(node, "riscv,cboz-block-size",
> > > > -				   &cboz_block_size, &cboz_hartid);
> > > > +	for_each_possible_cpu(cpu) {
> > > > +		if (acpi_disabled) {
> > > > +			node = of_cpu_device_node_get(cpu);
> > > > +			if (!node) {
> > > > +				pr_warn("Unable to find cpu node\n");
> > > > +				continue;
> > > > +			}
> > > > +
> > > > +			/* set block-size for cbom and/or cboz extension if available */
> > > > +			cbo_get_block_size(node, "riscv,cbom-block-size",
> > > > +					   &cbom_block_size, &cbom_hartid);
> > > > +			cbo_get_block_size(node, "riscv,cboz-block-size",
> > > > +					   &cboz_block_size, &cboz_hartid);
> > > 
> > > This leaks a reference to the device node.
> > > 
> > Yep!. I missed of_node_put(). Let me add in next revision. Thanks!
> > 
> > > > +		} else {
> > > > +			acpi_get_cbo_block_size(rhct, cpu, &cbom_block_size,
> > > > +						&cboz_block_size, NULL);
> > > 
> > > This function loops through the whole RHCT already. Why do we need to call it
> > > for each CPU? Can't we just call it once, and have it do the same consistency
> > > checks as cbo_get_block_size()?
> > > 
> > > In that case, the DT path could keep the for_each_of_cpu_node() loop.
> > > 
> > I kept the same logic as DT. Basically, by passing the cpu node, we
> > will fetch the exact CPU's CBO property from RHCT. It is not clear to me
> > why we overwrite the same variable with value from another cpu and
> > whether we can return as soon as we get the CBO size for one CPU.
> > 
> > Drew, can we exit the loop if we get the CBO size for one CPU?
> 
> We want to compare the values for each CPU with the first one we find in
> order to ensure they are consistent. I think Samuel is suggesting that
> we leave the DT path here the same, i.e. keep the for_each_of_cpu_node()
> loop, and then change acpi_get_cbo_block_size() to *not* take a cpu as
> input, but rather follow the same pattern as DT, which is to loop over
> all cpus doing a consistency check against the first cpu's CBO info.
> 
Ahh OK. Thanks Drew and Samuel. Let me update as you suggested.

Thanks!
Sunil

