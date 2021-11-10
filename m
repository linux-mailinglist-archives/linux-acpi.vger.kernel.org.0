Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A452744BC8C
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 09:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhKJIJS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 03:09:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:23527 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhKJIJQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Nov 2021 03:09:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232867174"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="232867174"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:06:29 -0800
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="564338585"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:06:27 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id A69D1205BA;
        Wed, 10 Nov 2021 10:06:25 +0200 (EET)
Date:   Wed, 10 Nov 2021 10:06:25 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/2] ACPI: Make acpi_node_get_parent() local
Message-ID: <YYt9gWhyIaxrmByH@paasikivi.fi.intel.com>
References: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
 <20211109111935.1627406-3-sakari.ailus@linux.intel.com>
 <YYpnlSl1PYIXefUs@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYpnlSl1PYIXefUs@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 09, 2021 at 02:20:37PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 09, 2021 at 01:19:35PM +0200, Sakari Ailus wrote:
> > acpi_node_get_parent() isn't used outside drivers/acpi/property.c. Make it
> > local.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Please, change this to @linux.intel.com.
> 
> ...
> 
> > -		struct device *dev =
> > -			to_acpi_device_node(fwnode)->dev.parent;
> > +		struct device *dev = to_acpi_device_node(fwnode)->dev.parent;
> 
> Ping-pong? (see comment to the previous patch)

This was meant to be in the first patch, I'll send v3.

-- 
Sakari Ailus
