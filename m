Return-Path: <linux-acpi+bounces-2797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F8482AD8C
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jan 2024 12:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DC81C235C4
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jan 2024 11:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17015492;
	Thu, 11 Jan 2024 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="m4l9wBed"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C761640D
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jan 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so4208621b3a.2
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jan 2024 03:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704972727; x=1705577527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNl3tpkyK5Mul56pIgZxAMIH2IfRCEnxfyE9fY+1LDU=;
        b=m4l9wBedswJIQVDZ9iGWGdJl9Zx/EVnZmK8UjrW3iuPogILnCXvAJ5f1DVnoOFFPr9
         dNjJr40uwVe1jyOxPyyMIjVBHG9GKDQbxNUCgQDxMh+7ILiAaRt4exHzghki0ZceTZMF
         3Dbv1wxPgpfe6UjtYap9e4S8wc+yTMP0/eZdYto48cZn9iVRxAi3usJchmpf1Y487iu9
         QWZanqvBtoXd1mlGy8n/UNrxV0qZQnnJjHidpG3f4YZPfkINJtesjsPSueY3hMjzosBs
         h/9j2Aeq0zw7BbfopuQadD6QMveY7L9dlciwRqhZlDo3pOhR7ulaooZ75t570elby4ih
         aF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704972727; x=1705577527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNl3tpkyK5Mul56pIgZxAMIH2IfRCEnxfyE9fY+1LDU=;
        b=hqvWzmPFwiXwu+FZL+QszI0SrnYwvyex864wQylsJLauOklB9gm6Y6iF9Nw2Al3+Kz
         raMKOAL95KUnOXNCMWied/ZaGDAFEcTW71+6z4qb6HZFbeu+2Qef6fmDB2b4J9qc1+gb
         c1hn7FRE+yDcYKlRdOrH5a4KfBcR4HdjqJZvWzq8ZXUGGLArDyTy1l+Pr8HAXD1utJ1s
         QjnH8jSDOLAriZUKCx0qjZ6pLWAO5tcQTb4ifFFfOoAbpE7kC0liqe5n6zN01klYd7/2
         hcusF3UUvTIj9dKFcfM+ow9v15DeN64InTH+ib/DaezUpVtczqs07xVIDwuETYYnzV2X
         vJVg==
X-Gm-Message-State: AOJu0YxPulan7qvUortt3/WPjqjDSU3DKXvPoWw9K7yRwV2X4DX9oy/O
	MT18+B8ZkHtPwlBTMoRvq428i4Jt1Vn9Og==
X-Google-Smtp-Source: AGHT+IFNT0pZlCC90UfGIUe+0iysvNpEOqgrUfAsJP18C9CfIaYaEO8KkvhcxXutmMYmMdMAFoeQNg==
X-Received: by 2002:a05:6a20:89a9:b0:199:dd9a:df27 with SMTP id h41-20020a056a2089a900b00199dd9adf27mr782621pzg.124.1704972727324;
        Thu, 11 Jan 2024 03:32:07 -0800 (PST)
Received: from sunil-laptop ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id mm4-20020a1709030a0400b001d4b46d8c10sm972947plb.66.2024.01.11.03.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:32:06 -0800 (PST)
Date: Thu, 11 Jan 2024 17:01:59 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH -next 2/2] cpuidle: RISC-V: Add ACPI LPI support
Message-ID: <ZZ/Rr7AXVAN4Ecmu@sunil-laptop>
References: <20240111093058.121838-1-sunilvl@ventanamicro.com>
 <20240111093058.121838-3-sunilvl@ventanamicro.com>
 <20240111-d37d338a6b1aa71e944ebe05@orel>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111-d37d338a6b1aa71e944ebe05@orel>

