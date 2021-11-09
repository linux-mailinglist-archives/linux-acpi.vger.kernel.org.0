Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36744AD6C
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Nov 2021 13:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhKIMXj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Nov 2021 07:23:39 -0500
Received: from mga01.intel.com ([192.55.52.88]:63460 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhKIMXj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Nov 2021 07:23:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="256115378"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="256115378"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 04:20:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="500464841"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 04:20:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mkQ7B-0054wb-Ta;
        Tue, 09 Nov 2021 14:20:37 +0200
Date:   Tue, 9 Nov 2021 14:20:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/2] ACPI: Make acpi_node_get_parent() local
Message-ID: <YYpnlSl1PYIXefUs@smile.fi.intel.com>
References: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
 <20211109111935.1627406-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109111935.1627406-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 09, 2021 at 01:19:35PM +0200, Sakari Ailus wrote:
> acpi_node_get_parent() isn't used outside drivers/acpi/property.c. Make it
> local.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Please, change this to @linux.intel.com.

...

> -		struct device *dev =
> -			to_acpi_device_node(fwnode)->dev.parent;
> +		struct device *dev = to_acpi_device_node(fwnode)->dev.parent;

Ping-pong? (see comment to the previous patch)

-- 
With Best Regards,
Andy Shevchenko


