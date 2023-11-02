Return-Path: <linux-acpi+bounces-1160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4E7DF51F
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 15:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8ED281B5A
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4729A0
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIXXkq8R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8263AD
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 12:59:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31F7112
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698929961; x=1730465961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LHM1aUtwkmqBuBUdIELNhGZ0uaa4x5vWaedieUIWVAU=;
  b=SIXXkq8RewRqSE5x8qFu5tNPg4JTlS1A28x78pTO/Z6O34qbMPx2HioK
   iiDz6bMjQhs3U6P/8RCjdvLrdykth/VpRF8Bhlv1r80k2in6ypph4cWOR
   F+S9PsS9S8XrejjD+RY91xfIuF1ejpp0K+Dn24aKAJ/JLOkwdFg7Rg9tK
   NnT7B0gDCiRyo236Q/u+PAu0QBHTvVpwLE5T2PkmtWlAJqZ8QfaAOHKIK
   HJwXFbChvnjOlb3Xy0ztRD5WAA5IAnvXqhHdArA81+d8Im/NZr3B/HNhl
   T0bCfQY8S2dt9+AEaZj1PShKrf4lg5hcGG0PMHHH0EeXLnp1oeJf6LGXQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="388523914"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="388523914"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="754765297"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="754765297"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:59:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qyXI5-0000000AguG-0LZX;
	Thu, 02 Nov 2023 14:59:17 +0200
Date: Thu, 2 Nov 2023 14:59:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] Make fwnode_property_get_reference_args accept NULL
 args
Message-ID: <ZUOdJIddenp_UjR1@smile.fi.intel.com>
References: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
 <ZUIfp43KYDvpdife@smile.fi.intel.com>
 <ZUIizkjRH1OdAOBx@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUIizkjRH1OdAOBx@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 01, 2023 at 10:05:02AM +0000, Sakari Ailus wrote:
> On Wed, Nov 01, 2023 at 11:51:35AM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 01, 2023 at 11:07:34AM +0200, Sakari Ailus wrote:
> > > Hi all,
> > > 
> > > The of_parse_phandle_with_args() accepts NULL args but
> > > fwnode_property_get_reference_args() does not currently, in its ACPI or
> > > software node implementations. Fix this.
> > 
> > The last sentence assumes Fixes tag(s) which I can't see.
> 
> This obviously hasn't been an issue for the existing users so backporting
> it has little value. From API consistency PoV this does matter though.

Fixes is not always about backporting. But if some code starts using that
and needs to be backported with that in mind...

> I can add a Fixes: tag if you like.

I think some clarity needs to be done, either Fixes tag(s) or changing language
to explain that this is an improvement and not an immediate fix.

-- 
With Best Regards,
Andy Shevchenko



