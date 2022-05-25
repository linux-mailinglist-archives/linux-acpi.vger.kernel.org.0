Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEB534259
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiEYRo3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 13:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243862AbiEYRo1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 13:44:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BBA9E9E3
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500665; x=1685036665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tRaAcxQwL9m1ox9/mAbc1RsnEDNWGC27f1oAy1giPK8=;
  b=GPJBQ7q7XXONzkj36JLvzXEvLgDdqxHdrjmTGxG2RKMOmQaD0UTVgyOq
   fTA0ii5MRkWbGxIRNA/VevfefcMKL6CwGF/QFpCyDlKq4KHqxyewzbxxV
   h4hFb5ADf+HvvLJqz1+dpdUNpFz3IZ2Ac1aHpb2c/wjV66emrXF2kLWf8
   VPSRVs/EtF+G8mbAP07tGEu5Z7gv2bkuGBeAKWLRXBgP0Ug6vItMnNFXQ
   dicxcJf1uiIbPAX2bV6xW2SJr54AcGLKyZbMJAWfx9DdqVKR7JGuZcPAo
   G1hfVLw78fiG0eVajcxvmukCjprRDEfBZg+2nF97S6mKPqagHGZk19yJU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="255948307"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="255948307"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:20:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="745841213"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:20:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ntug0-000L50-Qu;
        Wed, 25 May 2022 20:20:04 +0300
Date:   Wed, 25 May 2022 20:20:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 2/8] ACPI: property: Tie data nodes to acpi handles
Message-ID: <Yo5lRKqFoyL4BUNy@smile.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525130123.767410-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 25, 2022 at 04:01:17PM +0300, Sakari Ailus wrote:
> ACPICA allows associating additional information (i.e. pointers with
> specific tag) to acpi_handles. The acpi_device's are associated to
> acpi_handle's in acpi_tie_acpi_dev() in scan.c, do the same here for the
> _DSD data nodes.
> 
> This allows direct data node references in properties, implemented later on
> in the series.

...

> +static int acpi_tie_nondev_subnodes(struct acpi_device_data *data)
> +{
> +	struct acpi_data_node *dn;
> +
> +	list_for_each_entry(dn, &data->subnodes, sibling) {
> +		acpi_status status;
> +		int ret;
> +
> +		status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
> +		if (ACPI_FAILURE(status)) {
> +			acpi_handle_err(dn->handle, "Can't tag data node\n");
> +			return 0;
> +		}
> +
> +		ret = acpi_tie_nondev_subnodes(&dn->data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

...

> -	if (!adev->data.pointer) {
> +	if (!adev->data.pointer ||

> +	    acpi_tie_nondev_subnodes(&adev->data) < 0) {
> +		acpi_untie_nondev_subnodes(&adev->data);

I don't know this part of the code, but this looks unusual. Shouldn't _tie()
take care of proper error path itself?

Also, it's a bit strange to call _untie() when _tie() wasn't called.

>  		acpi_handle_debug(adev->handle, "Invalid _DSD data, skipping\n");
>  		ACPI_FREE(buf.pointer);
>  	}

-- 
With Best Regards,
Andy Shevchenko


