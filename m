Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7868C834
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 22:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjBFVEJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 16:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBFVEI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 16:04:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FB3B444;
        Mon,  6 Feb 2023 13:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675717447; x=1707253447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ehhTh2z9Y6QKN8C0AvGM3mrZyVdoETrxIgPO6fX6tu0=;
  b=UihYyZ2NBmwFpNCfxNxDYYx+Hq/1vuvKDwTHTX4XSyQYzyq0oIxRVBYb
   U5JvtraAtRDwSej+LmIdqWb4Yw9E+Ov6kfGCy/9gD8OmPF1BoA5BDmTaR
   ovE2aIpPOiSC51VdD7nzNflMlfMm2FujHjbAn6K8RnkcJiKKcyOGtR1+z
   dPfFwq5kZFZzCMOAw4hd6QhuxUGnTBNDPDLG2f+UPK1QSbt9I58xhfrnd
   fdJc8gl9IW7wsRYMAdfAOfhQXdIO/XFRkgZOdvr9FvdM7CbwGSSFxk6rd
   z7ZHQ/MFn2YpzCEdzpT3h9lsKUmxWgKhnZY0wuZZ8Lexny/1jpRwGvzNh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="312969099"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312969099"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 13:04:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="659972825"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659972825"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.111.195]) ([10.212.111.195])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 13:04:06 -0800
Message-ID: <283ddb72-d2ed-1c48-01e9-b470bbd007cb@intel.com>
Date:   Mon, 6 Feb 2023 14:04:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 01/18] cxl/Documentation: Update references to attributes
 added in v6.0
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
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
> Prior to Linus deciding that the kernel that following v5.19 would be
> v6.0, the CXL ABI documentation already referenced v5.20. In preparation
> for updating these entries update the kernel version to v6.0.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   Documentation/ABI/testing/sysfs-bus-cxl |   30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 329a7e46c805..5be032313e29 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -198,7 +198,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/endpointX/CDAT
>   Date:		July, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RO) If this sysfs entry is not present no DOE mailbox was
> @@ -209,7 +209,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/decoderX.Y/mode
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> @@ -229,7 +229,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint",
> @@ -240,7 +240,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/decoderX.Y/dpa_size
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> @@ -260,7 +260,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/decoderX.Y/interleave_ways
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RO) The number of targets across which this decoder's host
> @@ -275,7 +275,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/decoderX.Y/interleave_granularity
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RO) The number of consecutive bytes of host physical address
> @@ -287,7 +287,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RW) Write a string in the form 'regionZ' to start the process
> @@ -303,7 +303,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(WO) Write a string in the form 'regionZ' to delete that region,
> @@ -312,7 +312,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/regionZ/uuid
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RW) Write a unique identifier for the region. This field must
> @@ -322,7 +322,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/regionZ/interleave_granularity
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RW) Set the number of consecutive bytes each device in the
> @@ -333,7 +333,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/regionZ/interleave_ways
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RW) Configures the number of devices participating in the
> @@ -343,7 +343,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/regionZ/size
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RW) System physical address space to be consumed by the region.
> @@ -360,7 +360,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/regionZ/resource
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RO) A region is a contiguous partition of a CXL root decoder
> @@ -372,7 +372,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/regionZ/target[0..N]
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RW) Write an endpoint decoder object name to 'targetX' where X
> @@ -391,7 +391,7 @@ Description:
>   
>   What:		/sys/bus/cxl/devices/regionZ/commit
>   Date:		May, 2022
> -KernelVersion:	v5.20
> +KernelVersion:	v6.0
>   Contact:	linux-cxl@vger.kernel.org
>   Description:
>   		(RW) Write a boolean 'true' string value to this attribute to
> 
