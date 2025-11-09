Return-Path: <linux-acpi+bounces-18711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6420DC449E0
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 00:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BA1188B9CE
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 23:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E726D4D8;
	Sun,  9 Nov 2025 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E12mA6h+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQNOu73B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39461891AB
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730190; cv=none; b=EfltIlz/1lNQhuYKrZAvKh4mrcHuA04SDS/3XzNohskGr+rNpTdHBAhGRlSgZf6zL7WcYavaX8pptFXgcM26yNg0j352ub1pdiV4bGReNCnsmdu1TFW34+rnA5gLmlrR0aqLE9xduV1d8v8rX5c55lyRNpFNsdDrsq/u1EYPbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730190; c=relaxed/simple;
	bh=WEuhBaqGut5XAoUR3r29Kk93XGgI1lKeDXa8zdBsMQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7J6vBSfWSTIw4silVxFeJuWIEqpXydx92m8Ii/VUl49N2YHjwC8TqZ9+TDDfdOxrXdylPtn/unrA1RxP5ov6lkoW+yLG+pXu+W1rJ/hFFRHMPzj08V9ZUkfBNQWwIF2LSW3nJxlytuXGrwt+xeuYuEMpCq5TAZu5nuooYV0yVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E12mA6h+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQNOu73B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIWvhRHintsgUxq7/kw7iMAKxqqXku8h0+Og23yX6Gc=;
	b=E12mA6h+H0ovXOgBf/9JR/X/0tt/rCUWeufxydgbt4eCl7oEnZlIalH4e6svIUkGg1gA/B
	CfJ/OnGiH0bPzfFv6Y1b4daXlW7Rn0TEz9jiGlNqWy4004lJDFDeWCt8ATJT1ioVccmU7C
	Y6eYxuTr0ed/cuVM4eseLcWTnkUVe74=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-eC6vsl2vOquHTguUJGPCGQ-1; Sun, 09 Nov 2025 18:16:26 -0500
X-MC-Unique: eC6vsl2vOquHTguUJGPCGQ-1
X-Mimecast-MFC-AGG-ID: eC6vsl2vOquHTguUJGPCGQ_1762730185
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29555415c09so29704875ad.0
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 15:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730185; x=1763334985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIWvhRHintsgUxq7/kw7iMAKxqqXku8h0+Og23yX6Gc=;
        b=cQNOu73BsRKQUSCATq2C4ZYlTVD+BHt1ZwFDZRzmVEIMeMKORTd0r9igPZsJeRyM9Y
         /LoTDjXFpLMizTEQp5Bk7Y8Xr0noAbjwv81kCBzWXXEY2nzqSyxicCpqlaYyYNL7/tLs
         Ze7cvV09yqH5H6v7jJwVK4JGRl0a3Y35lJbYkdhrgiHzxhG5rCPiJ6sbcf+2bit37esv
         qUCAuaerM6qo9s3UuHogPqmfNt7phrmv67zr4jBroFWXKGsJSMMev8HWHYcWlmYp2MW0
         imbwaKUgLmtIVBMesNvyouWeCYkLrGZZlY4YTF21xJhTGC5Hpey/2LFGCi2S1krWkeZN
         Q9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730185; x=1763334985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIWvhRHintsgUxq7/kw7iMAKxqqXku8h0+Og23yX6Gc=;
        b=D7QbSKhIhpZwfMdj4SpkGY75mhGH1OP311KalfvaYidfcxAK3yaZDcIdFco/xAlhOW
         K/CLg73tyEWo8KfQcdAYbjwDuVX+Jn5M8pXsQTf55Ds3+MxtPZK+CXzt1AqWJVqEHFJ4
         qA7jVUk5Nowthsi7jbve/r6CQ264WWKnXB6xG3WCpOM17mkEXv4rigMDZpSfKTPi6gHZ
         RoVI6ayZ6p6ZtxE3smnC0vcMxA0t2eyEK7sPvf2tQA8Au8eL+/HZSGacVGG0wT+zkcxa
         Lc1VtqjS54CpRCESuaxUslnZFAItrWI0s5Ss0tyXreoOj4aef3fQM7vFbzN+Y2kbOI0x
         Wk5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfb/uFbcazE+ZA20idHZOp55KjcGUxMckMywdAI5Z4Y0G74DgLBW2E8K8tB7J/X/vljG3ZEmZPT4ds@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaKmDhhWCWdz5Y+QQcr4QxEVasbF+Y/bAQitMKIldSyoui6Ma
	QkdtMz3mjk3ctGdebavs/31tS45vlJF0o7eKC56sH1yTf1qUr4h77/U5FHBtDuG14G+PXbn4472
	wan7tQtIWk7N9gwNvIxUebj7C+gpSF9vykA6xj/KZxX7prcI/O+WvZco4OLQTgNk=
X-Gm-Gg: ASbGncsFc+RZZfPynnNf2NI40ipXxEqheV4ySSt6yLA/WZBkfBL4PO1DwvpIbiXdPxu
	TBxm24ndv/tO4sQQq90m7cbxGD7n++vlr8H08mh02whmXbEpwyEbqUcwKO8OJeY9McYYR0SxcVZ
	yekLefQo1OpVQXSUYhasN9mw1V/Ybv974oIXEQZOvK0bMw991Teavphg1ZBFIEFvlrjp0a9FfvB
	uJfaFYfQ/Jw+p2PioFVNX7uIq+OBbohWHSFVxpTOcB1Ws0hMyZcAgtJhulmLw9Btp7nkKqp2IZL
	m8en2iD+li9RVlAIRYJqID0Sh3OP/Lie3E00BpPB06A+AtKc3hYce9CqjUEP2xlMl255IMI82zo
	LqRTg6XD03P991/rkrNTePfarahdeBe5QvCf66SE=
X-Received: by 2002:a17:903:3ba4:b0:294:fb47:b623 with SMTP id d9443c01a7336-297e5619e35mr66189445ad.11.1762730185127;
        Sun, 09 Nov 2025 15:16:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW0fX3tz982fZEVFcVhHyjU6z81+PepIDK0pHZvIUFcQbTO7ihNToj0nHl6Ty3e3/m1+e+yQ==
X-Received: by 2002:a17:903:3ba4:b0:294:fb47:b623 with SMTP id d9443c01a7336-297e5619e35mr66189235ad.11.1762730184748;
        Sun, 09 Nov 2025 15:16:24 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec04sm123053925ad.102.2025.11.09.15.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:16:24 -0800 (PST)
Message-ID: <58d05fba-d678-4564-beba-45f667f9e975@redhat.com>
Date: Mon, 10 Nov 2025 09:16:12 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/33] arm_mpam: Consider overflow in bandwidth counter
 state
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Zeng Heng <zengheng4@huawei.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-29-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-29-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> Use the overflow status bit to track overflow on each bandwidth counter
> read and add the counter size to the correction when overflow is detected.
> 
> This assumes that only a single overflow has occurred since the last read
> of the counter. Overflow interrupts, on hardware that supports them could
> be used to remove this limitation.
> 
> Cc: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c  | 24 ++++++++++++++++++++++--
>   drivers/resctrl/mpam_internal.h |  3 ++-
>   2 files changed, 24 insertions(+), 3 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


