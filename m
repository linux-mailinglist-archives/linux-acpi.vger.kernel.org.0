Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38368C83E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 22:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBFVG1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 16:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBFVGQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 16:06:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F936EA6;
        Mon,  6 Feb 2023 13:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675717575; x=1707253575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x9OMFsqoU0CKBlWyYK5ZU5H+rXMOEtYx1Jfz8qzH0vs=;
  b=dU0Wlt7QnrOgewTqsllU+psgAXytNQsvnU+LGwr3ImNqVmS+Bs2Inc2A
   FyWCBJbJmsOvHw3UOeX4S9f0+OhMPyqXCZZD+lVydmrf1X6HMT0aHvxlt
   t0sByyaaqnz8qyKsTHixItJHgDpvs1TTwlY47dwvgCnQ5NXnH0n5B/2uM
   mrXb8SdYRCFf6+9uMQOYDHMtXbHSrKaLhpXU5AKdJXsoegLMy87bh5c+3
   DiKp+83SXVHnHOBnq5tOKRNlG2OCp4f6e31OkMR/J/eQRvjhf7jzO6qKa
   PwcpmDMzDnNyVPoC6HTMyH/iCH/INhruztwm8Eu6uvPYzK1XU+eK2vxzj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="312969548"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312969548"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 13:06:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="659973146"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659973146"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.111.195]) ([10.212.111.195])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 13:05:58 -0800
Message-ID: <ddc58134-9049-d718-1a61-a02a76aca874@intel.com>
Date:   Mon, 6 Feb 2023 14:05:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 02/18] cxl/region: Add a mode attribute for regions
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2/5/23 6:02 PM, Dan Williams wrote:
> In preparation for a new region type, "ram" regions, add a mode
> attribute to clarify the mode of the decoders that can be added to a
> region. Share the internals of mode_show() (for decoders) with the
> region case.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   Documentation/ABI/testing/sysfs-bus-cxl |   11 +++++++++++
>   drivers/cxl/core/port.c                 |   12 +-----------
>   drivers/cxl/core/region.c               |   10 ++++++++++
>   drivers/cxl/cxl.h                       |   14 ++++++++++++++
>   4 files changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 5be032313e29..058b0c45001f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -358,6 +358,17 @@ Description:
>   		results in the same address being allocated.
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
>   What:		/sys/bus/cxl/devices/regionZ/resource
>   Date:		May, 2022
>   KernelVersion:	v6.0
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 410c036c09fa..8566451cb22f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -180,17 +180,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>   {
>   	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
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
>   }
>   
>   static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 60828d01972a..17d2d0c12725 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -458,6 +458,15 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RO(resource);
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
>   static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>   {
>   	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> @@ -585,6 +594,7 @@ static struct attribute *cxl_region_attrs[] = {
>   	&dev_attr_interleave_granularity.attr,
>   	&dev_attr_resource.attr,
>   	&dev_attr_size.attr,
> +	&dev_attr_mode.attr,
>   	NULL,
>   };
>   
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index aa3af3bb73b2..ca76879af1de 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -320,6 +320,20 @@ enum cxl_decoder_mode {
>   	CXL_DECODER_DEAD,
>   };
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
>   /**
>    * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
>    * @cxld: base cxl_decoder_object
> 
