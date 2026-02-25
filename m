Return-Path: <linux-acpi+bounces-21145-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCB4C1annmmrWgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21145-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 08:40:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB351939A0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 08:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E47873078FE0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F072D73BE;
	Wed, 25 Feb 2026 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdXqckg4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA095284B26;
	Wed, 25 Feb 2026 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005131; cv=none; b=JC2UO4bOboXhxdZ9wIDE6jrp+b5URAuLmTSqtX7kAlXVKQV5PsIha2pxc8l8sLJxwJCJDCf9qyzya0IHyFDUNpUeX+nvsBbXI/VTNzyPmwyEf9L4MiPbFT9WqV3Kl+9sp0oRoI6pZNDQpTVRL7wL9Yn6P7rciZnahMZ3BrLZ2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005131; c=relaxed/simple;
	bh=lS4yqBnLA6YNBCx1H7wIWvSQxywB8aLgaTJUNH0vjIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPcAnSGDvfH0wnMKuR54S+c64FRzlD107+Sqhc5OG9Z5Qvmn6ny0lFvq1pyojcyyI7DR5YXBzo1Bgut81q2o3zEEnIrkKApr86eMDwji/R0GE5wfgfkO/GsqdJ5Ogx2E3yoGugx2HZucP5awCxnQyoYrH4Xs7++BmKLZ4s+s10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdXqckg4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772005130; x=1803541130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lS4yqBnLA6YNBCx1H7wIWvSQxywB8aLgaTJUNH0vjIo=;
  b=OdXqckg47NT/aFc07DJpdRrzZ3k6olAHsEb/rHUTH8ZpO57D69U4f4IQ
   PoZWJVQAA8ysF8lU8dNkHyk4PcTJFyCGg/QjK3s7Fu0wISCD+PE7bMo0T
   isw3BAuYTOouCga7TUx45JrlGxoOio7bX1g6yxAeRCxtXi1ub6pnJhjnz
   P4lG8TfhL2S2uWJTJaCQ7q72+c12W9X0o0csrU56GvY/VTRFW0N3m8GJ3
   5rsUHmwknV/TyIbkWuvRWg5bACDOAnHj3WyjRvlUUqkby2UyeHKC1uDok
   r/EHZ+1sK3pYd6JNDQhVmw5bpLBdPZ5pnNH5WCisXl9Sc3Gt2XmSaOpOG
   Q==;
X-CSE-ConnectionGUID: QnEkWckFR8Oey1I8cl9E0g==
X-CSE-MsgGUID: l2UgJK4PRaKLF31Npv28Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76904375"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="76904375"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 23:38:49 -0800
X-CSE-ConnectionGUID: lGSkHTVCSEKimV9xNHzgZw==
X-CSE-MsgGUID: hhvdLbXJQemhwzdfPFPKiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="216034318"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.32])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 23:38:45 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 63E7A121D20;
	Wed, 25 Feb 2026 09:39:12 +0200 (EET)
Date: Wed, 25 Feb 2026 09:39:12 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Message-ID: <aZ6nIK2AbPBHUVfq@kekkonen.localdomain>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
 <aZyNErXB_acR3yYq@kekkonen.localdomain>
 <CAJZ5v0ibXKiUNf5Fvj=q=f9JbHT=w3j3h=33ri_awzEHm_dBng@mail.gmail.com>
 <aZzPqbXH79Q6GvEn@kekkonen.localdomain>
 <CAMRc=MeSbRySCe9wuEUifhOxzX2PydsjnttAJ_n=Nr1NdU6W5w@mail.gmail.com>
 <aZ1nsPX36Y5DuDpr@kekkonen.localdomain>
 <aZ1yyxshteYU2BAg@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ1yyxshteYU2BAg@smile.fi.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linuxfoundation.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21145-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakari.ailus@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BEB351939A0
X-Rspamd-Action: no action

Hi Andy,

On Tue, Feb 24, 2026 at 11:43:39AM +0200, Andy Shevchenko wrote:
> On Tue, Feb 24, 2026 at 10:56:16AM +0200, Sakari Ailus wrote:
> > On Tue, Feb 24, 2026 at 09:47:57AM +0100, Bartosz Golaszewski wrote:
> > > On Mon, Feb 23, 2026 at 11:07 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> 
> ...
> 
> > > > > > >  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *fwnode)
> > > > > > >  {
> > > > > > > -     return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> > > > > > > +     struct device *dev = &gc->gpiodev->dev;
> > > > > > > +     struct fwnode_handle *node = dev_fwnode(dev);
> > > > > > > +
> > > > > > > +     if (IS_ERR(fwnode))
> > > > > > > +             return 0;
> > > > > > > +
> > > > > > > +     if (device_match_fwnode(dev, fwnode))
> > > > > >
> > > > > > Could device_match_fwnode() match secondary fwnode as well?
> > > > >
> > > > > In the previous discussion on this, Andy was against doing that due to
> > > > > the concern that it might introduce subtle bugs, which I agree with.
> > > >
> > > > Could you elaborate or provide an example?
> 
> I believe you ask me. Okay, the sophisticated case I have in mind is the
> intel_quark_i2c_gpio.c which provides a GPIO device with a list of children.
> 
> First of all, it seems broken as it rewrites the secondary link for the
> I²C device. (Which makes me think that we need to have a copy of the
> [primary] fwnode in the children devices of MFD, but I don't know how
> to refcount that properly). The gpiolib-acpi-core.c has a matching function
> via ACPI_HANDLE(). So it might be not affected by this.
> 
> What I don't know is USB Type-C and USB DWC3 code where it's much more
> complicated. And I'm not in a position to state that the change won't
> affect those.

Any idea who has the hardware in these cases? There aren't that many users
of this function out there and I think at some point we do need to fix
this.

What we could also do is that we add another function that only cares about
the very fwnode you have at hand, switch the dubious cases to use that and
have the proper function test both available fwnodes. That'd get us on the
right path to fix this eventually, if not now.

> 
> > > > The function has some 27 users although few are individual drivers.
> > > >
> > > > My understanding is that we only have the secondary fwnode for being able
> > > > to attach objects from different backend to the same node. The fwnode API
> > > > in the meantime generally tries to hide the existence of the secondary
> > > > fwnode; a rewrite (which ideally would have happened perhaps a few years
> > > > ago?) would probably make the fwnode a linked list instead so we'd lose
> > > > that secondary pointer in the process.
> > > 
> > > It already is a (singly) linked list. Ideally it would be a
> > 
> > With two entries at most.
> 
> There is no technical limitation based on the data type.

There aren't any, no, but the current implementation assumes this, and I
wouldn't change this without changing the data structure as well.

> 
> > > doubly-linked list moved into struct device with struct fwnode_handle
> > > having no concept of primary and secondary nodes.
> > 
> > I'd think we had that list in struct fwnode_handle, which will still
> > represent nodes. But let's see the details when someone gets to implement
> > it. :-)
> 
> In the case above single or double linked list doesn't solve the issue of
> the corrupted (parent) fwnode. We need also to have a siblings list so it
> looks more like a tree.
> 

-- 
Regards,

Sakari Ailus

