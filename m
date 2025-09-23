Return-Path: <linux-acpi+bounces-17220-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC27AB94789
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 07:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6833E3B5E4D
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 05:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8E61F63FF;
	Tue, 23 Sep 2025 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1FVDMtB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA862BA34
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606406; cv=none; b=sDPoy86xIJP1z50y4qK7R9HeEgfYAo7sr7pf6kQ1VmBVnDB8kD5ZLEtckk9m1MKONtiDVX6YVJdyppENpy4r4Oys/zIIl87SkN4xiu0VwqjAAnWLinwI2hPb8kjf87yjTyLTeXevW1rCqC8M6x4YuBBRy0/dXnQorxuysMaZkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606406; c=relaxed/simple;
	bh=iiX557JRAPda6AnTFl7efEi49nW003tr6l7vgmBVpn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN6Xya/b5CXnr86AQdi+98kxBgWOBTxWhnGMUWrGYOesfBrf/Qe+5J2BQEUtjyympFvbKiQRqiqlOiJ0C6bPG4hEsVTtEu3nJK99R4UpbYMqtlVtxsZv2Wz7sXbCTbC/99BiGXVF9agBOKBx7tT1uTCt45vRLBaWu5Fswp059/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1FVDMtB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758606405; x=1790142405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iiX557JRAPda6AnTFl7efEi49nW003tr6l7vgmBVpn0=;
  b=J1FVDMtBPgquJ+9TfG3uIP5Iz8vpsz6w9FkRVP//kLGtQQeyE1B1aDZt
   aJD5A5cAWvfkF9Mcs8zC1DGqEO/fYbudrQifhRvBZevlycFmOLHgIN+wc
   MSAVTCmPQEbNPMZtDt06xCtQdwfmhh4O9rK26nNS3jCnnRb//hyNb78DJ
   1S1lN+Lg1Uv3b9A//impP5HM6c+D/sqgbQaXUNGuq/Q/RlzfdYhBfbG3e
   4o1II7gkBc903aRJ8ESUtZonrqXsysQyUJjn9tpV5iFOk1PFsTwEYd0S6
   ZhmaOpgMGR7jtwZSPETuf6kQa/H1nQUZCEuA6jitQ/TMM6Dv4ngj1dQ0M
   Q==;
X-CSE-ConnectionGUID: YwUOam3IScGHxI/38wxkFw==
X-CSE-MsgGUID: ne0jow1iTRO6ioA/6RJFnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60818141"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60818141"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 22:46:43 -0700
X-CSE-ConnectionGUID: 6AoAlJ2jToGFP4glyKhFUQ==
X-CSE-MsgGUID: lB4WZahIRpyLfzjO3CrlAA==
X-ExtLoop1: 1
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 22:46:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v0vrK-00000005NuS-3c0K;
	Tue, 23 Sep 2025 08:46:38 +0300
Date: Tue, 23 Sep 2025 08:46:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 12/14] leds: Use fwnode_get_next_child_node() instead
Message-ID: <aNI0PncTY-Gf1MRU@smile.fi.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-13-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916160129.3955410-13-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 07:01:27PM +0300, Sakari Ailus wrote:
> fwnode_get_next_child_node() is now the same as
> fwnode_get_next_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants.

...

> --- a/drivers/leds/flash/leds-rt4505.c
> +++ b/drivers/leds/flash/leds-rt4505.c

> -	child = fwnode_get_next_available_child_node(client->dev.fwnode, NULL);
> +	child = fwnode_get_next_child_node(client->dev.fwnode, NULL);

Can we move to device_get_next_child_node() instead?

...

> --- a/drivers/leds/flash/leds-rt8515.c
> +++ b/drivers/leds/flash/leds-rt8515.c

> -	child = fwnode_get_next_available_child_node(dev->fwnode, NULL);
> +	child = fwnode_get_next_child_node(dev->fwnode, NULL);

Ditto.

...

> --- a/drivers/leds/flash/leds-sgm3140.c
> +++ b/drivers/leds/flash/leds-sgm3140.c

> -	child_node = fwnode_get_next_available_child_node(pdev->dev.fwnode,
> -							  NULL);
> +	child_node = fwnode_get_next_child_node(pdev->dev.fwnode, NULL);

Ditto.

...

> --- a/drivers/leds/flash/leds-tps6131x.c
> +++ b/drivers/leds/flash/leds-tps6131x.c

> -	tps6131x->led_node = fwnode_get_next_available_child_node(dev->fwnode, NULL);
> +	tps6131x->led_node = fwnode_get_next_child_node(dev->fwnode, NULL);

Ditto.

-- 
With Best Regards,
Andy Shevchenko



