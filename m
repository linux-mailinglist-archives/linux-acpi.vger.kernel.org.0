Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259F6929DA
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 23:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjBJWJI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 17:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjBJWJG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 17:09:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA57E8FC;
        Fri, 10 Feb 2023 14:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676066942; x=1707602942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sY8OLIIt7+LZVX9JONJjX/aUMbbtvwjmsYGVh+lvMyE=;
  b=X899ru8JBM8nObkgLJzyirddpltaj05mQ1q15GLYRacOtV5iBfo7hjSt
   cfkprwMwtbsZZONlZFE9Ci0RBGmcMmMzNjKE6Z8PWxkkITfAZBEY3lpGu
   PT7josWx23wx0lgIpPL4aTLaVlBt/lv7w76M8D0ypwGr2+FpXlJ0k5VG6
   kzlid+TD7pyeOhz/XyEw91wld2LYWMa+8H+nJd9mZ8Sm24u8m6QjldAW9
   alwO6N0NokRrg7LtGqGmXnQoDiDXEodvW6fgXaqQL17O2cX9ndmVtwB4s
   4U/yAWfNekyXc3Ik+S6YN14bu3korfLyT0lRsyOswsGsDfTabHosESTO3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="330547668"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="330547668"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 14:09:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="842156715"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="842156715"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.190.133]) ([10.213.190.133])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 14:09:01 -0800
