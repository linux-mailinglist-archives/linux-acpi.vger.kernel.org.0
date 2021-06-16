Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2151F3AA072
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhFPP5a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 11:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234970AbhFPPyt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 11:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623858705;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlBpjk0p11BKeTclm4FcvP2+RtXdSrKcaNlna0enzx0=;
        b=dflUIjwGERgyv1YDJp9SRcIDXTOnvAGQ1HRYgcPC9Bq05S0QrbsqJATw8L65AyPAS6ytnI
        YGKxB1GzIvmCNbVCqBPFp3VSOr1NpLAiMnHH9itjW5X6jogeMNaWd2rKrdCLuKZngz5lvx
        M5+E1QyYdz9wfm3ZormyBNhUp13VNjE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-4AW4xx45MzmkkcKrl9v9Wg-1; Wed, 16 Jun 2021 11:50:54 -0400
X-MC-Unique: 4AW4xx45MzmkkcKrl9v9Wg-1
Received: by mail-wm1-f70.google.com with SMTP id l25-20020a1c79190000b02901c7057f03d1so1407256wme.4
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 08:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=xlBpjk0p11BKeTclm4FcvP2+RtXdSrKcaNlna0enzx0=;
        b=Po3K/Jw1FTP+lS3Qb+Q6wHrJ9DXY8HjNJDTKztiVAt3pbs5xCcuHihd9D71hRJuXDR
         F+bgthryzZZoNL0CD0PAlpP4MTm8Cko/nIX+ezMOi3eDTNu4XZuT2av7aKWHwfK/RLNb
         Zk44NsWDZgysM/+eVC0meStrr7DS1NBqQZ20iTRiSDitctK2CecolNhhdEh1gylpO7nU
         E4ZtpltxsPR6gFnYb7FA7PS0J4n8xRf9skUvzeLPwgPJhdcQe5c8r5GsQhqQ6KXPajeF
         kCbZoAGr/4Mu5WLCn90mPXnN2AhNEpv32nbiHIbdOiA0/s7Ps8vQub6Ul6PvxQo8uglP
         NCVQ==
X-Gm-Message-State: AOAM532qz43RThpYQqMyEAZKKEAMxjsZaqcKraTGFCHgHzawNzlvoaL3
        MxORCROng41fQ+OleT7lPOMCSmBg/9Rblimblv8nLdxvpiV2QVtyMRHG9UjucdVMT12NcPc1iCj
        8/lmt+4g7DXJGkrbTMnlW3g==
X-Received: by 2002:a1c:193:: with SMTP id 141mr12231111wmb.106.1623858653021;
        Wed, 16 Jun 2021 08:50:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9OI2IVADygttdOre09Sy1S+JFXZdlBRd88z8bREst0fh3MJQ4Chz/ONg8Ap86S3zsy0+c3w==
X-Received: by 2002:a1c:193:: with SMTP id 141mr12231096wmb.106.1623858652836;
        Wed, 16 Jun 2021 08:50:52 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
        by smtp.gmail.com with ESMTPSA id g17sm3403307wrh.72.2021.06.16.08.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 08:50:52 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v4 5/6] iommu/dma: Simplify calls to iommu_setup_dma_ops()
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
 <20210610075130.67517-6-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <210dbd62-cd04-209c-eec9-f0a4e706264d@redhat.com>
Date:   Wed, 16 Jun 2021 17:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-6-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> dma-iommu uses the address bounds described in domain->geometry during
> IOVA allocation. The address size parameters of iommu_setup_dma_ops()
> are useful for describing additional limits set by the platform
> firmware, but aren't needed for drivers that call this function from
> probe_finalize(). The base parameter can be zero because dma-iommu
> already removes the first IOVA page, and the limit parameter can be
> U64_MAX because it's only checked against the domain geometry. Simplify
> calls to iommu_setup_dma_ops().
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/amd/iommu.c   |  9 +--------
>  drivers/iommu/dma-iommu.c   |  4 +++-
>  drivers/iommu/intel/iommu.c | 10 +---------
>  3 files changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 94b96d81fcfd..d3123bc05c08 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1708,14 +1708,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  
>  static void amd_iommu_probe_finalize(struct device *dev)
>  {
> -	struct iommu_domain *domain;
> -
> -	/* Domains are initialized for this device - have a look what we ended up with */
> -	domain = iommu_get_domain_for_dev(dev);
> -	if (domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, U64_MAX);
> -	else
> -		set_dma_ops(dev, NULL);
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
>  }
>  
>  static void amd_iommu_release_device(struct device *dev)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c62e19bed302..175f8eaeb5b3 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1322,7 +1322,9 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>  	if (domain->type == IOMMU_DOMAIN_DMA) {
>  		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>  			goto out_err;
> -		dev->dma_ops = &iommu_dma_ops;
> +		set_dma_ops(dev, &iommu_dma_ops);
> +	} else {
> +		set_dma_ops(dev, NULL);
>  	}
>  
>  	return;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 85f18342603c..8d866940692a 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5165,15 +5165,7 @@ static void intel_iommu_release_device(struct device *dev)
>  
>  static void intel_iommu_probe_finalize(struct device *dev)
>  {
> -	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> -
> -	if (domain && domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, base,
> -				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
> -	else
> -		set_dma_ops(dev, NULL);
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
>  }
>  
>  static void intel_iommu_get_resv_regions(struct device *device,

