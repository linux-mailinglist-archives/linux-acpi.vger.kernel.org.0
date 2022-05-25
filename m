Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAE753425D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbiEYRqF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243862AbiEYRqF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 13:46:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB79D06A
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500764; x=1685036764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Exps3SgTQQ/0EA+qu4RqymB+I35Km9jd9MlY1B76C6o=;
  b=Hud9yGshyNZtmDtQ+mgzSpisvDdk/18u3NH42A6blazM/dRbzeYr3dG+
   6a0R2sre91h/Ls5qi+rNW2I7YlPDpSWrxpJ9tf56PFc1WAPSGADsgVZcx
   Lkau/+KTWi35HBb9hh/n6+Ue/x4p/tmn9jV6dfkoNF/4EJQh1DLgLvjXL
   n+nzHs2FEejc7ekWIFD3FtoQ6tOl3NASHYrH81sgOX2npxiTTsyaQD85w
   gWeH04ndDv48TbmCC2pOxfAY1+hq+ENXsJ27vbz4fmrs+HuoAukm+EMKh
   SIpLE4hOc1iSCzdiz7rX4wvHyvbLAW5Oc+mKD6RsFL2mWUqOOwyPKdAOo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="254386231"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="254386231"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:30:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="704092634"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:30:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ntupv-000L5X-Ff;
        Wed, 25 May 2022 20:30:19 +0300
Date:   Wed, 25 May 2022 20:30:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 5/8] ACPI: property: Switch node property referencing
 from ifs to a switch
Message-ID: <Yo5nq1a7S1RgZg7f@smile.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-6-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525130123.767410-6-sakari.ailus@linux.intel.com>
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

On Wed, May 25, 2022 at 04:01:20PM +0300, Sakari Ailus wrote:
> __acpi_node_get_property_reference() uses a series of if () statements for
> testing the same variable. There's soon going to be one more value to be
> tested.
> 
> Switch to use switch() instead.

Looks like sanitization over the different parts of the code in this file.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index dd6cce955ee28..a8e8a214a524f 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -780,11 +780,9 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  	if (ret)
>  		return ret == -EINVAL ? -ENOENT : -EINVAL;
>  
> -	/*
> -	 * The simplest case is when the value is a single reference.  Just
> -	 * return that reference then.
> -	 */
> -	if (obj->type == ACPI_TYPE_LOCAL_REFERENCE) {
> +	switch (obj->type) {
> +	case ACPI_TYPE_LOCAL_REFERENCE:
> +		/* Plain single reference without arguments. */
>  		if (index)
>  			return -ENOENT;
>  
> @@ -795,19 +793,21 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  		args->fwnode = acpi_fwnode_handle(device);
>  		args->nargs = 0;
>  		return 0;
> +	case ACPI_TYPE_PACKAGE:
> +		/*
> +		 * If it is not a single reference, then it is a package of
> +		 * references followed by number of ints as follows:
> +		 *
> +		 *  Package () { REF, INT, REF, INT, INT }
> +		 *
> +		 * The index argument is then used to determine which reference
> +		 * the caller wants (along with the arguments).
> +		 */
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> -	/*
> -	 * If it is not a single reference, then it is a package of
> -	 * references followed by number of ints as follows:
> -	 *
> -	 *  Package () { REF, INT, REF, INT, INT }
> -	 *
> -	 * The index argument is then used to determine which reference
> -	 * the caller wants (along with the arguments).
> -	 */
> -	if (obj->type != ACPI_TYPE_PACKAGE)
> -		return -EINVAL;
>  	if (index >= obj->package.count)
>  		return -ENOENT;
>  
> @@ -815,7 +815,8 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  	end = element + obj->package.count;
>  
>  	while (element < end) {
> -		if (element->type == ACPI_TYPE_LOCAL_REFERENCE) {
> +		switch (element->type) {
> +		case ACPI_TYPE_LOCAL_REFERENCE:
>  			device = acpi_fetch_acpi_dev(element->reference.handle);
>  			if (!device)
>  				return -EINVAL;
> @@ -831,11 +832,13 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  			if (idx == index)
>  				return 0;
>  
> -		} else if (element->type == ACPI_TYPE_INTEGER) {
> +			break;
> +		case ACPI_TYPE_INTEGER:
>  			if (idx == index)
>  				return -ENOENT;
>  			element++;
> -		} else {
> +			break;
> +		default:
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


