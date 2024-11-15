Return-Path: <linux-acpi+bounces-9598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06959CF23F
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 17:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B49283E41
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E369C1D61A3;
	Fri, 15 Nov 2024 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfBrMDNh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7771D61A2;
	Fri, 15 Nov 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689959; cv=none; b=GLjeJz4U8G6IrtFoeTjoz8Mrr2+Qd/A+h2V8A2znXEJY8LkQXssbjNh25gLD9XcaTR2QiuMuZP2yuFFuf5VoZeWEoUe75jwa8qt6mPKQipT8VtvQxjyRdcpLfPfXCl5y4R+AOGTS742c6dkLMJatR4nq9SdXvEaO1Hl5wMmiygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689959; c=relaxed/simple;
	bh=dOBnJCqCaWZUjhxd2LK7dRHfKa39/Gqlsuh+gHaHxMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ec/U60H+ikblB8fiX+8YgydWb19M5RlId5sMU5XxqU6gLTcfgs6rEMywoV4O1KyTY9I5LdGsebgydPUtpqAL/hfYb+J+BmvBLZ6YwpIrqH26kK/YOo0XpsH0IIfXdLOi/a6k1i5o9FLnr19kSoMttAWmW6HwkRc+Dn6XFzgvPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfBrMDNh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cb47387ceso23545795ad.1;
        Fri, 15 Nov 2024 08:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731689956; x=1732294756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5My4RsjQqVpFcnn6C+E7zXPeOJ7hSHgTRe960WZ9eQ8=;
        b=MfBrMDNhClqZrHKmuE2DI0IKpv6HbLQyixVGN7kiR/afbx49Sw2iTKezdtf7B8amQS
         obqwhQujpPaVSfJA2pUHzHpkRqqgDPsa/YaoWMTIdlsH3vviiugXBIdFGKlVq5ELxJR5
         W1KxvufTIgVVsLwH5C23nnH93sltuAIKTfe+Bx7yfPTz8tbTD6HjQW1XNS0f1hdOR1fm
         r88m2rvhI0kmWr9xEc6986OT8b/ZEg4xoP3HNheJxDdaZhF0Tp6UzKNNwv60dguTWdaM
         e69aQf+L0XRxwcOUSO3PqVPT1gJmB5KhajOtHWD5hjwpblsu/EPkBfH9NSrwXJgs/QmQ
         cNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731689956; x=1732294756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5My4RsjQqVpFcnn6C+E7zXPeOJ7hSHgTRe960WZ9eQ8=;
        b=YuAZqGI8zpvsOfQKGog3tm3+fljPP7pdiAVzPoSi4P1TmiJmO9Gwd9jQPS3V4ksJcK
         wi9XZGcKm0C3f0LJz0vt2Fsongqd4xIi9zbQn78mScGu9AeDe395ZSJFhhoYbu/3zlKM
         1tGWcLIMNaTA+qsHYQCRDmxyyvhz8/zjToj01x8EleSArPLy2Sp7H7mc05FXtBfvOjEz
         zjow+njtKFvOxWQGCCJXxn2j1UUL444vBHKV4PTP7yztXRwd1PEM1za++2X7ebao+cQH
         cWZvc6x38TUpW+vDtsZzoYXS8uErs2scnB8hYwh7CO6o6++1mqdWCZFhevogj2bT2E5p
         L2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCV6QFRY3zrKgqzNgbYiV5aG51gJB1NzheekOIgVuaSOsg5n1WXJCl7hLnQZ9+VhKvaasxwqXdPtaKA6@vger.kernel.org, AJvYcCW6UfWZ+54Ny9RX5dAWV5Hc47YuPoT8No6GT50bheUvbvXY5AivnO8ihmoXgSGAR+OVgFyS/CZFsE5e5BVb@vger.kernel.org
X-Gm-Message-State: AOJu0YyVF747mH387hpkEVBK6H6yzCfL1aPDzZmC47AO+exWHKxfFO35
	NU/1NDDMB+wc//fJBZuMCHlBZXA5Q8UsU+aag7LBfnJinbo4fDwA
X-Google-Smtp-Source: AGHT+IE89VkCeLragNsInNsnFoD3XvhKObDCdMphxIgayw0eyZC/oYovPrx7FAYAPhzN0nuu1Lrhzg==
X-Received: by 2002:a17:902:d48e:b0:211:e693:90df with SMTP id d9443c01a7336-211e6939443mr9041615ad.46.1731689956450;
        Fri, 15 Nov 2024 08:59:16 -0800 (PST)
Received: from [192.168.0.198] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca2d9sm14520685ad.90.2024.11.15.08.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 08:59:15 -0800 (PST)
Message-ID: <b686dd59-29a0-44ac-82e1-86c26abda915@gmail.com>
Date: Fri, 15 Nov 2024 22:29:10 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
To: Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: rafael@kernel.org, lenb@kernel.org, nvdimm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
References: <20241113125157.14390-1-surajsonawane0215@gmail.com>
 <c69d74f7-4484-4fc6-9b95-d2ae86ead794@intel.com>
 <1cab2343-8d74-4477-9046-7940917fa7be@gmail.com>
 <f13b285d-cf5b-4edf-a7d5-933ccd20556a@intel.com>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <f13b285d-cf5b-4edf-a7d5-933ccd20556a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/11/24 21:12, Dave Jiang wrote:
