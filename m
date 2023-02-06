Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACEE68C219
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 16:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjBFPrE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 10:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjBFPrC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 10:47:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E82B60F;
        Mon,  6 Feb 2023 07:46:38 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P9Vqy5t0Vz6J7gF;
        Mon,  6 Feb 2023 23:42:06 +0800 (CST)
Received: from localhost (10.81.207.58) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 6 Feb
 2023 15:46:29 +0000
Date:   Mon, 6 Feb 2023 15:46:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 02/18] cxl/region: Add a mode attribute for regions
Message-ID: <20230206154627.00000a1b@Huawei.com>
In-Reply-To: <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.58]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Sun, 05 Feb 2023 17:02:40 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for a new region type, "ram" regions, add a mode
> attribute to clarify the mode of the decoders that can be added to a
> region. Share the internals of mode_show() (for decoders) with the
> region case.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
I guess the DEAD decoder cases is an odd enough path that it is
fine to not worry that it is presented as mixed (none might be
more appropriate as you can't put any memory behind it).

Other than that this is straight forwards exposure of internal data
that already existed...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   11 +++++++++++
>  drivers/cxl/core/port.c                 |   12 +-----------
>  drivers/cxl/core/region.c               |   10 ++++++++++
>  drivers/cxl/cxl.h                       |   14 ++++++++++++++
>  4 files changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 5be032313e29..058b0c45001f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -358,6 +358,17 @@ Description:
>  		results in the same address being allocated.
>  
>  
> +What:		/sys/bus/cxl/devices/regionZ/mode
> +Date:		January, 2023
> +KernelVersion:	v6.3
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The mode of a region is established at region creation time
> +		and dictates the mode of the endpoint decoder that comprise the
> +		region. For more details on the possible modes see
> +		/sys/bus/cxl/devices/decoderX.Y/mode
> +
> +
>  What:		/sys/bus/cxl/devices/regionZ/resource
>  Date:		May, 2022
>  KernelVersion:	v6.0
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 410c036c09fa..8566451cb22f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -180,17 +180,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
>  
> -	switch (cxled->mode) {
> -	case CXL_DECODER_RAM:
> -		return sysfs_emit(buf, "ram\n");
> -	case CXL_DECODER_PMEM:
> -		return sysfs_emit(buf, "pmem\n");
> -	case CXL_DECODER_NONE:
> -		return sysfs_emit(buf, "none\n");
> -	case CXL_DECODER_MIXED:
> -	default:
> -		return sysfs_emit(buf, "mixed\n");
> -	}
> +	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxled->mode));
>  }
>  
>  static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 60828d01972a..17d2d0c12725 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -458,6 +458,15 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(resource);
>  
> +static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +
> +	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxlr->mode));
> +}
> +static DEVICE_ATTR_RO(mode);
> +
>  static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> @@ -585,6 +594,7 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_interleave_granularity.attr,
>  	&dev_attr_resource.attr,
>  	&dev_attr_size.attr,
> +	&dev_attr_mode.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index aa3af3bb73b2..ca76879af1de 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -320,6 +320,20 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_DEAD,
>  };
>  
> +static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
> +{
> +	static const char * const names[] = {
> +		[CXL_DECODER_NONE] = "none",
> +		[CXL_DECODER_RAM] = "ram",
> +		[CXL_DECODER_PMEM] = "pmem",
> +		[CXL_DECODER_MIXED] = "mixed",
> +	};
> +
> +	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
> +		return names[mode];
> +	return "mixed";
> +}
> +
>  /**
>   * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
>   * @cxld: base cxl_decoder_object
> 

