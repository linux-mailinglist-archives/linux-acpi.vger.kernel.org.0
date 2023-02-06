Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BD868C42E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 18:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBFRGn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 12:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBFRGm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 12:06:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AFC22032;
        Mon,  6 Feb 2023 09:06:40 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P9Xh02LSGz6J9yW;
        Tue,  7 Feb 2023 01:05:20 +0800 (CST)
Received: from localhost (10.81.207.58) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 6 Feb
 2023 17:06:38 +0000
Date:   Mon, 6 Feb 2023 17:06:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 06/18] cxl/region: Refactor attach_target() for
 autodiscovery
Message-ID: <20230206170636.0000739e@Huawei.com>
In-Reply-To: <167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.58]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Sun, 05 Feb 2023 17:03:02 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

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

As below, I'd have broken this change out as a follow up patch - that
way reviewer could check for strict noop refactor, then look in ioslation
at that case.

I don't care that much though as second patch would only have about 4 lines
of diff.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> No behavior change is intended.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c |   47 +++++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8dea49c021b8..97eafdd75675 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1418,31 +1418,25 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  	up_write(&cxl_region_rwsem);
>  }
>  
> -static int attach_target(struct cxl_region *cxlr, const char *decoder, int pos)
> +static int attach_target(struct cxl_region *cxlr,
> +			 struct cxl_endpoint_decoder *cxled, int pos,
> +			 unsigned int state)
>  {
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

I'd be tempted to do this in two hops for patch readability. First
make the code reorg then follow up with this bit before the use
of it in the next patch.

>  	if (rc)
> -		goto out;
> +		return rc;
> +
>  	down_read(&cxl_dpa_rwsem);
> -	rc = cxl_region_attach(cxlr, to_cxl_endpoint_decoder(dev), pos);
> +	rc = cxl_region_attach(cxlr, cxled, pos);
>  	if (rc == 0)
>  		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>  	up_read(&cxl_dpa_rwsem);
>  	up_write(&cxl_region_rwsem);
> -out:
> -	put_device(dev);
>  	return rc;
>  }
>  
> @@ -1480,8 +1474,23 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
>  
>  	if (sysfs_streq(buf, "\n"))
>  		rc = detach_target(cxlr, pos);
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
>  	if (rc < 0)
>  		return rc;
> 
> 

