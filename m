Return-Path: <linux-acpi+bounces-15687-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 684BAB26B2F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059CE1CE073B
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01E23AE9B;
	Thu, 14 Aug 2025 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7pKTYJL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95F225A4F
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185692; cv=none; b=VJObn4kuGU+DM2Ypz+Gep/rR7e9Ptz7Ds4IjLjbvnJVD4P3cJHBr+5HeuiEyxVzcYioPuwWkNwIKUGyhzcTBwdRe4o05Fx/ZMYyEtJ1WUXsfQWPH7hjpFHhLp6JF6NsmhW/wNdfODRisZI98Rw9rLI0zNR5SZjWAv/y3vp8bzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185692; c=relaxed/simple;
	bh=xvGL7DY8ZMo2Ei32WQZRQ6BKK5rxE+s60T1JZuZ1YB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mkMwrOASCDjQFALiRoFXt532mMNGW1+ODqjS5JEnQhf4GSTBHZ7QNgPGkyC2OOLeHGxTpa03PY6GtYRI3s7tRaw0KKCfhaEY6q0NRLCB8OnF5Tl+lsQd0FJpHWvk3ToxlR7RVukl4YWDyc9ZGZXxtpYOBbLjMWJgvtUCXGrtXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7pKTYJL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755185689;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FF21Vrb0E9HgLsPo9WR8fvObdoRI3So91Rz3YvTAOHs=;
	b=C7pKTYJLxkD6YIksYuBYUWRvH63R82yq8bjLY9wFXqKVil1tStLEzoweh8NwPBUOO87Gg+
	wpbpS7AUOiM9MxQBKwuTCI54+191vPrcY/CCmFq7cyW0xU6h88stG66ABIFrwfLPwVzumu
	OydiEmUZDoawuYP6UZ8I6md3+B/Mf7A=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-dZat0phLPE24V1kUg7L4MQ-1; Thu, 14 Aug 2025 11:34:47 -0400
X-MC-Unique: dZat0phLPE24V1kUg7L4MQ-1
X-Mimecast-MFC-AGG-ID: dZat0phLPE24V1kUg7L4MQ_1755185687
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-89018f8e40cso393502241.1
        for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 08:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755185687; x=1755790487;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FF21Vrb0E9HgLsPo9WR8fvObdoRI3So91Rz3YvTAOHs=;
        b=QIOdISMjKXhh5JqjJl8sebfUtGnvS10YjDeMk5Jet2IE9EwN4+/59vNupNWfwk6X77
         /4g8dlvRKNgSJvGUofRLCacOrv5h36ZOmcN//pHtzrxLrtQ1zdORwHM32BjNoD367XEN
         JO846PgHK1h6KsBQfOuWmP/evbdzTkjGs6Df/sbNMiv6KHCppXUhZ5bpGYL20UfExBhG
         vRDpfADQSBXuAwaTxfhmn1KVG71XkqbaDnbUg3CKamb3YX3AUaQChSLjNAZfMD41caEI
         mfTHUfd0KBZfYLQt85GcEiOdxrITLaeTIpkmnP/aMyUlMAoy5IgfEAZMmC+0yNUWQo+U
         dCfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7JTAvhnSSspWKSbrTYcAfJPz8fBQMVGtHF2p6kkLXYozDmq4qU6RgXm8UeXyM52N6Ld8Ir3A0kAHY@vger.kernel.org
X-Gm-Message-State: AOJu0YymjOmGk586+fKaX+0+w97NsWek7qC+P/aRzJWX2iZjUcubA+su
	jisbDU6QapCwD4m/pbNnVnVIejviUk6HTi3UTsp0xDXR9kTVx4hXQq46iPWiGu7H6VXRVb9/9GG
	IH9X2Sret5vGNcv0+HVtd/cLxKN9zq74l4tOAEzuYJKl7oIUSXRNnuzAaygKvHip9PStEaA0=
X-Gm-Gg: ASbGncvC9ayvD1Ra4m4WrH+8vvtJzU1VSJ1U0PePmqDStGjaj/UHXU4JXLYCE4zHTpg
	VdLgl6Y+XdYnhIAUmjvsmT/bJUCh9//K0jj83OK0W2/GyaXBiI2KYWVBFBLHv9RqQNi3H1jmX4g
	lYB4EippNA6nR8pRGA533X8aDrv41C61H2/A/nQi1dUy1SFxafMvzclUedBly5RcQD4pzJFwfvW
	VxcnLoG6u+utx5AQ/PNE1QgYzJmLQA6moyfdoI+ihDNP6DKblxTUn8SsYUhrG5EHiBV7bMJ9UhP
	ylmFbWT5lJOo0G20qlPoaMtoiTHDQGRt/g/kF9hl3C1QsMsnrs+BW7gbGbRGHxm4ybjKpJ5hEwH
	XNPAzY1BvPlw=
