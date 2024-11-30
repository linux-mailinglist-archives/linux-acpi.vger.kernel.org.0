Return-Path: <linux-acpi+bounces-9837-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AE89DF356
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 22:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CB2281266
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 21:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6101AA1F8;
	Sat, 30 Nov 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIZCebaJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BA130E27;
	Sat, 30 Nov 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733003051; cv=none; b=IXZSkZxhTaVyYX3NI8yGBOHk/w4hm0T+ZuoSPDIpVDrD1GsregPEqkS6E/DKmr5/00wnffLl17WFnnd0sO60MZueHO6LsQfFPv/bS186MBmoNSDeWTtBoUsdahyOCEUDjzZ0MCZf/l2WvBjNdXOycDjaT281H6XElCepC2htDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733003051; c=relaxed/simple;
	bh=YvnE6yXibYSRVphsfuLW0ZRPXneTASycCwxmcTa7ToE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ+/0M0N4pVb8BeEE3pk6rjzjkzIZ3GxLnrvi76LerMe6jc0m6NWL8btK5NyVyoBv0XlKS0bsQmWWGvo/3veIRwtqjGGtW2qaRvUTkcLwa4YLKErnlrEFIHWf2h/HA/HsZclXDuJ9yFk7FfNn/tFkEbtMlP5B55c8BPiP3GDgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIZCebaJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733003050; x=1764539050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YvnE6yXibYSRVphsfuLW0ZRPXneTASycCwxmcTa7ToE=;
  b=kIZCebaJ7+kcYDqhxU6O2iqhKp/eRmmcEaCJawPiuY+MZMYLCnUAdgXd
   dXFwuKHGc8QPPjpAo/wBQaDXY/eyokMtjHTx5k1A6lEpnu8VhdH2KN0Y3
   3/dyaO9lxaoVxubj0wu73tD+pSdHUhvkGbYpz5poBUcrc7wrW3smnloRe
   +JZScie2aNRa4x0aEoJ9QZwdPdvCSsu7P5vvE9yE5t6GsK9RwUk0klD7l
   fEsY4OSpgSfZID5p23Riw+gT+4fea1ZeVyj0Bbiz7xhdDCCTQloUCGpPY
   KeB9YM5T55kpVsLM/muVfHjTaha08JAaRdcFICo7GcrY8YtN0YOIMT5tA
   w==;
X-CSE-ConnectionGUID: a7W3K7EGQxy1a7g/X4h8/g==
X-CSE-MsgGUID: p8/Q1FanRTmb2PFqDMxMZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="20786533"
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="20786533"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 13:44:09 -0800
X-CSE-ConnectionGUID: 3GdDkVDnRBmnWmn/6oAlKQ==
X-CSE-MsgGUID: mJ3/5bgLSiW7NwRkn0XL6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="116020974"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 13:44:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tHVG0-00000002fhb-2b2B;
	Sat, 30 Nov 2024 23:44:04 +0200
Date: Sat, 30 Nov 2024 23:44:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] device property: do not leak child nodes when using
 NULL/error pointers
Message-ID: <Z0uHJJKMog-REw1D@smile.fi.intel.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
 <Z0j3EtRmYBmGFApu@google.com>
 <Z0nUpytu0GFUgQ9V@smile.fi.intel.com>
 <Z0q75n_P3sZYnviO@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0q75n_P3sZYnviO@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 29, 2024 at 11:16:54PM -0800, Dmitry Torokhov wrote:
> On Fri, Nov 29, 2024 at 04:50:15PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 28, 2024 at 03:04:50PM -0800, Dmitry Torokhov wrote:
> > > On Thu, Nov 28, 2024 at 03:13:16PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:

...

> > > > > @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> > > > >  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > >  	struct fwnode_handle *next;
> > > > 
> > > > > -	if (IS_ERR_OR_NULL(fwnode))
> > > > > +	if (IS_ERR_OR_NULL(fwnode)) {
> > > > > +		fwnode_handle_put(child);
> > > > >  		return NULL;
> > > > > +	}
> > > > 
> > > > >  	/* Try to find a child in primary fwnode */
> > > > >  	next = fwnode_get_next_child_node(fwnode, child);
> > > > 
> > > > So, why not just moving the original check (w/o dropping the reference) here?
> > > > Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?
> > > 
> > > Because if you rely on check in fwnode_get_next_child_node() you would
> > > not know if it returned NULL because there are no more children or
> > > because the node is invalid. In the latter case you can't dereference
> > > fwnode->secondary.
> > 
> > Yes, so, how does it contradict my proposal?
> 
> I guess I misunderstood your proposal then. Could you please explain it
> in more detail?


Current code (in steps):
	if (IS_ERR_OR_NULL()) check
	trying primary
	trying secondary if previous is NULL


My proposal

	trying primary
	return if not NULL
	if (IS_ERR_OR_NULL()) check in its current form (no put op)
	trying secondary

After your first patch IIUC this is possible as trying primary will put child uncoditionally.

-- 
With Best Regards,
Andy Shevchenko



