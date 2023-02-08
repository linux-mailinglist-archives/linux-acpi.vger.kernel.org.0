Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE668EF07
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 13:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjBHMgY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 07:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBHMgX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 07:36:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F545F6B;
        Wed,  8 Feb 2023 04:36:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PBfWY5FbPz6J7Ln;
        Wed,  8 Feb 2023 20:31:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Feb
 2023 12:36:19 +0000
Date:   Wed, 8 Feb 2023 12:36:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 09/18] cxl/region: Enable CONFIG_CXL_REGION to be
 toggled
Message-ID: <20230208123618.00007460@Huawei.com>
In-Reply-To: <167564539875.847146.16213498614174558767.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564539875.847146.16213498614174558767.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Sun, 05 Feb 2023 17:03:18 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Add help text and a label so the CXL_REGION config option can be
> toggled. This is mainly to enable compile testing without region
> support.

Hmm. Possibly pull the reasoning up here for why this might
want to be configurable at all.  I'm not sure I fully follow
your reasoning as enumerating existing regions 'should' be harmless
gathering of information, not something that could do any damage
- so who would turn this off?

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/Kconfig |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 0ac53c422c31..163c094e67ae 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -104,12 +104,22 @@ config CXL_SUSPEND
>  	depends on SUSPEND && CXL_MEM
>  
>  config CXL_REGION
> -	bool
> +	bool "CXL: Region Support"
>  	default CXL_BUS
>  	# For MAX_PHYSMEM_BITS
>  	depends on SPARSEMEM
>  	select MEMREGION
>  	select GET_FREE_REGION
> +	help
> +	  Enable the CXL core to enumerate and provision CXL regions. A CXL
> +	  region is defined by one or more CXL expanders that decode a given
> +	  system-physical address range. For CXL regions established by
> +	  platform-firmware this option enables memory error handling to
> +	  identify the devices participating in a given interleaved memory
> +	  range. Otherwise, platform-firmware managed CXL is enabled by being
> +	  placed in the system address map and does not need a driver.
> +
> +	  If unsure say 'y'
>  
>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
> 
> 

