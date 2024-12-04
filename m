Return-Path: <linux-acpi+bounces-9909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 711679E30AC
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 02:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632E1B245E3
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 01:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F04C76;
	Wed,  4 Dec 2024 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYFJS1LS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280A2500C1;
	Wed,  4 Dec 2024 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275001; cv=none; b=LSrJmmDQw0XzvHjDXX7MOUJgQBO/oVwbx8cEoaaIhTySTsvG8cOPrAMhjWQPe5Za5h1S9f2folhVDritaVdX8MnLsojz0YuWT1MhVxJCsTD04qQg9PDCwe++qij8Wfsv49aJ6+OVkDOkcI0xFs+eYwrQ+6RSZfPf6anbN4CX3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275001; c=relaxed/simple;
	bh=pR2MElwHtwWwS6jdx+JWc0MpXQDktTgkhYQF3j0TDjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRiztrTZ6dOmZu0VKd0vovaeo2PLSYeaFNIj20x55Yn3uQWpp8AWnp2ri8mzNhC9JqbG/HDHUxua/fs0xqXOUTkoZ7i4clxU5o4cwlJH8d5AQ1JVGcImOe/PDIXb1gs1Q/Sbg7rAbhOx7kyEHRDE3Kyhcnez1jSW9JTYw2deXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYFJS1LS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733274999; x=1764810999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pR2MElwHtwWwS6jdx+JWc0MpXQDktTgkhYQF3j0TDjY=;
  b=jYFJS1LSxnug0ytoOD12eG0l8E43Ca3VzAZoRRZ0/Nx21COWLVoKppzV
   Ivzis7hS3pjP3CeC4RbfW/RstgB32kyxylUlVJvr8unWn1BNhP7l9ZjqC
   g1odqIOuSQe3NIQ0TviIrU3TPQA+5R8RGbtOGpyJhIx3Pj0sIB5MCIJMu
   4KZZLnhJko6tzNqu7cSy/Cyc1ZdzJ4XC+0jIUaMgbV7NSXJQhz/wbvy9e
   2OZxKlnPUiRzw2DYSwphuhDjpUDqQmP+ZPy/a0im6F4+IU/jGN9fiO/fR
   /nwYx9YoVJ4BbKeki02DeghqtvCjLvPkTuTNAI2QWVPSsSjqNHpDgO3ZE
   g==;
X-CSE-ConnectionGUID: BB5IfPshRMOpH+JTjbmlqQ==
X-CSE-MsgGUID: qecPGkmoRD6tqmPpe7AoHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33443770"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33443770"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:16:39 -0800
X-CSE-ConnectionGUID: ULLCaQy7RAeXoVfvIkyH5A==
X-CSE-MsgGUID: BLgSlryZTEKlP+2h/GiatA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93462728"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:16:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIe0I-00000003bUz-1yrw;
	Wed, 04 Dec 2024 03:16:34 +0200
Date: Wed, 4 Dec 2024 03:16:34 +0200
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
Message-ID: <Z0-tcsOw5imlWZn4@smile.fi.intel.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
 <Z0j3EtRmYBmGFApu@google.com>
 <Z0nUpytu0GFUgQ9V@smile.fi.intel.com>
 <Z0q75n_P3sZYnviO@google.com>
 <Z0uHJJKMog-REw1D@smile.fi.intel.com>
 <Z06b0oTvxUi4DTlx@google.com>
 <Z08HQ2JmETJLNuud@smile.fi.intel.com>
 <Z0-KHYnhu81ljbDk@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0-KHYnhu81ljbDk@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 03, 2024 at 02:45:49PM -0800, Dmitry Torokhov wrote:
> On Tue, Dec 03, 2024 at 03:27:31PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 02, 2024 at 09:49:06PM -0800, Dmitry Torokhov wrote:
> > > On Sat, Nov 30, 2024 at 11:44:04PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Nov 29, 2024 at 11:16:54PM -0800, Dmitry Torokhov wrote:
> > > > > On Fri, Nov 29, 2024 at 04:50:15PM +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Nov 28, 2024 at 03:04:50PM -0800, Dmitry Torokhov wrote:
> > > > > > > On Thu, Nov 28, 2024 at 03:13:16PM +0200, Andy Shevchenko wrote:
> > > > > > > > On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:

