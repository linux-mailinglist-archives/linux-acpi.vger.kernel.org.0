Return-Path: <linux-acpi+bounces-15686-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67012B26B05
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E422E177AB0
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C5B20101D;
	Thu, 14 Aug 2025 15:28:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C481A5B8D;
	Thu, 14 Aug 2025 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185307; cv=none; b=HCCIn/1ESqPLKZt94D/sid5J16cVZNfrNP0l7WeaEAI1eLw+uQ1VyXXS+P8M9m0Z9QeqVYc75XqPPXnjTdEtvHGkVh3CNRj9q0p8ZYToke4uMeEsm0+P0QZNHAta8V3+BktYudBy7AWJPv9ljjvLUF1bqTRXeTTuYDj6PyIrSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185307; c=relaxed/simple;
	bh=OtX8NQC4WyCIC6HX5tnUsUk0WKM0GZbwEuVcQ1HlxAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rARQDOOY5XIwz4kLN5ZAW6qonb1b1FAv7FLoLGvaF+RqhMWTsy7xorS2djJRfjNCGJ1cZ8qBRDilDp/Dc+hy4ZaanZCtXcGbqfuKJRevWm01liDgHxa+caxHhetQYWoGdmsR7oj1WG0NTnBtlO4j+fNmluQIAUeYEQFWkTxzKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A36441691;
	Thu, 14 Aug 2025 08:28:16 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DDC63F5A1;
	Thu, 14 Aug 2025 08:28:23 -0700 (PDT)
Message-ID: <6065d82b-0a07-4f82-8b4e-9c00374d2f71@arm.com>
Date: Thu, 14 Aug 2025 16:28:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu: Fix virtio-iommu probing
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, rafael@kernel.org,
 bhelgaas@google.com, jgg@ziepe.ca, lpieralisi@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org,
 jean-philippe@linaro.org, jsnitsel@redhat.com
References: <20250814141758.2140641-1-eric.auger@redhat.com>
 <e3935099-6e29-493d-8587-64ceca8a20e9@arm.com>
 <3fdbd23d-cd65-453b-aa8d-78f9ed1bc4c4@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <3fdbd23d-cd65-453b-aa8d-78f9ed1bc4c4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2025 4:19 pm, Eric Auger wrote:
> Hi Robin
> 
> On 8/14/25 4:53 PM, Robin Murphy wrote:
>> On 14/08/2025 3:17 pm, Eric Auger wrote:
>>> Commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
>>> probe path") broke virtio-iommu probing and no iommu group are
>>> produced anymore.
>>>
>>> When probe_iommu_group() gets called viommu_probe_device() fails
>>> because viommu_get_by_fwnode(fwspec->iommu_fwnode) returns NULL.
>>
>> ...which it's not supposed to. And *now* I remember, we never got this
>> finished, did we?
> Seems we did not ;-)
>>
>> https://lore.kernel.org/linux-iommu/9beaed48da83a0882dba153e65e6cfd0a8e21482.1742484773.git.robin.murphy@arm.com/
>>
> 
> Unfortunately it does not fix my issue. Still no iommu group when
> booting with ACPI.

Indeed the evidence at the time suggested the patch isn't quite right 
as-is, but that is definitely the place which needs fixing. Since 
Jean-Philippe's occupied with more exciting things at the moment, do you 
happen to have an easy recipe for testing virtio-iommu so I can try 
debugging it myself?

Cheers,
Robin.

> 
> Thanks
> 
> Eric
>>
>> Thanks,
>> Robin.
>>
>>> So it seems we need to restore the original iommu_probe_device
>>> call site in acpi_iommu_configure_id() to get a chance to probe
>>> the device again.
>>>
>>> Maybe this defeats the whole purpose of the original commit but
>>> at least it fixes the virtio-iommu probing.
>>>
>>> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
>>> probe path")
>>> Cc: stable@vger.kernel.org # v6.15+
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> ---
>>>
>>> I also tested smmu probing and this seems to work fine.
>>> ---
>>>    drivers/acpi/scan.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>> index fb1fe9f3b1a3..9f4efa8f75a6 100644
>>> --- a/drivers/acpi/scan.c
>>> +++ b/drivers/acpi/scan.c
>>> @@ -1632,6 +1632,13 @@ static int acpi_iommu_configure_id(struct
>>> device *dev, const u32 *id_in)
>>>            err = viot_iommu_configure(dev);
>>>        mutex_unlock(&iommu_probe_device_lock);
>>>    +    /*
>>> +     * If we have reason to believe the IOMMU driver missed the initial
>>> +     * iommu_probe_device() call for dev, replay it to get things in
>>> order.
>>> +     */
>>> +    if (!err && dev->bus)
>>> +        err = iommu_probe_device(dev);
>>> +
>>>        return err;
>>>    }
>>>    
>>
> 


