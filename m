Return-Path: <linux-acpi+bounces-21119-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNS1Gl1znWmAQAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21119-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:46:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0D9184E2B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0817D3101DBD
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715D36EA88;
	Tue, 24 Feb 2026 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yd4Iq+F/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD836E477;
	Tue, 24 Feb 2026 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926227; cv=none; b=cpNvwfg/s4eKIq92Jk2CZmlLi6dgxwdsIjyPYtTcdcT49jSLg8QsEjVOH8wJ/Si2qIEr1fQkb4jcquxc40z8Z2kS8BEc6v6MIHQm6nGhuX/DDG2KJ1yUOsmwEkUToqr3Czb0A6K/rOl0XgoJa2w1RncGp6H3105EsHlRyDjWPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926227; c=relaxed/simple;
	bh=26QMdg0hEVO6yJPDPsExraWWw+rvU+ntty1r2FB2pfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcBzEJ4nQ4sjybbYBBph/PZajhP/hzIMJkNXMDBDWUsi/HfiQYLfxYth0h2FviHl8b1Kf9087mlgt6g4yp0b44MKf1UWRs15QBuRhH/oZJTNH/qB/5q2O7piXS1HsNVrVMCqOnB9iJ0XWabUataCxG8OT268UeNkwa8aRHUC32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yd4Iq+F/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771926226; x=1803462226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=26QMdg0hEVO6yJPDPsExraWWw+rvU+ntty1r2FB2pfs=;
  b=Yd4Iq+F/BgaYrvIIOdTDGyM4q71q8G7cBgjuiwEFEAUUSdqaRJ7cFQqZ
   w/Ov4C8DEjhVbmJK40ZSu1pZNB1gYcbHjE1OpwN1Fk5h1WGWErTtC8c85
   v5U4nh24GZZXcPb3ifQCbvkczd0aVKV+k875G5EpoHYuTuJiEQBFOtyXL
   3nlBvQNPmgPxfbOauNtfL1rdCdZlb3WN3ZlYcNwvQEcK3tf/J4cp/XrOe
   0/HBEorwLk5/H+YVYjEzbxMXttg0nRFm1L7Pp+Mh3w2teb8FMCPov2gI6
   G5qos4d8kE30KVZnVuLQnLW3WWCCjQeo849Sl9RTtffeRX5Xlqgs/X9E4
   A==;
X-CSE-ConnectionGUID: yu71uJsERP+NVVMrfhOFFg==
X-CSE-MsgGUID: OwlX9kcGSsGiqXxIX4N/YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72640380"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72640380"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:43:45 -0800
X-CSE-ConnectionGUID: LInzymtYRXqIKLfPflPCbw==
X-CSE-MsgGUID: wjJlLgC0TFOUWcphC7T1LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="246430905"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:43:41 -0800
Date: Tue, 24 Feb 2026 11:43:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
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
Message-ID: <aZ1yyxshteYU2BAg@smile.fi.intel.com>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
 <aZyNErXB_acR3yYq@kekkonen.localdomain>
 <CAJZ5v0ibXKiUNf5Fvj=q=f9JbHT=w3j3h=33ri_awzEHm_dBng@mail.gmail.com>
 <aZzPqbXH79Q6GvEn@kekkonen.localdomain>
 <CAMRc=MeSbRySCe9wuEUifhOxzX2PydsjnttAJ_n=Nr1NdU6W5w@mail.gmail.com>
 <aZ1nsPX36Y5DuDpr@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ1nsPX36Y5DuDpr@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linuxfoundation.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21119-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: AC0D9184E2B
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:56:16AM +0200, Sakari Ailus wrote:
> On Tue, Feb 24, 2026 at 09:47:57AM +0100, Bartosz Golaszewski wrote:
> > On Mon, Feb 23, 2026 at 11:07 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:

...

> > > > > >  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *fwnode)
> > > > > >  {
> > > > > > -     return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> > > > > > +     struct device *dev = &gc->gpiodev->dev;
> > > > > > +     struct fwnode_handle *node = dev_fwnode(dev);
> > > > > > +
> > > > > > +     if (IS_ERR(fwnode))
> > > > > > +             return 0;
> > > > > > +
> > > > > > +     if (device_match_fwnode(dev, fwnode))
> > > > >
> > > > > Could device_match_fwnode() match secondary fwnode as well?
> > > >
> > > > In the previous discussion on this, Andy was against doing that due to
> > > > the concern that it might introduce subtle bugs, which I agree with.
> > >
> > > Could you elaborate or provide an example?

I believe you ask me. Okay, the sophisticated case I have in mind is the
intel_quark_i2c_gpio.c which provides a GPIO device with a list of children.

First of all, it seems broken as it rewrites the secondary link for the
I²C device. (Which makes me think that we need to have a copy of the
[primary] fwnode in the children devices of MFD, but I don't know how
to refcount that properly). The gpiolib-acpi-core.c has a matching function
via ACPI_HANDLE(). So it might be not affected by this.

What I don't know is USB Type-C and USB DWC3 code where it's much more
complicated. And I'm not in a position to state that the change won't
affect those.

> > > The function has some 27 users although few are individual drivers.
> > >
> > > My understanding is that we only have the secondary fwnode for being able
> > > to attach objects from different backend to the same node. The fwnode API
> > > in the meantime generally tries to hide the existence of the secondary
> > > fwnode; a rewrite (which ideally would have happened perhaps a few years
> > > ago?) would probably make the fwnode a linked list instead so we'd lose
> > > that secondary pointer in the process.
> > 
> > It already is a (singly) linked list. Ideally it would be a
> 
> With two entries at most.

There is no technical limitation based on the data type.

> > doubly-linked list moved into struct device with struct fwnode_handle
> > having no concept of primary and secondary nodes.
> 
> I'd think we had that list in struct fwnode_handle, which will still
> represent nodes. But let's see the details when someone gets to implement
> it. :-)

In the case above single or double linked list doesn't solve the issue of
the corrupted (parent) fwnode. We need also to have a siblings list so it
looks more like a tree.

-- 
With Best Regards,
Andy Shevchenko



