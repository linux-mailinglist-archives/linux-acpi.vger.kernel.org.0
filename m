Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AFC66E1FA
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 16:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjAQPWR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 10:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjAQPWQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 10:22:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E415F55BA;
        Tue, 17 Jan 2023 07:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673968934; x=1705504934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7BTQ79mOZfvv0uHbF0pJ6F9idS5NsvEgnqqwJjZd0IE=;
  b=miGQb1lJ2mCPkYcTcfCP73+DAOPhYyxqQJapBuaYsBlRiXjzuiN7rSoF
   8ZPfKPSYlqazqNM2fCsWXOGr2eE9iPpRYwNodmpLlRrXA2L5AUXwaMlJj
   0JayTqlU36gsFuGGWPUn17ydKsX0h5HLXNAEO3VAzon/bWmQs3/tFcHKg
   dIKZzFgfvemyuN65lXLnQap89SQN7w3ybm8Cu0gn4bln84SfEi0hk/WVp
   d9wtu1ROXGCaQGp5HYjOkyARB+ek6BPRmqcOEKgdahXYQhHHVG2H3fzxU
   kLM63fU1tyhVYWG0qlfIfIqucwAgedGspMpelStb7siLuGcJgECJ4vtiD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="312586345"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="312586345"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:22:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="689823338"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="689823338"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 17 Jan 2023 07:22:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHnmt-00AdLk-1I;
        Tue, 17 Jan 2023 17:22:11 +0200
Date:   Tue, 17 Jan 2023 17:22:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 5/8] ACPI: property: Dig "rotation" property for devices
 with CSI2 _CRS
Message-ID: <Y8a9Iy2xzmHh7crA@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-6-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117122244.2546597-6-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2023 at 02:22:41PM +0200, Sakari Ailus wrote:
> Dig "rotation" property value for devices with _CRS CSI2 resource
> descriptor. The value comes from _PLD (physical location of device)
> object, if it exists for the device.
> 
> This way camera sensor drivers that know the "rotation" property do not
> need to care about _PLD on ACPI.

...

> +	if (fwnode_property_read_u32(fwnode, "rotation", &val) &&
> +	    acpi_get_physical_device_location(acpi_device_handle(device),
> +					      &pld) == AE_OK) {

ACPI_SUCCESS() ?

...

> +		ads->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
> +			PROPERTY_ENTRY_U32("rotation",
> +					   (u32)pld->rotation * 45U);

Why do you need casting?

-- 
With Best Regards,
Andy Shevchenko


