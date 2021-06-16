Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467DC3AA075
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhFPP5c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 11:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235046AbhFPPzi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 11:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623858779;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6r7FqEyIqGHuXZGRXFsW95199nXnF1UaOlSdhA4lIyc=;
        b=e/w1e5FV69liS2UOxKlZDGCrk8TlUaXgHQdkKHt2WAUYO3zeXlp4CnEy/d8d9oX6326vIW
        Sfc56KF2IfgRMfWHfgP5YptE9C6qEc0BErDbeyW5nWTEOse0nM8u/hWdCB63AYZxkhi4b0
        oBfmLJ7HgcdjqeU4x59DIMcAaz86K5Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-f8oocvAoNOmSnV0xcaTc3w-1; Wed, 16 Jun 2021 11:52:50 -0400
X-MC-Unique: f8oocvAoNOmSnV0xcaTc3w-1
Received: by mail-wr1-f69.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso1456321wrh.12
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 08:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=6r7FqEyIqGHuXZGRXFsW95199nXnF1UaOlSdhA4lIyc=;
        b=bs8s3bioircvI/sMWYyD1rvPTQb1LsyW4WHC0WMhNY5OiY3r1fYfBgegxN02NvkLXi
         dAm+rIlXOYIJWyXTpvfnIis/C+sjmSkpboT+yg9p7NrBy9lz/XDV2c7aVoqQJxICZvJm
         psKsoVwJkw/yVpMi9ABq8yzFPzTi5wROpDvWbwzY1lUCx/DT5T2SfNG45ceLHcRsgt0Z
         aEv7Ou61z8oHTfm++x72Ou/tfvyPwVSfYuPfckXC/iWT+7iItdScdwjD/8h73+DE8cMa
         zTKqnBPS2kZnhiW1ooChAouGJN+wIQNh/83rQvSD5Eo3P0KHsIfROhC70cRa7wPG8lbX
         ntsg==
X-Gm-Message-State: AOAM533xNYelE2Kqme4HxT4XzEfOQjIDc7lnndY5IcYI5zAMSkJuaxq3
        ofBs8QfX2oAuEeYfxupawh/H10gg0f++deNtD+GEAp4yS/3Yop4ZIPGUC/axsK46BmlPTV3WbJ7
        1CtYd1itIEaZaO/BKPMcGHw==
X-Received: by 2002:a5d:64c2:: with SMTP id f2mr55251wri.291.1623858769531;
        Wed, 16 Jun 2021 08:52:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysyzQ5DAqgvGtPQdPC6k1RsxHctJlotRiVdhus3R8J8Yk+bdyOpT1kx5y2o1TBPyLSdtUNPA==
X-Received: by 2002:a5d:64c2:: with SMTP id f2mr55237wri.291.1623858769411;
        Wed, 16 Jun 2021 08:52:49 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
        by smtp.gmail.com with ESMTPSA id c13sm2703348wrb.5.2021.06.16.08.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 08:52:48 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v4 6/6] iommu/virtio: Enable x86 support
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, sebastien.boeuf@intel.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-7-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <9149c79e-6f88-5df5-80e7-4da4cb13d6e1@redhat.com>
Date:   Wed, 16 Jun 2021 17:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-7-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi jean,

On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> With the VIOT support in place, x86 platforms can now use the
> virtio-iommu.
>
> Because the other x86 IOMMU drivers aren't yet ready to use the
> acpi_dma_setup() path, x86 doesn't implement arch_setup_dma_ops() at the
> moment. Similarly to Vt-d and AMD IOMMU, call iommu_setup_dma_ops() from
> probe_finalize().
>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
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
> index 218fe8560e8d..77aee1207ced 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1026,6 +1026,13 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
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
> @@ -1062,6 +1069,7 @@ static struct iommu_ops viommu_ops = {
>  	.iova_to_phys		= viommu_iova_to_phys,
>  	.iotlb_sync		= viommu_iotlb_sync,
>  	.probe_device		= viommu_probe_device,
> +	.probe_finalize		= viommu_probe_finalize,
>  	.release_device		= viommu_release_device,
>  	.device_group		= viommu_device_group,
>  	.get_resv_regions	= viommu_get_resv_regions,

