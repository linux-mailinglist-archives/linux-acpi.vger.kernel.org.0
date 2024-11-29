Return-Path: <linux-acpi+bounces-9797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD39DE8ED
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2024 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C09EB20E09
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2024 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3821182D66;
	Fri, 29 Nov 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgoSvC5V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596021FAA;
	Fri, 29 Nov 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891823; cv=none; b=FDwlAXv2Ts5dvyv3JNX7R64c90BnDgyMM9vxIDnTpnaVd3Js9a2AYxalMgR79nWicXc9iPdoG4wRDD6hPe/sVeUQ8EBFRamWG5V+AzkwYHFJmmKCIRqdsyN2WK8aMNl7xaWQA16XCUfRkpaVayMBgmpb64lHZ0swAKPKaaTcBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891823; c=relaxed/simple;
	bh=9EItK1iBzO7hrcXR2AeXKOb3MdaLUN4UUJ0sqF+4WwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaKFUspMLoowhX5L1x0dLQs/k14s3vHPs7Jk/M7s0LofeBFD5NgbeYshOFGJB/x0g5SUNJJjDkv/sajzJiTG6/M+sC10VPeXT/1FpzukM5QcRbJR/7KF3gPNq7lXAwh8Mz/TuDwc1ICmtB+N6QSDspCukrsEcJUQApQbU+I7AZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgoSvC5V; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732891822; x=1764427822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9EItK1iBzO7hrcXR2AeXKOb3MdaLUN4UUJ0sqF+4WwE=;
  b=XgoSvC5VJRgH9q2GIB+9sojN2gvDHB7FgsDmO2EomBHcRLrVu04mu498
   1LuHRkZnI3yzMP5Np6DFVpG/2zsWznVJue6jn+xtFO9+d4eDnR06oN2qf
   PPW9Sf86oOpbATtawl336QBCS1SInccK/vRC6exdAc300o3uqWB5s9NNa
   A98dCQwFcalKJWikheo4Yl4qGSJYC0m9pJjPMoQhmGvSZ49TIVosz3sMj
   dbSWQG51aI+T69M4FNvMwomONXQekYVB6wrChRntsj2xmBq+uEK7soJ73
   N+eXnF5sACS9pt7CbxIOwY4feBYnEYrB3lSquB11u82g1os6j7jYd7ojt
   A==;
X-CSE-ConnectionGUID: NM63QFd9SjKFjvh1DmDt/w==
X-CSE-MsgGUID: R8/k7llpSIm4+aJDMnQT1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="33283814"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="33283814"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 06:50:21 -0800
X-CSE-ConnectionGUID: JbrrgPEvThmP7G44kajMDA==
X-CSE-MsgGUID: 7MTo6NdiQfe5HGHQnh6lSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="92318485"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 06:50:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tH2K0-00000002Ghe-0tsO;
	Fri, 29 Nov 2024 16:50:16 +0200
Date: Fri, 29 Nov 2024 16:50:15 +0200
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
Message-ID: <Z0nUpytu0GFUgQ9V@smile.fi.intel.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
 <Z0j3EtRmYBmGFApu@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0j3EtRmYBmGFApu@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 28, 2024 at 03:04:50PM -0800, Dmitry Torokhov wrote:
> On Thu, Nov 28, 2024 at 03:13:16PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:
> > > The documentation to various API calls that locate children for a given
> > > fwnode (such as fwnode_get_next_available_child_node() or
> > > device_get_next_child_node()) states that the reference to the node
> > > passed in "child" argument is dropped unconditionally, however the
> > > change that added checks for the main node to be NULL or error pointer
> > > broke this promise.
> > 
> > This commit message doesn't explain a use case. Hence it might be just
> > a documentation issue, please elaborate.
> 
> I do not have a specific use case in mind, however the implementation
> behavior does not match the stated one, and so it makes sense to get it
> fixed. Otherwise callers would have to add checks to conditionally drop
> the reference to "child" argument in certain cases, which will
> complicate caller's code.

Perhaps this should be somewhere between the cover letter / commit message?

> > > Add missing fwnode_handle_put() calls to restore the documented
> > > behavior.

...

> > >  {
> > > +	if (IS_ERR_OR_NULL(fwnode) ||
> > 
> > Unneeded check as fwnode_has_op() has it already.
> 
> Yes, it has, but that is not obvious nor it is a documented behavior of
> fwnode_has_op().

Would like to document that then?

> It also different semantics: it checks whether a fwnode
> implements a given operation, not whether fwnode is valid. That check is
> incidental in fwnode_has_op().

I kinda disagree on this. The invalid fwnode may not have any operations,
so it's implied and will always be like that.

> They all are macros so compiler should collapse duplicate checks, but if
> you feel really strongly about it I can drop IS_ERR_OR_NULL() check.

Yes, please drop it and rather we want fwnode_has_op() to be documented with
main purpose and guaranteed side effect (the latter makes no need of
duplication that I pointed out).

> > > +	    !fwnode_has_op(fwnode, get_next_child_node)) {
> > > +		fwnode_handle_put(child);
> > > +		return NULL;
> > > +	}

...

> > > @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> > >  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> > >  	struct fwnode_handle *next;
> > 
> > > -	if (IS_ERR_OR_NULL(fwnode))
> > > +	if (IS_ERR_OR_NULL(fwnode)) {
> > > +		fwnode_handle_put(child);
> > >  		return NULL;
> > > +	}
> > 
> > >  	/* Try to find a child in primary fwnode */
> > >  	next = fwnode_get_next_child_node(fwnode, child);
> > 
> > So, why not just moving the original check (w/o dropping the reference) here?
> > Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?
> 
> Because if you rely on check in fwnode_get_next_child_node() you would
> not know if it returned NULL because there are no more children or
> because the node is invalid. In the latter case you can't dereference
> fwnode->secondary.

Yes, so, how does it contradict my proposal?

-- 
With Best Regards,
Andy Shevchenko



