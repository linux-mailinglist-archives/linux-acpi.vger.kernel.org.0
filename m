Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC36929BF
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 22:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjBJV7j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 16:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjBJV7i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 16:59:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFE97D8B3;
        Fri, 10 Feb 2023 13:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676066378; x=1707602378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IWeWBAcXU8gR83oqaSxz80kzyVRTcSG6AcaGmWbiYD8=;
  b=LUaeco8sb//FAPtCcxzVpDXfNxDbE+PUV+ZsKRXhRRyEp+7SI2qkzfZv
   1s4VvoC6cjNORKpwpwxZE1UbTqgbPI4UYtjb2g9fv94rcw4R8hldwLLJJ
   8EGxP0UGTPXjLrDvKnSrgx5JiNotAMMZs15xlzWr1jUV94AgoMFmY9Fg0
   emLjr97NlW6paJ/nxFI+nHcatP0ca3UQh0GO1XJavxBzJ3UkqPFMMcUg6
   KyZUTOhRAY80glV9lQGD3tSW3aoSEwQbEvlQVv8TJq0d2irotYPa3AbBv
   AuyHLOFxVQ8mMFvY+giBhG4fs8qhzHW5OyEpKvoQJh4c96LDyDrhdYkwA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="330545038"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="330545038"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 13:59:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="700616322"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="700616322"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.190.133]) ([10.213.190.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 13:59:37 -0800
Message-ID: <3bef679e-ddb6-45a1-2152-522fc217efa8@intel.com>
Date:   Fri, 10 Feb 2023 14:59:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2 16/20] dax/hmem: Drop unnecessary dax_hmem_remove()
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gregory.price@memverge.com>,
        Fan Ni <fan.ni@samsung.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <167602001664.1924368.9102029637928071240.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167602001664.1924368.9102029637928071240.stgit@dwillia2-xfh.jf.intel.com>
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



On 2/10/23 2:06 AM, Dan Williams wrote:
> Empty driver remove callbacks can just be elided.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Link: https://lore.kernel.org/r/167564542679.847146.17174404738816053065.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dax/hmem/hmem.c |    7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 1bf040dbc834..c7351e0dc8ff 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -44,15 +44,8 @@ static int dax_hmem_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int dax_hmem_remove(struct platform_device *pdev)
> -{
> -	/* devm handles teardown */
> -	return 0;
> -}
> -
>   static struct platform_driver dax_hmem_driver = {
>   	.probe = dax_hmem_probe,
> -	.remove = dax_hmem_remove,
>   	.driver = {
>   		.name = "hmem",
>   	},
> 
