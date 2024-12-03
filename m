Return-Path: <linux-acpi+bounces-9898-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812539E1D89
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 14:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4574D282863
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7331C1EF080;
	Tue,  3 Dec 2024 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXr3VXKH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733919A297;
	Tue,  3 Dec 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232458; cv=none; b=pXRs2k006+KcrvGOaSTbLcGTqjpvBMo1cq5YIjVyvx2CJ05nYkXnplQ/WXOW7lqUenKdVXmM9E1L3pIfEgIApnEaatHvyMmksMM6rvv00DE28ewAxlGvJ5UAMl1WTumvVaJTazfTQx1uPfzR25r0mN8gAPhWA/n2RuKV0eQawvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232458; c=relaxed/simple;
	bh=6Q5UniimspbX4XfDjtpafCMvJCawwNGVwORSbaSKzwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktm94HCglySsbI4UKOdR+ZVFPUuF6hQpMzxe50R9A9kaQ5TS6iNwLQeBq0hzGqB5/k3Yww+WvPAagRAs3Sbfj7ipJLb+sEaMA1MVnO0Df1MtY30+K9c1dri4HszkNscaBMC23F/fpTzFmCAZ0j9YPaITsJWJweTiITzXHx/6rJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXr3VXKH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733232456; x=1764768456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Q5UniimspbX4XfDjtpafCMvJCawwNGVwORSbaSKzwk=;
  b=BXr3VXKH+Om8QhBz6zmuMAm3S/q9SZJHmeU2OAyxA1SfW9lR+ZymfM/j
   1fkwIJWCLnmQ4lZd49DE2JzdXbtKIPmT55ktAzTAAynaEzgWFAjFpUAjN
   z2J+4yHNDV1bT4vTMdhE8/AdFDA0lEDE6TLtPHJb2fEe7r6a9YOQKXmlt
   OyY8+F5WIsj84fcfripfcqHC9ZBCZAZUStC7nmUljE3jUY+XSfJa5iTCa
   1hMz2BJkxKzWXYnLtrg0oi4sgOZnuwLsiq00tFzAN+lCpA9htBpFCFHUf
   8xOGgwy6pWcqsI8K5NhDh92m1+lhpnR9mukOoNGjeD5uwPAsC8smV/PzN
   w==;
X-CSE-ConnectionGUID: h+spne0eSJahHWZ5Uv+0gA==
X-CSE-MsgGUID: U8p8+LsNSouKS+szNxhLyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="21028225"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="21028225"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:27:36 -0800
X-CSE-ConnectionGUID: FE87xROMQUWVZM+BXEbvpQ==
X-CSE-MsgGUID: y931rEgfQxew5PUT0WD+Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="116683978"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:27:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tISw7-00000003Rr0-3ABF;
	Tue, 03 Dec 2024 15:27:31 +0200
Date: Tue, 3 Dec 2024 15:27:31 +0200
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
Message-ID: <Z08HQ2JmETJLNuud@smile.fi.intel.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
 <Z0j3EtRmYBmGFApu@google.com>
 <Z0nUpytu0GFUgQ9V@smile.fi.intel.com>
 <Z0q75n_P3sZYnviO@google.com>
 <Z0uHJJKMog-REw1D@smile.fi.intel.com>
 <Z06b0oTvxUi4DTlx@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z06b0oTvxUi4DTlx@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 02, 2024 at 09:49:06PM -0800, Dmitry Torokhov wrote:
> On Sat, Nov 30, 2024 at 11:44:04PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 29, 2024 at 11:16:54PM -0800, Dmitry Torokhov wrote:
> > > On Fri, Nov 29, 2024 at 04:50:15PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Nov 28, 2024 at 03:04:50PM -0800, Dmitry Torokhov wrote:
> > > > > On Thu, Nov 28, 2024 at 03:13:16PM +0200, Andy Shevchenko wrote:
> > > > > > On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:

...

> > > > > > > @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> > > > > > >  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > > > >  	struct fwnode_handle *next;
> > > > > > 
> > > > > > > -	if (IS_ERR_OR_NULL(fwnode))
> > > > > > > +	if (IS_ERR_OR_NULL(fwnode)) {
> > > > > > > +		fwnode_handle_put(child);
> > > > > > >  		return NULL;
> > > > > > > +	}
> > > > > > 
> > > > > > >  	/* Try to find a child in primary fwnode */
> > > > > > >  	next = fwnode_get_next_child_node(fwnode, child);
> > > > > > 
> > > > > > So, why not just moving the original check (w/o dropping the reference) here?
> > > > > > Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?
> > > > > 
> > > > > Because if you rely on check in fwnode_get_next_child_node() you would
> > > > > not know if it returned NULL because there are no more children or
> > > > > because the node is invalid. In the latter case you can't dereference
> > > > > fwnode->secondary.
> > > > 
> > > > Yes, so, how does it contradict my proposal?
> > > 
> > > I guess I misunderstood your proposal then. Could you please explain it
> > > in more detail?
> > 
> > 
> > Current code (in steps):
> > 	if (IS_ERR_OR_NULL()) check
> > 	trying primary
> > 	trying secondary if previous is NULL
> > 
> > 
> > My proposal
> > 
> > 	trying primary
> > 	return if not NULL
> > 	if (IS_ERR_OR_NULL()) check in its current form (no put op)
> > 	trying secondary
> > 
> > After your first patch IIUC this is possible as trying primary will put child uncoditionally.
> 
> Ah, I see. No, I do not think this is a good idea: it will make the code
> harder to understand for a casual reader: "Why do we check node validity
> only after we used it for the first time?"

Theare a re already a few API calls there that are hard to understand, I spent
some time on them to get it through and still got it wrong as this series
shows. So, I don't think we anyhow change this.

> For the code not in a hot path there is a lot of value in simplicity.

If you really want to go to this rabbit hole, think how we can get rid of
repetitive checks of the secondary or more if any in the future nodes in the
list.

So the basic idea is to have this all hidden (to some extent) behind the macro
or alike. In the code it would be something as

  for node in primary, secondary, ...
    call the API
    if (okay)
	return result

  return error

This will indeed help.

-- 
With Best Regards,
Andy Shevchenko



