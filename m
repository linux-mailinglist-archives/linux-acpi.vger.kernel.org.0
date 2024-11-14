Return-Path: <linux-acpi+bounces-9583-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4119C85EA
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 10:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB651F221FC
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994091DED57;
	Thu, 14 Nov 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4tNE40q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011D418B47A;
	Thu, 14 Nov 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575976; cv=none; b=GaFWC31mQc/BBWPKVC1q5pq9G39EfvnbNyhQRr7G6m+0g1HpjstK+U1bL76bjCKsvy0cxS35/sT5kQOoBArx4lR6+H7HnSC/h83lMZsKFNLaZOYObttIGf0fIncMS6SdGfGI2purimvLJDmDhP2EYDidb1qB4D4BDcVjOfMFODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575976; c=relaxed/simple;
	bh=NU1w+haqDXEPicku8Ol9S8ylkWjc+N2IczRGt6lLWy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOHiZkVU77Cx9JWnXPY16NI1kmrRLMR1WL6NjIfBW/RqcbcyPlkIZ1aeVQ9ixKo91aRxBHANExopsQzxyB2QjGMNBC0EgyumLAFaOZZzzOlnDmIh3Kjwe9HxGmtZSROhv/g4oydVcPoiOJqL1N+uj4ysft27GrDxFol70p3tl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4tNE40q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-211c1c144f5so3970625ad.1;
        Thu, 14 Nov 2024 01:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731575974; x=1732180774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUt/EcD6vorUbwGG3Sx+YdUqBqHorJh6OABgPgdjzc8=;
        b=D4tNE40qm1QLaYxFdlCaGaVLjHsl7w4JGsn4wnE297uR/yYIBAlkHJsUx9K8HVQu5c
         rBGqCSA+8W1GyZIvxLcSQ25qnbfxLCiBSbeulalEzfhaKPdaFmcmDQTLphcVFm7VDL7t
         IgGnvNbu5L5Z1a3Mnuafrn7KuZXjz29gHQdLDlwbXOsx2LNiG8SHRS6AgEj+afI+x6/n
         Cul9e85p0qB4aB07Y5AKEx2hUSjmbA8PVcFlA0gNIvQbxXINebNp2E8Nj7vkJafwQK7M
         XNrNH02xKtvlZ3iqMhXdibWMn1pdHto/tNBlcPlSosUnd3KaBtdM65MfzT2phmpAi5NX
         hnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575974; x=1732180774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUt/EcD6vorUbwGG3Sx+YdUqBqHorJh6OABgPgdjzc8=;
        b=L7BXzF/xpovbiTX2zS1FNBiaLwxyHfqigSBxxzSy4JQSXj7HWu2h9PerSASouEt8OP
         bSKJRPMASPLAbUFMx82iqMDxM89gu/s30w4m32h88tO4x7jlLYj7+VUjCe31XA59OD5q
         ZdsLZ2Fvw4zewFPBaT0kfxkXrPP4/gLSuIEZz7OGEE11buOWpUH/jjYd9LdCV8jF1l+y
         LIgWNq2aEQRifaWphYRlQr0D3wp/tRc+i53o+ctsNf0W0fNK2Kwd1KVveEN5xnlvRtGv
         3nPNqq9K3KFysRePHkGWaSh5YQrk64NNdJy24Hhm0THV5P71d+cw211mK/vNuvlqXH6i
         sz8A==
X-Forwarded-Encrypted: i=1; AJvYcCWPXHywXtOZrCzPUJqApoAox0giEjJjk8R/ZUD3PQbJCz77h5RhbCGB3wu0Xlv3OMB6lHAK69T9CTG5sZK4@vger.kernel.org, AJvYcCXdwT+7YHR3UEx93DaIt8gPft00wY5D3NAM8QTESjWOwr/eZYXFQIIKzCTAN5hT/jq0KNEi648DhZOi@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLSnINQfRth/SSbgKyifWAOAkObQ2utND6N/ggbvVIx/+be1m
	aFZs53kCXXyoo9RoOdGA6riMN34ONC0WPJREUXycSiAuoiORWECM
X-Google-Smtp-Source: AGHT+IFAsiiRUQ9C9JCTDYc5W3f/4gx2o3puNGPkDNQyTPO+rxV8Vtlfhiu/zcezOPbWY9TYDPq3nA==
X-Received: by 2002:a17:902:f54a:b0:20b:6c1e:1e13 with SMTP id d9443c01a7336-211c0fbf416mr39095895ad.23.1731575974189;
        Thu, 14 Nov 2024 01:19:34 -0800 (PST)
