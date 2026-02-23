Return-Path: <linux-acpi+bounces-21097-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFLVNhXRnGllKQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21097-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 23:13:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B8B17E15E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 23:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293E3327AABD
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDB737AA85;
	Mon, 23 Feb 2026 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWWJKB7B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788637A49D;
	Mon, 23 Feb 2026 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884443; cv=none; b=nCZ2jXllruYz4V7Z1oQxRIMy5ZtU+QWkXG4JvIBhn7lT4AMb/sSBGkP5BdzgFZmAtKW1hMN9kiDdJctPbWSlf04P7c9i3k4xulY50AQCEs/fA4ArMybNlSYRl332bV76TGmRiLTB/NccYYq6nYkRSYgPqd+35XCpDHyCC3McGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884443; c=relaxed/simple;
	bh=QLRt1ihCEGutlnY3VQn0B0BPbTeJrNzIfTdx0Vhb06U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+dbVggXOQVDin9eg/8B/16YV6r7JdJlA9DCZmDCK7pbGfSaImlyXXDkC65prsyo0J4JnEwChRAvo/94y8l6y4JAuyY3MHR8VDVSBpsV/OON5ssQtrQOGagjDPREoidK2jn8Br+qacddnoolWcuEJfzqD8fdwz+7GUSu5SHpBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWWJKB7B; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771884442; x=1803420442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QLRt1ihCEGutlnY3VQn0B0BPbTeJrNzIfTdx0Vhb06U=;
  b=mWWJKB7B44VU5zsW5268qiqZb7zFp8W+Z2pUPr8uLP6EFlnx9sFG/i2c
   UrjLH48mPweXH40o7DGemf/RBq2VwcUVAsuPfL3bkKzVWfXvL3Z/2wEmz
   nGN6WW3pZzFUjQmNI0f2w4kd7cwRhwZcxEFicTq+pF1uBN7D1nEQCdR8n
   BsajphCXe2Pq3Ct6K6VvjX1JGXTUdX+M6PZD1NFH7uLso4250S6Ye8cHk
   rAll12u2d0pLlufYPxea+n9nZ4CfVBXv2qgjPaPW34DY7P+66eHiTm5rT
   3qO3c2FmoGJRB4IHQEAVNaQ7bP5sK1AIQJZpDn+gj2jH+YWw3bA3u/Eag
   Q==;
X-CSE-ConnectionGUID: CaWx/QkdQgGWBzyVJ0iIpw==
X-CSE-MsgGUID: wgUoQ/QTQHiFGDmNJFUjkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="75498110"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="75498110"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:07:16 -0800
X-CSE-ConnectionGUID: bZBxDYz7QnO7HwaONAAgpw==
X-CSE-MsgGUID: 2d7dg5weRAWji89mBhuZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215849310"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.61])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:07:12 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C8D9C11FC4C;
	Tue, 24 Feb 2026 00:07:37 +0200 (EET)
Date: Tue, 24 Feb 2026 00:07:37 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Message-ID: <aZzPqbXH79Q6GvEn@kekkonen.localdomain>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
 <aZyNErXB_acR3yYq@kekkonen.localdomain>
 <CAJZ5v0ibXKiUNf5Fvj=q=f9JbHT=w3j3h=33ri_awzEHm_dBng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ibXKiUNf5Fvj=q=f9JbHT=w3j3h=33ri_awzEHm_dBng@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,oss.qualcomm.com,linuxfoundation.org,kernel.org,gmail.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21097-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 55B8B17E15E
X-Rspamd-Action: no action

Hi Rafael,

On Mon, Feb 23, 2026 at 06:46:38PM +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 23, 2026 at 6:23 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Bartosz,
> >
> > Thanks for the patch.
> >
> > On Mon, Feb 23, 2026 at 04:40:53PM +0100, Bartosz Golaszewski wrote:
> > > In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> > > reference to a specific fwnode, we only match it against the primary
> > > node of the controllers. Let's extend that to also the secondary node by
> > > reworking gpio_chip_match_by_fwnode()
> > >
> > > Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > > ---
> > >  drivers/gpio/gpiolib.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..7fe1d9ab1281d6c5022b9bdd8909fef2cb74122e 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/errno.h>
> > >  #include <linux/file.h>
> > >  #include <linux/fs.h>
> > > +#include <linux/fwnode.h>
> > >  #include <linux/idr.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/irq.h>
> > > @@ -1395,7 +1396,16 @@ EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
> > >
> > >  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *fwnode)
> > >  {
> > > -     return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> > > +     struct device *dev = &gc->gpiodev->dev;
> > > +     struct fwnode_handle *node = dev_fwnode(dev);
> > > +
> > > +     if (IS_ERR(fwnode))
> > > +             return 0;
> > > +
> > > +     if (device_match_fwnode(dev, fwnode))
> >
> > Could device_match_fwnode() match secondary fwnode as well?
> 
> In the previous discussion on this, Andy was against doing that due to
> the concern that it might introduce subtle bugs, which I agree with.

Could you elaborate or provide an example?

The function has some 27 users although few are individual drivers.

My understanding is that we only have the secondary fwnode for being able
to attach objects from different backend to the same node. The fwnode API
in the meantime generally tries to hide the existence of the secondary
fwnode; a rewrite (which ideally would have happened perhaps a few years
ago?) would probably make the fwnode a linked list instead so we'd lose
that secondary pointer in the process.

-- 
Kind regards,

Sakari Ailus

