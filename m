Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD5268C937
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 23:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBFWQh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 17:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBFWQh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 17:16:37 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A9126DD;
        Mon,  6 Feb 2023 14:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675721796; x=1707257796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8GE1fZKcNZbLmBi51IrXVXcHqJazEVEwOf9U373Kk8o=;
  b=hxbMRNylIHZhYoVUZ67zrZOp7DTryRzprFnRC08KgFLb+xFE5sjKpKqq
   uv/xzfPP8ih0JKYu8u8uXij5kQ0mqOxLApvziCwYEPomDHi45Qb5zdd5K
   uUlOSicS8R7reiHPZ96wueUFzE0mWMR5b57v4ou7FxR9x5DbHv6B/4Knv
   rO/B1EsHu4a2bpRyIftud+aXILvE6rG+NMl/wP4hHXsSD13ZKIGaz0+vo
   eyglMSgxmAV+8Pi7VCnoovqzgng8SFkY1IpeplFcd7/uA6pwtZqg+gjnb
   WSDpcN0Rg4CwztfkT2mlig4DvLVHHWb/RZ2z/hoUm51BH2tIDTFa5B/Kb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="312983146"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312983146"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:16:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="755395786"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="755395786"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.111.195]) ([10.212.111.195])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:16:35 -0800
Message-ID: <982239b1-2bd5-9045-6097-c413208aaecb@intel.com>
Date:   Mon, 6 Feb 2023 15:16:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 04/18] cxl/region: Validate region mode vs decoder mode
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
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
> In preparation for a new region mode, do not, for example, allow
> 'ram' decoders to be assigned to 'pmem' regions and vice versa.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/region.c |    6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c9e7f05caa0f..53d6dbe4de6d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1217,6 +1217,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   	struct cxl_dport *dport;
>   	int i, rc = -ENXIO;
>   
> +	if (cxled->mode != cxlr->mode) {
> +		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> +			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> +		return -EINVAL;
> +	}
> +
>   	if (cxled->mode == CXL_DECODER_DEAD) {
>   		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
>   		return -ENODEV;
> 
