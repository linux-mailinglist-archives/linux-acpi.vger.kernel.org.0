Return-Path: <linux-acpi+bounces-7822-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D442295EA3D
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 09:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DA81C20F62
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F32126F2A;
	Mon, 26 Aug 2024 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RoARceJV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404380611
	for <linux-acpi@vger.kernel.org>; Mon, 26 Aug 2024 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656812; cv=none; b=XGMXza+D/AWG5dLGk4Oo2Sp0rXDJNq8nJltHSNYdW5QohtfaagNCVSvrLw7m2d/x4CWlehwyGij5GQIbfn9GwxFeIhMWXV+yoQY11OeaTpzltdJt0TW5HNHHkxeuMGUXRva1rOURneHiiUcRyNHNf7SQgE19p9ur510szilCrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656812; c=relaxed/simple;
	bh=T1336E7cVpUCrR3+tpvcbqJ7mz1A0cXcYu7auU083T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZO1LlQxfzuMxPJPD22QeeZg5UVZC0LBDx7lKBYi5wPAONqJEno78Cu4/qGeuEXCrvy8vcGsUMPCN1qHRxCq+Zc/82zYEYTOI+0u4yPa4gHw0yJq1GMuo/FrtFFV5F7A/jdatyk2OmGvXCngdNnIiPOLeJxAiijT5sDbtlKegEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RoARceJV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367990aaef3so1873073f8f.0
        for <linux-acpi@vger.kernel.org>; Mon, 26 Aug 2024 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724656808; x=1725261608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9f/Uu+DkKJiET7sozQNTkmkP72NpT2vE2dSLgjRAD1A=;
        b=RoARceJVqB+pcPRI3CQdcPffcAMaPwcyVPeI+WKrzXaLllhVsaYyGDqQXXuz+Q44i9
         sP4PbkO+6wY69bU5WYn0laTelzEPDkebQf0x3EdnD6QyX2x6Y6YQ2D59TbZJtBDI0WGl
         JJMmMAixKUG+TlNFKkrId3XKic6KgpmLAeo8qQmA7b3ndYtwA8+Qia3dkZLLYtO4VYQq
         YMwHvyvFpvwjVox1E5kAAY+e2KqZhFfXEqfNE9zsoIr/Hr+MzN6X8eQsGgeM8t4Usrm/
         68gDxnz1+riBtjwqAwhlJct06p3M6nTmP2PUhHVujfHCZmT+CnSzokTW7NvXMnQBZAfl
         SbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724656808; x=1725261608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9f/Uu+DkKJiET7sozQNTkmkP72NpT2vE2dSLgjRAD1A=;
        b=oLblIi6zqrmZ4fe+n7dx9l7ezxt6QDP9QU0j3vtYFs/XraG+9sFSXO7u48jsJY/175
         BaP0tMM7V9A6g4BxFar8/v5fqt8g7ghF4LXTo+Arjz7zGdJS3ErAVfjDa8v0R1FWbUNp
         p5pZid+XNedgFGvZkNGrnc4FQSPnsyJJ7eO5KSu85s1gOOgiPfaZOVwfwV1Qgq8cZTTF
         kOFPnxpizKGPwzjl3frJy0ClvCEvhQWP9dVWaJoD9bCMWL+bpPVU4ShHb7Vsqv3KqfWa
         hUnfmfSAXWKUJdz26sEo2qPXZtxwMHdjssACe8o2p2X/LKSboHskjqb47Ww+O0hhiF43
         LBPA==
X-Forwarded-Encrypted: i=1; AJvYcCVkoTvV3xOsm8NMblvRo7d6tQNvy008o0/JEmPz1cxI+nyvN4b+1+PqJ7u+tS/NBYQkK9spBJ0D9wTD@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvBd3gq//UnQiDalmRhL/UBTbf2rC3Z94SQum2oxuxObyVfaq
	6k7CTOHWqnuX0idkEdTbLK1n05gdIPN9y6t9Pr9idCKj55HJ1XsbLRwE2ecavZI=
X-Google-Smtp-Source: AGHT+IGGKWMJKcRV71NJLebmInIF+DDQiEwfWQ1N+2q9OU+9Oj1IF/Kfj5SxvQ6tTCRtfASJOtVWOw==
X-Received: by 2002:adf:e50c:0:b0:368:6598:131e with SMTP id ffacd0b85a97d-373118d228amr6056072f8f.38.1724656808090;
        Mon, 26 Aug 2024 00:20:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5159555sm143096845e9.18.2024.08.26.00.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 00:20:07 -0700 (PDT)
Message-ID: <5042c5ca-137c-4639-bd1a-12c836deabd0@rivosinc.com>
Date: Mon, 26 Aug 2024 09:20:05 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Fix MASK_VAL() usage
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20240715153336.3720653-1-cleger@rivosinc.com>
 <CAJZ5v0g5eAxJiiC6hY3BLKcuTyG1sZxgV5g=Zx4xu02UFfuwMA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAJZ5v0g5eAxJiiC6hY3BLKcuTyG1sZxgV5g=Zx4xu02UFfuwMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/08/2024 17:13, Rafael J. Wysocki wrote:
