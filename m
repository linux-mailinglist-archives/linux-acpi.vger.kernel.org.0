Return-Path: <linux-acpi+bounces-1941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A6C7FE33E
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 23:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0002AB20DBE
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 22:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F947A56
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F1EcOt6i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239BDD67
	for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2023 12:50:12 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1fa37df6da8so71663fac.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2023 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701291010; x=1701895810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z14ncuPizPQTpz34E/qdK1zleu0e7/OH8lwfu0qFocg=;
        b=F1EcOt6iBj3aQN+agExfUCk/6FwHrRczkDc9gi5HGDtGGVBgJb4EnxfUHew+kXbVp3
         pMMxJYd9hjXsd4HXBksuJAAuBs82etU0bVSeCNi9pzptcOtzWiZrGdcqgh96MDiMqF5E
         oo3pcNWSAQmHD7aYzQeJExoHKAG+asGv6NmsYusKPuj8lxyOf25tg6nUGRz8/IPqfNF4
         kr4KEQP9O1hgZWdT87ce2gnhOxHs0eejEOyNcKUtbtD8y8Rz2MMZIx9pNx2rBxpvcSce
         n6UR427PMpcEnV6hDui5Q0wjY4TaJ18T0fnuh+oHD3EWKrSTRpLjIjkpjz+m9v977NZe
         DC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701291010; x=1701895810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z14ncuPizPQTpz34E/qdK1zleu0e7/OH8lwfu0qFocg=;
        b=tKtFZ9zkXGReOG+5m1wY8cHIfMjO1AfgTlpivjeM9MRpS5JB/tHG74on6VrhJymSGt
         0MnDyaD29fYQRCdNgdtF6mGkROsV7r6JD2n9wjrzp5btuFK2wj7RtcLXIklvvqVHDvsy
         K5Aw+GCqMVLIYQhc8/RFD2kQE8VLJif6p1VAhBcpx26p+L82d1XGdcA7dDgLqneRVKYU
         hydEHxLXyh4q3iEO07iKG4oq++TwMxNL6i6DHSlp/3pzzNTauak3M2/Xq1R1a5vleVuE
         aKL1kT4AlY13DISl7KNVoYzgEgha/jtAxg9hs5sOcc4/Hy4y0+/mR7u6UKrcjIS2AFb4
         veKw==
X-Gm-Message-State: AOJu0YzyQzPqILOVmuZi7/uiKgKlywATSakBpshyKjIGwfKkFTtLn3Yr
	i3T32B8RosTH8Cegly1aTDIcSA==
X-Google-Smtp-Source: AGHT+IGgKdfE8YcFNMWNxw13U7YpCs8rnHcqlluxJCfOn0tU84fkZFp4MzoV02U2Np+AMlZvjw1IBA==
X-Received: by 2002:a05:6870:d622:b0:1fa:ca3:7069 with SMTP id a34-20020a056870d62200b001fa0ca37069mr20658402oaq.16.1701291009170;
        Wed, 29 Nov 2023 12:50:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id yu6-20020a05687c224600b001fa6ba84054sm1349572oab.55.2023.11.29.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:50:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8RVX-005pjC-Mb;
	Wed, 29 Nov 2023 16:50:07 -0400
Date: Wed, 29 Nov 2023 16:50:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
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
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Message-ID: <20231129205007.GR1312390@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <7fe5a0d2bc855ac38dff326f3e64ba394bc262d4.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe5a0d2bc855ac38dff326f3e64ba394bc262d4.1701268753.git.robin.murphy@arm.com>

On Wed, Nov 29, 2023 at 05:43:03PM +0000, Robin Murphy wrote:
> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
> which means there should be no harm in instead running it off the back
> of iommu_probe_device() itself, as is currently done for x86 and s390
> with .probe_finalize bodges. Pull it all into the main flow properly.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c  |  2 --
>  drivers/iommu/amd/iommu.c    |  8 --------
>  drivers/iommu/dma-iommu.c    | 17 ++++-------------
>  drivers/iommu/dma-iommu.h    |  6 ++++++
>  drivers/iommu/intel/iommu.c  |  7 -------
>  drivers/iommu/iommu.c        |  2 ++
>  drivers/iommu/s390-iommu.c   |  6 ------
>  drivers/iommu/virtio-iommu.c | 10 ----------
>  include/linux/iommu.h        |  7 -------
>  9 files changed, 12 insertions(+), 53 deletions(-)

Yes! That probe_finalize() stuff is not nice

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 824989874dee..3a0901165b69 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -589,6 +589,8 @@ int iommu_probe_device(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	iommu_setup_dma_ops(dev);
> +

I'm pretty sure this should be inside the group mutex lock.

The setting of dev->dma_ops should exactly follow the setting of
group->domain, and all transitions, including from the sysfs override
file should update it, right?

Thus to avoid races agsinst concurrent sysfs this should be locked.

I think you can just put this in iommu_setup_default_domain() and it
will take care of all the cases?

Once in iommu_setup_default_domain() it is easy to call it with the
domain argument and it can know the domain type without using
iommu_is_dma_domain() which is one of the very last few places
checking for the DMA domain type.

Jason

