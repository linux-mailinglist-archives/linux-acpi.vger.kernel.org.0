Return-Path: <linux-acpi+bounces-17222-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD4AB94FF0
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 10:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBEA3AF4FE
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2E31DD97;
	Tue, 23 Sep 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfn43COP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0731DD87
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616177; cv=none; b=CTtBXMaEVJb59Ag/XxjwajxkbWStpMjAIRCXDUsDnjZ6muNIpSKRg1+zeBvjA0qNPvw3NhEPLvgLB0O3AuDXgUMahkX4moaSHzcNHMDhtTINsxUkKpKR8JCBTD5oiNsrDuf9Dy94Qw1YKJ8ckcCcy4fei0GHyzZv4Vy8yY1N4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616177; c=relaxed/simple;
	bh=CowkBq4AYe0jXiC0oTJBDUkEIgMM+VcPfMDSLOj+dSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wpllyou8I1YWD6XS5Euy59eTLuDZws3/xs4ILr6LiUiA8NukPmnbv9Le8G9HYplckmZkHITuSAklgqxph7wvYM2QEdIEicj/ddwk9hoTnctY1hqePSQXjHsISwKj8GhuPmosW0DqmSVc8CcgbpTlpPA/7qVPIgcL5Yvn/63iU4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfn43COP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758616176; x=1790152176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CowkBq4AYe0jXiC0oTJBDUkEIgMM+VcPfMDSLOj+dSA=;
  b=lfn43COPmvV+07uN/FvJy51g3nj/T4Alt7hD0TeQ9OGM3ueXgK4SBuft
   4L0CQBwaio0urYyUIJ+OpA2nKYkOpWzPDFwmAgmd1Wr55NKa1xubF5KcW
   cshO7lkNIx2Bh0OFuHsTvD1YFH2nVc2JklWIkThT53iUqupVDfTAiDl/R
   0Va2ZJMk3rp6h9VAqxPv6EYR4fKUFp9qgI+kKW5yaNL/UPoffGt3gl7An
   mMvlP3DIRKL/GS47gb6p3NQ0IX0r0TiISJK/5+g4dHA39wCG14Yu7Nczr
   0ZzVqmnNJs6HbhJC5LzxetP4ReWCZMimB/rbZNu06tjDDr2pQu++wSx40
   w==;
X-CSE-ConnectionGUID: pGz77b0iTeGxg3lqKhdDGQ==
X-CSE-MsgGUID: GKrfJDIWSdWU4dvnk3EQuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86325047"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="86325047"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 01:29:35 -0700
X-CSE-ConnectionGUID: aWgVVkDRS+uaNsNEB2DiTQ==
X-CSE-MsgGUID: smhwUvWDTp+mL51sOrqSmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="181095364"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.23])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 01:29:33 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C6EE5121ED8;
	Tue, 23 Sep 2025 11:29:29 +0300 (EEST)
Date: Tue, 23 Sep 2025 11:29:29 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 12/14] leds: Use fwnode_get_next_child_node() instead
Message-ID: <aNJaaToLRoUcl6Xm@kekkonen.localdomain>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-13-sakari.ailus@linux.intel.com>
 <aNI0PncTY-Gf1MRU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNI0PncTY-Gf1MRU@smile.fi.intel.com>

Hi Andy,

Thanks for the review.

On Tue, Sep 23, 2025 at 08:46:38AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 07:01:27PM +0300, Sakari Ailus wrote:
> > fwnode_get_next_child_node() is now the same as
> > fwnode_get_next_available_child_node() on all backends (OF, ACPI and
> > swnode). In order to remove the available variants, switch the uses to
> > non-available variants.
> 
> ...
> 
> > --- a/drivers/leds/flash/leds-rt4505.c
> > +++ b/drivers/leds/flash/leds-rt4505.c
> 
> > -	child = fwnode_get_next_available_child_node(client->dev.fwnode, NULL);
> > +	child = fwnode_get_next_child_node(client->dev.fwnode, NULL);
> 
> Can we move to device_get_next_child_node() instead?
> 
> ...
> 
> > --- a/drivers/leds/flash/leds-rt8515.c
> > +++ b/drivers/leds/flash/leds-rt8515.c
> 
> > -	child = fwnode_get_next_available_child_node(dev->fwnode, NULL);
> > +	child = fwnode_get_next_child_node(dev->fwnode, NULL);
> 
> Ditto.
> 
> ...
> 
> > --- a/drivers/leds/flash/leds-sgm3140.c
> > +++ b/drivers/leds/flash/leds-sgm3140.c
> 
> > -	child_node = fwnode_get_next_available_child_node(pdev->dev.fwnode,
> > -							  NULL);
> > +	child_node = fwnode_get_next_child_node(pdev->dev.fwnode, NULL);
> 
> Ditto.
> 
> ...
> 
> > --- a/drivers/leds/flash/leds-tps6131x.c
> > +++ b/drivers/leds/flash/leds-tps6131x.c
> 
> > -	tps6131x->led_node = fwnode_get_next_available_child_node(dev->fwnode, NULL);
> > +	tps6131x->led_node = fwnode_get_next_child_node(dev->fwnode, NULL);
> 
> Ditto.

I'll fix these for v2.

-- 
Regards,

Sakari Ailus

