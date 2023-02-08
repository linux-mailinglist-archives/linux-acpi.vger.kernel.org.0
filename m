Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB16268F3CB
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 17:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjBHQvm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 11:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBHQvm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 11:51:42 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93BB38B54;
        Wed,  8 Feb 2023 08:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675875100; x=1707411100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1td23WNm+twz/kiCnlM+DjtLLYqUIN8+ULqYy3NpLb8=;
  b=dDZso6x1Jr2WA+dZ1wFLI6wFDYYmH3KUUKxhyZteNwt4NraF3jvRPmBO
   GXxgYRhIzuukZtHk1vjwvB0816ZxsU3cKngOvXjvIxQmCPVP4+Q5jVO0n
   ikI8T3onGnen25g5zANQGt6d5oQDgswyLLPbjXJap7JsAD4T9bCI66uyo
   6PMdzt1pcelTpVCK1AGvAIklfE2D4w8MvMHPv9CYEATyrkgmnMarWpcZD
   DJe6o1Al5M/OOfoH2PZSMXbKA1tl4bs/Uis3Loyox4Ad8GDsjBTJMR7mT
   m/Q6S/iRBRtPIKiacDSPyqPZXC+4fR+xuDTrN9IvEMGNanaZUMw+6XhAN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="329880983"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="329880983"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 08:51:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="644920700"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="644920700"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2023 08:51:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pPnfB-004DRl-12;
        Wed, 08 Feb 2023 18:51:17 +0200
Date:   Wed, 8 Feb 2023 18:51:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v4 5/8] ACPI: property: Dig "rotation" property for
 devices with CSI2 _CRS
Message-ID: <Y+PTBdEPZoRLG4Hw@smile.fi.intel.com>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
 <20230208152807.3064242-6-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208152807.3064242-6-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 08, 2023 at 05:28:04PM +0200, Sakari Ailus wrote:
> Dig "rotation" property value for devices with _CRS CSI2 resource
> descriptor. The value comes from _PLD (physical location of device)
> object, if it exists for the device.
> 
> This way camera sensor drivers that know the "rotation" property do not
> need to care about _PLD on ACPI.

...

> +	/*
> +	 * Check if "rotation" property exists and if it doesn't but there's a
> +	 * _PLD object, then get the rotation value from there.
> +	 */
> +	if (fwnode_property_read_u32(fwnode, "rotation", &val) &&
> +	    ACPI_SUCCESS(acpi_get_physical_device_location(acpi_device_handle(device),
> +							   &pld))) {

> +	if (fwnode_property_read_u32(fwnode, "rotation", &val) &&
> +	    ACPI_SUCCESS(acpi_get_physical_device_location(acpi_device_handle(device),
> +							   &pld))) {

Wouldn't be a bit better to use temporary variables for this?

	ret = fwnode_property_read_u32(fwnode, "rotation", &val);
	if (ret) {
		acpi_handle handle = acpi_device_handle(device);
		acpi_status status;

		status = acpi_get_physical_device_location(handle, &pld);
		if (ACPI_SUCCESS(status)) {
			...
		}
	}

?

> +		ads->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
> +			PROPERTY_ENTRY_U32("rotation", pld->rotation * 45U);
> +		kfree(pld);
> +	}


-- 
With Best Regards,
Andy Shevchenko


