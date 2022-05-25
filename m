Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6181553425A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 19:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbiEYRos (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 13:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243862AbiEYRor (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 13:44:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0FC9D06A
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500687; x=1685036687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pSC2eTO+PjPz74SLe+CFlcTxMRcX28+vr7tm7VjJdKI=;
  b=d+D3/9NXrmO57kkFnSIcqjLpGGoXdZq4oUp3GaLEwt9KLBPfqFYsW9IL
   qrPRwNd2YR5IhM99MNvTLD0fV9vrpPm/j0G05HTxiKciBz2VINMscwBsq
   RoKe+1tntUeLpdADIO12iNrKEv5j1zyTrJmhBALzLBldx90owHnXcmLAb
   IqqXF3OYxGBfRuq3ooGNmFxBTRqNetVSnggJ4UKSHafGrflZqTDplsEXo
   tlusKUjifDeTeFDJex8AqtejeBxafLczM8p+LCapnYQF2M78E+TC97b+W
   4Vwm3+RO+2UlZzmhsyeBeyV3Zqb7MPsJCJCcv+vPxQz7a2YEryJ7wNXou
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="336936526"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="336936526"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:23:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="602043624"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:23:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ntuja-000L58-8L;
        Wed, 25 May 2022 20:23:46 +0300
Date:   Wed, 25 May 2022 20:23:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 3/8] ACPI: property: Use acpi_object_type consistently
 in property ref parsing
Message-ID: <Yo5mIZxz8HDtxRPP@smile.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525130123.767410-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 25, 2022 at 04:01:18PM +0300, Sakari Ailus wrote:
> The type of union acpi_object field type is acpi_object_type. Use that
> instead of int.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index f8c83ee6c8d59..b36cb7e36e420 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -793,7 +793,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  			 * nor integer, return an error, we can't parse it.
>  			 */
>  			for (i = 0; element + i < end && i < num_args; i++) {
> -				int type = element[i].type;
> +				acpi_object_type type = element[i].type;
>  
>  				if (type == ACPI_TYPE_LOCAL_REFERENCE)
>  					break;
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


