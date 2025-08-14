Return-Path: <linux-acpi+bounces-15685-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ED6B26AD6
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D2C1C81394
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9B1E522;
	Thu, 14 Aug 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y75VZXAB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278721B9CF
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184798; cv=none; b=eHZhwkEfwFFeZMh2SjnfFHLR4o7PpEPQDYFtM62Y/zi69PqmojnOO22zzbWRZ898KyqiYVowILArIqJLcyK+pjpTCqU99Vxuiv3Yc4YK7KDukdIHq/5TOoIoqcNAb0vNmF3aXEcs7xK39BbfjPYfxFCkiXHum5b9tvYB+1tC2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184798; c=relaxed/simple;
	bh=Me9loLch93dkc0dpmXGYnGiHnYvadiSaEhticdiiJe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CtfmVV/qppBYPwdE2L8Dm3GcfvqFBwWNOPmLYC7/k47iQhzpkm/JExf9EThS2rmqU95gACBBOIjGjwpChOG/a1iutgGhaLxkba/X31J1fAusZa+nAm8VUYD7yhzadJKINDBAAHZ2xXXHzp5AHJ+hFGYb08QhpF+0Zr7F28PYbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y75VZXAB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184794;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHIaca87a+Lei/XHRRpk/utjyoa+VsnhzwStKO2yDEo=;
	b=Y75VZXAB60RJo85flsm1BWcRd2SUmABHYULDY2juW+Y9Tgwued38A8JIfJS0s9bH1iniqe
	h3qOwTQyfaTWm3KaBmWkow1zGQW1c3G3q/UkwlkMY+K8nDZ5lSwW6n8o92as2PgURJ/Nl+
	8JgRSW4wWvxjyy6S8fjOs9Vnog/9JQ0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-0ILx-mxAPVWUONLQ9ZOkoQ-1; Thu, 14 Aug 2025 11:19:52 -0400
X-MC-Unique: 0ILx-mxAPVWUONLQ9ZOkoQ-1
X-Mimecast-MFC-AGG-ID: 0ILx-mxAPVWUONLQ9ZOkoQ_1755184792
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e86f8f27e1so289731685a.0
        for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 08:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184792; x=1755789592;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHIaca87a+Lei/XHRRpk/utjyoa+VsnhzwStKO2yDEo=;
        b=NZWDHzKRyGxg4Tu6xvoUFKSDT8EGRe3+6gTykxQZG2QMZ30twXmn/RQXqHZetCYiwf
         YoIaI2rJxGWwmQMcqTRltUilOB/ZW1W8GdrfkeBnTz84AA4cg+GpRFyi4qjffN9l9s9k
         WmaC+leRYPMWsV9nZRTu5WMloKub8ZX4iI2yOgQuk6lDJPPZCh1jB10yA3meH/2u2GhO
         7VMzXSiF7IounsokMvm9tJPJIgSuZoC9x+5GWZcXsHUBEnYREwSeAeaC8lVF5oX8WnuC
         fVgJgg02MgCvm/Pc5iKH/SmLmjKgWjsRSGdSlkUnjANxAa+JFmkwAulySll+rTrEcVau
         LjZw==
X-Forwarded-Encrypted: i=1; AJvYcCVgUzV6jxdEXeQ062WxQOKkphrio71i8VofzADWrJa7pyYJG7qK2PIiYTpjBPOVQ2my6Y9ACyk7l3X8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9PAK2Maccl1rOyhiszrofua+TgQWhIZH0N305t0pI/LTnP8+j
	iqMsbzC956NkLuY2T9v4875wECl8qeIw4BoZjf9vT7YpdUKAYAG5vExvw/hut7TLMBt4keIof7l
	TYvIIrwqVPul57PHVUVIu9Sxwd/KkF3fsM/JoUTSKnvO2KBEF3dgoDvnVpBtUmk4=
