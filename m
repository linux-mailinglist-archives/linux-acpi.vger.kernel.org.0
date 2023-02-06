Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27DE68C12B
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 16:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjBFPRz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 10:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjBFPRw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 10:17:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B521A269B;
        Mon,  6 Feb 2023 07:17:47 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P9VGM46g7z6J9yB;
        Mon,  6 Feb 2023 23:16:27 +0800 (CST)
Received: from localhost (10.81.207.58) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 6 Feb
 2023 15:17:44 +0000
Date:   Mon, 6 Feb 2023 15:17:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 01/18] cxl/Documentation: Update references to
 attributes added in v6.0
Message-ID: <20230206151742.00002c85@Huawei.com>
In-Reply-To: <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
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

On Sun, 05 Feb 2023 17:02:35 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Prior to Linus deciding that the kernel that following v5.19 would be
> v6.0, the CXL ABI documentation already referenced v5.20. In preparation
> for updating these entries update the kernel version to v6.0.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Fair enough though that fun bit of history disappears :)

Might as well queue this up ahead of the rest if you want to.
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
 
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 329a7e46c805..5be032313e29 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -198,7 +198,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/endpointX/CDAT
>  Date:		July, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) If this sysfs entry is not present no DOE mailbox was
> @@ -209,7 +209,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> @@ -229,7 +229,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint",
> @@ -240,7 +240,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_size
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> @@ -260,7 +260,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/interleave_ways
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) The number of targets across which this decoder's host
> @@ -275,7 +275,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/interleave_granularity
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) The number of consecutive bytes of host physical address
> @@ -287,7 +287,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a string in the form 'regionZ' to start the process
> @@ -303,7 +303,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(WO) Write a string in the form 'regionZ' to delete that region,
> @@ -312,7 +312,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/uuid
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a unique identifier for the region. This field must
> @@ -322,7 +322,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/interleave_granularity
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Set the number of consecutive bytes each device in the
> @@ -333,7 +333,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/interleave_ways
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Configures the number of devices participating in the
> @@ -343,7 +343,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/size
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) System physical address space to be consumed by the region.
> @@ -360,7 +360,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/resource
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) A region is a contiguous partition of a CXL root decoder
> @@ -372,7 +372,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/target[0..N]
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write an endpoint decoder object name to 'targetX' where X
> @@ -391,7 +391,7 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/regionZ/commit
>  Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a boolean 'true' string value to this attribute to
> 
> 

