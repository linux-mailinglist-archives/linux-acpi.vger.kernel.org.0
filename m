Return-Path: <linux-acpi+bounces-5549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C88B8877
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 12:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA0E2833BF
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8780C53814;
	Wed,  1 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4WepgK2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E85337C
	for <linux-acpi@vger.kernel.org>; Wed,  1 May 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558738; cv=none; b=iHHGDvHgJxaLz5mW+hxSnDjuWJvN0/AUGnt9/fQgZRGA0mjgEWG1JfEa0Pi0Fe/47VAWod1xvmFj0fl4Fh/34KYYxZ7MEbsSyVZHlAMKeKcE8BCBVYGR1GZKRZ/OB4KzF9ULQPYKhCNkbMnpsyRwfDrlDsjCDQINx9QyZRA/fTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558738; c=relaxed/simple;
	bh=Ev3McdlDAs4BYS6y+XNElwdCdUSfrG/SuHrK3FK3B+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aA9KxAe9GEu1s8a9wEcgCnDizvQxuRj3/q50OtWsYWw7DkZF6EyTChf9qVeibNeBICCTKvOTTmbHUu81tOJwdu3FbOpSKw8Vmd5TMpmaqld9puq+Lc7xZxGnPAe+HX3B/Z80fP4iz7aCYDCcQjXgHMfFlzQkTWiS757MNvQAUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4WepgK2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714558736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxKl3udzzGpg1eT3+MxaYs7RsOyw5KvkU4S7GKrDV/g=;
	b=g4WepgK2x3WteLqKsJhaL/Oz9DWRSqV7upYvHNaCpa7HXjlNM7TsukXIKNL7rEoM1QoFOU
	W9lM2FsBj7wEpUkX48mZ2e4mjPhSOBPrXl1QmaHmOJ4Omn0oaUc92g27zIX62Ie2XLeMYm
	LR0I0Tg3cM8rITli0r5aPXJ3MywA5fM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-hZ62BLm9MmW5t1zGSo0fGg-1; Wed, 01 May 2024 06:18:52 -0400
X-MC-Unique: hZ62BLm9MmW5t1zGSo0fGg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da7d4ccb67so713359739f.0
        for <linux-acpi@vger.kernel.org>; Wed, 01 May 2024 03:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558732; x=1715163532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxKl3udzzGpg1eT3+MxaYs7RsOyw5KvkU4S7GKrDV/g=;
        b=eJ149ItqFALfnoFyrCHrjRWVhWKn/UWPG8vhUqLxNIKQ3aXqpPPHOboJMAip2oDA1v
         Et3UIbdbMM2QmBo0Ltp+Kpg/XGugxge2JBr/AXBan0ht3BGJN3WYXSpuYr1iXnPJwN+j
         04ncfDT0feKxaLBRYxIH2mpWNt09p59eoAtRRhrN1aHfk3bsMGs+unex5WpN4XBHfpiB
         LQIegU7kQOqwn3tBBentxXRu5gMP6ID9FA48qF2erI3Lf39/RufPxTPRXMFcuS8ZTWHc
         vrOBRa926uEYg1Upq5c+UOSX5DAIoJHKWPkTFmxPtDLpYHSw746nLYVPMafHuixdAJWT
         oJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZGRcopXA2I96MJ1M+FmZQboc75CITnngZ7iZPwTfwJO6hrylq3k19gQW/x7RTnqeRJd2YCE3pxGXdU6osp+wIh/5aMM5kepfEtw==
X-Gm-Message-State: AOJu0YygPBt70U+igLotnbV1MRaVjeP6Vu3daWl07p0nAgB3gy3orBjG
	s8jU0EFKsESBAgWnCz8dXKiZLcb1R2cmdNzkUGP5EyWvvJjaSXn6A+IOx8YDL7hsnLtNN7DmfAz
	aoMtEG2H02RquuaZS5n/NliF3eLpMyDwW6jmucEhcmu0MU/TV9ux8Qp5mUR0=
X-Received: by 2002:a92:cda8:0:b0:36c:5092:e6a1 with SMTP id g8-20020a92cda8000000b0036c5092e6a1mr2567002ild.29.1714558732159;
        Wed, 01 May 2024 03:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXwbnm2St0QGkNYvo0Kzya2DtdxpDRe1dq5klNVqI1ZMi8KwgV+DlV3hJf4iiekAiT2koB1Q==
X-Received: by 2002:a92:cda8:0:b0:36c:5092:e6a1 with SMTP id g8-20020a92cda8000000b0036c5092e6a1mr2566984ild.29.1714558731861;
        Wed, 01 May 2024 03:18:51 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id x71-20020a63864a000000b00606dd49d3b8sm12183225pgd.57.2024.05.01.03.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:18:51 -0700 (PDT)
Message-ID: <08c6ff11-ab3d-4a4f-95ea-735134fca8cb@redhat.com>
Date: Wed, 1 May 2024 20:18:40 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/19] ACPI: processor: Return an error if
 acpi_processor_get_info() fails in processor_add()
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
 <20240430142434.10471-5-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> Rafael observed [1] that returning 0 from processor_add() will result in
> acpi_default_enumeration() being called which will attempt to create a
> platform device, but that makes little sense when the processor is known
> to be not available.  So just return the error code from acpi_processor_get_info()
> instead.
> 
> Link: https://lore.kernel.org/all/CAJZ5v0iKU8ra9jR+EmgxbuNm=Uwx2m1-8vn_RAZ+aCiUVLe3Pw@mail.gmail.com/ [1]
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: New patch following through from Gavin pointing out a memory leak later
>      in the series.
> ---
>   drivers/acpi/acpi_processor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


