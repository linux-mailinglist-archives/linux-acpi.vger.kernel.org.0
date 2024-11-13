Return-Path: <linux-acpi+bounces-9535-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95B9C6ABE
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 09:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2061F24614
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700918BBA2;
	Wed, 13 Nov 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhNQCkKs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983718B484;
	Wed, 13 Nov 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487299; cv=none; b=tgkLhLtait3haFROy+VccgkDGU0Q9u/ZwxE1S5EAvEmXGMw9YPbOlcVKSIQWFwTMRD1gQaQXkidoX3Y7W9SwHPWL8Ka8shaV0juDrO9hKMUtztO1rVg0UYdolKKSY38YDQhfH2QrbUWFZ1c3et6Ph1eTasPQa4u1icWgKJ3a8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487299; c=relaxed/simple;
	bh=coGrNgoWkLMHBfiIuhn/xIYu0/a/0dOqEzIaEbp6e4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjRp8C5SLeLp1+iikWA+CLosojC9sJue750d30haFlaRYEbNhbvgea7SIdLcqwfnCMslcxuMlj4cOime86o8xNA0h0UKUsedY1348vQLlZRbqyBJvQOKfUyvNC0B4D8/pM29zoBnEozWiZDqpS5Z1YUFJH3JMhWEteJDGA4cWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhNQCkKs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c7edf2872so3830915ad.1;
        Wed, 13 Nov 2024 00:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731487297; x=1732092097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QcuWZIztgNxUKNlP2X7zVrrT6cEWzHq8P6f0ogdK94=;
        b=lhNQCkKslCK4PeKhqo2Nw56TrOFduSPyGvLO7npfwlQujdOYU0WkNGbLK+qngldJ4Q
         K/zv95Bv9VebIqlI8DXsEpqlfuLSUxrNX79rHBg/yk2YA4aJQnbedMxMAqg5s1d1HcId
         BoxvCHPiUfARSDvj/7+2xrEHZKAwBM+KlapAZcfnbfR4KO0zTLgDXHdBohzjMriBcH32
         gwhxPuzom1fvljD6TPd9WiZO/bLfw0fANx5M/OAGwUuPg1MKWmgGu4CQBi6rYZPBEqYy
         WwGUFgmRMrdvAYvuUW9/WofRTvwaBRa29KcCEGGiftqQsFbazv0stsTxpYeSzZlRgvq4
         ElKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731487297; x=1732092097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QcuWZIztgNxUKNlP2X7zVrrT6cEWzHq8P6f0ogdK94=;
        b=i7aRcgu1FkXgkfOgnOdjtRjdYv7WbYMooqW/uHgV21lmhiTHw8rTSh+t0V8rs0VLqr
         kF5du8khyAitgZPi4En4kXz+lTxcIe4OiMa/Oyt3OyQqkE81AOuCNC8iWMPNFuTkKF0M
         UA4Lmm7WU2LxkfVOzfSFfEADlGvdaohUYrMYuJ4gwMdkWv5OTOL4NAYpPlXkOXJM9+8y
         vjMknhZhLeUsRXm4QzTytxPSm0MX5XuNmPOeF0bpRTYMxLkHIbUIG09eVlATMAcrrJQ2
         q32n9U9pInAPB3kqNCYXqlE/CSlysJqzJTYdLXIgxJLBv9Lr/O4Rb9SGdCdH1iYxnPqB
         JqMw==
X-Forwarded-Encrypted: i=1; AJvYcCUge8PtIvCgaZugXGPTE4s9LeJuHJa6stLwZAl1aVJBPW53NVEzniSOsw1t43cJ8evyXCbGS46KMWAQ@vger.kernel.org, AJvYcCXkxJqVIBg6ASc/o8+4XILBvvhk18YEPRwU6449mTBDxZffMj5SN5vdIlDlLo+GNjtXaTSsmM9znb3Sdjte@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdnl8wEGYxIxPQeezvNvi/8kprPb8X2HVxuayLk3NCmrLJKXZH
	jSzLu6ZcJkKaKpZ3SaHk79G3XHC3MsABdz11Yvz9brE7vTZxQeh3
X-Google-Smtp-Source: AGHT+IEe6UKfn6nbhSkb2kTrGGS/P7JCBRmHw/QfWnQj8ti6LcqoX99L5qmJubLi9ojMHupngMwDUA==
X-Received: by 2002:a17:903:2349:b0:20c:b6cf:f465 with SMTP id d9443c01a7336-2118369d629mr290047115ad.6.1731487297121;
        Wed, 13 Nov 2024 00:41:37 -0800 (PST)
Received: from ?IPV6:2405:204:20ac:21b:f7dd:e473:be3f:2c8f? ([2405:204:20ac:21b:f7dd:e473:be3f:2c8f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7e0fsm106349585ad.21.2024.11.13.00.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 00:41:36 -0800 (PST)
Message-ID: <4e932421-132a-4a47-b97b-415bd232836a@gmail.com>
Date: Wed, 13 Nov 2024 14:11:28 +0530
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
 <ZzQtOFiW1G4jAIzf@aschofie-mobl2.lan>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <ZzQtOFiW1G4jAIzf@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/24 10:08, Alison Schofield wrote:
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
> 
> That all sounds good! A couple of coding conventions fixups suggested
> below -
> 
> snip
> 
>> @@ -439,7 +439,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>>   {
>>   	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>> -	union acpi_object in_obj, in_buf, *out_obj;
>> +	union acpi_object in_obj, in_buf, *out_obj = NULL;
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
>> +		if (buf == NULL || buf_len < sizeof(struct nd_cmd_pkg)) {
> 
> Comparison to NULL and sizeof() usage preferred like this:
> 	if (!buf || buf_len < sizeof(*call_pkg))
> 
> 
> -snip
>>
>>
Thank you for the feedback and your time.

I appreciate your review and coding convention insights. I have studied 
the suggested change and updated the patch.

I will test the updated patch with syzbot and submit a new version very 
shortly.

Best regards,
Suraj Sonawane


