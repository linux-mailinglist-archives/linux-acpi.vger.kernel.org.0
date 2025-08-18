Return-Path: <linux-acpi+bounces-15816-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772CB2B1B4
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 21:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDC162658E
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 19:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB9272E43;
	Mon, 18 Aug 2025 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jf8luqdO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B7259C93
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545404; cv=none; b=TpAr5Jc7W3Sl3kpUmDHdG6HVi1Z+kFza6YAi7YYCsPmut3pU2cWZvqaSScXSXzuGfiTD1cBjnMzOs2i5EDv2TcrClywXdy+lj0zitkvBskZeSWUeZjfzLcm4pzitwqKprjGWSJhyvNz8Bk5hipJ8Pst5gjp596VzgIdy1awQG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545404; c=relaxed/simple;
	bh=oChUBydQOkx609E7c71/3StyYXNoPtXDhpQ3MJUsrNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgQ0+aHz2ucAJEBLuuPSc5XDywIRWrouynuYh9YPbQZaOz/VFqd9GK0o1pZNgV/iA/XsJVgAjfouWLdS7qoAamwck3n/lc7BEvSroG78iWUYX2QIOzQCcIZAYS7Mgq7SKtPQYUjqx205RPgZ74BT5nBt4NBCQSs6SgyfL3iht5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jf8luqdO; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <187e5d1b-92f0-4a24-99ae-c55137cb7de4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755545390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1LPhIu7KE1xSdbtwTXFZXR3H6pDP+wGqBCLl8liJ5M=;
	b=jf8luqdOxN31PMcev2r/bYnXNrAC7PVeprZZXSQqbz1DYXczHAM6Xj3jzHKccxQgF5CNHB
	0JUKfPrXsDap//jnKeUpEwUFe4Hj7untSaThcFhfuSVObB6NVY4EoSV+lH8R2QoKzBBXx6
	g2/BYT4pWb/5AXT0BO8nT4wVOzrIOO0=
Date: Mon, 18 Aug 2025 12:29:38 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
To: Anup Patel <apatel@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Len Brown <lenb@kernel.org>, Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-3-apatel@ventanamicro.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
Content-Language: en-US
In-Reply-To: <20250818143600.894385-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/18/25 7:36 AM, Anup Patel wrote:
> In RISC-V, there is no CSR read/write instruction which takes CSR
> number via register so add common csr_read_num() and csr_write_num()
> functions which allow accessing certain CSRs by passing CSR number
> as parameter. These common functions will be first used by the
> ACPI CPPC driver and RISC-V PMU driver.

Thanks for the cleanup. Are you planning to align the csr.h in tools so 
that userpsace tools can use leverage it as well ?

tools/arch/riscv/include/asm/csr.h

> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>   arch/riscv/include/asm/csr.h |   3 +
>   arch/riscv/kernel/Makefile   |   1 +
>   arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
>   drivers/acpi/riscv/cppc.c    |  17 ++--
>   drivers/perf/riscv_pmu.c     |  54 ++----------
>   5 files changed, 184 insertions(+), 56 deletions(-)
>   create mode 100644 arch/riscv/kernel/csr.c
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 6fed42e37705..1540626b3540 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -575,6 +575,9 @@
>   			      : "memory");			\
>   })
>   
> +extern unsigned long csr_read_num(unsigned long csr_num, int *out_err);
> +extern void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err);
> +
>   #endif /* __ASSEMBLY__ */
>   
>   #endif /* _ASM_RISCV_CSR_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index c7b542573407..0a75e20bde18 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -50,6 +50,7 @@ obj-y	+= soc.o
>   obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
>   obj-y	+= cpu.o
>   obj-y	+= cpufeature.o
> +obj-y	+= csr.o
>   obj-y	+= entry.o
>   obj-y	+= irq.o
>   obj-y	+= process.o
> diff --git a/arch/riscv/kernel/csr.c b/arch/riscv/kernel/csr.c
> new file mode 100644
> index 000000000000..e96b129c1a99
> --- /dev/null
> +++ b/arch/riscv/kernel/csr.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Ventana Micro Systems Inc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/types.h>
> +#include <asm/csr.h>
> +
> +#define CSR_CUSTOM0_U_RW_BASE		0x800
> +#define CSR_CUSTOM0_U_RW_COUNT		0x100
> +
> +#define CSR_CUSTOM1_U_RO_BASE		0xCC0
> +#define CSR_CUSTOM1_U_RO_COUNT		0x040
> +
> +#define CSR_CUSTOM2_S_RW_BASE		0x5C0
> +#define CSR_CUSTOM2_S_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM3_S_RW_BASE		0x9C0
> +#define CSR_CUSTOM3_S_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM4_S_RO_BASE		0xDC0
> +#define CSR_CUSTOM4_S_RO_COUNT		0x040
> +
> +#define CSR_CUSTOM5_HS_RW_BASE		0x6C0
> +#define CSR_CUSTOM5_HS_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM6_HS_RW_BASE		0xAC0
> +#define CSR_CUSTOM6_HS_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM7_HS_RO_BASE		0xEC0
> +#define CSR_CUSTOM7_HS_RO_COUNT		0x040
> +
> +#define CSR_CUSTOM8_M_RW_BASE		0x7C0
> +#define CSR_CUSTOM8_M_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM9_M_RW_BASE		0xBC0
> +#define CSR_CUSTOM9_M_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM10_M_RO_BASE		0xFC0
> +#define CSR_CUSTOM10_M_RO_COUNT		0x040
> +
> +unsigned long csr_read_num(unsigned long csr_num, int *out_err)
> +{
> +#define switchcase_csr_read(__csr_num)				\
> +	case (__csr_num):					\
> +		return csr_read(__csr_num)
> +#define switchcase_csr_read_2(__csr_num)			\
> +	switchcase_csr_read(__csr_num + 0);			\
> +	switchcase_csr_read(__csr_num + 1)
> +#define switchcase_csr_read_4(__csr_num)			\
> +	switchcase_csr_read_2(__csr_num + 0);			\
> +	switchcase_csr_read_2(__csr_num + 2)
> +#define switchcase_csr_read_8(__csr_num)			\
> +	switchcase_csr_read_4(__csr_num + 0);			\
> +	switchcase_csr_read_4(__csr_num + 4)
> +#define switchcase_csr_read_16(__csr_num)			\
> +	switchcase_csr_read_8(__csr_num + 0);			\
> +	switchcase_csr_read_8(__csr_num + 8)
> +#define switchcase_csr_read_32(__csr_num)			\
> +	switchcase_csr_read_16(__csr_num + 0);			\
> +	switchcase_csr_read_16(__csr_num + 16)
> +#define switchcase_csr_read_64(__csr_num)			\
> +	switchcase_csr_read_32(__csr_num + 0);			\
> +	switchcase_csr_read_32(__csr_num + 32)
> +#define switchcase_csr_read_128(__csr_num)			\
> +	switchcase_csr_read_64(__csr_num + 0);			\
> +	switchcase_csr_read_64(__csr_num + 64)
> +#define switchcase_csr_read_256(__csr_num)			\
> +	switchcase_csr_read_128(__csr_num + 0);			\
> +	switchcase_csr_read_128(__csr_num + 128)
> +
> +	*out_err = 0;
> +	switch (csr_num) {
> +	switchcase_csr_read_32(CSR_CYCLE);
> +	switchcase_csr_read_32(CSR_CYCLEH);
> +	switchcase_csr_read_256(CSR_CUSTOM0_U_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM1_U_RO_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM2_S_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM3_S_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM4_S_RO_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM5_HS_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM6_HS_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM7_HS_RO_BASE);
> +#ifdef CONFIG_RISCV_M_MODE
> +	switchcase_csr_read_64(CSR_CUSTOM8_M_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM9_M_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM10_M_RO_BASE);
> +#endif
> +	default:
> +		*out_err = -EINVAL;
> +		break;
> +	}
> +
> +	return 0;
> +#undef switchcase_csr_read_256
> +#undef switchcase_csr_read_128
> +#undef switchcase_csr_read_64
> +#undef switchcase_csr_read_32
> +#undef switchcase_csr_read_16
> +#undef switchcase_csr_read_8
> +#undef switchcase_csr_read_4
> +#undef switchcase_csr_read_2
> +#undef switchcase_csr_read
> +}
> +EXPORT_SYMBOL_GPL(csr_read_num);
> +
> +void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err)
> +{
> +#define switchcase_csr_write(__csr_num, __val)			\
> +	case (__csr_num):					\
> +		csr_write(__csr_num, __val);			\
> +		break
> +#define switchcase_csr_write_2(__csr_num, __val)		\
> +	switchcase_csr_write(__csr_num + 0, __val);		\
> +	switchcase_csr_write(__csr_num + 1, __val)
> +#define switchcase_csr_write_4(__csr_num, __val)		\
> +	switchcase_csr_write_2(__csr_num + 0, __val);		\
> +	switchcase_csr_write_2(__csr_num + 2, __val)
> +#define switchcase_csr_write_8(__csr_num, __val)		\
> +	switchcase_csr_write_4(__csr_num + 0, __val);		\
> +	switchcase_csr_write_4(__csr_num + 4, __val)
> +#define switchcase_csr_write_16(__csr_num, __val)		\
> +	switchcase_csr_write_8(__csr_num + 0, __val);		\
> +	switchcase_csr_write_8(__csr_num + 8, __val)
> +#define switchcase_csr_write_32(__csr_num, __val)		\
> +	switchcase_csr_write_16(__csr_num + 0, __val);		\
> +	switchcase_csr_write_16(__csr_num + 16, __val)
> +#define switchcase_csr_write_64(__csr_num, __val)		\
> +	switchcase_csr_write_32(__csr_num + 0, __val);		\
> +	switchcase_csr_write_32(__csr_num + 32, __val)
> +#define switchcase_csr_write_128(__csr_num, __val)		\
> +	switchcase_csr_write_64(__csr_num + 0, __val);		\
> +	switchcase_csr_write_64(__csr_num + 64, __val)
> +#define switchcase_csr_write_256(__csr_num, __val)		\
> +	switchcase_csr_write_128(__csr_num + 0, __val);		\
> +	switchcase_csr_write_128(__csr_num + 128, __val)
> +
> +	*out_err = 0;
> +	switch (csr_num) {
> +	switchcase_csr_write_256(CSR_CUSTOM0_U_RW_BASE, val);
> +	switchcase_csr_write_64(CSR_CUSTOM2_S_RW_BASE, val);
> +	switchcase_csr_write_64(CSR_CUSTOM3_S_RW_BASE, val);
> +	switchcase_csr_write_64(CSR_CUSTOM5_HS_RW_BASE, val);
> +	switchcase_csr_write_64(CSR_CUSTOM6_HS_RW_BASE, val);
> +#ifdef CONFIG_RISCV_M_MODE
> +	switchcase_csr_write_64(CSR_CUSTOM8_M_RW_BASE, val);
> +	switchcase_csr_write_64(CSR_CUSTOM9_M_RW_BASE, val);
> +#endif
> +	default:
> +		*out_err = -EINVAL;
> +		break;
> +	}
> +#undef switchcase_csr_write_256
> +#undef switchcase_csr_write_128
> +#undef switchcase_csr_write_64
> +#undef switchcase_csr_write_32
> +#undef switchcase_csr_write_16
> +#undef switchcase_csr_write_8
> +#undef switchcase_csr_write_4
> +#undef switchcase_csr_write_2
> +#undef switchcase_csr_write
> +}
> +EXPORT_SYMBOL_GPL(csr_write_num);
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 42c1a9052470..fe491937ed25 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -65,24 +65,19 @@ static void sbi_cppc_write(void *write_data)
>   static void cppc_ffh_csr_read(void *read_data)
>   {
>   	struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
> +	int err;
>   
> -	switch (data->reg) {
> -	/* Support only TIME CSR for now */
> -	case CSR_TIME:
> -		data->ret.value = csr_read(CSR_TIME);
> -		data->ret.error = 0;
> -		break;
> -	default:
> -		data->ret.error = -EINVAL;
> -		break;
> -	}
> +	data->ret.value = csr_read_num(data->reg, &err);
> +	data->ret.error = err;
>   }
>   
>   static void cppc_ffh_csr_write(void *write_data)
>   {
>   	struct sbi_cppc_data *data = (struct sbi_cppc_data *)write_data;
> +	int err;
>   
> -	data->ret.error = -EINVAL;
> +	csr_write_num(data->reg, data->val, &err);
> +	data->ret.error = err;
>   }
>   
>   /*
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index 7644147d50b4..b41f353ba964 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -16,6 +16,7 @@
>   #include <linux/smp.h>
>   #include <linux/sched_clock.h>
>   
> +#include <asm/csr.h>
>   #include <asm/sbi.h>
>   
>   static bool riscv_perf_user_access(struct perf_event *event)
> @@ -88,58 +89,21 @@ void arch_perf_update_userpage(struct perf_event *event,
>   	userpg->cap_user_time_short = 1;
>   }
>   
> -static unsigned long csr_read_num(int csr_num)
> -{
> -#define switchcase_csr_read(__csr_num, __val)		{\
> -	case __csr_num:					\
> -		__val = csr_read(__csr_num);		\
> -		break; }
> -#define switchcase_csr_read_2(__csr_num, __val)		{\
> -	switchcase_csr_read(__csr_num + 0, __val)	 \
> -	switchcase_csr_read(__csr_num + 1, __val)}
> -#define switchcase_csr_read_4(__csr_num, __val)		{\
> -	switchcase_csr_read_2(__csr_num + 0, __val)	 \
> -	switchcase_csr_read_2(__csr_num + 2, __val)}
> -#define switchcase_csr_read_8(__csr_num, __val)		{\
> -	switchcase_csr_read_4(__csr_num + 0, __val)	 \
> -	switchcase_csr_read_4(__csr_num + 4, __val)}
> -#define switchcase_csr_read_16(__csr_num, __val)	{\
> -	switchcase_csr_read_8(__csr_num + 0, __val)	 \
> -	switchcase_csr_read_8(__csr_num + 8, __val)}
> -#define switchcase_csr_read_32(__csr_num, __val)	{\
> -	switchcase_csr_read_16(__csr_num + 0, __val)	 \
> -	switchcase_csr_read_16(__csr_num + 16, __val)}
> -
> -	unsigned long ret = 0;
> -
> -	switch (csr_num) {
> -	switchcase_csr_read_32(CSR_CYCLE, ret)
> -	switchcase_csr_read_32(CSR_CYCLEH, ret)
> -	default :
> -		break;
> -	}
> -
> -	return ret;
> -#undef switchcase_csr_read_32
> -#undef switchcase_csr_read_16
> -#undef switchcase_csr_read_8
> -#undef switchcase_csr_read_4
> -#undef switchcase_csr_read_2
> -#undef switchcase_csr_read
> -}
> -
>   /*
>    * Read the CSR of a corresponding counter.
>    */
>   unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
>   {
> -	if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
> -	   (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {
> -		pr_err("Invalid performance counter csr %lx\n", csr);
> -		return -EINVAL;
> +	unsigned long val;
> +	int rc;
> +
> +	val = csr_read_num(csr, &rc);
> +	if (rc) {
> +		pr_err("Failed to read performance counter csr %lx (error %d)\n", csr, rc);
> +		return rc;
>   	}
>   
> -	return csr_read_num(csr);
> +	return val;
>   }

Otherwise, lgtm.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

>   
>   u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)

