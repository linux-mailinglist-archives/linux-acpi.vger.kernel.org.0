Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459616A71F3
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Mar 2023 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCARTT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Mar 2023 12:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCARS5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2023 12:18:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D868F7DB0
        for <linux-acpi@vger.kernel.org>; Wed,  1 Mar 2023 09:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677691136; x=1709227136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pvZzO8AI5NQOLzj1KoU3PoHZvR1xMIxp9I3k7IiX/MM=;
  b=buoOwMhUthAVsaFy4+JhIogy/FlIF8wDRs5xLhsIlbe+ihsobjrPRcGE
   dgQAD24HJIg/chAOvcLRjLwhqFckLZgKOk52sexPERijEdFtjHNUz5077
   JX4Y6esbr4cEPXWjIHn7HWGmpu/iCoPTELtCsBCCj2TAv9QMO2c5oxfqW
   bQ7CujUIaqe7HH2SUCjAiqVCIp98wslJElZPwMFPuo3yu87xE28d221jf
   3Ioau3uG0zOY5Jdwvk7j15Vk9KTtnHNCuquefvgSd6hAfBIIk+pCR8lM3
   sy6W7qWpkhhhIWS8RkU1R34Zub/cUYLkseI71zhDa8SQle8v6Djwq4i1B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="399255432"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="399255432"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 09:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="676835965"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="676835965"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 01 Mar 2023 09:18:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXQ6B-00Dqsi-2Z;
        Wed, 01 Mar 2023 19:18:39 +0200
Date:   Wed, 1 Mar 2023 19:18:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] acpi/arm64: Drop extra (struct resource)
Message-ID: <Y/+I75/Pgo6wgyk3@smile.fi.intel.com>
References: <20230301170938.9278-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301170938.9278-1-Jonathan.Cameron@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 01, 2023 at 05:09:38PM +0000, Jonathan Cameron wrote:
> DEFINE_RES_IRQ() is a wrapper around the DEFINE_RES_NAMED()
> macro which already has the (struct resource) for the compound
> literal.

Thank you!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes warnings:
>   CC      drivers/acpi/arm64/gtdt.o
>   CHECK   drivers/acpi/arm64/gtdt.c
> drivers/acpi/arm64/gtdt.c:355:19: warning: cast to non-scalar
> drivers/acpi/arm64/gtdt.c:355:19: warning: cast from non-scalar
> 
> Fixes: 52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/arm64/gtdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index c0e77c1c8e09..24bd479de91f 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -352,7 +352,7 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
>  	}
>  
>  	irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
> -	res[2] = (struct resource)DEFINE_RES_IRQ(irq);
> +	res[2] = DEFINE_RES_IRQ(irq);
>  	if (irq <= 0) {
>  		pr_warn("failed to map the Watchdog interrupt.\n");
>  		nr_res--;
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