Received: from [192.168.0.198] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a6e6fe8sm817929b3a.62.2024.11.14.01.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:19:33 -0800 (PST)
Message-ID: <1cab2343-8d74-4477-9046-7940917fa7be@gmail.com>
Date: Thu, 14 Nov 2024 14:49:26 +0530
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
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <c69d74f7-4484-4fc6-9b95-d2ae86ead794@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/24 22:32, Dave Jiang wrote:
> 
> 
> On 11/13/24 5:51 AM, Suraj Sonawane wrote:
>> Fix an issue detected by syzbot with KASAN:
>>
>> BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/
>> core.c:416 [inline]
>> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
>> drivers/acpi/nfit/core.c:459
>>
>> The issue occurs in cmd_to_func when the call_pkg->nd_reserved2
>> array is accessed without verifying that call_pkg points to a buffer
>> that is appropriately sized as a struct nd_cmd_pkg. This can lead
>> to out-of-bounds access and undefined behavior if the buffer does not
>> have sufficient space.
>>
>> To address this, a check was added in acpi_nfit_ctl() to ensure that
>> buf is not NULL and that buf_len is greater than sizeof(*call_pkg)
>> before casting buf to struct nd_cmd_pkg *. This ensures safe access
>> to the members of call_pkg, including the nd_reserved2 array.
>>
>> Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
>> Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
>> Fixes: ebe9f6f19d80 ("acpi/nfit: Fix bus command validation")
>> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
>> ---
>> V1: https://lore.kernel.org/lkml/20241111080429.9861-1-surajsonawane0215@gmail.com/
>> V2: Initialized `out_obj` to `NULL` in `acpi_nfit_ctl()` to prevent
>> potential uninitialized variable usage if condition is true.
>> V3: Changed the condition to if (!buf || buf_len < sizeof(*call_pkg))
>> and updated the Fixes tag to reference the correct commit.
>>
>>   drivers/acpi/nfit/core.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index 5429ec9ef..eb5349606 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -439,7 +439,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>>   {
>>   	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>> -	union acpi_object in_obj, in_buf, *out_obj;
>> +	union acpi_object in_obj, in_buf, *out_obj = NULL;
> 
> Looking at the code later, out_obj is always assigned before access. I'm not seeing a path where out_obj would be accessed unitialized...

I initialized out_obj to NULL to prevent potential issues where goto out 
might access an uninitialized pointer, ensuring ACPI_FREE(out_obj) 
handles NULL safely in the cleanup section. This covers cases where the 
condition !buf || buf_len < sizeof(*call_pkg) triggers an early exit, 
preventing unintended behavior.

> 
> https://elixir.bootlin.com/linux/v6.12-rc7/source/drivers/acpi/nfit/core.c#L538
>   
>>   	const struct nd_cmd_desc *desc = NULL;
>>   	struct device *dev = acpi_desc->dev;
>>   	struct nd_cmd_pkg *call_pkg = NULL;
>> @@ -454,8 +454,14 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>>   	if (cmd_rc)
>>   		*cmd_rc = -EINVAL;
>>   
>> -	if (cmd == ND_CMD_CALL)
>> -		call_pkg = buf;
>> +	if (cmd == ND_CMD_CALL) {
>> +		if (!buf || buf_len < sizeof(*call_pkg)) {
>> +			rc = -EINVAL;
>> +			goto out;
>> +		}
>> +		call_pkg = (struct nd_cmd_pkg *)buf;
> 
> Is the casting needed? It wasn't in the old code
> 

I tested the code both with and without the cast using syzbot, and it 
didn't result in any errors in either case. Since the buffer (buf) is 
being used as a pointer to struct nd_cmd_pkg, and the casting works in 
both scenarios, it appears that the cast may not be strictly necessary 
for this particular case.

I can remove the cast and retain the original code structure, as it does 
not seem to affect functionality. However, the cast was added for 
clarity and type safety to ensure that buf is explicitly treated as a 
struct nd_cmd_pkg *.

Would you prefer to remove the cast, or should I keep it as is for type 
safety and clarity?

>> +	}
>> +
>>   	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
>>   	if (func < 0)
>>   		return func;
> 

Thank you for your feedback and your time.

