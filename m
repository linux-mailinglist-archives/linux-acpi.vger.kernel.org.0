Return-Path: <linux-acpi+bounces-2427-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF08136EB
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Dec 2023 17:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345871F21273
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Dec 2023 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A561FB0;
	Thu, 14 Dec 2023 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DR8rOima"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F71BFF
	for <linux-acpi@vger.kernel.org>; Thu, 14 Dec 2023 08:51:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3363eba94ebso1522481f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 14 Dec 2023 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702572678; x=1703177478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Usgg76jsYIefadLxnuqF6rdoT8QTltStQ3cD7RxnFLY=;
        b=DR8rOimajl1BKgv9Za9Env3gqsag2S+MtD4mQLR3wB5Z5jV9R55vgpJsQNJm2dkbL9
         HhJtlKfs8gG0axuKPmLOSfN4L5VWVezvfIeDqLkymBvnp1A5xC32WZtp54ldQeNzBuAm
         Vl9nPIIBztsUsxbRMWR8Nl4zcDJd/Q5DPVw36mEKqa4sYw0ouseXWQIKg8flyb8LjZAS
         XPrp5oxPXKG+bl1lGPq223WRlZkh3o2Hk0hG6ElQLLsA4BQoC+YWc3iVECSSsyGY0do9
         dYvM6DIm5zHg9OnQyT0YnlcFFv6OFPGuCqoNPFoFYJ4/JT1cN0zaG9GJFkjL65tpJsjA
         srpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572678; x=1703177478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Usgg76jsYIefadLxnuqF6rdoT8QTltStQ3cD7RxnFLY=;
        b=CeIWbB27r+YkqZZSdichlI0tQr7ouxN+HpIuIZAJotVt3o14lMSr6E/LYWLWKscdip
         2WhUuOpJhFRg837h4QXNn7pRdM5UX6+OgNy9OTyuP2pVVyTX0+xI3ceKdLYauY0rcOx9
         4PW/47XR8OqTxtZQk/xu0l6KnB4lBbgizNeTaQMBSyNweOkjry8K1qJoC0Y6SBwnkucH
         3eEjYxzv5Mca2yIj/DbkOoTjB1TgiqSDiFCZ3UpHOqFIdpkeuOL7jdXluwMFY/pl/43H
         TNzc9FhQCxm3Q9zLTHlGyJ6i/tzIoUDuXWtSGDtQxlBz+xnmeVfC+Tv01pCPDrAcJn2D
         g6Gw==
X-Gm-Message-State: AOJu0Yy0cfsb+4ZUMb4h4yp6UQEsG5/Rja/26BT7Ocw537bruXbXNXx8
	usV7MmTA4PIe6mm452ucBX7MMg==
X-Google-Smtp-Source: AGHT+IFBMhJj6OgBJFoBT/wwSuMBs9mGXlacijvXWzHs6AsF1SDBWLDmS4Y/dcB+WWbQ8eP+CZ35gg==
X-Received: by 2002:a05:6000:1e8e:b0:336:4256:c7d7 with SMTP id dd14-20020a0560001e8e00b003364256c7d7mr632414wrb.111.1702572678542;
        Thu, 14 Dec 2023 08:51:18 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id q18-20020adff952000000b0033609b71825sm16076369wrr.35.2023.12.14.08.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:51:18 -0800 (PST)
Date: Thu, 14 Dec 2023 16:51:26 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Message-ID: <20231214165126.GA3726750@myrica>
References: <cover.1702486837.git.robin.murphy@arm.com>
 <5d89190b35720bf5b66621f46b6d3c85323d8eab.1702486837.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d89190b35720bf5b66621f46b6d3c85323d8eab.1702486837.git.robin.murphy@arm.com>

On Wed, Dec 13, 2023 at 05:17:59PM +0000, Robin Murphy wrote:
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 27a167f4cd3e..d808c8dcf5cb 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1724,25 +1724,20 @@ static const struct dma_map_ops iommu_dma_ops = {
>  	.opt_mapping_size	= iommu_dma_opt_mapping_size,
>  };
>  
> -/*
> - * The IOMMU core code allocates the default DMA domain, which the underlying
> - * IOMMU driver needs to support via the dma-iommu layer.
> - */
> -void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
> +void iommu_setup_dma_ops(struct device *dev)
>  {
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>  
> -	if (!domain)
> -		goto out_err;
> +	if (dev_is_pci(dev))
> +		dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
>  
> -	/*
> -	 * The IOMMU core code allocates the default DMA domain, which the
> -	 * underlying IOMMU driver needs to support via the dma-iommu layer.
> -	 */
>  	if (iommu_is_dma_domain(domain)) {

...

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 824989874dee..43f630d0530e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -560,10 +560,10 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  		if (list_empty(&group->entry))
>  			list_add_tail(&group->entry, group_list);
>  	}
> -	mutex_unlock(&group->mutex);
>  
> -	if (dev_is_pci(dev))
> -		iommu_dma_set_pci_32bit_workaround(dev);
> +	iommu_setup_dma_ops(dev);

With Intel VT-d (QEMU emulation) I get a crash in iommu_setup_dma_ops()
because at this point group->domain and group->default_domain are still
NULL, group_list is non-NULL.

No problem with x86 virtio-iommu, it goes through
iommu_setup_default_domain() earlier in the function. Arm virtio-iommu is
fine too.

Thanks,
Jean


