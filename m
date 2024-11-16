Return-Path: <linux-acpi+bounces-9614-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169B69CFED5
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 13:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0D81F23F92
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB3194C7A;
	Sat, 16 Nov 2024 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avWITplX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0F18C039;
	Sat, 16 Nov 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731760882; cv=none; b=Nxq3qIc1UBz4JzwsUkaraRFMdN25PTcRNkODSRwWF56qzvdUm33m+Wr4HeqzCixMZsUryOxTT0EWsvQKrVvet/Zelq9ViQqA/7XO6bjWUfpx7XjSaT0c5Z+/nPYWjOZ9fRVFAB9BftKCZ7v4I3NXGIQ6gyRbNpU5UaToTIJzKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731760882; c=relaxed/simple;
	bh=3+EQXZdxkZkhS9V2BEsUVD2fzNOhXUHdEA1GAH1AxoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oczkO/ODhveDD7VR4mKbFtreVcBRKhIjIDOwzUJjv87KmynWJAy4NJddLr/5xEd+xlFVG0h1tdDl6EDCvvwixuQZb1EoNMm4/NxQ8Oqxv0tMs6LTcBXZBrN2MKpGLMQ5zKLPJ1VIsjihuECHA7EmOVHLcW0L0ozFNlOrGSZfQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avWITplX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724455f40a0so1852719b3a.0;
        Sat, 16 Nov 2024 04:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731760880; x=1732365680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LCynoPn19dfCOHYqjru4yO7txCVRlW/xym4tzc5li4=;
        b=avWITplXwglKGbMm8cHSTBoscZ7+zB/rF/2o0g730GeP5wMBnpH78ekmWspmP4WqaW
         Juu3mm6ExKOpOjXLBVWGJTP1FQksmOJ5PRfz60lbB0tOFW9vvEY4WfsnVUPRcKAoMxSN
         Melzix3yjpB33L9WZJWbCg0g+3YZGpric1zR5aIiAd8q3btJh5h91VVUjTXNATH1IaGO
         G+XvJywmAYoCfn5BhdejVRJjb11fUtekm2m9kbVCvEZnH8xjUPKkeK+Rhz+CpT9buV0n
         islN7adSbyuNyg2nGiyvV/0jxtrxFsf07IZYa9YAsOxJcwI5jg3zJrKYFq+oy4LA0J58
         OjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731760880; x=1732365680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LCynoPn19dfCOHYqjru4yO7txCVRlW/xym4tzc5li4=;
        b=jU7YCGOd+0JIT9FbR0T2RZ/e2/ERqa4raStMXrKtpUZe5WXRqz9z8cE1tUkAsBjexf
         KV9DvwSAJ1z4K1jzecUhzScOw8NKxUq4T+RJvAsRBAutEn7Y34AdGQooWTrrkuAGZkki
         sEp01qHF1x4xE8TJT6JGSgBu+WS1vz+eapmSowGCDLCLc3POVyF1wYo+h97vCDuu1I2n
         pTAeKyMSTQmInKs6hpUfo9cnJbgxDaYfsvle+3Wm9paDKpTDJjL+dBaiBnjgfVhg9dGZ
         voLGamqrPNcNUQar8iEPyyeNutQRRXEsZPnABeQhSfsB8hjjW4WL0a9HlOgh7RHdEzxF
         ToYw==
X-Forwarded-Encrypted: i=1; AJvYcCUXEtUUI94DNXfvozohXF4M2ftzYtnPY/ZgIRZXczdvbneFjIYrn6G/ZdunFs+U0qx62JdiJlSe8K4Z9WWY@vger.kernel.org, AJvYcCVZOe/ZUotYP4ibWB/+sO46is/Sh0dtwgNywh5b5+DLssGmsf+3sYjWQEaJk1qnYeOUALSAp4sfPrpF@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+JTH2qAnWm6ZLM+2jEOelhLMNxWHo/ROdIvulQWREDb6Vzh5
	4lyj00HcJa4GGelTPcRTivW+OgElZ5DC5zOObF90zIok7ymJHSCI
X-Google-Smtp-Source: AGHT+IFs8EVfbw/QPULwfxkPOjAL+2s+zFhdIlynzF5Ui08rwGCnEWCd6ZyIupLPaGgcqrO1DBKVgg==
X-Received: by 2002:a17:90b:2e0e:b0:2e2:991c:d796 with SMTP id 98e67ed59e1d1-2ea154f2dbdmr7998426a91.9.1731760879745;
        Sat, 16 Nov 2024 04:41:19 -0800 (PST)
Received: from [172.18.38.232] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc305dsm27190125ad.44.2024.11.16.04.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 04:41:19 -0800 (PST)
Message-ID: <b943d500-438a-44ef-876c-53846c2198c0@gmail.com>
Date: Sat, 16 Nov 2024 18:11:13 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
To: Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com
Cc: dave.jiang@intel.com, rafael@kernel.org, lenb@kernel.org,
 nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
References: <20241115164223.20854-1-surajsonawane0215@gmail.com>
 <6737a14cdd16b_29946a2944e@iweiny-mobl.notmuch>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <6737a14cdd16b_29946a2944e@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/11/24 01:00, Ira Weiny wrote:
> Suraj Sonawane wrote:
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
>> buf is not NULL and that buf_len is less than sizeof(*call_pkg)
>> before accessing it. This ensures safe access to the members of
>> call_pkg, including the nd_reserved2 array.
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
>> V4: Removed the explicit cast to maintain the original code style.
>>
>>   drivers/acpi/nfit/core.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index 5429ec9ef..84d8eef2a 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -454,8 +454,15 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>>   	if (cmd_rc)
>>   		*cmd_rc = -EINVAL;
>>   
>> -	if (cmd == ND_CMD_CALL)
>> +	if (cmd == ND_CMD_CALL) {
>> +		if (!buf || buf_len < sizeof(*call_pkg)) {
>> +			rc = -EINVAL;
>> +			goto out;
> 
> This goto is wrong.  This will result in ACPI_FREE() being called on an
> undefined out_obj.
> 
> This should be:
> 			return -EINVAL;
> 
Thanks for catching that. You’re correct about the goto issue. I had 
initialized out_obj to NULL in previous versions but missed it in this 
patch. In v5, I’ve re-initialized out_obj to NULL, to avoid unintended 
access. Here’s the updated patch link: 
https://lore.kernel.org/lkml/20241116114027.19303-1-surajsonawane0215@gmail.com/ 


> Ira
> 
>> +		}
>> +
>>   		call_pkg = buf;
>> +	}
>> +
>>   	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
>>   	if (func < 0)
>>   		return func;
>> -- 
>> 2.34.1
>>

Best Regards,
Suraj Sonawane

