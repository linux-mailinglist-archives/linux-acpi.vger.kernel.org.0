Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF83A9640
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhFPJh0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 05:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231491AbhFPJh0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 05:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623836119;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7/u+qiQjFNpBGBnU8PkqwDI2pL2rL4MnC0nLS1qI/c=;
        b=OOB2YPXPRyk7Go7Cg4YlIyPtpdaNLU9GxpTnoEfiVz/0Y4pXJcbLN3efWyxrTgrJTFZUHU
        sEqX9BNdL7OxMrzHzIixihHRLo/Llr75CcfsSuAjXc0UGw3AX2uwcvkcbYWknm021WZTDp
        eB7SwqNTCAhlzobL2RW6gqK7a8qBwps=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-k_Ba9lCAOxKHw1mnf3e1Sw-1; Wed, 16 Jun 2021 05:35:18 -0400
X-MC-Unique: k_Ba9lCAOxKHw1mnf3e1Sw-1
Received: by mail-wr1-f72.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso850543wrf.4
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 02:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=k7/u+qiQjFNpBGBnU8PkqwDI2pL2rL4MnC0nLS1qI/c=;
        b=s1eIM32mKxGAjfV6MpI8oOFU0rDvA24klULEP4wD8lkhLl0QzdCDx1RgRAE9HkSqud
         0h5UhATzr3rh2CGG8UvEHzCxIIY0utD51Vp1Bk54I9Ra1hpGRe/lAGi8B1SMGCBBkqvw
         wJazsymZeS/sJ98qDA/q15tLWCgkLZmMmwJlVmEk9Zbuygg3AlZg4M8ODPZc8w5YgR5n
         vdCFTbwK/cFCoQ3JFFfyGVmeISRoWE/XqoYwvG6CYArSa80CVOcuj9xX+TQiMaA0jMGc
         VDdHg6q0ssrHzj5l8iiOdDntHEcU/5xvoPzFOWAAPRUKeuLCqWhP6OTmg7kKymvSfcSQ
         hNiA==
X-Gm-Message-State: AOAM530yjy4BlEUHWvO5zW0HuDwaK6nMmw/+bqJq7G94/L7oJa+CUmdD
        /rTaRii0ZXSvKdQCfOzkW5/AODvId9BO+WdJvyKFuEBn4yH48K4vw/y9q98awYcx5NNei/iu+HS
        ssZtQQs0519B5yb9bpmjgFA==
X-Received: by 2002:a1c:6782:: with SMTP id b124mr10020536wmc.159.1623836117000;
        Wed, 16 Jun 2021 02:35:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxvvMH/+LmgMRAdfEY93e6GDqPoP4oWvvF9Q5FV5jkTeLRPfDg3ObfEPDZATLgLlz773b36w==
X-Received: by 2002:a1c:6782:: with SMTP id b124mr10020505wmc.159.1623836116725;
        Wed, 16 Jun 2021 02:35:16 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
        by smtp.gmail.com with ESMTPSA id c21sm1283902wme.38.2021.06.16.02.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 02:35:16 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v4 2/6] ACPI: Move IOMMU setup code out of IORT
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
 <20210610075130.67517-3-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <2c53c9cf-43e6-11c2-6ee3-530ad1f87aec@redhat.com>