X-Received: by 2002:a05:6102:d93:b0:4e7:5f31:7443 with SMTP id ada2fe7eead31-50fe0c158a1mr1427617137.9.1755185686476;
        Thu, 14 Aug 2025 08:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+/6dKe1kJ911yQbOAzRDTDCXbofqZKWFiMIThFR3OOIAtFum7vkGGy+nnE5DHeftlrWrxEg==
X-Received: by 2002:a05:6102:d93:b0:4e7:5f31:7443 with SMTP id ada2fe7eead31-50fe0c158a1mr1427588137.9.1755185686046;
        Thu, 14 Aug 2025 08:34:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5b82985sm13963766d6.65.2025.08.14.08.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:34:45 -0700 (PDT)
Message-ID: <e9212299-d66c-4779-93f9-3bb5833e5c07@redhat.com>
Date: Thu, 14 Aug 2025 17:34:43 +0200
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
 <3fdbd23d-cd65-453b-aa8d-78f9ed1bc4c4@redhat.com>
 <6065d82b-0a07-4f82-8b4e-9c00374d2f71@arm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6065d82b-0a07-4f82-8b4e-9c00374d2f71@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/14/25 5:28 PM, Robin Murphy wrote:
> On 14/08/2025 4:19 pm, Eric Auger wrote:
>> Hi Robin
>>
>> On 8/14/25 4:53 PM, Robin Murphy wrote:
>>> On 14/08/2025 3:17 pm, Eric Auger wrote:
>>>> Commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
>>>> probe path") broke virtio-iommu probing and no iommu group are
>>>> produced anymore.
>>>>
>>>> When probe_iommu_group() gets called viommu_probe_device() fails
>>>> because viommu_get_by_fwnode(fwspec->iommu_fwnode) returns NULL.
>>>
>>> ...which it's not supposed to. And *now* I remember, we never got this
>>> finished, did we?
>> Seems we did not ;-)
>>>
>>> https://lore.kernel.org/linux-iommu/9beaed48da83a0882dba153e65e6cfd0a8e21482.1742484773.git.robin.murphy@arm.com/
>>>
>>>
>>
>> Unfortunately it does not fix my issue. Still no iommu group when
>> booting with ACPI.
>
> Indeed the evidence at the time suggested the patch isn't quite right
> as-is, but that is definitely the place which needs fixing. Since
> Jean-Philippe's occupied with more exciting things at the moment, do
> you happen to have an easy recipe for testing virtio-iommu so I can
> try debugging it myself?
No easy recipe. on my end I am using qemu/kvm with a rhel guest and
custom kernel. I guess it was integrated in kvmtool, wasn't it? I am
just testing with protected virtio devices.

Thanks

Eric
>
> Cheers,
> Robin.
>
>>
>> Thanks
>>
>> Eric
>>>
>>> Thanks,
>>> Robin.
>>>
>>>> So it seems we need to restore the original iommu_probe_device
>>>> call site in acpi_iommu_configure_id() to get a chance to probe
>>>> the device again.
>>>>
>>>> Maybe this defeats the whole purpose of the original commit but
>>>> at least it fixes the virtio-iommu probing.
>>>>
>>>> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
>>>> probe path")
>>>> Cc: stable@vger.kernel.org # v6.15+
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> I also tested smmu probing and this seems to work fine.
>>>> ---
>>>>    drivers/acpi/scan.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>>> index fb1fe9f3b1a3..9f4efa8f75a6 100644
>>>> --- a/drivers/acpi/scan.c
>>>> +++ b/drivers/acpi/scan.c
>>>> @@ -1632,6 +1632,13 @@ static int acpi_iommu_configure_id(struct
>>>> device *dev, const u32 *id_in)
>>>>            err = viot_iommu_configure(dev);
>>>>        mutex_unlock(&iommu_probe_device_lock);
>>>>    +    /*
>>>> +     * If we have reason to believe the IOMMU driver missed the
>>>> initial
>>>> +     * iommu_probe_device() call for dev, replay it to get things in
>>>> order.
>>>> +     */
>>>> +    if (!err && dev->bus)
>>>> +        err = iommu_probe_device(dev);
>>>> +
>>>>        return err;
>>>>    }
>>>>    
>>>
>>
>


