Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F2E4F957A
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Apr 2022 14:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiDHMVM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Apr 2022 08:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiDHMVL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Apr 2022 08:21:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1F2325738
        for <linux-acpi@vger.kernel.org>; Fri,  8 Apr 2022 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649420348; x=1680956348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yRvUHW2NjjCl+NJusv1LQ7RYIkUPOck7aZW/3pPYTNw=;
  b=NDk1WP1WaD4r73nDvzTqhu808H981nOjsjt+ksVGBhfZnCys8M081Abu
   ohFA/o6+TRyXIC7mzFxi1UZLl7pt0gGhizGRx2FO6MILFBdrmQBFzZUuG
   D4fNRhCZhJGAzG82bijYr8Y+ruWQqqGL7opAdBFrxY/o04iO5MdI6d6bb
   6Y4JaJp20qs1XRrum7seRq+V042wqJL+VOre9J6svkM9v74bsR8RK+2xh
   OlBI0LZy2FjXVItITEswUFKyQpAmcFqU9e+iJbSX67pW27kEsRJwaA3Uv
   ydsKkuv3+WiOKc0BN6z1IRp6xB4gRZ2a62N/ZZ/LqV4PUgQUUtO6MYR+F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="259178891"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="259178891"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:19:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="653238413"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:19:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ncnWQ-000HPj-9M;
        Fri, 08 Apr 2022 15:15:26 +0300
Date:   Fri, 8 Apr 2022 15:15:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: Re: [PATCH 1/1] ACPI: property: Release subnode properties with data
 nodes
Message-ID: <YlAnXoxVdV1JAuSb@smile.fi.intel.com>
References: <20220406131208.603830-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406131208.603830-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 06, 2022 at 04:12:08PM +0300, Sakari Ailus wrote:
> struct acpi_device_properties describes one source of properties present
> on either struct acpi_device or struct acpi_data_node. When properties are
> parsed, both are populated but when released, only those properties that
> are associated with the device node are freed.
> 
> Fix this by also releasing memory of the data node properties.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 5f5e4890d57a ("ACPI / property: Allow multiple property compatible _DSD entries")
> Cc: stable@vger.kernel.org (for v4.20 and up)
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 3fceb4681ec9f..2da5e7cd28134 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -433,6 +433,16 @@ void acpi_init_properties(struct acpi_device *adev)
>  		acpi_extract_apple_properties(adev);
>  }
>  
> +static void acpi_free_device_properties(struct list_head *list)
> +{
> +	struct acpi_device_properties *props, *tmp;
> +
> +	list_for_each_entry_safe(props, tmp, list, list) {
> +		list_del(&props->list);
> +		kfree(props);
> +	}
> +}
> +
>  static void acpi_destroy_nondev_subnodes(struct list_head *list)
>  {
>  	struct acpi_data_node *dn, *next;
> @@ -445,22 +455,18 @@ static void acpi_destroy_nondev_subnodes(struct list_head *list)
>  		wait_for_completion(&dn->kobj_done);
>  		list_del(&dn->sibling);
>  		ACPI_FREE((void *)dn->data.pointer);
> +		acpi_free_device_properties(&dn->data.properties);
>  		kfree(dn);
>  	}
>  }
>  
>  void acpi_free_properties(struct acpi_device *adev)
>  {
> -	struct acpi_device_properties *props, *tmp;
> -
>  	acpi_destroy_nondev_subnodes(&adev->data.subnodes);
>  	ACPI_FREE((void *)adev->data.pointer);
>  	adev->data.of_compatible = NULL;
>  	adev->data.pointer = NULL;
> -	list_for_each_entry_safe(props, tmp, &adev->data.properties, list) {
> -		list_del(&props->list);
> -		kfree(props);
> -	}
> +	acpi_free_device_properties(&adev->data.properties);
>  }
>  
>  /**
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


