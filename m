Return-Path: <linux-acpi+bounces-9536-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC19C6B29
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 10:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607E6285A9F
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F11BD9EB;
	Wed, 13 Nov 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l87Ws+sD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A591BD4E5;
	Wed, 13 Nov 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488779; cv=none; b=FIFNYn36JxAL//uO9bv1YaUOS2WamHSoPSx6bVhnPSUvs1RRFszuLuf2UfajUFs5hWyH/2IjRXR1yCAW4Wc2++0bI3qHsCVj3mqUQqpTP1cj4JeXoGxHYj5e27xp25t8uMKDjjX8ViCvRNlbjrWGLRJL+mrYfQPt9qce/LFOsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488779; c=relaxed/simple;
	bh=8mmggMnuem4ngZVnWODeAvZk/jEMDw94O9PO4QS1Qx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ier8GTNLkzYFOjmyZGF3vKW3GIR+Kwx9DKNFrd2ljx08Gi13Kxddh1lZ2TXvBeUKPb2ROtWklf3lT/77xA2z/Bzc0y1+nWO6V81BBEIXNraiGzXBbXfuJdhcwygMBvu2ZoewvVzTmx4R06JalTj755L14NrDzrMFzGUxiB9AjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l87Ws+sD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e4e481692so6521950b3a.1;
        Wed, 13 Nov 2024 01:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731488776; x=1732093576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+I+VueqE1fhRquKRS0Z9am0cKm07A/xqHYx9ptqJ2Ak=;
        b=l87Ws+sDSwLbD71na/ym8j4aExIrk7tbP28nk0Y9pW7Q3w8z4ppS8VkOIpXHIPjLfY
         iAyzwxB5AVE5M/7pb9oGyx7572szswFrUf3rZHI2HGYA6JzYtw+t7yC/EW2J9+5kd96L
         eYPvzCiRAtqBTnRJPdiK/U5M9oZ/Bc0i7Bf/nQu2XWtx9GyjXr/QOqilvaNmiGzSZxSv
         VQpzS1eFjrHEzh0jYmku/DRmmGSew934W4zIlCHvVlh02LXXbpiOHGsVFf8EWlgEY1xO
         1qgceedmQ+xslvr2W9g366hvXMYhzzAPpJaDurx3wojs2NHGp5W1f6XgLkY083jCmzID
         mfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731488776; x=1732093576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+I+VueqE1fhRquKRS0Z9am0cKm07A/xqHYx9ptqJ2Ak=;
        b=oYvBxCODhGYkW8m2P0kV1/SUJrUrD5bYAgoT+VNt7Enz87bopDPxPx4DghNGbXB2/A
         yPe6QQjnVX5/4r695n2EKiOP4mhX2C4YlYRTRPG3DcWiajIDNzOdKt3Jm4b5zjZcVbUw
         6dzgh7QbpFiHaNDn8b2gXQL4N/NFqm4ZlEN19LVT9XS1OstKoxUI9fuh7tJ+cG6cBAoy
         TedHoUoQikb0CKpxrf0uWnfMQ2fT81gskKAGp9blzNGQ1ay8Uxaofl8kiMPKp1o9Ks+Z
         NpGTjf2eFxOD6CJ7qXWGqxgt0fCSiKF1nIHsWcd+HSo74P4qA5EALtFMM1wq8toQYC8I
         3mog==
X-Forwarded-Encrypted: i=1; AJvYcCUu9/LLwh8KYwOF7H4yOW+pwUgZuJf28JI8eWkMVEBdMUbZIM8Y9Qa6U2Vk3b46pvD8MiBAClw4pmkJwTjc@vger.kernel.org, AJvYcCWvlXbDuq+i0om+pfPAKBfZvqnKxizT5SeYaPtFcBQZ6JpOdVFCLsdwEMklgTPVFgy/XRckeMKGt3r+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04YMTKdREnKMf2e59SehZwB7ek0/b9SqRXUWLiRdfIebbfODl
	urmXR0wSIi48nxH1IaYxMVkV995EDWqWeDltKbYylC6hsb6yse5m8a2M+g==
X-Google-Smtp-Source: AGHT+IFufLTuaitJ9nQtmqz7t8i7uh0sbUQmWkdKOKws642qgOc+M31tKFhD6xSC8RMnZwHG/iKq0g==
X-Received: by 2002:a05:6a20:43a8:b0:1db:f099:13b9 with SMTP id adf61e73a8af0-1dc22b9275cmr29765775637.43.1731488776109;
        Wed, 13 Nov 2024 01:06:16 -0800 (PST)
Received: from ?IPV6:2405:204:20ac:21b:f7dd:e473:be3f:2c8f? ([2405:204:20ac:21b:f7dd:e473:be3f:2c8f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a1fd2bsm12678697b3a.167.2024.11.13.01.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 01:06:15 -0800 (PST)
Message-ID: <d777ec88-f8a8-499c-b9de-9efefa638eb6@gmail.com>
Date: Wed, 13 Nov 2024 14:36:08 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
To: Alison Schofield <alison.schofield@intel.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 ira.weiny@intel.com, rafael@kernel.org, lenb@kernel.org,
 nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
References: <20241112052035.14122-1-surajsonawane0215@gmail.com>
 <ZzQwXXSwioLsG8vv@aschofie-mobl2.lan>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <ZzQwXXSwioLsG8vv@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/24 10:21, Alison Schofield wrote:
> On Tue, Nov 12, 2024 at 10:50:35AM +0530, Suraj Sonawane wrote:
>> Fix an issue detected by syzbot with KASAN:
>>
>> BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/
>> core.c:416 [inline]
>> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
>> drivers/acpi/nfit/core.c:459
>>
>> The issue occurs in `cmd_to_func` when the `call_pkg->nd_reserved2`
>> array is accessed without verifying that `call_pkg` points to a
>> buffer that is sized appropriately as a `struct nd_cmd_pkg`. This
>> could lead to out-of-bounds access and undefined behavior if the
>> buffer does not have sufficient space.
>>
>> To address this issue, a check was added in `acpi_nfit_ctl()` to
>> ensure that `buf` is not `NULL` and `buf_len` is greater than or
>> equal to `sizeof(struct nd_cmd_pkg)` before casting `buf` to
>> `struct nd_cmd_pkg *`. This ensures safe access to the members of
>> `call_pkg`, including the `nd_reserved2` array.
>>
>> This change preventing out-of-bounds reads.
>>
>> Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
>> Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
>> Fixes: 2d5404caa8c7 ("Linux 6.12-rc7")
>> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> 
> Suraj,
> 
> The fixes tag needs to be where the issue originated, not
> where you discovered it (which I'm guessing was using 6.12-rc7).
> 
Thank you for your feedback.

> Here's how I find the tag:
> 
> $ git blame drivers/acpi/nfit/core.c | grep call_pkg | grep buf
> ebe9f6f19d80d drivers/acpi/nfit/core.c (Dan Williams       2019-02-07 14:56:50 -0800  458) 		call_pkg = buf;
> 
> $ git log -1 --pretty=fixes ebe9f6f19d80d

Thank you for this detailed explaination.
> Fixes: ebe9f6f19d80 ("acpi/nfit: Fix bus command validation")
> 
> I think ^ should be your Fixes tag.

Yes, I ran the provided steps to verify the commit ID ebe9f6f19d80d and 
verified it.
> 
> 
> snip
> 
>>

I'll update the Fixes tag in the next version of the patch. 
Additionally, I will re-test with syzbot and submit the revised patch 
shortly.

Thank you for your time and feedback!

Best,
Suraj Sonawane