X-Gm-Gg: ASbGnctp5ikeSKrDJuCY8QgOY0fXE5GBf/7JueyLs5Ky+rcX2MamuSoHSzG39E3duRy
	MejNz82MruCKky81hojYx7BfWTmc1s92Aqds2+Y3uiIv6QYA2FNGM6UdswtN/V9/O8cLSfttJmN
	iUZVQ1vqIWX/kqPWCzJiEAlFRPxj6Hv5dFK3DcqUu221ZuiB2uTYiI2qoJwbz+zQ8z5zTIcyZNl
	L2kbU1OYzRVVN4aHmnb9XtYfoCaB3LfGGuNKT9/04pPyS7lbiu/WXJ7y67UgH9OP461HmeQhGjt
	yOaRwMrLo8B0aMJClIUpFbopwfJMu8F8qpwQpcX2uqtnPhqXahlB/p4bGkFPrRGkBwcMPx7UQPj
	I5JFEsWu0SUc=
X-Received: by 2002:a05:620a:444f:b0:7e6:3e26:63b6 with SMTP id af79cd13be357-7e87177df9bmr360188985a.21.1755184792056;
        Thu, 14 Aug 2025 08:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbBWvamtmgCDWchP6EGpptPrCEMuK58uAggqkP3T93k3CpPZISIT2j7qtn++KMlZQWGXRgAg==
X-Received: by 2002:a05:620a:444f:b0:7e6:3e26:63b6 with SMTP id af79cd13be357-7e87177df9bmr360184485a.21.1755184791608;
        Thu, 14 Aug 2025 08:19:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e806ad969dsm1617338385a.78.2025.08.14.08.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:19:51 -0700 (PDT)
Message-ID: <3fdbd23d-cd65-453b-aa8d-78f9ed1bc4c4@redhat.com>
Date: Thu, 14 Aug 2025 17:19:48 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [RFC] iommu: Fix virtio-iommu probing
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, eric.auger.pro@gmail.com,
 rafael@kernel.org, bhelgaas@google.com, jgg@ziepe.ca, lpieralisi@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org,
 jean-philippe@linaro.org, jsnitsel@redhat.com
References: <20250814141758.2140641-1-eric.auger@redhat.com>
 <e3935099-6e29-493d-8587-64ceca8a20e9@arm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e3935099-6e29-493d-8587-64ceca8a20e9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Robin

On 8/14/25 4:53 PM, Robin Murphy wrote:
> On 14/08/2025 3:17 pm, Eric Auger wrote:
>> Commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
>> probe path") broke virtio-iommu probing and no iommu group are
>> produced anymore.
>>
>> When probe_iommu_group() gets called viommu_probe_device() fails
>> because viommu_get_by_fwnode(fwspec->iommu_fwnode) returns NULL.
>
> ...which it's not supposed to. And *now* I remember, we never got this
> finished, did we?
Seems we did not ;-)
>
> https://lore.kernel.org/linux-iommu/9beaed48da83a0882dba153e65e6cfd0a8e21482.1742484773.git.robin.murphy@arm.com/
>

Unfortunately it does not fix my issue. Still no iommu group when
booting with ACPI.

Thanks

Eric
>
> Thanks,
> Robin.
>
>> So it seems we need to restore the original iommu_probe_device
>> call site in acpi_iommu_configure_id() to get a chance to probe
>> the device again.
>>
>> Maybe this defeats the whole purpose of the original commit but
>> at least it fixes the virtio-iommu probing.
>>
>> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
>> probe path")
>> Cc: stable@vger.kernel.org # v6.15+
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> I also tested smmu probing and this seems to work fine.
>> ---
>>   drivers/acpi/scan.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index fb1fe9f3b1a3..9f4efa8f75a6 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1632,6 +1632,13 @@ static int acpi_iommu_configure_id(struct
>> device *dev, const u32 *id_in)
>>           err = viot_iommu_configure(dev);
>>       mutex_unlock(&iommu_probe_device_lock);
>>   +    /*
>> +     * If we have reason to believe the IOMMU driver missed the initial
>> +     * iommu_probe_device() call for dev, replay it to get things in
>> order.
>> +     */
>> +    if (!err && dev->bus)
>> +        err = iommu_probe_device(dev);
>> +
>>       return err;
>>   }
>>   
>