...

> > > > > > > > > @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> > > > > > > > >  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > > > > > >  	struct fwnode_handle *next;
> > > > > > > > 
> > > > > > > > > -	if (IS_ERR_OR_NULL(fwnode))
> > > > > > > > > +	if (IS_ERR_OR_NULL(fwnode)) {
> > > > > > > > > +		fwnode_handle_put(child);
> > > > > > > > >  		return NULL;
> > > > > > > > > +	}
> > > > > > > > 
> > > > > > > > >  	/* Try to find a child in primary fwnode */
> > > > > > > > >  	next = fwnode_get_next_child_node(fwnode, child);
> > > > > > > > 
> > > > > > > > So, why not just moving the original check (w/o dropping the reference) here?
> > > > > > > > Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?
> > > > > > > 
> > > > > > > Because if you rely on check in fwnode_get_next_child_node() you would
> > > > > > > not know if it returned NULL because there are no more children or
> > > > > > > because the node is invalid. In the latter case you can't dereference
> > > > > > > fwnode->secondary.
> > > > > > 
> > > > > > Yes, so, how does it contradict my proposal?
> > > > > 
> > > > > I guess I misunderstood your proposal then. Could you please explain it
> > > > > in more detail?
> > > > 
> > > > 
> > > > Current code (in steps):
> > > > 	if (IS_ERR_OR_NULL()) check
> > > > 	trying primary
> > > > 	trying secondary if previous is NULL
> > > > 
> > > > 
> > > > My proposal
> > > > 
> > > > 	trying primary
> > > > 	return if not NULL
> > > > 	if (IS_ERR_OR_NULL()) check in its current form (no put op)
> > > > 	trying secondary
> > > > 
> > > > After your first patch IIUC this is possible as trying primary will put child uncoditionally.
> > > 
> > > Ah, I see. No, I do not think this is a good idea: it will make the code
> > > harder to understand for a casual reader: "Why do we check node validity
> > > only after we used it for the first time?"
> > 
> > Theare a re already a few API calls there that are hard to understand, I spent
> > some time on them to get it through and still got it wrong as this series
> > shows. So, I don't think we anyhow change this.
> 
> The fact that some code is confusing does not mean that we should add
> more confusing code. We will not fix everything at once, but we can make
> things better bit by bit.
> 
> Look, the check where it is now makes total sense, you added it there
> yourself! It checks that we are dealing with a valid node and returns
> early. The intent is very easy to understand and the only thing that is
> missing is that "put" operation to satisfy the documented behavior.
> Anything more just makes things more complex for no good reason.

Right, that's why I think we need to go away from open coding the iteration
over the list of nodes (primary, secondary, etc).

> > > For the code not in a hot path there is a lot of value in simplicity.
> > 
> > If you really want to go to this rabbit hole, think how we can get rid of
> > repetitive checks of the secondary or more if any in the future nodes in the
> > list.
> > 
> > So the basic idea is to have this all hidden (to some extent) behind the macro
> > or alike. In the code it would be something as
> > 
> >   for node in primary, secondary, ...
> >     call the API
> >     if (okay)
> > 	return result
> > 
> >   return error
> > 
> > This will indeed help.
> 
> I think this will indeed help if we ever going to have more than primary
> and secondary nodes. It is also tricky if you want to transition
> seamlessly between different types of nodes (i.e. you have ACPI primary
> with OF overlay secondary with swnode as tertiary etc). And you probably
> want to add support for references between different typesof nodes
> (i.e. swnode being able to reference OF device node for example).
> 
> This kind of rework is however out of scope of what I have time to do at
> the moment.

I am not asking you to invest into big rework, the idea is to try to fold the
iterations to a kind of loop. Is it feasible?

Or maybe it can be partially done, so the above becomes something like

call_prmary_op(fwnode, ...)
	if (IS_ERR_OR_NULL(fwnode))
		...
	else
		call_op()

call_secondary_op(fwnode, ...)
	if (IS_ERR_OR_NULL(fwnode))
		...
	else
		call_op()

(with the potential of collapsing one into the other)

and then the above

	next = call_primary_op(wnode, ...);
	if (next)
		return next;

	return call_secondary_op(fwnode, ...);

-- 
With Best Regards,
Andy Shevchenko



