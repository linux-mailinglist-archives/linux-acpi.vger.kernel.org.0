Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4BC68C254
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 16:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBFPzT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 10:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBFPzR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 10:55:17 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12B42C642;
        Mon,  6 Feb 2023 07:54:57 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P9W1b3GvHz6J7dZ;
        Mon,  6 Feb 2023 23:50:27 +0800 (CST)
Received: from localhost (10.81.207.58) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 6 Feb
 2023 15:54:49 +0000
Date:   Mon, 6 Feb 2023 15:54:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 03/18] cxl/region: Support empty uuids for non-pmem
 regions
Message-ID: <20230206155448.00007dfe@Huawei.com>
In-Reply-To: <167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com>
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

On Sun, 05 Feb 2023 17:02:45 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Shipping versions of the cxl-cli utility expect all regions to have a
> 'uuid' attribute. In preparation for 'ram' regions, update the 'uuid'
> attribute to return an empty string which satisfies the current
> expectations of 'cxl list -R'. Otherwise, 'cxl list -R' fails in the
> presence of regions with the 'uuid' attribute missing. Force the
> attribute to be read-only as there is no facility or expectation for a
> 'ram' region to recall its uuid from one boot to the next.

This is new functionality, so do we need the backwards compatibility?
Or does that cxl list -R not just skip these, but fail hard?
It's inelegant to have this visible at all (and it confused me when
I was running tests as I assumed I needed to poke something in it).

If nothing else, good to have a comment to remind us in the code
why there is the oddity of setting it to read only.

Jonathan

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |    3 ++-
>  drivers/cxl/core/region.c               |    7 +++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 058b0c45001f..4c4e1cbb1169 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -317,7 +317,8 @@ Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a unique identifier for the region. This field must
>  		be set for persistent regions and it must not conflict with the
> -		UUID of another region.
> +		UUID of another region. For volatile ram regions this
> +		attribute is a read-only empty string.
>  
>  
>  What:		/sys/bus/cxl/devices/regionZ/interleave_granularity
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 17d2d0c12725..c9e7f05caa0f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -45,7 +45,10 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>  	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
> +	if (cxlr->mode != CXL_DECODER_PMEM)
> +		rc = sysfs_emit(buf, "\n");
> +	else
> +		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
>  	up_read(&cxl_region_rwsem);
>  
>  	return rc;
> @@ -301,7 +304,7 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
>  	struct cxl_region *cxlr = to_cxl_region(dev);
>  
>  	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
> -		return 0;
> +		return 0444;

Definitely a comment here as this is very odd and we may forget why
it is like this.

>  	return a->mode;
>  }
>  
> 

