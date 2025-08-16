Return-Path: <linux-acpi+bounces-15754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95ACB28D6B
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Aug 2025 13:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F933BB084
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Aug 2025 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF828688C;
	Sat, 16 Aug 2025 11:26:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341B21FF3F;
	Sat, 16 Aug 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755343613; cv=none; b=p93Y7FJOJSWlJ5N7aGccXDBB4yuTbV4Yl6k7PtV3cvhLIPzRVksQANr0nYmoY48p/ePNHy3pIVEw0c1coKeof64+x7CZQ5zCmOla22/LsNDlpiWjUuUSXZvjPtcSirH4WyEeb7ihQNfwWtBGAJWkG6sOtn/tclNV4m4iRU3mDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755343613; c=relaxed/simple;
	bh=YB4lGrcSUba+o7QPviwqtchjCljGl39IbF8SyIF+eNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXnhwxiJB3DfYfcLMp0kYFJGBrLO9uQyWM4305pXl0wvLRnPFWmvAteMB5zeel0zKKyCsHPFPKpBGDDKJaFCF/AcNDkqFuerRoBIhoeoaWjyLw7Xxw2rZbLKkpH9Fxi5jW/4jV9dM7J74QXUAyzfwBiGX6X9CDOCsW+DGWD+b/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.104] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowACXLV7eaqBo6I9YDA--.55398S2;
	Sat, 16 Aug 2025 19:26:22 +0800 (CST)
Message-ID: <8fc2da6d-0ad7-48ec-b1ed-df6ae6ddebf4@iscas.ac.cn>
Date: Sat, 16 Aug 2025 19:26:22 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] RISC-V: Add common csr_read_num() and csr_write_num()
 functions
To: Anup Patel <apatel@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
 Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250815161406.76370-1-apatel@ventanamicro.com>
 <20250815161406.76370-3-apatel@ventanamicro.com>
 <89865f17-f405-445a-874d-9361fe247bfe@iscas.ac.cn>
 <CAK9=C2VWSpREd0Hqg3TuLcVxG1=Ddfqn9ouNcowxHdCfJWgmJg@mail.gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <CAK9=C2VWSpREd0Hqg3TuLcVxG1=Ddfqn9ouNcowxHdCfJWgmJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXLV7eaqBo6I9YDA--.55398S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1xAr15Kry8tFW8Xw4Utwb_yoW3GrWfpr
	Wqkayqkr1UAr4Ig34a9Fn8JryrX3ZYgFW7G340q347Zr4Dtry3Gry0g34YkryqgFZ7J34D
	uF1q9w1fC3sxtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07betCcUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 8/16/25 16:42, Anup Patel wrote:
