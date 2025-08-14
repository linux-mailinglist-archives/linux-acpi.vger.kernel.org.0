Return-Path: <linux-acpi+bounces-15684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D4AB26A5B
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7E86222B4
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE361DE3AC;
	Thu, 14 Aug 2025 14:53:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E4533D6;
	Thu, 14 Aug 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183238; cv=none; b=hWNZoiy1Ar9FhWLQ6atAQAHZ+K5GBmVU/7XBmkMqo4Z5tPNP3P4vMUhTJpq+CtZtlbFVT7J1eqLHxuAERiKuzzzVRL7RhHZmmHjqbyqyUH749ZUUA67eJUxGSv1N59xjnnKF+Tf4YKId+Jx/dne3/BrVWOFC2ZBU+PnYg4iwZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183238; c=relaxed/simple;
	bh=mbQT4r7dcTsmDY2GBNqWkAPmBYv5GDEJG3LgdErK4Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=spnCGM68WVNOebn0NOMtem5yAak7KjtKCnmT8HkoO71JtkxqFqfeq6h4QM5+Uy9Az2PYQ51aXhd8Od1pfs5bCQO/n114gDL2Dez6f9pdgYc8Zr5tPg2nxFNHgMcyQYx4dyRm04J93VR/bd57qIqEI5fMq+dvpNKTSXO/59E9bPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B72C1691;
	Thu, 14 Aug 2025 07:53:48 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B09F3F5A1;
	Thu, 14 Aug 2025 07:53:55 -0700 (PDT)
Message-ID: <e3935099-6e29-493d-8587-64ceca8a20e9@arm.com>
Date: Thu, 14 Aug 2025 15:53:43 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu: Fix virtio-iommu probing
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 rafael@kernel.org, bhelgaas@google.com, jgg@ziepe.ca, lpieralisi@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org,
 jean-philippe@linaro.org, jsnitsel@redhat.com
References: <20250814141758.2140641-1-eric.auger@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250814141758.2140641-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2025 3:17 pm, Eric Auger wrote:
> Commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
> probe path") broke virtio-iommu probing and no iommu group are
> produced anymore.
> 
> When probe_iommu_group() gets called viommu_probe_device() fails
> because viommu_get_by_fwnode(fwspec->iommu_fwnode) returns NULL.

...which it's not supposed to. And *now* I remember, we never got this 
finished, did we?

https://lore.kernel.org/linux-iommu/9beaed48da83a0882dba153e65e6cfd0a8e21482.1742484773.git.robin.murphy@arm.com/

Thanks,
Robin.

> So it seems we need to restore the original iommu_probe_device
> call site in acpi_iommu_configure_id() to get a chance to probe
> the device again.
> 
> Maybe this defeats the whole purpose of the original commit but
> at least it fixes the virtio-iommu probing.
> 
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> I also tested smmu probing and this seems to work fine.
> ---
>   drivers/acpi/scan.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fb1fe9f3b1a3..9f4efa8f75a6 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1632,6 +1632,13 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>   		err = viot_iommu_configure(dev);
>   	mutex_unlock(&iommu_probe_device_lock);
>   
> +	/*
> +	 * If we have reason to believe the IOMMU driver missed the initial
> +	 * iommu_probe_device() call for dev, replay it to get things in order.
> +	 */
> +	if (!err && dev->bus)
> +		err = iommu_probe_device(dev);
> +
>   	return err;
>   }
>   


