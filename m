Return-Path: <linux-acpi+bounces-8294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED9978ECA
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 09:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072B91C24619
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 07:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D9E1CDFAD;
	Sat, 14 Sep 2024 07:12:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F031CDA09;
	Sat, 14 Sep 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726297973; cv=none; b=Qe9roExvHvAHZ4iTChTMOKP/sbNSWX/WDeLZM/YhkbcbZuFStgloFn2wtUlvwyRg6l/6as/S0MC4osqzIJ8oC+ofCeexlDdchqLuy53crAJABAkQ5juZyKlKzKjBc9KbIM1mCN+lw45clzY7BDVyIsULtyFvcuqKwQJWTPPEOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726297973; c=relaxed/simple;
	bh=ZceQdqQJqEGlJLdBWTH43nSRYHAKB33VcqzfQ+YQbvE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aS+CpE6axj9Du9KxkYtphNWribYSy6uK4+LeBPCe96BTIwDgvXOHazFDYj5NjkZJmNAQISN0MCbs0EkrDxzPH1zodwMkTi2DGKhlYdqDnHLqvptY9UlV+KNv5hrL5SVwtekW1yuss7HU6AZpaUR6wWIcmg6yLxKf6iziwCge67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxhehwN+VmP8sHAA--.17038S3;
	Sat, 14 Sep 2024 15:12:48 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDx_9dsN+VmQ6IGAA--.38150S3;
	Sat, 14 Sep 2024 15:12:47 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: Enable ACPI BGRT handling
To: Huacai Chen <chenhuacai@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240914065318.2099448-1-maobibo@loongson.cn>
 <CAAhV-H6k2c9M1htncx3UQdqy275PHDZTeo_56fWbtxDYNH-s6w@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <76b79099-ea95-eef5-e02b-6879f0998f18@loongson.cn>
Date: Sat, 14 Sep 2024 15:12:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6k2c9M1htncx3UQdqy275PHDZTeo_56fWbtxDYNH-s6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_9dsN+VmQ6IGAA--.38150S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF4DCrWDGFWDXw17Gw48uFX_yoWruF1xpF
	yvkF4kJFs8CF18Grnrt343WF98tr4kKrWIqFy7Ka43ZFnFvr17Ar4kur9IvFyjv3yDKF4F
	9FWSqa13uF4UXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
	SoJUUUUU=



On 2024/9/14 下午3:01, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Sat, Sep 14, 2024 at 2:53 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Add ACPI BGRT support on LoongArch so it can display image provied by
>> acpi table at boot stage and switch to graphical UI smoothly.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202409102056.DNqh6zzA-lkp@intel.com/
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>> v1 ... v2:
>>    1. Solve compile warning issue reported from lkp, return type of
>>       function early_memunmap() is void *, that of function early_ioremap()
>>       is void __iomem *, force type conversion is added.
> I've applied V1, build warnings seems another problem which has no
> relationship with this patch itself.
Good, thanks for applying it.

Regards
Bibo Mao
> 
> Huacai
> 
>> ---
>>   arch/loongarch/include/asm/io.h | 4 +---
>>   arch/loongarch/kernel/acpi.c    | 8 ++++++--
>>   arch/loongarch/mm/ioremap.c     | 9 +++++++++
>>   drivers/acpi/Kconfig            | 2 +-
>>   4 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
>> index 5e95a60df180..3049bccec693 100644
>> --- a/arch/loongarch/include/asm/io.h
>> +++ b/arch/loongarch/include/asm/io.h
>> @@ -10,6 +10,7 @@
>>
>>   #include <asm/addrspace.h>
>>   #include <asm/cpu.h>
>> +#include <asm/early_ioremap.h>
>>   #include <asm/page.h>
>>   #include <asm/pgtable-bits.h>
>>   #include <asm/string.h>
>> @@ -17,9 +18,6 @@
>>   extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size);
>>   extern void __init early_iounmap(void __iomem *addr, unsigned long size);
>>
>> -#define early_memremap early_ioremap
>> -#define early_memunmap early_iounmap
>> -
>>   #ifdef CONFIG_ARCH_IOREMAP
>>
>>   static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
>> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
>> index 929a497c987e..2993d7921198 100644
>> --- a/arch/loongarch/kernel/acpi.c
>> +++ b/arch/loongarch/kernel/acpi.c
>> @@ -9,6 +9,7 @@
>>
>>   #include <linux/init.h>
>>   #include <linux/acpi.h>
>> +#include <linux/efi-bgrt.h>
>>   #include <linux/irq.h>
>>   #include <linux/irqdomain.h>
>>   #include <linux/memblock.h>
>> @@ -39,14 +40,14 @@ void __init __iomem * __acpi_map_table(unsigned long phys, unsigned long size)
>>          if (!phys || !size)
>>                  return NULL;
>>
>> -       return early_memremap(phys, size);
>> +       return (void __iomem *)early_memremap(phys, size);
>>   }
>>   void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
>>   {
>>          if (!map || !size)
>>                  return;
>>
>> -       early_memunmap(map, size);
>> +       early_memunmap((void *)map, size);
>>   }
>>
>>   void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>> @@ -212,6 +213,9 @@ void __init acpi_boot_table_init(void)
>>          /* Do not enable ACPI SPCR console by default */
>>          acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
>>
>> +       if (IS_ENABLED(CONFIG_ACPI_BGRT))
>> +               acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
>> +
>>          return;
>>
>>   fdt_earlycon:
>> diff --git a/arch/loongarch/mm/ioremap.c b/arch/loongarch/mm/ioremap.c
>> index 70ca73019811..28562ac510c8 100644
>> --- a/arch/loongarch/mm/ioremap.c
>> +++ b/arch/loongarch/mm/ioremap.c
>> @@ -16,6 +16,15 @@ void __init early_iounmap(void __iomem *addr, unsigned long size)
>>
>>   }
>>
>> +void __init *early_memremap(resource_size_t phys_addr, unsigned long size)
>> +{
>> +       return (__force void *)early_ioremap(phys_addr, size);
>> +}
>> +
>> +void __init early_memunmap(void *addr, unsigned long size)
>> +{
>> +}
>> +
>>   void *early_memremap_ro(resource_size_t phys_addr, unsigned long size)
>>   {
>>          return early_memremap(phys_addr, size);
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index e3a7c2aedd5f..d67f63d93b2a 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -451,7 +451,7 @@ config ACPI_HED
>>
>>   config ACPI_BGRT
>>          bool "Boottime Graphics Resource Table support"
>> -       depends on EFI && (X86 || ARM64)
>> +       depends on EFI && (X86 || ARM64 || LOONGARCH)
>>          help
>>            This driver adds support for exposing the ACPI Boottime Graphics
>>            Resource Table, which allows the operating system to obtain
>>
>> base-commit: 196145c606d0f816fd3926483cb1ff87e09c2c0b
>> --
>> 2.39.3
>>
>>