> On Mon, Jul 15, 2024 at 5:33 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> MASK_VAL() was added a way to handle bit_offset and bit_width for
>> registers located in system memory address space. However, while suited
>> for reading, it does not work for writing and result in corrupted
>> registers when writing values with bit_offset > 0. Moreover, when a
>> register is collocated with another one at the same address but with a
>> different mask, the current code results in the other registers being
>> overwritten with 0s. The write procedure for SYSTEM_MEMORY registers
>> should actually read the value, mask it, update it and write it with the
>> updated value. Moreover, since registers can be located in the same
>> word, we must take care of locking the access before doing it. We should
>> potentially use a global lock since we don't know in if register
>> addresses aren't shared with another _CPC package but better not
>> encourage vendors to do so. Assume that registers can use the same word
>> inside a _CPC package and thus, use a per _CPC package lock.
>>
>> Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> ---
>>  drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++----
>>  include/acpi/cppc_acpi.h |  2 ++
>>  2 files changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 1d857978f5f4..2e99cf1842ee 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -170,8 +170,11 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
>>  #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
>>
>>  /* Shift and apply the mask for CPC reads/writes */
>> -#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) &                     \
>> +#define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &                                \
>>                                         GENMASK(((reg)->bit_width) - 1, 0))
>> +#define MASK_VAL_WRITE(reg, prev_val, val)                                             \
>> +       ((((val) & GENMASK(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |          \
>> +       ((prev_val) & ~(GENMASK(((reg)->bit_width) - 1, 0) << (reg)->bit_offset)))      \
>>
>>  static ssize_t show_feedback_ctrs(struct kobject *kobj,
>>                 struct kobj_attribute *attr, char *buf)
>> @@ -857,6 +860,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>
>>         /* Store CPU Logical ID */
>>         cpc_ptr->cpu_id = pr->id;
>> +       spin_lock_init(&cpc_ptr->rmw_lock);
>>
>>         /* Parse PSD data for this CPU */
>>         ret = acpi_get_psd(cpc_ptr, handle);
>> @@ -1062,7 +1066,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>>         }
>>
>>         if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>> -               *val = MASK_VAL(reg, *val);
>> +               *val = MASK_VAL_READ(reg, *val);
>>
>>         return 0;
>>  }
>> @@ -1071,9 +1075,11 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>  {
>>         int ret_val = 0;
>>         int size;
>> +       u64 prev_val;
>>         void __iomem *vaddr = NULL;
>>         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>         struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>> +       struct cpc_desc *cpc_desc;
>>
>>         size = GET_BIT_WIDTH(reg);
>>
>> @@ -1106,8 +1112,34 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>                 return acpi_os_write_memory((acpi_physical_address)reg->address,
>>                                 val, size);
>>
>> -       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>> -               val = MASK_VAL(reg, val);
>> +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>> +               cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +               if (!cpc_desc) {
>> +                       pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +                       return -ENODEV;
>> +               }
>> +
>> +               spin_lock(&cpc_desc->rmw_lock);
>> +               switch (size) {
>> +               case 8:
>> +                       prev_val = readb_relaxed(vaddr);
>> +                       break;
>> +               case 16:
>> +                       prev_val = readw_relaxed(vaddr);
>> +                       break;
>> +               case 32:
>> +                       prev_val = readl_relaxed(vaddr);
>> +                       break;
>> +               case 64:
>> +                       prev_val = readq_relaxed(vaddr);
>> +                       break;
>> +               default:
>> +                       ret_val = -EFAULT;
>> +                       goto out_unlock;
> 
> I would do
> 
>                       spin_unlock(&cpc_desc->rmw_lock);
>                       return -EFAUL;
> 
> here to avoid the check below which is redundant in this path and the
> label would not be necessary then.

Acked, I'll send a V2 with these modifications.

Thanks,

Clément

> 
> LGTM otherwise.
> 
>> +               };
>> +               val = MASK_VAL_WRITE(reg, prev_val, val);
>> +               val |= prev_val;
>> +       }
>>
>>         switch (size) {
>>         case 8:
>> @@ -1134,6 +1166,10 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>                 break;
>>         }
>>
>> +out_unlock:
>> +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>> +               spin_unlock(&cpc_desc->rmw_lock);
>> +
>>         return ret_val;
>>  }
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 930b6afba6f4..e1720d930666 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -64,6 +64,8 @@ struct cpc_desc {
>>         int cpu_id;
>>         int write_cmd_status;
>>         int write_cmd_id;
>> +       /* Lock used for RMW operations in cpc_write() */
>> +       spinlock_t rmw_lock;
>>         struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
>>         struct acpi_psd_package domain_info;
>>         struct kobject kobj;
>> --
>> 2.45.2
>>