Date:   Wed, 16 Jun 2021 11:35:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-3-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi jean,
On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> Extract the code that sets up the IOMMU infrastructure from IORT, since
> it can be reused by VIOT. Move it one level up into a new
> acpi_iommu_configure_id() function, which calls the IORT parsing
> function which in turn calls the acpi_iommu_fwspec_init() helper.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/acpi/acpi_bus.h   |  3 ++
>  include/linux/acpi_iort.h |  8 ++---
>  drivers/acpi/arm64/iort.c | 75 +++++----------------------------------
>  drivers/acpi/scan.c       | 73 ++++++++++++++++++++++++++++++++++++-
>  4 files changed, 87 insertions(+), 72 deletions(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a82faac5767..41f092a269f6 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -588,6 +588,9 @@ struct acpi_pci_root {
>  
>  bool acpi_dma_supported(struct acpi_device *adev);
>  enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
> +int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> +			   struct fwnode_handle *fwnode,
> +			   const struct iommu_ops *ops);
>  int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>  		       u64 *size);
>  int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f7f054833afd..f1f0842a2cb2 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -35,8 +35,7 @@ void acpi_configure_pmsi_domain(struct device *dev);
>  int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *id_in);
> +int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>  #else
> @@ -50,9 +49,8 @@ static inline void acpi_configure_pmsi_domain(struct device *dev) { }
>  /* IOMMU interface */
>  static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
>  { return -ENODEV; }
> -static inline const struct iommu_ops *iort_iommu_configure_id(
> -				      struct device *dev, const u32 *id_in)
> -{ return NULL; }
> +static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
> +{ return -ENODEV; }
>  static inline
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  { return 0; }
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index a940be1cf2af..b5b021e064b6 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -806,23 +806,6 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  	return NULL;
>  }
>  
> -static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
> -{
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
> -}
> -
> -static inline int iort_add_device_replay(struct device *dev)
> -{
> -	int err = 0;
> -
> -	if (dev->bus && !device_iommu_mapped(dev))
> -		err = iommu_probe_device(dev);
> -
> -	return err;
> -}
> -
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()
> @@ -900,18 +883,6 @@ static inline bool iort_iommu_driver_enabled(u8 type)
>  	}
>  }
>  
> -static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
> -			       struct fwnode_handle *fwnode,
> -			       const struct iommu_ops *ops)
> -{
> -	int ret = iommu_fwspec_init(dev, fwnode, ops);
> -
> -	if (!ret)
> -		ret = iommu_fwspec_add_ids(dev, &streamid, 1);
> -
> -	return ret;
> -}
> -
>  static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
>  {
>  	struct acpi_iort_root_complex *pci_rc;
> @@ -946,7 +917,7 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
>  		return iort_iommu_driver_enabled(node->type) ?
>  		       -EPROBE_DEFER : -ENODEV;
>  
> -	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
> +	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
>  }
>  
>  struct iort_pci_alias_info {
> @@ -1020,24 +991,14 @@ static int iort_nc_iommu_map_id(struct device *dev,
>   * @dev: device to configure
>   * @id_in: optional input id const value pointer
>   *
> - * Returns: iommu_ops pointer on configuration success
> - *          NULL on configuration failure
> + * Returns: 0 on success, <0 on failure
>   */
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *id_in)
> +int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>  {
>  	struct acpi_iort_node *node;
> -	const struct iommu_ops *ops;
> +	const struct iommu_ops *ops = NULL;
>  	int err = -ENODEV;
>  
> -	/*
> -	 * If we already translated the fwspec there
> -	 * is nothing left to do, return the iommu_ops.
> -	 */
> -	ops = iort_fwspec_iommu_ops(dev);
> -	if (ops)
> -		return ops;
> -
>  	if (dev_is_pci(dev)) {
>  		struct iommu_fwspec *fwspec;
>  		struct pci_bus *bus = to_pci_dev(dev)->bus;
> @@ -1046,7 +1007,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>  				      iort_match_node_callback, &bus->dev);
>  		if (!node)
> -			return NULL;
> +			return -ENODEV;
>  
>  		info.node = node;
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
> @@ -1059,7 +1020,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>  				      iort_match_node_callback, dev);
>  		if (!node)
> -			return NULL;
> +			return -ENODEV;
>  
>  		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
>  			      iort_nc_iommu_map(dev, node);
> @@ -1068,32 +1029,14 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  			iort_named_component_init(dev, node);
>  	}
>  
> -	/*
> -	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * add_device callback for dev, replay it to get things in order.
> -	 */
> -	if (!err) {
> -		ops = iort_fwspec_iommu_ops(dev);
> -		err = iort_add_device_replay(dev);
> -	}
> -
> -	/* Ignore all other errors apart from EPROBE_DEFER */
> -	if (err == -EPROBE_DEFER) {
> -		ops = ERR_PTR(err);
> -	} else if (err) {
> -		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> -		ops = NULL;
> -	}
> -
> -	return ops;
> +	return err;
>  }
>  
>  #else
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  { return 0; }
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *input_id)
> -{ return NULL; }
> +int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
> +{ return -ENODEV; }
>  #endif
>  
>  static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ea613df8f913..0c53c8533300 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/iommu.h>
>  #include <linux/signal.h>
>  #include <linux/kthread.h>
>  #include <linux/dmi.h>
> @@ -1520,6 +1521,76 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>  	return ret >= 0 ? 0 : ret;
>  }
>  
> +#ifdef CONFIG_IOMMU_API
> +int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> +			   struct fwnode_handle *fwnode,
> +			   const struct iommu_ops *ops)
> +{
> +	int ret = iommu_fwspec_init(dev, fwnode, ops);
> +
> +	if (!ret)
> +		ret = iommu_fwspec_add_ids(dev, &id, 1);
> +
> +	return ret;
> +}
> +
> +static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	return fwspec ? fwspec->ops : NULL;
> +}
> +
> +static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
> +						       const u32 *id_in)
> +{
> +	int err;
> +	const struct iommu_ops *ops;
> +
> +	/*
> +	 * If we already translated the fwspec there is nothing left to do,
> +	 * return the iommu_ops.
> +	 */
> +	ops = acpi_iommu_fwspec_ops(dev);
> +	if (ops)
> +		return ops;
> +
> +	err = iort_iommu_configure_id(dev, id_in);
> +
> +	/*
> +	 * If we have reason to believe the IOMMU driver missed the initial
> +	 * add_device callback for dev, replay it to get things in order.
> +	 */
> +	if (!err && dev->bus && !device_iommu_mapped(dev))
> +		err = iommu_probe_device(dev);
Previously we had:
    if (!err) {
        ops = iort_fwspec_iommu_ops(dev);
        err = iort_add_device_replay(dev);
    }

Please can you explain the transform? I see the

acpi_iommu_fwspec_ops call below but is it not straightforward to me.
Also the comment mentions replay. Unsure if it is still OK.

> +
> +	/* Ignore all other errors apart from EPROBE_DEFER */
> +	if (err == -EPROBE_DEFER) {
> +		return ERR_PTR(err);
> +	} else if (err) {
> +		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> +		return NULL;
> +	}
> +	return acpi_iommu_fwspec_ops(dev);
> +}
> +
> +#else /* !CONFIG_IOMMU_API */
> +
> +int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> +			   struct fwnode_handle *fwnode,
> +			   const struct iommu_ops *ops)
> +{
> +	return -ENODEV;
> +}
> +
> +static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
> +						       const u32 *id_in)
> +{
> +	return NULL;
> +}
> +
> +#endif /* !CONFIG_IOMMU_API */
> +
>  /**
>   * acpi_dma_configure_id - Set-up DMA configuration for the device.
>   * @dev: The pointer to the device
> @@ -1539,7 +1610,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>  
>  	acpi_arch_dma_setup(dev, &dma_addr, &size);
>  
> -	iommu = iort_iommu_configure_id(dev, input_id);
> +	iommu = acpi_iommu_configure_id(dev, input_id);
>  	if (PTR_ERR(iommu) == -EPROBE_DEFER)
>  		return -EPROBE_DEFER;
>  
Thanks

Eric