> On Sat, Aug 16, 2025 at 9:54 AM Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>>
>> On 8/16/25 00:14, Anup Patel wrote:
>>> In RISC-V, there is no CSR read/write instruction which takes CSR
>>> number via register so add common csr_read_num() and csr_write_num()
>>> functions which allow accessing certain CSRs by passing CSR number
>>> as parameter. These common functions will be first used by the
>>> ACPI CPPC driver and RISC-V PMU driver.
>>>
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>> ---
>>>  arch/riscv/include/asm/csr.h |   3 +
>>>  arch/riscv/kernel/Makefile   |   1 +
>>>  arch/riscv/kernel/csr.c      | 177 +++++++++++++++++++++++++++++++++++
>>>  drivers/acpi/riscv/cppc.c    |  17 ++--
>>>  drivers/perf/riscv_pmu.c     |  43 +--------
>>>  5 files changed, 189 insertions(+), 52 deletions(-)
>>>  create mode 100644 arch/riscv/kernel/csr.c
>>>
>>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
>>> index 6fed42e37705..1540626b3540 100644
>>> --- a/arch/riscv/include/asm/csr.h
>>> +++ b/arch/riscv/include/asm/csr.h
>>> @@ -575,6 +575,9 @@
>>>                             : "memory");                      \
>>>  })
>>>
>>> +extern unsigned long csr_read_num(unsigned long csr_num, int *out_err);
>>> +extern void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err);
>>> +
>>>  #endif /* __ASSEMBLY__ */
>>>
>>>  #endif /* _ASM_RISCV_CSR_H */
>>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>> index c7b542573407..0a75e20bde18 100644
>>> --- a/arch/riscv/kernel/Makefile
>>> +++ b/arch/riscv/kernel/Makefile
>>> @@ -50,6 +50,7 @@ obj-y       += soc.o
>>>  obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
>>>  obj-y        += cpu.o
>>>  obj-y        += cpufeature.o
>>> +obj-y        += csr.o
>>>  obj-y        += entry.o
>>>  obj-y        += irq.o
>>>  obj-y        += process.o
>>> diff --git a/arch/riscv/kernel/csr.c b/arch/riscv/kernel/csr.c
>>> new file mode 100644
>>> index 000000000000..f7de45bb597c
>>> --- /dev/null
>>> +++ b/arch/riscv/kernel/csr.c
>>> @@ -0,0 +1,177 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2025 Ventana Micro Systems Inc.
>>> + */
>>> +
>>> +#define pr_fmt(fmt) "riscv: " fmt
>>> +#include <linux/err.h>
>>> +#include <linux/export.h>
>>> +#include <linux/printk.h>
>>> +#include <linux/types.h>
>>> +#include <asm/csr.h>
>>> +
>>> +#define CSR_CUSTOM0_U_RW_BASE                0x800
>>> +#define CSR_CUSTOM0_U_RW_COUNT               0x100
>>> +
>>> +#define CSR_CUSTOM1_U_RO_BASE                0xCC0
>>> +#define CSR_CUSTOM1_U_RO_COUNT               0x040
>>> +
>>> +#define CSR_CUSTOM2_S_RW_BASE                0x5C0
>>> +#define CSR_CUSTOM2_S_RW_COUNT               0x040
>>> +
>>> +#define CSR_CUSTOM3_S_RW_BASE                0x9C0
>>> +#define CSR_CUSTOM3_S_RW_COUNT               0x040
>>> +
>>> +#define CSR_CUSTOM4_S_RO_BASE                0xDC0
>>> +#define CSR_CUSTOM4_S_RO_COUNT               0x040
>>> +
>>> +#define CSR_CUSTOM5_HS_RW_BASE               0x6C0
>>> +#define CSR_CUSTOM5_HS_RW_COUNT              0x040
>>> +
>>> +#define CSR_CUSTOM6_HS_RW_BASE               0xAC0
>>> +#define CSR_CUSTOM6_HS_RW_COUNT              0x040
>>> +
>>> +#define CSR_CUSTOM7_HS_RO_BASE               0xEC0
>>> +#define CSR_CUSTOM7_HS_RO_COUNT              0x040
>>> +
>>> +#define CSR_CUSTOM8_M_RW_BASE                0x7C0
>>> +#define CSR_CUSTOM8_M_RW_COUNT               0x040
>>> +
>>> +#define CSR_CUSTOM9_M_RW_BASE                0xBC0
>>> +#define CSR_CUSTOM9_M_RW_COUNT               0x040
>>> +
>>> +#define CSR_CUSTOM10_M_RO_BASE               0xFC0
>>> +#define CSR_CUSTOM10_M_RO_COUNT              0x040
>>> +
>>> +unsigned long csr_read_num(unsigned long csr_num, int *out_err)
>>> +{
>>> +#define switchcase_csr_read(__csr_num)                               \
>>> +     case (__csr_num):                                       \
>>> +             return csr_read(__csr_num)
>>> +#define switchcase_csr_read_2(__csr_num)                     \
>>> +     switchcase_csr_read(__csr_num + 0);                     \
>>> +     switchcase_csr_read(__csr_num + 1)
>>> +#define switchcase_csr_read_4(__csr_num)                     \
>>> +     switchcase_csr_read_2(__csr_num + 0);                   \
>>> +     switchcase_csr_read_2(__csr_num + 2)
>>> +#define switchcase_csr_read_8(__csr_num)                     \
>>> +     switchcase_csr_read_4(__csr_num + 0);                   \
>>> +     switchcase_csr_read_4(__csr_num + 4)
>>> +#define switchcase_csr_read_16(__csr_num)                    \
>>> +     switchcase_csr_read_8(__csr_num + 0);                   \
>>> +     switchcase_csr_read_8(__csr_num + 8)
>>> +#define switchcase_csr_read_32(__csr_num)                    \
>>> +     switchcase_csr_read_16(__csr_num + 0);                  \
>>> +     switchcase_csr_read_16(__csr_num + 16)
>>> +#define switchcase_csr_read_64(__csr_num)                    \
>>> +     switchcase_csr_read_32(__csr_num + 0);                  \
>>> +     switchcase_csr_read_32(__csr_num + 32)
>>> +#define switchcase_csr_read_128(__csr_num)                   \
>>> +     switchcase_csr_read_64(__csr_num + 0);                  \
>>> +     switchcase_csr_read_64(__csr_num + 64)
>>> +#define switchcase_csr_read_256(__csr_num)                   \
>>> +     switchcase_csr_read_128(__csr_num + 0);                 \
>>> +     switchcase_csr_read_128(__csr_num + 128)
>>> +
>> That's... a bit horrendous.
>>
>> Since we know that each inner case is quite simple, can we just do our
>> own jump table for that? Each case can be one csrr/csrw and one jal
>> (possibly pad to 8 bytes), and we can just jump to
>> label + (csr_num - range_start) * 8. See bottom of this message for an
>> untested prototype.
>>
>> Vivian "dramforever" Wang
>>
>> UNTESTED prototype:
>>
>> #define CSR_CYCLE 0xc00
>> #define CSR_CYCLEH 0xc80
>>
>> /* Force expand argument if macro */
>> #define str(_x) #_x
>>
>> unsigned long csr_read_num(long csr_num)
>> {
>>         unsigned long res, tmp;
>>
>>         /*
>>          * Generate a jump table for each range. Each (inner) case is 8 bytes of
>>          * code, a csrr instruction and a jump, possibly padded, so we just jump
>>          * to label_1f + (csr_num - _start) * 8
>>          */
>> #define csr_read_case_range(_start, _size)                                      \
>>         case (_start) ... ((_start) + (_size) - 1):                             \
>>                 asm volatile (                                                  \
>>                                 "       lla %[tmp], 1f\n"                       \
>>                                 "       add %[tmp], %[tmp], %[offset]\n"        \
>>                                 "       jr %[tmp]\n"                            \
>>                                 "1:\n"                                          \
>>                                 "       .rept (" str(_size) ")\n"               \
>>                                 "       csrr %[res], (" str(_start) " + \\+)\n" \
>>                                 "       j 2f\n"                                 \
>>                                 "       .balign 4\n"                            \
>>                                 "       .endr\n"                                \
>>                                 "2:\n"                                          \
>>                                 : [tmp] "=&r"(tmp), [res] "=r"(res)             \
>>                                 : [offset] "r"((csr_num - _start) * 8)          \
>>                                 : );                                            \
>>                 break;                                                          \
>>
>>
>>         switch (csr_num) {
>>         csr_read_case_range(CSR_CYCLE, 4)
>>         csr_read_case_range(CSR_CYCLEH, 4)
>>
>>         /* ... other cases */
>>
>>         default:
>>                 /* Error handling */
>>         }
>>
>> #undef csr_read_case_range
>>
>>         return res;
>> }
> Clearly you have trust issues with compiler switch-case optimizations
> and your proposed solution looks horrendous to me.

What I am concerned about is less whether the compiler generates better
code, but more that you would need to build out these macros to write
out the cases. I was trying to make it so that you can just have one
macro that would work for any (constant) range.

> Your proposed solution is effectively a nested switch case where
> there is a higher-level jump-table generated by the compiler which
> selects a range case and within each range case you have a hand
> assembled jump table. If you analyse the effective number of
> instructions involved in accessing an CSR then it will be much
> more than the current approach.

If you think it is more important that this is all handled within one
jump table for the fastest generated code possible, no problem.

Vivian "dramforever" Wang

> The current approach relies on a compiler optimized jump table
> where each switch-case is just two instructions (12 bytes) for
> both csr_read_num() and csr_write_num().
>
> Regards,
> Anup


