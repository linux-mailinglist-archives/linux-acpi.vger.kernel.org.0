Return-Path: <linux-acpi+bounces-21085-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABV2C3u3nGkqKAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21085-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:24:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C617CD4D
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F01653033512
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3BB377557;
	Mon, 23 Feb 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3lFWuqe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8036F43D;
	Mon, 23 Feb 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878263; cv=none; b=dLI9gXvjIm0vCPcE8l4Rztmjq32w1t6eejcJk/qfIQ/isrO5h7QMQ01zUEWx6wDa+ZsB5hE/NC1+676viFtOGIAcfACD22HMBqtsrQsPRy4/shgZnBeKEOUPoXT5dCt+M8eteTcJjy///fASqf3MjhEacXwulXL3A1ma++X2oMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878263; c=relaxed/simple;
	bh=UG4Ae2B1bf+fYvg+n7r+yfZdgjJr+7l0NYPIOp4X3q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXvetALXP9pb5IP/k5s2D9mjYzFIwelMj97HGUZ7CsnANzUowctqyYMrvlDMPececfjyD2ExfxvHjwM6/fOX2xp5rDZZvY+NfU9Yk/nm6bOrc8NtOZhxTgKJc6PVid4oDCb85BMsyqoM+Ksz6tdweTeCqCYyQcFt2lQzkGC2bGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3lFWuqe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771878262; x=1803414262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UG4Ae2B1bf+fYvg+n7r+yfZdgjJr+7l0NYPIOp4X3q8=;
  b=M3lFWuqekQSLYpVrI9zjJURH/fhjvVSx1uszl0rc8AFrQ4M9531D5WFK
   IoI1kO5+EIlUNl9s07mxGCT2JKxyENw24E0b85QrUrIhhnXMBJsgglhWL
   SOWPWmPKOa5HPHkXQymobCaBv6MlZoafb0WVSyUKJ4EhmioUZmwGT1lKP
   EReBIwvgoTcW/9r6R+455bsnht9ZLrEgmmpboY5fdeJdvNMastMlUdlCj
   PzCYWuXhBNS8y+K42Fiw8W0UJ2/lMKofdGJJg4piuFt4MgQiXCFOnJywo
   rrscV5zCHobp5vF0Ier99N55NSd6BoSTnen+n6lgcqLeyuDQGszrq2Pj4
   Q==;
X-CSE-ConnectionGUID: YB/QxLz0Rx+qZAUKXBQlRA==
X-CSE-MsgGUID: 6ypsp40zTQCnIY21/sWweg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="71912461"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="71912461"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:24:21 -0800
X-CSE-ConnectionGUID: pkaYP0i0TWeItj3eeahs/Q==
X-CSE-MsgGUID: kmSDxVkkQpSq0BHmkuT8+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214747266"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:24:17 -0800
Date: Mon, 23 Feb 2026 22:24:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] driver core: make fwnode_is_primary() public
Message-ID: <aZy3bu-W2KkFbJHO@smile.fi.intel.com>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
 <aZyUY3ZsmrwHw4X_@smile.fi.intel.com>
 <CAMRc=MfpzgOPf4pkHd_tNQ4wBNMhfUBOh=ptajhhZwDpFUPGBQ@mail.gmail.com>
 <aZyrVWYQKT-JUYR3@smile.fi.intel.com>
 <CAJZ5v0ivGazojW0BfSh7HzWyu+1ij6p=KbpwsmZPJ5YuTSahDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ivGazojW0BfSh7HzWyu+1ij6p=KbpwsmZPJ5YuTSahDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linuxfoundation.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21085-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 805C617CD4D
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 08:45:42PM +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 23, 2026 at 8:32 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 23, 2026 at 07:28:48PM +0100, Bartosz Golaszewski wrote:
> > > On Mon, Feb 23, 2026 at 6:54 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Feb 23, 2026 at 04:40:52PM +0100, Bartosz Golaszewski wrote:
> > > > > Export fwnode_is_primary() in fwnode.h for use in driver code.

...

> > > > > --- a/include/linux/fwnode.h
> > > > > +++ b/include/linux/fwnode.h
> > > > > @@ -230,4 +230,9 @@ void fwnode_links_purge(struct fwnode_handle *fwnode);
> > > > >  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> > > > >  bool fw_devlink_is_strict(void);
> > > > >
> > > > > +static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> > > > > +{
> > > > > +     return fwnode && !IS_ERR(fwnode->secondary);
> > > > > +}
> > > >
> > > > This is inconsistent. Please, split out fwnode stuff from device.h to
> > > > device/fwnode.h and share it there.
> > > >
> > > > This reminds me to look what I have locally in development...
> > > >
> > > > (With your patch it will be in device.h and fwnode.h and in the latter
> > > >  it's even not properly grouped with other non-fwdevlink related stuff.)
> > >
> > > Please rephrase the entire email because I have no idea what you mean. :(
> >
> > The primary/secondary and other device-fwnode related stuff is currently
> > exposed via include/linux/device.h. The problem is that device.h is overloaded
> > and starves for more splitting, which I'm doing (very slowly, though).
> > The idea is to have all device-fwnode  (and maybe of_node) stuff to be gathered in
> > include/linux/device/fwnode.h
> 
> I don't see "struct device" anywhere in fwnode_is_primary().  This
> check is only about whether or not the given fwnode has a valid
> secondary fwnode.

I am talking about splitting device-fwnode related API to
include/linux/device/fwnode.h. The idea of primary/secondary comes from the
upper layer (device) as struct fwnode_handle just defines a 'secondary' member
for a single linked list. It doesn't seem to limit anyhow the list.

My understanding is that the fwnode_is_primary() belongs to the device layer more
than to fwnode one. fwnode layer doesn't (clearly?) define the use cases
and in my opinion should not, fwnode_handle is more abstract and shouldn't
be limited to primary/secondary division that is currently related to the
device. Maybe I am missing something obvious... but to me spreading these
APIs into fwnode.h sounds like layering violation (especially if we think
of the future decoupling fwnode from struct device and making it a separate
entity).

> > You, guys, missed the keyword 'device' in the pathname for the proposed
> > [include/linux/device/]fwnode.h.
> 
> Why do you think we missed it?

Because of the previous comment that suggest that I wanted to move the code to
fwnode.h, but I was talking about device/fwnode.h (which is currently absent).

-- 
With Best Regards,
Andy Shevchenko



