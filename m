Return-Path: <linux-acpi+bounces-10021-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E729E9DD6
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 19:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DD51883B9F
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 18:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8327155325;
	Mon,  9 Dec 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1ZTdznU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AA1F5F6;
	Mon,  9 Dec 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767592; cv=none; b=Gcx2+Vcd57bTDsvGnMXGCKV1QS1WsTlstQQkqJFSippwvnvsjWf4n/MYo2ru/+NLCL6WaIP2lzfv6FF7YcyrANkP0Z3uFX5Le4KEgG5KEi3L1chlyMF5BOpcdZsumxw285V7nrRoLCHp545t5PrwLDSGrNeuOe2nnMh61UPl3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767592; c=relaxed/simple;
	bh=Y4l3ZfOIPZ+WCek7NkLHDtyXuwNXPzs0gg5OHknB2V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLoXsSTxWIS77wFQU6CeTp+pEWDA6vwKilTyWhNcO1HEsb9S5dACcfZtw0EYvalNRGm5R/8HeqnBvqYtFbP8UGJ2NKW6pwEuzRQvnzojNCcZsww7oLySf/FfHBt+aCYRxLPOsrl3eFI4iHng1rPpkw0pTp+hcHYsymbb76RIymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1ZTdznU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733767591; x=1765303591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y4l3ZfOIPZ+WCek7NkLHDtyXuwNXPzs0gg5OHknB2V4=;
  b=U1ZTdznUUMBmJZtsLQIRaVV4D3ik0Uzcn5kZJ+wVclx2Q1Qe6dLbZ1El
   fN2S+QweTkws1q7a4XXVfpQeheaHWI+H9ewgJCvnkBqwVi1Q5q8/XKK1V
   lIMK9MjAwKVytESsAZhXXO6I4EbvoG8Ra4Eb/7Q2dAH5vmUhPLZ0OroMv
   HyV2hZnOOjGlp8HZNDNgRd1ySmmzG0+ekzyZ2lkUV9fb1uIHumtvwGNOc
   QPOjmNcV6rLbMsFp0GSaHWGNMclBUcKU6nkj5tQbqOp68uEo5v0B8DWWt
   5ENAClz2ycNfA0FrCYeJ+lrEnMYvI3XpWW+/ZF/On9d2QvKbm4fWlgb7T
   w==;
X-CSE-ConnectionGUID: Vxo5CIgXQFqy85/GGlpzhQ==
X-CSE-MsgGUID: 14Lh4ymYRC6zl9+YbDK3wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34214229"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="34214229"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:06:31 -0800
X-CSE-ConnectionGUID: B7e4zTAmQaiXDCJjfx4OmA==
X-CSE-MsgGUID: PVdSbbJ+Q8mtVg3NMCy5fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="100192653"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:06:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tKi9J-00000005pHn-2HVa;
	Mon, 09 Dec 2024 20:06:25 +0200
Date: Mon, 9 Dec 2024 20:06:25 +0200
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
Message-ID: <Z1cxoUFCnkN0Ux24@smile.fi.intel.com>
References: <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
 <Z0j3EtRmYBmGFApu@google.com>
 <Z0nUpytu0GFUgQ9V@smile.fi.intel.com>
 <Z0q75n_P3sZYnviO@google.com>
 <Z0uHJJKMog-REw1D@smile.fi.intel.com>
 <Z06b0oTvxUi4DTlx@google.com>
 <Z08HQ2JmETJLNuud@smile.fi.intel.com>
 <Z0-KHYnhu81ljbDk@google.com>
 <Z0-tcsOw5imlWZn4@smile.fi.intel.com>
 <Z1ITwpJcwPNc37X_@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1ITwpJcwPNc37X_@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 05, 2024 at 12:57:38PM -0800, Dmitry Torokhov wrote:
> On Wed, Dec 04, 2024 at 03:16:34AM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 03, 2024 at 02:45:49PM -0800, Dmitry Torokhov wrote:
> > > On Tue, Dec 03, 2024 at 03:27:31PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Dec 02, 2024 at 09:49:06PM -0800, Dmitry Torokhov wrote:
> > > > > On Sat, Nov 30, 2024 at 11:44:04PM +0200, Andy Shevchenko wrote:
> > > > > > On Fri, Nov 29, 2024 at 11:16:54PM -0800, Dmitry Torokhov wrote:
> > > > > > > On Fri, Nov 29, 2024 at 04:50:15PM +0200, Andy Shevchenko wrote:
> > > > > > > > On Thu, Nov 28, 2024 at 03:04:50PM -0800, Dmitry Torokhov wrote:
> > > > > > > > > On Thu, Nov 28, 2024 at 03:13:16PM +0200, Andy Shevchenko wrote:
> > > > > > > > > > On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:

...

