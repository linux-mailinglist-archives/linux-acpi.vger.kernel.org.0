Return-Path: <linux-acpi+bounces-21115-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIVkFLVnnWlgPQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21115-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 09:56:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 746DF18416B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 09:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 092C6303F090
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 08:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58937369220;
	Tue, 24 Feb 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOwwjwnp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B457369209;
	Tue, 24 Feb 2026 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923356; cv=none; b=AiySLV0bnkoSetQgk0nsvKwuZRT+BTvwmH9WzOEgwFNznpi2f/UJaRvI0cFdBUNtO96JSzbszp/QpUaf84PvtYk5FLwPcOFsxhtY4eBqpHdweHYGVmdR8jgl2PRv+QXOaQsy/tu+h2JHhWsEWXJ4/INmkGJ9fxiqKtd80/O/7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923356; c=relaxed/simple;
	bh=Dojfc4lY1jGJgubjie+JVgOABa0MLrHT4L0P9hEX72A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECI6Q32UTb9p4Wtil7//IHVNgsV+Y4yGdlyT1Dbb12FO5qwhGGCaC7+u7fpQChzBAaEIezq1w3EdfDqoi89Kby+BIJDoxNrn5ru570vTRXWVdxtP+y9tsrb6DZ0At50X86Qmmwyet11VDawGLOfxLd3wF2Rk12/HlbKKrtnSwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOwwjwnp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771923355; x=1803459355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Dojfc4lY1jGJgubjie+JVgOABa0MLrHT4L0P9hEX72A=;
  b=iOwwjwnpJD1VX60y8BMX18uwW/3o2WFqpAsvFLIvyevsbo4DHy7QCkWa
   wnBUgWpXua83HIXrb5X/Qx4B5+iCyWsUTcBkLcU6XJUDDIIiuiineBB2r
   Q+Of2qY0zWqkiDihhJD74gUoSUK1mpmoeShTEA5uCg69uXa7iXTepnrQ3
   /qKeZV9zEDaDRF1NmDNF+jz1ZeL7uT6UnAykTv5Y3bZFl4JXjCSkq1Eka
   mlIDDkwH3z8c6oVh0dLx0oKxBaULefjp1mM6FQFnExvmV8jOMZRVZHJMT
   F+0NpCHC6WPqXSMgQZ1Iy/WOJ1PgJAJxZRP/70kCoxQeR6Nbr+jshDRuh
   w==;
X-CSE-ConnectionGUID: 8oqkLqIOSXGeEOPgtLyOTw==
X-CSE-MsgGUID: bLvHi9oxRT2yuBzDNWTeSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83554803"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="83554803"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 00:55:54 -0800
X-CSE-ConnectionGUID: p5CrduGGR3uxnZCWCZAOIw==
X-CSE-MsgGUID: 9EuYBeM8SH2gzKnEupuo9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220359469"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.104])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 00:55:51 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 4770611F70F;
	Tue, 24 Feb 2026 10:56:16 +0200 (EET)
Date: Tue, 24 Feb 2026 10:56:16 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <aZ1nsPX36Y5DuDpr@kekkonen.localdomain>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
 <aZyNErXB_acR3yYq@kekkonen.localdomain>
 <CAJZ5v0ibXKiUNf5Fvj=q=f9JbHT=w3j3h=33ri_awzEHm_dBng@mail.gmail.com>
 <aZzPqbXH79Q6GvEn@kekkonen.localdomain>
 <CAMRc=MeSbRySCe9wuEUifhOxzX2PydsjnttAJ_n=Nr1NdU6W5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeSbRySCe9wuEUifhOxzX2PydsjnttAJ_n=Nr1NdU6W5w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,oss.qualcomm.com,linuxfoundation.org,gmail.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21115-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakari.ailus@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kekkonen.localdomain:mid]
X-Rspamd-Queue-Id: 746DF18416B
X-Rspamd-Action: no action

Hi Bartosz,

On Tue, Feb 24, 2026 at 09:47:57AM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 23, 2026 at 11:07 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > > > >
> > > > >  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *fwnode)
> > > > >  {
> > > > > -     return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> > > > > +     struct device *dev = &gc->gpiodev->dev;
> > > > > +     struct fwnode_handle *node = dev_fwnode(dev);
> > > > > +
> > > > > +     if (IS_ERR(fwnode))
> > > > > +             return 0;
> > > > > +
> > > > > +     if (device_match_fwnode(dev, fwnode))
> > > >
> > > > Could device_match_fwnode() match secondary fwnode as well?
> > >
> > > In the previous discussion on this, Andy was against doing that due to
> > > the concern that it might introduce subtle bugs, which I agree with.
> >
> > Could you elaborate or provide an example?
> >
> > The function has some 27 users although few are individual drivers.
> >
> > My understanding is that we only have the secondary fwnode for being able
> > to attach objects from different backend to the same node. The fwnode API
> > in the meantime generally tries to hide the existence of the secondary
> > fwnode; a rewrite (which ideally would have happened perhaps a few years
> > ago?) would probably make the fwnode a linked list instead so we'd lose
> > that secondary pointer in the process.
> >
> 
> It already is a (singly) linked list. Ideally it would be a

With two entries at most.

> doubly-linked list moved into struct device with struct fwnode_handle
> having no concept of primary and secondary nodes.

I'd think we had that list in struct fwnode_handle, which will still
represent nodes. But let's see the details when someone gets to implement
it. :-)

-- 
Kind regards,

Sakari Ailus

