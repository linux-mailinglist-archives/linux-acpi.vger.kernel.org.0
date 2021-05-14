Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE553809A0
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 14:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhENMfe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 08:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233019AbhENMfd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 08:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620995662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBw7gIpngSLTMJRgkqlTDn2EW5sfHupDmKkTQSBDQu8=;
        b=MHCYOJELwyyQYR8uLpNmdjOAmo2hX0Xl+ldVvIrWRE4eJCOnnsAsrTjrn65uMAd2JEvpPW
        wYpLUjXblOJlEcjtGfpnQvei8UJTuws0g4qEDSexZcS7JkQABGlTmQXHNeY8yoA9LYIg5z
        d7DNYgPctPscp5YoidXgk3OE5uVNldg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-bakDhKm6NByA7Kmxx29vjw-1; Fri, 14 May 2021 08:34:19 -0400
X-MC-Unique: bakDhKm6NByA7Kmxx29vjw-1
Received: by mail-wr1-f71.google.com with SMTP id 36-20020adf91a70000b029010ec34b3f27so4473751wri.10
        for <linux-acpi@vger.kernel.org>; Fri, 14 May 2021 05:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yBw7gIpngSLTMJRgkqlTDn2EW5sfHupDmKkTQSBDQu8=;
        b=RhQ5qrmNcwBl5S3Q6wkCZrAZ7i7GRB4Who8Muhwtlba/yCHMklHclkloR78ate5tH4
         0FlX2fW/5lgQeq8nIYhx1dxsoTdQlcOdocMIod0geoctEzncGVKParSS+Tn1Vny/Eem6
         h7i17H5ft3OjZY/G1CL3U3OIlgP6NlyPuzianYScLT4twL439jRMJdZXc9uBs8mmw58i
         em4L5+RDzm+1cMukKczoupZfcU2KCenfeTGjORp5jtVRmdqCH8/ujI4LVDX9m/j51JQV
         80rRsvN5eEAgY1AsoaelD4eBFp6w3pZDlpRqIZl4FjtYOx4ymiVlyv0IELwGr5UfS1pZ
         9auA==
X-Gm-Message-State: AOAM531cN0V/JgWRsN83muRK+CgeZpFqOOhKgSkbpGH3PN+NysBBZ3h1
        Ahc8rNrY29BopBu24SOLbRsxUclBySeqNnYRFuMC5tGU73vJKGjMToKtvvgrpDOo4rmEfBfc4V8
        XzyGlE+PVdYoLHmCDcFy3GA==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr27822633wmq.138.1620995657884;
        Fri, 14 May 2021 05:34:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFPlnSw9Rc/MJc1oJZloOpaijmqBpFKdogoBEFMFg1dOVUteKbEaiQtObG1YSFXWGviULp6Q==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr27822619wmq.138.1620995657750;
        Fri, 14 May 2021 05:34:17 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
        by smtp.gmail.com with ESMTPSA id j13sm7360302wrd.81.2021.05.14.05.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:34:17 -0700 (PDT)
Date:   Fri, 14 May 2021 08:34:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com
Subject: Re: [PATCH v2 6/6] iommu/virtio: Enable x86 support
Message-ID: <20210514083402-mutt-send-email-mst@kernel.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
 <20210423113836.3974972-7-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423113836.3974972-7-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2021 at 01:38:37PM +0200, Jean-Philippe Brucker wrote:
> With the VIOT support in place, x86 platforms can now use the
> virtio-iommu.
> 
> Because the other x86 IOMMU drivers aren't yet ready to use the
> acpi_dma_setup() path, x86 doesn't implement arch_setup_dma_ops() at the
> moment. Similarly to Vt-d and AMD IOMMU, call iommu_setup_dma_ops() from
> probe_finalize().
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/iommu/Kconfig        | 3 ++-
>  drivers/iommu/dma-iommu.c    | 1 +
>  drivers/iommu/virtio-iommu.c | 8 ++++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index aff8a4830dd1..07b7c25cbed8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -400,8 +400,9 @@ config HYPERV_IOMMU
>  config VIRTIO_IOMMU
>  	tristate "Virtio IOMMU driver"
>  	depends on VIRTIO
> -	depends on ARM64
> +	depends on (ARM64 || X86)
>  	select IOMMU_API
> +	select IOMMU_DMA
>  	select INTERVAL_TREE
>  	select ACPI_VIOT if ACPI
>  	help
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 175f8eaeb5b3..46ed43c400cf 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1332,6 +1332,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>  	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
>  		 dev_name(dev));
>  }
> +EXPORT_SYMBOL_GPL(iommu_setup_dma_ops);
>  
>  static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  		phys_addr_t msi_addr, struct iommu_domain *domain)
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 29a397c2d12f..8be546a338e7 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1027,6 +1027,13 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
>  	return ERR_PTR(ret);
>  }
>  
> +static void viommu_probe_finalize(struct device *dev)
> +{
> +#ifndef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
> +#endif
> +}
> +
>  static void viommu_release_device(struct device *dev)
>  {
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> @@ -1063,6 +1070,7 @@ static struct iommu_ops viommu_ops = {
>  	.iova_to_phys		= viommu_iova_to_phys,
>  	.iotlb_sync		= viommu_iotlb_sync,
>  	.probe_device		= viommu_probe_device,
> +	.probe_finalize		= viommu_probe_finalize,
>  	.release_device		= viommu_release_device,
>  	.device_group		= viommu_device_group,
>  	.get_resv_regions	= viommu_get_resv_regions,
> -- 
> 2.31.1