Message-ID: <87d18c67-1b6a-6331-fb17-152ce9b7bd88@intel.com>
Date:   Fri, 10 Feb 2023 15:09:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2 18/20] dax/hmem: Move hmem device registration to
 dax_hmem.ko
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Fan Ni <fan.ni@samsung.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <167602002771.1924368.5653558226424530127.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167602002771.1924368.5653558226424530127.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2/10/23 2:07 AM, Dan Williams wrote:
> In preparation for the CXL region driver to take over the responsibility
> of registering device-dax instances for CXL regions, move the
> registration of "hmem" devices to dax_hmem.ko.
> 
> Previously the builtin component of this enabling
> (drivers/dax/hmem/device.o) would register platform devices for each
> address range and trigger the dax_hmem.ko module to load and attach
> device-dax instances to those devices. Now, the ranges are collected
> from the HMAT and EFI memory map walking, but the device creation is
> deferred. A new "hmem_platform" device is created which triggers
> dax_hmem.ko to load and register the platform devices.
> 
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Link: https://lore.kernel.org/r/167564543923.847146.9030380223622044744.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/acpi/numa/hmat.c  |    2 -
>   drivers/dax/Kconfig       |    2 -
>   drivers/dax/hmem/device.c |   91 +++++++++++++++++++--------------------
>   drivers/dax/hmem/hmem.c   |  105 +++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/dax.h       |    7 ++-
>   5 files changed, 155 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index ff24282301ab..bba268ecd802 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -718,7 +718,7 @@ static void hmat_register_target_devices(struct memory_target *target)
>   	for (res = target->memregions.child; res; res = res->sibling) {
>   		int target_nid = pxm_to_node(target->memory_pxm);
>   
> -		hmem_register_device(target_nid, res);
> +		hmem_register_resource(target_nid, res);
>   	}
>   }
>   
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index 5fdf269a822e..d13c889c2a64 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -46,7 +46,7 @@ config DEV_DAX_HMEM
>   	  Say M if unsure.
>   
>   config DEV_DAX_HMEM_DEVICES
> -	depends on DEV_DAX_HMEM && DAX=y
> +	depends on DEV_DAX_HMEM && DAX
>   	def_bool y
>   
>   config DEV_DAX_KMEM
> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index b1b339bccfe5..f9e1a76a04a9 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -8,6 +8,8 @@
>   static bool nohmem;
>   module_param_named(disable, nohmem, bool, 0444);
>   
> +static bool platform_initialized;
> +static DEFINE_MUTEX(hmem_resource_lock);
>   static struct resource hmem_active = {
>   	.name = "HMEM devices",
>   	.start = 0,
> @@ -15,71 +17,66 @@ static struct resource hmem_active = {
>   	.flags = IORESOURCE_MEM,
>   };
>   
> -void hmem_register_device(int target_nid, struct resource *res)
> +int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
> +{
> +	struct resource *res;
> +	int rc = 0;
> +
> +	mutex_lock(&hmem_resource_lock);
> +	for (res = hmem_active.child; res; res = res->sibling) {
> +		rc = fn(host, (int) res->desc, res);
> +		if (rc)
> +			break;
> +	}
> +	mutex_unlock(&hmem_resource_lock);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(walk_hmem_resources);
> +
> +static void __hmem_register_resource(int target_nid, struct resource *res)
>   {
>   	struct platform_device *pdev;
> -	struct memregion_info info;
> -	int rc, id;
> +	struct resource *new;
> +	int rc;
>   
> -	if (nohmem)
> +	new = __request_region(&hmem_active, res->start, resource_size(res), "",
> +			       0);
> +	if (!new) {
> +		pr_debug("hmem range %pr already active\n", res);
>   		return;
> +	}
>   
> -	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> -			       IORES_DESC_SOFT_RESERVED);
> -	if (rc != REGION_INTERSECTS)
> -		return;
> +	new->desc = target_nid;
>   
> -	id = memregion_alloc(GFP_KERNEL);
> -	if (id < 0) {
> -		pr_err("memregion allocation failure for %pr\n", res);
> +	if (platform_initialized)
>   		return;
> -	}
>   
> -	pdev = platform_device_alloc("hmem", id);
> +	pdev = platform_device_alloc("hmem_platform", 0);
>   	if (!pdev) {
> -		pr_err("hmem device allocation failure for %pr\n", res);
> -		goto out_pdev;
> -	}
> -
> -	if (!__request_region(&hmem_active, res->start, resource_size(res),
> -			      dev_name(&pdev->dev), 0)) {
> -		dev_dbg(&pdev->dev, "hmem range %pr already active\n", res);
> -		goto out_active;
> -	}
> -
> -	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
> -	info = (struct memregion_info) {
> -		.target_node = target_nid,
> -		.range = {
> -			.start = res->start,
> -			.end = res->end,
> -		},
> -	};
> -	rc = platform_device_add_data(pdev, &info, sizeof(info));
> -	if (rc < 0) {
> -		pr_err("hmem memregion_info allocation failure for %pr\n", res);
> -		goto out_resource;
> +		pr_err_once("failed to register device-dax hmem_platform device\n");
> +		return;
>   	}
>   
>   	rc = platform_device_add(pdev);
> -	if (rc < 0) {
> -		dev_err(&pdev->dev, "device add failed for %pr\n", res);
> -		goto out_resource;
> -	}
> +	if (rc)
> +		platform_device_put(pdev);
> +	else
> +		platform_initialized = true;
> +}
>   
> -	return;
> +void hmem_register_resource(int target_nid, struct resource *res)
> +{
> +	if (nohmem)
> +		return;
>   
> -out_resource:
> -	__release_region(&hmem_active, res->start, resource_size(res));
> -out_active:
> -	platform_device_put(pdev);
> -out_pdev:
> -	memregion_free(id);
> +	mutex_lock(&hmem_resource_lock);
> +	__hmem_register_resource(target_nid, res);
> +	mutex_unlock(&hmem_resource_lock);
>   }
>   
>   static __init int hmem_register_one(struct resource *res, void *data)
>   {
> -	hmem_register_device(phys_to_target_node(res->start), res);
> +	hmem_register_resource(phys_to_target_node(res->start), res);
>   
>   	return 0;
>   }
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 5025a8c9850b..e7bdff3132fa 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -3,6 +3,7 @@
>   #include <linux/memregion.h>
>   #include <linux/module.h>
>   #include <linux/pfn_t.h>
> +#include <linux/dax.h>
>   #include "../bus.h"
>   
>   static bool region_idle;
> @@ -43,8 +44,110 @@ static struct platform_driver dax_hmem_driver = {
>   	},
>   };
>   
> -module_platform_driver(dax_hmem_driver);
> +static void release_memregion(void *data)
> +{
> +	memregion_free((long) data);
> +}
> +
> +static void release_hmem(void *pdev)
> +{
> +	platform_device_unregister(pdev);
> +}
> +
> +static int hmem_register_device(struct device *host, int target_nid,
> +				const struct resource *res)
> +{
> +	struct platform_device *pdev;
> +	struct memregion_info info;
> +	long id;
> +	int rc;
> +
> +	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			       IORES_DESC_SOFT_RESERVED);
> +	if (rc != REGION_INTERSECTS)
> +		return 0;
> +
> +	id = memregion_alloc(GFP_KERNEL);
> +	if (id < 0) {
> +		dev_err(host, "memregion allocation failure for %pr\n", res);
> +		return -ENOMEM;
> +	}
> +	rc = devm_add_action_or_reset(host, release_memregion, (void *) id);
> +	if (rc)
> +		return rc;
> +
> +	pdev = platform_device_alloc("hmem", id);
> +	if (!pdev) {
> +		dev_err(host, "device allocation failure for %pr\n", res);
> +		return -ENOMEM;
> +	}
> +
> +	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
> +	info = (struct memregion_info) {
> +		.target_node = target_nid,
> +		.range = {
> +			.start = res->start,
> +			.end = res->end,
> +		},
> +	};
> +	rc = platform_device_add_data(pdev, &info, sizeof(info));
> +	if (rc < 0) {
> +		dev_err(host, "memregion_info allocation failure for %pr\n",
> +		       res);
> +		goto out_put;
> +	}
> +
> +	rc = platform_device_add(pdev);
> +	if (rc < 0) {
> +		dev_err(host, "%s add failed for %pr\n", dev_name(&pdev->dev),
> +			res);
> +		goto out_put;
> +	}
> +
> +	return devm_add_action_or_reset(host, release_hmem, pdev);
> +
> +out_put:
> +	platform_device_put(pdev);
> +	return rc;
> +}
> +
> +static int dax_hmem_platform_probe(struct platform_device *pdev)
> +{
> +	return walk_hmem_resources(&pdev->dev, hmem_register_device);
> +}
> +
> +static struct platform_driver dax_hmem_platform_driver = {
> +	.probe = dax_hmem_platform_probe,
> +	.driver = {
> +		.name = "hmem_platform",
> +	},
> +};
> +
> +static __init int dax_hmem_init(void)
> +{
> +	int rc;
> +
> +	rc = platform_driver_register(&dax_hmem_platform_driver);
> +	if (rc)
> +		return rc;
> +
> +	rc = platform_driver_register(&dax_hmem_driver);
> +	if (rc)
> +		platform_driver_unregister(&dax_hmem_platform_driver);
> +
> +	return rc;
> +}
> +
> +static __exit void dax_hmem_exit(void)
> +{
> +	platform_driver_unregister(&dax_hmem_driver);
> +	platform_driver_unregister(&dax_hmem_platform_driver);
> +}
> +
> +module_init(dax_hmem_init);
> +module_exit(dax_hmem_exit);
>   
>   MODULE_ALIAS("platform:hmem*");
> +MODULE_ALIAS("platform:hmem_platform*");
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Intel Corporation");
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 2b5ecb591059..bf6258472e49 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -262,11 +262,14 @@ static inline bool dax_mapping(struct address_space *mapping)
>   }
>   
>   #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
> -void hmem_register_device(int target_nid, struct resource *r);
> +void hmem_register_resource(int target_nid, struct resource *r);
>   #else
> -static inline void hmem_register_device(int target_nid, struct resource *r)
> +static inline void hmem_register_resource(int target_nid, struct resource *r)
>   {
>   }
>   #endif
>   
> +typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
> +			    const struct resource *res);
> +int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
>   #endif
> 