> 
> 
> On 11/14/24 2:19 AM, Suraj Sonawane wrote:
>> On 13/11/24 22:32, Dave Jiang wrote:
>>>
>>>
>>> On 11/13/24 5:51 AM, Suraj Sonawane wrote:
>>>> Fix an issue detected by syzbot with KASAN:
>>>>
>>>> BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/
>>>> core.c:416 [inline]
>>>> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
>>>> drivers/acpi/nfit/core.c:459
>>>>
>>>> The issue occurs in cmd_to_func when the call_pkg->nd_reserved2
>>>> array is accessed without verifying that call_pkg points to a buffer
>>>> that is appropriately sized as a struct nd_cmd_pkg. This can lead
>>>> to out-of-bounds access and undefined behavior if the buffer does not
>>>> have sufficient space.
>>>>
>>>> To address this, a check was added in acpi_nfit_ctl() to ensure that
>>>> buf is not NULL and that buf_len is greater than sizeof(*call_pkg)
>>>> before casting buf to struct nd_cmd_pkg *. This ensures safe access
>>>> to the members of call_pkg, including the nd_reserved2 array.
>>>>
>>>> Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
>>>> Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
>>>> Fixes: ebe9f6f19d80 ("acpi/nfit: Fix bus command validation")
>>>> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
>>>> ---
>>>> V1: https://lore.kernel.org/lkml/20241111080429.9861-1-surajsonawane0215@gmail.com/
>>>> V2: Initialized `out_obj` to `NULL` in `acpi_nfit_ctl()` to prevent
>>>> potential uninitialized variable usage if condition is true.
>>>> V3: Changed the condition to if (!buf || buf_len < sizeof(*call_pkg))
>>>> and updated the Fixes tag to reference the correct commit.
>>>>
>>>>    drivers/acpi/nfit/core.c | 12 +++++++++---
>>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>>>> index 5429ec9ef..eb5349606 100644
>>>> --- a/drivers/acpi/nfit/core.c
>>>> +++ b/drivers/acpi/nfit/core.c
>>>> @@ -439,7 +439,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>>>>    {
>>>>        struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>>>>        struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>>>> -    union acpi_object in_obj, in_buf, *out_obj;
>>>> +    union acpi_object in_obj, in_buf, *out_obj = NULL;
>>>
>>> Looking at the code later, out_obj is always assigned before access. I'm not seeing a path where out_obj would be accessed unitialized...
>>
>> I initialized out_obj to NULL to prevent potential issues where goto out might access an uninitialized pointer, ensuring ACPI_FREE(out_obj) handles NULL safely in the cleanup section. This covers cases where the condition !buf || buf_len < sizeof(*call_pkg) triggers an early exit, preventing unintended behavior.
> 
> ok
> 
>>
>>>
>>> https://elixir.bootlin.com/linux/v6.12-rc7/source/drivers/acpi/nfit/core.c#L538
>>>   
>>>>        const struct nd_cmd_desc *desc = NULL;
>>>>        struct device *dev = acpi_desc->dev;
>>>>        struct nd_cmd_pkg *call_pkg = NULL;
>>>> @@ -454,8 +454,14 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>>>>        if (cmd_rc)
>>>>            *cmd_rc = -EINVAL;
>>>>    -    if (cmd == ND_CMD_CALL)
>>>> -        call_pkg = buf;
>>>> +    if (cmd == ND_CMD_CALL) {
>>>> +        if (!buf || buf_len < sizeof(*call_pkg)) {
>>>> +            rc = -EINVAL;
>>>> +            goto out;
>>>> +        }
>>>> +        call_pkg = (struct nd_cmd_pkg *)buf;
>>>
>>> Is the casting needed? It wasn't in the old code
>>>
>>
>> I tested the code both with and without the cast using syzbot, and it didn't result in any errors in either case. Since the buffer (buf) is being used as a pointer to struct nd_cmd_pkg, and the casting works in both scenarios, it appears that the cast may not be strictly necessary for this particular case.
>>
>> I can remove the cast and retain the original code structure, as it does not seem to affect functionality. However, the cast was added for clarity and type safety to ensure that buf is explicitly treated as a struct nd_cmd_pkg *.
>>
>> Would you prefer to remove the cast, or should I keep it as is for type safety and clarity?
> 
> I would just leave it as it was.

I have submitted the patch with the original code unchanged(without 
casting) by testing with syzbot. You can view it 
here:https://lore.kernel.org/lkml/20241115164223.20854-1-surajsonawane0215@gmail.com/

> 
>>
>>>> +    }
>>>> +
>>>>        func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
>>>>        if (func < 0)
>>>>            return func;
>>>
>>
>> Thank you for your feedback and your time.
> 


