Return-Path: <linux-acpi+bounces-15748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E45ECB28A88
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Aug 2025 06:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB0E1CE6996
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Aug 2025 04:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B901C5496;
	Sat, 16 Aug 2025 04:25:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88437483;
	Sat, 16 Aug 2025 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755318311; cv=none; b=TEJLyG5olFLpALOtHSDM3gY2sgHnR/aXedu3bwshJgB0G9bpbyArgwlr0Iifnxe0TfQ+NlSQBlt/RRdAhu1LVCpYfVYFnZG/4yM9MMB4RdIeNEw8m4pCPpgCtJGsSoIpd/vlwxgDwEEkLYyvbnxduKPf2YUyPLYVdYfe3RzEFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755318311; c=relaxed/simple;
	bh=AvE7Vq+Ia1iy0ymdsrxHDLQTSws2IWS+/tUHXwiSo/E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=o4MLSp1Wi5UZl95x103DasavgYLFIsRjOA9hwvBgRG9c6ewDbcXF5etjCbwodRkROHOwGEzIyBLzqsvxDW1AIl1XxTjHuda0aN4LjN+FhdJLLzk5dyMJSLgCuQMnEzD3aKBZpQ/28UpaqW6CrPULucxYeliieoRsgVOsUNk60es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.108] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowABXgaUGCKBoONhEDA--.30386S2;
	Sat, 16 Aug 2025 12:24:39 +0800 (CST)
Message-ID: <89865f17-f405-445a-874d-9361fe247bfe@iscas.ac.cn>
Date: Sat, 16 Aug 2025 12:24:38 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH 2/2] RISC-V: Add common csr_read_num() and csr_write_num()
 functions
To: Anup Patel <apatel@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Len Brown <lenb@kernel.org>, Atish Patra <atish.patra@linux.dev>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Vivian Wang <wangruikang@iscas.ac.cn>
References: <20250815161406.76370-1-apatel@ventanamicro.com>
 <20250815161406.76370-3-apatel@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250815161406.76370-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowABXgaUGCKBoONhEDA--.30386S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1xWw18WFy5KrW8JryDAwb_yoW7uFyUpr
	WjkFZIkr48Ars293y3Crn8Jry5X3WxWFWUK348Xay3Xr4Utr98WrykWa4UtryDWFZ5X3s8
	WF1q9w4fC3s0qrDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUUxR6UUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 8/16/25 00:14, Anup Patel wrote:
> In RISC-V, there is no CSR read/write instruction which takes CSR
> number via register so add common csr_read_num() and csr_write_num()
> functions which allow accessing certain CSRs by passing CSR number
> as parameter. These common functions will be first used by the
> ACPI CPPC driver and RISC-V PMU driver.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/csr.h |   3 +
>  arch/riscv/kernel/Makefile   |   1 +
>  arch/riscv/kernel/csr.c      | 177 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/riscv/cppc.c    |  17 ++--
>  drivers/perf/riscv_pmu.c     |  43 +--------
>  5 files changed, 189 insertions(+), 52 deletions(-)
>  create mode 100644 arch/riscv/kernel/csr.c
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 6fed42e37705..1540626b3540 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -575,6 +575,9 @@
>  			      : "memory");			\
>  })
>
> +extern unsigned long csr_read_num(unsigned long csr_num, int *out_err);
> +extern void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err);
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_CSR_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index c7b542573407..0a75e20bde18 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -50,6 +50,7 @@ obj-y	+= soc.o
>  obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
>  obj-y	+= cpu.o
>  obj-y	+= cpufeature.o
> +obj-y	+= csr.o
>  obj-y	+= entry.o
>  obj-y	+= irq.o
>  obj-y	+= process.o
> diff --git a/arch/riscv/kernel/csr.c b/arch/riscv/kernel/csr.c
> new file mode 100644
> index 000000000000..f7de45bb597c
> --- /dev/null
> +++ b/arch/riscv/kernel/csr.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Ventana Micro Systems Inc.
> + */
> +
> +#define pr_fmt(fmt) "riscv: " fmt
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/printk.h>
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

That's... a bit horrendous.

Since we know that each inner case is quite simple, can we just do our
own jump table for that? Each case can be one csrr/csrw and one jal
(possibly pad to 8 bytes), and we can just jump to
label + (csr_num - range_start) * 8. See bottom of this message for an
untested prototype.

Vivian "dramforever" Wang

UNTESTED prototype:

#define CSR_CYCLE 0xc00
#define CSR_CYCLEH 0xc80

/* Force expand argument if macro */
#define str(_x) #_x

unsigned long csr_read_num(long csr_num)
{
	unsigned long res, tmp;

        /*
	 * Generate a jump table for each range. Each (inner) case is 8 bytes of
	 * code, a csrr instruction and a jump, possibly padded, so we just jump
	 * to label_1f + (csr_num - _start) * 8
	 */
#define csr_read_case_range(_start, _size) 					\
	case (_start) ... ((_start) + (_size) - 1):				\
		asm volatile (							\
				"	lla %[tmp], 1f\n"			\
				"	add %[tmp], %[tmp], %[offset]\n"	\
				"	jr %[tmp]\n"				\
				"1:\n"						\
				"	.rept (" str(_size) ")\n"		\
				"	csrr %[res], (" str(_start) " + \\+)\n"	\
				"	j 2f\n"					\
				"	.balign 4\n"				\
				"	.endr\n"				\
				"2:\n"						\
				: [tmp] "=&r"(tmp), [res] "=r"(res)		\
				: [offset] "r"((csr_num - _start) * 8)		\
				: );						\
		break;								\


	switch (csr_num) {
	csr_read_case_range(CSR_CYCLE, 4)
	csr_read_case_range(CSR_CYCLEH, 4)

	/* ... other cases */

	default:
		/* Error handling */
	}

#undef csr_read_case_range

	return res;
}


