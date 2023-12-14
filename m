Return-Path: <linux-acpi+bounces-2440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD718139DF
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Dec 2023 19:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CFBB210CA
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Dec 2023 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D168B77;
	Thu, 14 Dec 2023 18:23:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64C69120;
	Thu, 14 Dec 2023 10:22:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77EACC15;
	Thu, 14 Dec 2023 10:23:42 -0800 (PST)
Received: from [10.57.86.13] (unknown [10.57.86.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1D713F738;
	Thu, 14 Dec 2023 10:22:51 -0800 (PST)
Message-ID: <2d87c1dc-cc95-4d92-968c-9d6e6e6439ff@arm.com>
Date: Thu, 14 Dec 2023 18:22:49 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <cover.1702486837.git.robin.murphy@arm.com>
 <5d89190b35720bf5b66621f46b6d3c85323d8eab.1702486837.git.robin.murphy@arm.com>
 <20231214165126.GA3726750@myrica>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231214165126.GA3726750@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-14 4:51 pm, Jean-Philippe Brucker wrote:
> On Wed, Dec 13, 2023 at 05:17:59PM +0000, Robin Murphy wrote:
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 27a167f4cd3e..d808c8dcf5cb 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -1724,25 +1724,20 @@ static const struct dma_map_ops iommu_dma_ops = {
>>   	.opt_mapping_size	= iommu_dma_opt_mapping_size,
>>   };
>>   
>> -/*
>> - * The IOMMU core code allocates the default DMA domain, which the underlying
>> - * IOMMU driver needs to support via the dma-iommu layer.
>> - */
>> -void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>> +void iommu_setup_dma_ops(struct device *dev)
>>   {
>>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>>   
>> -	if (!domain)
>> -		goto out_err;
>> +	if (dev_is_pci(dev))
>> +		dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
>>   
>> -	/*
>> -	 * The IOMMU core code allocates the default DMA domain, which the
>> -	 * underlying IOMMU driver needs to support via the dma-iommu layer.
>> -	 */
>>   	if (iommu_is_dma_domain(domain)) {
> 
> ...
> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 824989874dee..43f630d0530e 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -560,10 +560,10 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>   		if (list_empty(&group->entry))
>>   			list_add_tail(&group->entry, group_list);
>>   	}
>> -	mutex_unlock(&group->mutex);
>>   
>> -	if (dev_is_pci(dev))
>> -		iommu_dma_set_pci_32bit_workaround(dev);
>> +	iommu_setup_dma_ops(dev);
> 
> With Intel VT-d (QEMU emulation) I get a crash in iommu_setup_dma_ops()
> because at this point group->domain and group->default_domain are still
> NULL, group_list is non-NULL.

Ugh, clearly I'd manage to confuse myself, since what I wrote in the
changelog isn't even right...

Taking yet another look, there's not actually one single place we can do
this right now which will work in a manageable way for all cases. With 2
or 3 more levels of mess unpicked it's going to clean up much further
(it's also becoming clear that iommu-dma wants better separation of its
own per-device and per-domain bits), but for the immediate task in this
series of finally getting out of arch code, I guess that continuing to
echo the current probe_finalize flows is going to be safest. Something
like the diff below (but I'll have a further think about it with a fresh
head tomorrow).

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8972b7f22a9a..ba4cd5251205 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -562,7 +562,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
  			list_add_tail(&group->entry, group_list);
  	}
  
-	iommu_setup_dma_ops(dev);
+	if (group->default_domain)
+		iommu_setup_dma_ops(dev);
  
  	mutex_unlock(&group->mutex);
  
@@ -1992,6 +1993,8 @@ int bus_iommu_probe(const struct bus_type *bus)
  			mutex_unlock(&group->mutex);
  			return ret;
  		}
+		for_each_group_device(group, gdev)
+			iommu_setup_dma_ops(gdev->dev);
  		mutex_unlock(&group->mutex);
  
  		/*
@@ -3217,18 +3220,9 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
  	if (ret)
  		goto out_unlock;
  
-	/*
-	 * Release the mutex here because ops->probe_finalize() call-back of
-	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
-	 * in-turn might call back into IOMMU core code, where it tries to take
-	 * group->mutex, resulting in a deadlock.
-	 */
-	mutex_unlock(&group->mutex);
-
  	/* Make sure dma_ops is appropriatley set */
  	for_each_group_device(group, gdev)
-		iommu_group_do_probe_finalize(gdev->dev);
-	return count;
+		iommu_setup_dma_ops(gdev->dev);
  
  out_unlock:
  	mutex_unlock(&group->mutex);

