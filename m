Return-Path: <linux-acpi+bounces-14239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701F3AD1BBE
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 12:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37661188DD0C
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9106253956;
	Mon,  9 Jun 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v0jpNaGt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB495253358;
	Mon,  9 Jun 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749465782; cv=none; b=AzyLk3Ow9B72lGpEk2y+q2cpGIvyAUMAAaDnPF2oUKcyTRqAgrhWNkUkHNAUVxY4Sli3fVilkt0fXERdIQLXW6YOcvCBRt2kdz/k3k8tvWB0LkZrRgvu5oW1Je7yj7CcSxcSfz+yeOyn2gmUc7ub2ac2n/hC04FQPJNZNjQTtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749465782; c=relaxed/simple;
	bh=RO0M5v7DMElc6ChipnWpEqVr3s8Oz/7GQJ9z5A8pIUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoiuD2VOZVzRDeRXKsYbGwjVp4lkcelRmyi0b+wEKcOBjOloAxgLOGpJ7wCGuGAXZpIVTuyvl3G+OJ0y+U2riRMwoPDjrqM1jEIKlOOVDBbW4zI7vIJUBjQb28Z/RwNbx/pQ2/y4HvPQ+oQ6tbWTV2buVBqNLk8y1GkNyXJ43Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v0jpNaGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D79C4CEEB;
	Mon,  9 Jun 2025 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749465782;
	bh=RO0M5v7DMElc6ChipnWpEqVr3s8Oz/7GQJ9z5A8pIUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v0jpNaGtYcfgBNwB9QHKxk53cdsW/8wa8sGn2pYhvI5IACqvWHaiILp/4fBmTxHYG
	 oq2vrXcwDoqIVXX0lINDR4h47F5VkHwnp0liveJXl7Fzk92Ti8nmc8a4d41eg0PfAY
	 aoWG1RMo9AgZKxgvK1+mKuDotexUqFcHcZe/EEZY=
Date: Mon, 9 Jun 2025 12:42:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, rafael.j.wysocki@intel.com,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: Re: [PATCH 3/3] ACPI: APEI: EINJ: Do not fail einj_init() on
 faux_device_create() failure
Message-ID: <2025060954-district-breeder-2c3e@gregkh>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
 <20250607033228.1475625-4-dan.j.williams@intel.com>
 <20250609111758.0000258d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609111758.0000258d@huawei.com>

On Mon, Jun 09, 2025 at 11:17:58AM +0100, Jonathan Cameron wrote:
> On Fri, 6 Jun 2025 20:32:28 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > CXL has a symbol dependency on einj_core.ko, so if einj_init() fails then
> > cxl_core.ko fails to load. Prior to the faux_device_create() conversion,
> > einj_probe() failures were tracked by the einj_initialized flag without
> > failing einj_init().
> > 
> > Revert to that behavior and always succeed einj_init() given there is no
> > way, and no pressing need, to discern faux device-create vs device-probe
> > failures.
> > 
> > This situation arose because CXL knows proper kernel named objects to
> > trigger errors against, but acpi-einj knows how to perform the error
> > injection. The injection mechanism is shared with non-CXL use cases. The
> > result is CXL now has a module dependency on einj-core.ko, and init/probe
> > failures are handled at runtime.
> > 
> > Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/acpi/apei/einj-core.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> > index fea11a35eea3..9b041415a9d0 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -883,19 +883,16 @@ static int __init einj_init(void)
> >  	}
> >  
> >  	einj_dev = faux_device_create("acpi-einj", NULL, &einj_device_ops);
> > -	if (!einj_dev)
> > -		return -ENODEV;
> >  
> > -	einj_initialized = true;
> > +	if (einj_dev)
> > +		einj_initialized = true;
> >  
> >  	return 0;
> >  }
> >  
> >  static void __exit einj_exit(void)
> >  {
> > -	if (einj_initialized)
> > -		faux_device_destroy(einj_dev);
> > -
> > +	faux_device_destroy(einj_dev);
> 
> Hi Dan,
> 
> Thi bit is sort of fine though not really related, because
> faux_device_destroy() checks
> 
> void faux_device_destroy(struct faux_device *faux_dev)
> {
> 	struct device *dev = &faux_dev->dev;
> 
> 	if (!faux_dev)
> 		return;
> 
> Though that check is after a dereference of faux_dev
> which doesn't look right to me.  Might be fine because
> of how the kernel is built (I can't remember where we ended
> up on topic of compilers making undefined behavior based
> optimizations).  Still not that nice from a logical point of view!

I think this is fine as we just put "0 + offset of dev" into dev, and
didn't do anything with that (i.e. no actual read of that memory
location happened).  The compiler shouldn't be doing anything that could
happen after the return before we check for a valid pointer here, right?

thanks,

greg k-h

