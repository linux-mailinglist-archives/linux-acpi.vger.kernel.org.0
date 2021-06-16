Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170973A9F13
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhFPPbM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 11:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234357AbhFPPbL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 11:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623857344;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loHXjaH+snUizquVOGFXdAGS2wFtAssCuoNUK+zEZXk=;
        b=TXi/6nJw86/t3k2D3a7cncIq0aX0hGPD3zU8AshgcpyvqMRiPw62rKFgts4pEih+CL5mR3
        vwpH+Prm0+Jc+YcJshPxC8H1AgBvl6gMDkijosly7hEgxzEjixxljaBIXdSP3kZqPh3pPg
        adyReHfVIUpd2F4mxPbnJ4kVC9uqZ20=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-v0X9FL_RNw6O6ZdhIY6Ulg-1; Wed, 16 Jun 2021 11:29:03 -0400
X-MC-Unique: v0X9FL_RNw6O6ZdhIY6Ulg-1
Received: by mail-wr1-f72.google.com with SMTP id y12-20020adffa4c0000b0290119c11bd29eso1441665wrr.2
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 08:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=loHXjaH+snUizquVOGFXdAGS2wFtAssCuoNUK+zEZXk=;
        b=mt/bLI6IRHcErYraKhd+VGhdovhINEzIm/miUcs11tvBsTwRbl9E1nQPYg2Vm4UT+P
         24qWxSQ8aHlTUdQaMG5+o0nM8A27HpmFzHa4Q//MQakvtP/X27+P5tWJ+Y6/WufL9fnF
         5JJvqp+avDenz51HXeRg9mo5S5JILStGq9yOmiHxhLUIx0O5mdwYeDdzt7yTrdLl+nLY
         /55hxompjjltO0mXrNPtOn6PDzicmQUr6VVMzVnqCuqle1Y4szIs6kt6DfRA6p1hVc7l
         t/sI7nUfY/4SEGN7r6xlbypbH5HGIQ8vyK5nvanyI1JxEJjQwjnTlKOkiPeyuu+FmwuT
         6B3A==
X-Gm-Message-State: AOAM530CfUHHqMDmLsLi9/XtOZQditbXn0SfA8GYtcLsZlWznUDbeaFP
        5+DjyaYsSg9ch2fPMkNnLRVCl49hZlcCiQ7l05R9CO5N0ESUcJYyLfqL/wkBM9tNVXGeYyoXvj1
        LhWTJR2kp06moHaKAQuc+BA==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr6214501wru.77.1623857342707;
        Wed, 16 Jun 2021 08:29:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww2Pu5vVjE6MjPOz8ZmDG/gXcWdwBxOIwn5bdbiZvyd47pKBtqNWTde6Bs/ZdGOQmWSbzHnw==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr6214481wru.77.1623857342495;
        Wed, 16 Jun 2021 08:29:02 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
        by smtp.gmail.com with ESMTPSA id 25sm5158567wmk.20.2021.06.16.08.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 08:29:02 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v4 4/6] iommu/dma: Pass address limit rather than size to
 iommu_setup_dma_ops()
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
 <20210610075130.67517-5-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <6d139529-9539-fbe4-8f85-da39461047ba@redhat.com>
Date:   Wed, 16 Jun 2021 17:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-5-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> Passing a 64-bit address width to iommu_setup_dma_ops() is valid on
> virtual platforms, but isn't currently possible. The overflow check in
> iommu_dma_init_domain() prevents this even when @dma_base isn't 0. Pass
> a limit address instead of a size, so callers don't have to fake a size
> to work around the check.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/linux/dma-iommu.h   |  4 ++--
>  arch/arm64/mm/dma-mapping.c |  2 +-
>  drivers/iommu/amd/iommu.c   |  2 +-
>  drivers/iommu/dma-iommu.c   | 12 ++++++------
>  drivers/iommu/intel/iommu.c |  2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 6e75a2d689b4..758ca4694257 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -19,7 +19,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
>  void iommu_put_dma_cookie(struct iommu_domain *domain);
>  
>  /* Setup call for arch DMA mapping code */
> -void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size);
> +void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
>  
>  /* The DMA API isn't _quite_ the whole story, though... */
>  /*
> @@ -50,7 +50,7 @@ struct msi_msg;
>  struct device;
>  
>  static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
> -		u64 size)
> +				       u64 dma_limit)
>  {
>  }
>  
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 4bf1dd3eb041..7bd1d2199141 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -50,7 +50,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  
>  	dev->dma_coherent = coherent;
>  	if (iommu)
> -		iommu_setup_dma_ops(dev, dma_base, size);
> +		iommu_setup_dma_ops(dev, dma_base, size - dma_base - 1);
I don't get  size - dma_base - 1?
>  
>  #ifdef CONFIG_XEN
>  	if (xen_swiotlb_detect())
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 3ac42bbdefc6..94b96d81fcfd 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1713,7 +1713,7 @@ static void amd_iommu_probe_finalize(struct device *dev)
>  	/* Domains are initialized for this device - have a look what we ended up with */
>  	domain = iommu_get_domain_for_dev(dev);
>  	if (domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, 0);
> +		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, U64_MAX);
>  	else
>  		set_dma_ops(dev, NULL);
>  }
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7bcdd1205535..c62e19bed302 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -319,16 +319,16 @@ static bool dev_is_untrusted(struct device *dev)
>   * iommu_dma_init_domain - Initialise a DMA mapping domain
>   * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>   * @base: IOVA at which the mappable address space starts
> - * @size: Size of IOVA space
> + * @limit: Last address of the IOVA space
>   * @dev: Device the domain is being initialised for
>   *
> - * @base and @size should be exact multiples of IOMMU page granularity to
> + * @base and @limit + 1 should be exact multiples of IOMMU page granularity to
>   * avoid rounding surprises. If necessary, we reserve the page at address 0
>   * to ensure it is an invalid IOVA. It is safe to reinitialise a domain, but
>   * any change which could make prior IOVAs invalid will fail.
>   */
>  static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> -		u64 size, struct device *dev)
> +				 dma_addr_t limit, struct device *dev)
>  {
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	unsigned long order, base_pfn;
> @@ -346,7 +346,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  	/* Check the domain allows at least some access to the device... */
>  	if (domain->geometry.force_aperture) {
>  		if (base > domain->geometry.aperture_end ||
> -		    base + size <= domain->geometry.aperture_start) {
> +		    limit < domain->geometry.aperture_start) {
>  			pr_warn("specified DMA range outside IOMMU capability\n");
>  			return -EFAULT;
>  		}
> @@ -1308,7 +1308,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>   * The IOMMU core code allocates the default DMA domain, which the underlying
>   * IOMMU driver needs to support via the dma-iommu layer.
>   */
> -void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size)
> +void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>  {
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>  
> @@ -1320,7 +1320,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size)
>  	 * underlying IOMMU driver needs to support via the dma-iommu layer.
>  	 */
>  	if (domain->type == IOMMU_DOMAIN_DMA) {
> -		if (iommu_dma_init_domain(domain, dma_base, size, dev))
> +		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>  			goto out_err;
>  		dev->dma_ops = &iommu_dma_ops;
>  	}
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index be35284a2016..85f18342603c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5171,7 +5171,7 @@ static void intel_iommu_probe_finalize(struct device *dev)
>  
>  	if (domain && domain->type == IOMMU_DOMAIN_DMA)
>  		iommu_setup_dma_ops(dev, base,
> -				    __DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);
> +				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
>  	else
>  		set_dma_ops(dev, NULL);
>  }
Thanks

Eric

