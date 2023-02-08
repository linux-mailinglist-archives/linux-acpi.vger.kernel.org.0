Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8668F5CD
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 18:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjBHRlI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 12:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjBHRkx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 12:40:53 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ED34FC32;
        Wed,  8 Feb 2023 09:37:31 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PBn8p4F8qz6J7Hp;
        Thu,  9 Feb 2023 01:31:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Feb
 2023 17:35:32 +0000
Date:   Wed, 8 Feb 2023 17:35:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 15/18] dax/hmem: Convey the dax range via
 memregion_info()
Message-ID: <20230208173531.00000687@Huawei.com>
In-Reply-To: <167564543303.847146.11045895213318648441.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564543303.847146.11045895213318648441.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, 05 Feb 2023 17:03:53 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for hmem platform devices to be unregistered, stop using
> platform_device_add_resources() to convey the address range. The
> platform_device_add_resources() API causes an existing "Soft Reserved"
> iomem resource to be re-parented under an inserted platform device
> resource. When that platform device is deleted it removes the platform
> device resource and all children.
> 
> Instead, it is sufficient to convey just the address range and let
> request_mem_region() insert resources to indicate the devices active in
> the range. This allows the "Soft Reserved" resource to be re-enumerated
> upon the next probe event.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Seems sensible to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/dax/hmem/device.c |   37 ++++++++++++++-----------------------
>  drivers/dax/hmem/hmem.c   |   14 +++-----------
>  include/linux/memregion.h |    2 ++
>  3 files changed, 19 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index 20749c7fab81..b1b339bccfe5 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -15,15 +15,8 @@ static struct resource hmem_active = {
>  	.flags = IORESOURCE_MEM,
>  };
>  
> -void hmem_register_device(int target_nid, struct resource *r)
> +void hmem_register_device(int target_nid, struct resource *res)
>  {
> -	/* define a clean / non-busy resource for the platform device */
> -	struct resource res = {
> -		.start = r->start,
> -		.end = r->end,
> -		.flags = IORESOURCE_MEM,
> -		.desc = IORES_DESC_SOFT_RESERVED,
> -	};
>  	struct platform_device *pdev;
>  	struct memregion_info info;
>  	int rc, id;
> @@ -31,55 +24,53 @@ void hmem_register_device(int target_nid, struct resource *r)
>  	if (nohmem)
>  		return;
>  
> -	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
> -			IORES_DESC_SOFT_RESERVED);
> +	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			       IORES_DESC_SOFT_RESERVED);
>  	if (rc != REGION_INTERSECTS)
>  		return;
>  
>  	id = memregion_alloc(GFP_KERNEL);
>  	if (id < 0) {
> -		pr_err("memregion allocation failure for %pr\n", &res);
> +		pr_err("memregion allocation failure for %pr\n", res);
>  		return;
>  	}
>  
>  	pdev = platform_device_alloc("hmem", id);
>  	if (!pdev) {
> -		pr_err("hmem device allocation failure for %pr\n", &res);
> +		pr_err("hmem device allocation failure for %pr\n", res);
>  		goto out_pdev;
>  	}
>  
> -	if (!__request_region(&hmem_active, res.start, resource_size(&res),
> +	if (!__request_region(&hmem_active, res->start, resource_size(res),
>  			      dev_name(&pdev->dev), 0)) {
> -		dev_dbg(&pdev->dev, "hmem range %pr already active\n", &res);
> +		dev_dbg(&pdev->dev, "hmem range %pr already active\n", res);
>  		goto out_active;
>  	}
>  
>  	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
>  	info = (struct memregion_info) {
>  		.target_node = target_nid,
> +		.range = {
> +			.start = res->start,
> +			.end = res->end,
> +		},
>  	};
>  	rc = platform_device_add_data(pdev, &info, sizeof(info));
>  	if (rc < 0) {
> -		pr_err("hmem memregion_info allocation failure for %pr\n", &res);
> -		goto out_resource;
> -	}
> -
> -	rc = platform_device_add_resources(pdev, &res, 1);
> -	if (rc < 0) {
> -		pr_err("hmem resource allocation failure for %pr\n", &res);
> +		pr_err("hmem memregion_info allocation failure for %pr\n", res);
>  		goto out_resource;
>  	}
>  
>  	rc = platform_device_add(pdev);
>  	if (rc < 0) {
> -		dev_err(&pdev->dev, "device add failed for %pr\n", &res);
> +		dev_err(&pdev->dev, "device add failed for %pr\n", res);
>  		goto out_resource;
>  	}
>  
>  	return;
>  
>  out_resource:
> -	__release_region(&hmem_active, res.start, resource_size(&res));
> +	__release_region(&hmem_active, res->start, resource_size(res));
>  out_active:
>  	platform_device_put(pdev);
>  out_pdev:
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index c7351e0dc8ff..5025a8c9850b 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -15,25 +15,17 @@ static int dax_hmem_probe(struct platform_device *pdev)
>  	struct memregion_info *mri;
>  	struct dev_dax_data data;
>  	struct dev_dax *dev_dax;
> -	struct resource *res;
> -	struct range range;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENOMEM;
>  
>  	mri = dev->platform_data;
> -	range.start = res->start;
> -	range.end = res->end;
> -	dax_region = alloc_dax_region(dev, pdev->id, &range, mri->target_node,
> -			PMD_SIZE, 0);
> +	dax_region = alloc_dax_region(dev, pdev->id, &mri->range,
> +				      mri->target_node, PMD_SIZE, 0);
>  	if (!dax_region)
>  		return -ENOMEM;
>  
>  	data = (struct dev_dax_data) {
>  		.dax_region = dax_region,
>  		.id = -1,
> -		.size = region_idle ? 0 : resource_size(res),
> +		.size = region_idle ? 0 : range_len(&mri->range),
>  	};
>  	dev_dax = devm_create_dev_dax(&data);
>  	if (IS_ERR(dev_dax))
> diff --git a/include/linux/memregion.h b/include/linux/memregion.h
> index bf83363807ac..c01321467789 100644
> --- a/include/linux/memregion.h
> +++ b/include/linux/memregion.h
> @@ -3,10 +3,12 @@
>  #define _MEMREGION_H_
>  #include <linux/types.h>
>  #include <linux/errno.h>
> +#include <linux/range.h>
>  #include <linux/bug.h>
>  
>  struct memregion_info {
>  	int target_node;
> +	struct range range;
>  };
>  
>  #ifdef CONFIG_MEMREGION
> 