On Thu, Jan 11, 2024 at 11:19:49AM +0100, Andrew Jones wrote:
> On Thu, Jan 11, 2024 at 03:00:58PM +0530, Sunil V L wrote:
> > Add required callbacks to support Low Power Idle (LPI) on ACPI based
> > RISC-V platforms.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/cpuidle/cpuidle-riscv-sbi.c | 78 +++++++++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > index e8094fc92491..cea67a54ab39 100644
> > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > @@ -632,3 +632,81 @@ static int __init sbi_cpuidle_init(void)
> >  	return 0;
> >  }
> >  device_initcall(sbi_cpuidle_init);
> > +
> > +#ifdef CONFIG_ACPI_PROCESSOR_IDLE
> > +
> > +#include <linux/acpi.h>
> > +#include <acpi/processor.h>
> > +
> > +#define RISCV_FFH_LPI_TYPE_MASK		0x1000000000000000ULL
> > +#define RISCV_FFH_LPI_RSVD_MASK		0x0FFFFFFF00000000ULL
> 
> GENMASK might look nicer and the type mask is 0xF000000000000000ULL,
> where 0x1000000000000000ULL means that the type is an SBI identifier.
> We need both defined
> 
> #define RISCV_FFH_LPI_TYPE_MASK              0xF000000000000000ULL
> #define RISCV_FFH_LPI_TYPE_SBI               0x1000000000000000ULL
> 
Sure. Let me use GENMASK and define both MASK and SBI type.

> as I point out below.
> 
> > +
> > +static int acpi_cpu_init_idle(unsigned int cpu)
> > +{
> > +	int i;
> > +	struct acpi_lpi_state *lpi;
> > +	struct acpi_processor *pr = per_cpu(processors, cpu);
> > +
> > +	if (unlikely(!pr || !pr->flags.has_lpi))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The SBI HSM suspend function is only available when:
> > +	 * 1) SBI version is 0.3 or higher
> > +	 * 2) SBI HSM extension is available
> > +	 */
> > +	if (sbi_spec_version < sbi_mk_version(0, 3) ||
> > +	    !sbi_probe_extension(SBI_EXT_HSM)) {
> > +		pr_warn("HSM suspend not available\n");
> 
> The comment and these lines match what's done in sbi_cpuidle_init().
> How about a static helper function to avoid duplication?
> 
Sure.

> > +		return -EINVAL;
> > +	}
> > +
> > +	if (pr->power.count <= 1)
> > +		return -ENODEV;
> > +
> > +	for (i = 1; i < pr->power.count; i++) {
> > +		u32 state;
> > +
> > +		lpi = &pr->power.lpi_states[i];
> > +
> > +		/* Validate Entry Method as per FFH spec.
> > +		 * bits[63:60] should be 0x1
> > +		 * bits[59:32] should be 0x0
> > +		 * bits[31:0] represent a SBI power_state
>                                         ^ an
> 
> > +		 */
> 
> Comment block needs opening wing (/*)
> 
Okay.

> > +		if (!(lpi->address & RISCV_FFH_LPI_TYPE_MASK) ||
> 
> This should be (lpi->address & RISCV_FFH_LPI_TYPE_MASK) != RISCV_FFH_LPI_TYPE_SBI
> 
Sure.

Let me send v2 in couple of days with these changes.

Thanks!
Sunil

> > +		    (lpi->address & RISCV_FFH_LPI_RSVD_MASK)) {
> > +			pr_warn("Invalid LPI entry method %#llx\n", lpi->address);
> > +			return -EINVAL;
> > +		}
> > +
> > +		state = lpi->address;
> > +		if (!sbi_suspend_state_is_valid(state)) {
> > +			pr_warn("Invalid SBI power state %#x\n", state);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int acpi_processor_ffh_lpi_probe(unsigned int cpu)
> > +{
> > +	return acpi_cpu_init_idle(cpu);
> > +}
> > +
> > +int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> > +{
> > +	u32 state = lpi->address;
> > +
> > +	if (state & SBI_HSM_SUSP_NON_RET_BIT)
> > +		return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend,
> > +						   lpi->index,
> > +						   state);
> > +	else
> > +		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
> > +							     lpi->index,
> > +							     state);
> > +}
> > +
> > +#endif
> > -- 
> > 2.34.1
> >
> 
> Thanks,
> drew