> > > > > > > > > > > @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> > > > > > > > > > >  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > > > > > > > >  	struct fwnode_handle *next;
> > > > > > > > > > 
> > > > > > > > > > > -	if (IS_ERR_OR_NULL(fwnode))
> > > > > > > > > > > +	if (IS_ERR_OR_NULL(fwnode)) {
> > > > > > > > > > > +		fwnode_handle_put(child);
> > > > > > > > > > >  		return NULL;
> > > > > > > > > > > +	}
> > > > > > > > > > 
> > > > > > > > > > >  	/* Try to find a child in primary fwnode */
> > > > > > > > > > >  	next = fwnode_get_next_child_node(fwnode, child);
> > > > > > > > > > 
> > > > > > > > > > So, why not just moving the original check (w/o dropping the reference) here?
> > > > > > > > > > Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?
> > > > > > > > > 
> > > > > > > > > Because if you rely on check in fwnode_get_next_child_node() you would
> > > > > > > > > not know if it returned NULL because there are no more children or
> > > > > > > > > because the node is invalid. In the latter case you can't dereference
> > > > > > > > > fwnode->secondary.
> > > > > > > > 
> > > > > > > > Yes, so, how does it contradict my proposal?
> > > > > > > 
> > > > > > > I guess I misunderstood your proposal then. Could you please explain it
> > > > > > > in more detail?
> > > > > > 
> > > > > > 
> > > > > > Current code (in steps):
> > > > > > 	if (IS_ERR_OR_NULL()) check
> > > > > > 	trying primary
> > > > > > 	trying secondary if previous is NULL
> > > > > > 
> > > > > > 
> > > > > > My proposal
> > > > > > 
> > > > > > 	trying primary
> > > > > > 	return if not NULL
> > > > > > 	if (IS_ERR_OR_NULL()) check in its current form (no put op)
> > > > > > 	trying secondary
> > > > > > 
> > > > > > After your first patch IIUC this is possible as trying primary will put child uncoditionally.
> > > > > 
> > > > > Ah, I see. No, I do not think this is a good idea: it will make the code
> > > > > harder to understand for a casual reader: "Why do we check node validity
> > > > > only after we used it for the first time?"
> > > > 
> > > > Theare a re already a few API calls there that are hard to understand, I spent
> > > > some time on them to get it through and still got it wrong as this series
> > > > shows. So, I don't think we anyhow change this.
> > > 
> > > The fact that some code is confusing does not mean that we should add
> > > more confusing code. We will not fix everything at once, but we can make
> > > things better bit by bit.
> > > 
> > > Look, the check where it is now makes total sense, you added it there
> > > yourself! It checks that we are dealing with a valid node and returns
> > > early. The intent is very easy to understand and the only thing that is
> > > missing is that "put" operation to satisfy the documented behavior.
> > > Anything more just makes things more complex for no good reason.
> > 
> > Right, that's why I think we need to go away from open coding the iteration
> > over the list of nodes (primary, secondary, etc).
> > 
> > > > > For the code not in a hot path there is a lot of value in simplicity.
> > > > 
> > > > If you really want to go to this rabbit hole, think how we can get rid of
> > > > repetitive checks of the secondary or more if any in the future nodes in the
> > > > list.
> > > > 
> > > > So the basic idea is to have this all hidden (to some extent) behind the macro
> > > > or alike. In the code it would be something as
> > > > 
> > > >   for node in primary, secondary, ...
> > > >     call the API
> > > >     if (okay)
> > > > 	return result
> > > > 
> > > >   return error
> > > > 
> > > > This will indeed help.
> > > 
> > > I think this will indeed help if we ever going to have more than primary
> > > and secondary nodes. It is also tricky if you want to transition
> > > seamlessly between different types of nodes (i.e. you have ACPI primary
> > > with OF overlay secondary with swnode as tertiary etc). And you probably
> > > want to add support for references between different typesof nodes
> > > (i.e. swnode being able to reference OF device node for example).
> > > 
> > > This kind of rework is however out of scope of what I have time to do at
> > > the moment.
> > 
> > I am not asking you to invest into big rework, the idea is to try to fold the
> > iterations to a kind of loop. Is it feasible?
> 
> We could potentially do something like below.
> 
> BTW, do you know why fwnode_property_get_reference_args() returns
> -ENOENT for NULL or error fwnode instead of -EINVAL as the rest of them?

I think we need to ask author, but I believe it's due to the OF analogue.
(Haven't checked myself, though)

> And would you object to unifying this?

...

> +#define FWNODE_ITERATE(n, result, cont_val, op, ...)				\

for_each_fwnode() or alike.

> +({										\
> +	int __ret = -EINVAL;							\
> +	typeof(result) __r;							\
> +										\
> +	for (const struct fwnode_handle *__node = n;				\
> +	     !IS_ERR_OR_NULL(__node);						\
> +	     __node = __node->secondary) {					\
> +	        if (!__node->ops || !__node->ops->op) {				\
> +			__ret = -ENXIO;						\
> +			continue;						\
> +		}								\
> +		__r = __node->ops->op(__node, ## __VA_ARGS__);			\
> +		if (__r != cont_val) {						\
> +			result = __r;						\
> +			__ret = 0;						\
> +			break;							\
> +		}								\
> +	}									\
> +	__ret;									\

With a bit of polishing this may be the way to go.

> +})

-- 
With Best Regards,
Andy Shevchenko



