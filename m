Return-Path: <linux-acpi+bounces-12117-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA0A5DAF3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 11:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B117178187
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF25623E33A;
	Wed, 12 Mar 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hmobr1gl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99523BD19;
	Wed, 12 Mar 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777038; cv=none; b=qk4jHWok2EHDhxD9DXb3F08Tz85MYrO64UKErTr0Wk9H8QRabdV3AH3nyLQHisDPM0U5AMRsu2JWxkRD69M6/MS0ShfLO3voh+v10wB+4p2rS4iRQnPdDlmBhwvZ3ZxH4/3Yt40Q1n+dC2hrhvE7YvQFqepGrFe/fZzmw3bUKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777038; c=relaxed/simple;
	bh=TT244cdGMl7t7RbsnB78w7lxYAjNAtm0K9Um1dx/Muw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrpufv7YSceKnqCPhtUn4BYNXeEKMFRCHnS3Ja4ymFz9gtB4dEUK8ilufUBA+HyFOnj/bANBQIVt8S787eZyBroItK0RZDeaYAPXJ7Edb2zSeyAhTD73CYJo0oq58nZFDraAyD+KTzS47RdO+1TyUoCnUNIBvl+KnvChIzuAh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hmobr1gl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741777038; x=1773313038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TT244cdGMl7t7RbsnB78w7lxYAjNAtm0K9Um1dx/Muw=;
  b=Hmobr1gly+Aidb0c+UEFnQnK9bp0LSaTT+KWbGz3puhjmxHw6glXkDwl
   zvrQCYeHcjO+BQeHlu89h3d89w6omsg2JBgXRFrA+bQpc4SjmooWcE8Mo
   GO2PWvlVXIdIgmPjTtuuIIT2fnIE9N9itkhI4I0U9+y8tTO4eEo5JavtZ
   XrCFPnUrTtqxj8CEab5XQ5IYQSvGLZig7UQLP9i8RX9/Ws6bo7+R8c29I
   VcEneinAXZarm+sHTN9uYHf7E3FBnFoNuv75K2yq7LEmwbxzFWostESsq
   9e9NalxU9MciLpxItyAQpnE3vIaI0YVcroOlropT6dQvFLCo0OekSc3JK
   Q==;
X-CSE-ConnectionGUID: QWTvyQ8ySaSvlwl8NKVJMg==
X-CSE-MsgGUID: zqhJS/ktRL2Om2/RinF3YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="65309588"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="65309588"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 03:57:17 -0700
X-CSE-ConnectionGUID: uxCzlLVHRoqHcodrqqLGeA==
X-CSE-MsgGUID: B1YJx9mwR/Kyv4Sv3+iKjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120551858"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 03:57:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsJlt-00000001q0A-0dsv;
	Wed, 12 Mar 2025 12:57:09 +0200
Date: Wed, 12 Mar 2025 12:57:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-usb@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 3/4] leds: ncp5623: Use fwnode_get_child_node_count()
Message-ID: <Z9FohBe0U0c_VVRt@smile.fi.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
 <20250310150835.3139322-4-andriy.shevchenko@linux.intel.com>
 <20250311095402.00002845@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311095402.00002845@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 11, 2025 at 09:54:02AM +0000, Jonathan Cameron wrote:
> On Mon, 10 Mar 2025 16:54:53 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > static int ncp5623_probe(struct i2c_client *client)

> >  	struct device *dev = &client->dev;
> >  	struct fwnode_handle *mc_node, *led_node;
> >  	struct led_init_data init_data = { };
> > -	int num_subleds = 0;
> >  	struct ncp5623 *ncp;
> >  	struct mc_subled *subled_info;
> > +	unsigned int num_subleds;
> I have no idea what the scheme is for ordering here. My gut
> feeling would have been to leave it in original location but it's
> not something I feel strongly about.

I guess I tried to follow multiple approaches here while moving it:
1) it follows "longer line first";
2) it follows "group the variables of the same type".

I also dunno what was behind the original code, but I think my approach has
a benefit as pointed out above.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thank you!

> >  	u32 color_index;
> >  	u32 reg;
> >  	int ret;

-- 
With Best Regards,
Andy Shevchenko



