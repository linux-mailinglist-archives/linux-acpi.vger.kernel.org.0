Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F376468C9B4
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 23:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBFWlc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 17:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFWlb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 17:41:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAAA27D6B;
        Mon,  6 Feb 2023 14:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675723290; x=1707259290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=icL/vzCvDKIx0vVTt7mGj47ZeqruLivskwmA6EaeK0c=;
  b=A0QkaSr3fnWQlvqX+68zWwTCXP5JspteYKw0Rupjcoim0XdJxL/GjT/X
   rtsDPW1EdRhKISQ81xB8nVxPIX8qU22N50977rH7eyzdbRyuCvtRzmCfe
   PIUoBnHDrkQCy+XP7wSFZ5A3heE+VpBr8xiXZpOTaRLwc71YM9qQ6bjWe
   JIDYB5RM1FMzUnP/P+nbbHbzQv5Pwt+NU5CzNc3lOCLlOLibfNK8t9Oqt
   i+7dWgRikDaue6lYBMmNypw6eyqLKJ150f588obEnNaI/XsJTte1ddYrI
   DaLSq778T1KUrQ+8Zk/XO8HXJD8RpU1kwut11g1FE9kv7bZNFbgWLhwP1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="329349460"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="329349460"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:41:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="775298862"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775298862"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.111.195]) ([10.212.111.195])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:41:30 -0800
Message-ID: <e7277580-eb0c-4ea2-ac96-eb80a1e56c1b@intel.com>
Date:   Mon, 6 Feb 2023 15:41:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 06/18] cxl/region: Refactor attach_target() for
 autodiscovery
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com>
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



On 2/5/23 6:03 PM, Dan Williams wrote:
> Region autodiscovery is the process of kernel creating 'struct
> cxl_region' object to represent active CXL memory ranges it finds
> already active in hardware when the driver loads. Typically this happens
> when platform firmware establishes CXL memory regions and then publishes
> them in the memory map. However, this can also happen in the case of
> kexec-reboot after the kernel has created regions.
> 
> In the autodiscovery case the region creation process starts with a
> known endpoint decoder. Refactor attach_target() into a helper that is
> suitable to be called from either sysfs, for runtime region creation, or
> from cxl_port_probe() after it has enumerated all endpoint decoders.
> 
> The cxl_port_probe() context is an async device-core probing context, so
> it is not appropriate to allow SIGTERM to interrupt the assembly
> process. Refactor attach_target() to take @cxled and @state as arguments
> where @state indicates whether waiting from the region rwsem is
> interruptible or not.
> 
> No behavior change is intended.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c |   47 +++++++++++++++++++++++++++------------------
>   1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8dea49c021b8..97eafdd75675 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1418,31 +1418,25 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>   	up_write(&cxl_region_rwsem);
>   }
>   
> -static int attach_target(struct cxl_region *cxlr, const char *decoder, int pos)
> +static int attach_target(struct cxl_region *cxlr,
> +			 struct cxl_endpoint_decoder *cxled, int pos,
> +			 unsigned int state)
>   {
> -	struct device *dev;
> -	int rc;
> -
> -	dev = bus_find_device_by_name(&cxl_bus_type, NULL, decoder);
> -	if (!dev)
> -		return -ENODEV;
> -
> -	if (!is_endpoint_decoder(dev)) {
> -		put_device(dev);
> -		return -EINVAL;
> -	}
> +	int rc = 0;
>   
> -	rc = down_write_killable(&cxl_region_rwsem);
> +	if (state == TASK_INTERRUPTIBLE)
> +		rc = down_write_killable(&cxl_region_rwsem);
> +	else
> +		down_write(&cxl_region_rwsem);
>   	if (rc)
> -		goto out;
> +		return rc;
> +
>   	down_read(&cxl_dpa_rwsem);
> -	rc = cxl_region_attach(cxlr, to_cxl_endpoint_decoder(dev), pos);
> +	rc = cxl_region_attach(cxlr, cxled, pos);
>   	if (rc == 0)
>   		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>   	up_read(&cxl_dpa_rwsem);
>   	up_write(&cxl_region_rwsem);
> -out:
> -	put_device(dev);
>   	return rc;
>   }
>   
> @@ -1480,8 +1474,23 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
>   
>   	if (sysfs_streq(buf, "\n"))
>   		rc = detach_target(cxlr, pos);
> -	else
> -		rc = attach_target(cxlr, buf, pos);
> +	else {
> +		struct device *dev;
> +
> +		dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> +		if (!dev)
> +			return -ENODEV;
> +
> +		if (!is_endpoint_decoder(dev)) {
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +
> +		rc = attach_target(cxlr, to_cxl_endpoint_decoder(dev), pos,
> +				   TASK_INTERRUPTIBLE);
> +out:
> +		put_device(dev);
> +	}
>   
>   	if (rc < 0)
>   		return rc;
> 
