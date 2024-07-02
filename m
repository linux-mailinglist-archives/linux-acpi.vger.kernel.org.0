Return-Path: <linux-acpi+bounces-6734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F72923D93
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 14:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 600A2B2414D
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7633716C680;
	Tue,  2 Jul 2024 12:24:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EC015D5AB;
	Tue,  2 Jul 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923046; cv=none; b=P5KLws3o3VCUIdh9otbB+cxw9LNaazjS1x9FZMvf9NPgiLr3vMUMHzdKxWPh9Sx8sD1UBo+tZ+Xty8aUjKYVuNamNBytBfoOWLcICXxH6gctKlAGMJnnPMsrnEX3e8uQ5bJN6S1fXLszj00dUUV+qNkFbJEaIXcwXQElX4YEGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923046; c=relaxed/simple;
	bh=ZlcDNI6pGGDPH5HC2e7A4qlmK/71B8n6Njrvg7BCTg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIpqYWMS0/kdobXEqYnzIouafMPIKgXPqDihhr/EzvpRyKSOaXUuFXNX5fS6npvyGff7Hd8u/PUPS16cXpNrbxqfsHVjWBkvAIXFmmpf3F0N2OfOrQiTYy099jnUOqoDZNkzA7HRzytd2ofPrREDiI5vvn2tG+otvaq7ash6KkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA4A339;
	Tue,  2 Jul 2024 05:24:28 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE07A3F762;
	Tue,  2 Jul 2024 05:24:01 -0700 (PDT)
Message-ID: <eee1f654-3719-4965-a7c2-50039a43b586@arm.com>
Date: Tue, 2 Jul 2024 13:23:56 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] iommu: Remove iommu_fwspec ops
To: Saravana Kannan <saravanak@google.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <cover.1718994350.git.robin.murphy@arm.com>
 <CAGETcx-nBb43181Rd4HC6HQF-6=XOufA05e8Zda+LBBfhwvagw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAGETcx-nBb43181Rd4HC6HQF-6=XOufA05e8Zda+LBBfhwvagw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/06/2024 9:51 pm, Saravana Kannan wrote:
> On Fri, Jun 21, 2024 at 8:46 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> v1: https://lore.kernel.org/linux-iommu/cover.1713523251.git.robin.murphy@arm.com
>>
>> Hi all,
>>
>> Here's v2 of this little cleanup, with acks and the additional cosmetic
>> tweak suggested by Andy. There were some slightly non-trivial changes in
>> the rebase so I've left off Jean-Philippe's tested-by from v1, but I've
>> given it a quick spin on arm64 ACPI and DT and all seems well still.
> 
> Hi Robin,
> 
> I see in this series you talk about figuring out if a device has a
> driver that could match. There has been a "can_match" flag in every
> device that's set if a driver that match it is present, but hasn't
> probed the device yet (for whatever reason). Just pointing that out in
> case that makes things a lot easier for you. As of now, we don't
> handle clearing it when the driver is unregistered, but if that really
> needs to be handled, that shouldn't be too difficult.

Thanks, that's interesting to know. I'm not sure it's directly 
applicable here since we have the more general case where the IOMMU 
driver may also be a module that's not even loaded yet. What ultimately 
matters is whether someone has called iommu_device_register() for a 
matching IOMMU instance, or may do within a reasonable timeframe, so as 
long as we can keep relying on fw_devlink and deferred_probe_timeout to 
do most of the heavy lifting then I'd actually hope we can avoid getting 
into the low-level details here.

Cheers,
Robin.

