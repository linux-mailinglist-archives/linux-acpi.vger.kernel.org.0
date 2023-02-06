Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6668C2F1
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 17:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjBFQTC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 11:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjBFQSk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 11:18:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A8C44B4;
        Mon,  6 Feb 2023 08:18:10 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P9WXS4wm7z6J7fH;
        Tue,  7 Feb 2023 00:13:44 +0800 (CST)
Received: from localhost (10.81.207.58) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 6 Feb
 2023 16:18:07 +0000
Date:   Mon, 6 Feb 2023 16:18:04 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 05/18] cxl/region: Add volatile region creation support
Message-ID: <20230206161804.00005c47@Huawei.com>
In-Reply-To: <167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.58]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Sun, 05 Feb 2023 17:02:56 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Expand the region creation infrastructure to enable 'ram'
> (volatile-memory) regions. The internals of create_pmem_region_store()
> and create_pmem_region_show() are factored out into helpers
> __create_region() and __create_region_show() for the 'ram' case to
> reuse.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Entirely trivial comments inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   22 +++++-----
>  drivers/cxl/core/core.h                 |    1 
>  drivers/cxl/core/port.c                 |   14 ++++++
>  drivers/cxl/core/region.c               |   71 +++++++++++++++++++++++++------
>  4 files changed, 82 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 4c4e1cbb1169..3acf2f17a73f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -285,20 +285,20 @@ Description:
>  		interleave_granularity).
>  
>  
> -What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
> -Date:		May, 2022
> -KernelVersion:	v6.0
> +What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> +Date:		May, 2022, January, 2023
> +KernelVersion:	v6.0 (pmem), v6.3 (ram)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a string in the form 'regionZ' to start the process
> -		of defining a new persistent memory region (interleave-set)
> -		within the decode range bounded by root decoder 'decoderX.Y'.
> -		The value written must match the current value returned from
> -		reading this attribute. An atomic compare exchange operation is
> -		done on write to assign the requested id to a region and
> -		allocate the region-id for the next creation attempt. EBUSY is
> -		returned if the region name written does not match the current
> -		cached value.
> +		of defining a new persistent, or volatile memory region
> +		(interleave-set) within the decode range bounded by root decoder
> +		'decoderX.Y'. The value written must match the current value
> +		returned from reading this attribute. An atomic compare exchange
> +		operation is done on write to assign the requested id to a
> +		region and allocate the region-id for the next creation attempt.
> +		EBUSY is returned if the region name written does not match the
> +		current cached value.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 8c04672dca56..5eb873da5a30 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -11,6 +11,7 @@ extern struct attribute_group cxl_base_attribute_group;
>  
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
> +extern struct device_attribute dev_attr_create_ram_region;
>  extern struct device_attribute dev_attr_delete_region;
>  extern struct device_attribute dev_attr_region;
>  extern const struct device_type cxl_pmem_region_type;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8566451cb22f..47e450c3a5a9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -294,6 +294,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_type3.attr,
>  	&dev_attr_target_list.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
> +	SET_CXL_REGION_ATTR(create_ram_region)
>  	SET_CXL_REGION_ATTR(delete_region)
>  	NULL,
>  };
> @@ -305,6 +306,13 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
>  }
>  
> +static bool can_create_ram(struct cxl_root_decoder *cxlrd)
> +{
> +	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +
> +	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> +}
> +
>  static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
> @@ -313,7 +321,11 @@ static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *
>  	if (a == CXL_REGION_ATTR(create_pmem_region) && !can_create_pmem(cxlrd))
>  		return 0;
>  
> -	if (a == CXL_REGION_ATTR(delete_region) && !can_create_pmem(cxlrd))
> +	if (a == CXL_REGION_ATTR(create_ram_region) && !can_create_ram(cxlrd))
> +		return 0;
> +
> +	if (a == CXL_REGION_ATTR(delete_region) &&
> +	    !(can_create_pmem(cxlrd) || can_create_ram(cxlrd)))
>  		return 0;
>  
>  	return a->mode;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 53d6dbe4de6d..8dea49c021b8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1685,6 +1685,15 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	struct device *dev;
>  	int rc;
>  
> +	switch (mode) {
> +	case CXL_DECODER_RAM:
> +	case CXL_DECODER_PMEM:
> +		break;
> +	default:
> +		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	cxlr = cxl_region_alloc(cxlrd, id);
>  	if (IS_ERR(cxlr))
>  		return cxlr;
> @@ -1713,12 +1722,38 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
> +{
> +	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> +}
> +
>  static ssize_t create_pmem_region_show(struct device *dev,
>  				       struct device_attribute *attr, char *buf)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> +}
>  
> -	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> +static ssize_t create_ram_region_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> +}
> +
> +static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> +					  enum cxl_decoder_mode mode, int id)
> +{
> +	int rc;
> +
> +	rc = memregion_alloc(GFP_KERNEL);
> +	if (rc < 0)
> +		return ERR_PTR(rc);
> +
> +	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
> +		memregion_free(rc);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_EXPANDER);
>  }
>  
>  static ssize_t create_pmem_region_store(struct device *dev,
> @@ -1727,29 +1762,37 @@ static ssize_t create_pmem_region_store(struct device *dev,
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>  	struct cxl_region *cxlr;
> -	int id, rc;
> +	int rc, id;
>  
>  	rc = sscanf(buf, "region%d\n", &id);
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	rc = memregion_alloc(GFP_KERNEL);
> -	if (rc < 0)
> -		return rc;
> +	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
> +	if (IS_ERR(cxlr))
> +		return PTR_ERR(cxlr);

I'd have a blank line here - see below.

> +	return len;
> +}
> +DEVICE_ATTR_RW(create_pmem_region);
>  
> -	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
> -		memregion_free(rc);
> -		return -EBUSY;
> -	}
> +static ssize_t create_ram_region_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +	struct cxl_region *cxlr;
> +	int rc, id;
>  
> -	cxlr = devm_cxl_add_region(cxlrd, id, CXL_DECODER_PMEM,
> -				   CXL_DECODER_EXPANDER);
> +	rc = sscanf(buf, "region%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
> -

Just so you know I read to the end!

Spurious unrelated white space change :)

>  	return len;
>  }
> -DEVICE_ATTR_RW(create_pmem_region);
> +DEVICE_ATTR_RW(create_ram_region);
>  
>  static ssize_t region_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
> 

