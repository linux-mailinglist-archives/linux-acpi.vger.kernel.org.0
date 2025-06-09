Return-Path: <linux-acpi+bounces-14252-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AACAD2344
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 18:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB7918865DC
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57671217648;
	Mon,  9 Jun 2025 16:05:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A820125F;
	Mon,  9 Jun 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485118; cv=none; b=urB+wI3agBoQGFkYHtwMmcPrz+JdRjUCR0G7J/dYy3C6Bh4THTTfNuH47+tn8cAGEUGrXZr9x43CEZ5Tj2OsuGTezkf9N5nS1eyD2LxzTBPwW2BEBFX5bUX4h/yaH20B1pPX+xEfEe1WatanJtPHJjlRZV3HkVUEl9E0TEYAlz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485118; c=relaxed/simple;
	bh=utDUVMOkzXdVkyrfJC2/3sY336KJeXgCz1ZGWZEglxE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/lJXeXbV4ZOQpUj/X0EbICoauKqM9H097piSgbRgzIGYmOUidmkhdUz/OtvMGSrBlDXLsquXbDl/N5sID7Z1MMAgaEs5PYdRmVbBAauIP5w1tNenCDuisqgAt8MWFWcX3Sb+mMCAiwL1nSVwbD6FWH+WSsoDjJgglpbWTBF9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGGqb0y8Mz6L5mv;
	Tue, 10 Jun 2025 00:00:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 860BD140276;
	Tue, 10 Jun 2025 00:05:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 18:05:10 +0200
Date: Mon, 9 Jun 2025 17:05:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, <rafael.j.wysocki@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: Re: [PATCH 3/3] ACPI: APEI: EINJ: Do not fail einj_init() on
 faux_device_create() failure
Message-ID: <20250609170509.00003625@huawei.com>
In-Reply-To: <2025060954-district-breeder-2c3e@gregkh>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
	<20250607033228.1475625-4-dan.j.williams@intel.com>
	<20250609111758.0000258d@huawei.com>
	<2025060954-district-breeder-2c3e@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 9 Jun 2025 12:42:53 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Jun 09, 2025 at 11:17:58AM +0100, Jonathan Cameron wrote:
> > On Fri, 6 Jun 2025 20:32:28 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > CXL has a symbol dependency on einj_core.ko, so if einj_init() fails then
> > > cxl_core.ko fails to load. Prior to the faux_device_create() conversion,
> > > einj_probe() failures were tracked by the einj_initialized flag without
> > > failing einj_init().
> > > 
> > > Revert to that behavior and always succeed einj_init() given there is no
> > > way, and no pressing need, to discern faux device-create vs device-probe
> > > failures.
> > > 
> > > This situation arose because CXL knows proper kernel named objects to
> > > trigger errors against, but acpi-einj knows how to perform the error
> > > injection. The injection mechanism is shared with non-CXL use cases. The
> > > result is CXL now has a module dependency on einj-core.ko, and init/probe
> > > failures are handled at runtime.
> > > 
> > > Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/acpi/apei/einj-core.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> > > index fea11a35eea3..9b041415a9d0 100644
> > > --- a/drivers/acpi/apei/einj-core.c
> > > +++ b/drivers/acpi/apei/einj-core.c
> > > @@ -883,19 +883,16 @@ static int __init einj_init(void)
> > >  	}
> > >  
> > >  	einj_dev = faux_device_create("acpi-einj", NULL, &einj_device_ops);
> > > -	if (!einj_dev)
> > > -		return -ENODEV;
> > >  
> > > -	einj_initialized = true;
> > > +	if (einj_dev)
> > > +		einj_initialized = true;
> > >  
> > >  	return 0;
> > >  }
> > >  
> > >  static void __exit einj_exit(void)
> > >  {
> > > -	if (einj_initialized)
> > > -		faux_device_destroy(einj_dev);
> > > -
> > > +	faux_device_destroy(einj_dev);  
> > 
> > Hi Dan,
> > 
> > Thi bit is sort of fine though not really related, because
> > faux_device_destroy() checks
> > 
> > void faux_device_destroy(struct faux_device *faux_dev)
> > {
> > 	struct device *dev = &faux_dev->dev;
> > 
> > 	if (!faux_dev)
> > 		return;
> > 
> > Though that check is after a dereference of faux_dev
> > which doesn't look right to me.  Might be fine because
> > of how the kernel is built (I can't remember where we ended
> > up on topic of compilers making undefined behavior based
> > optimizations).  Still not that nice from a logical point of view!  
> 
> I think this is fine as we just put "0 + offset of dev" into dev, and
> didn't do anything with that (i.e. no actual read of that memory
> location happened).  The compiler shouldn't be doing anything that could
> happen after the return before we check for a valid pointer here, right?

Hmm. I did some digging. Seems that was debated 10 years ago without
a huge amount of clarity on the answer beyond all sane people telling
compiler folk not to use this in optimizations :)

Comes down to whether any dereference of NULL is UB whether or not
the compiler can just do a simple offset calculation.

Anyhow, whilst fine, it's still a little ugly to my eyes :(

Jonathan



> 
> thanks,
> 
> greg k-h
> 


