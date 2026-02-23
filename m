Return-Path: <linux-acpi+bounces-21079-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNXKL2SrnGklJwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21079-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:32:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D5317C68A
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FD8D3012C85
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 19:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB077371064;
	Mon, 23 Feb 2026 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSWZpJdo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF523EA85;
	Mon, 23 Feb 2026 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875164; cv=none; b=Lb5OFVLj4/XsEt/QN0/PV1+kxk90CU2mq06hNkYBpIiRfJlm+mGN8LXRhLQZET8Qs4g0QLVdXakzTO0uIWwS0H2g/CybzdkBdcmV3DxJkoLuTwl7RnLJLBqb8A2HSTFdRGojBRnt3p/UyINQEIwHxk/LQGL49pomDaVJrk9ey0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875164; c=relaxed/simple;
	bh=lem6w1jewrFyvuZOTw9pH+Kcu+aFFKzXD6fyndfz50c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIobdkQsJQe7QGbsuvvUKcPDokYZAoJpC+EHIEFTmaK9260L7ZCh3Rs3RY8srf+YObeCTjksM5oEimZULZGSM1LsvB1NIDK/bYpV2fo6UTDP+gCwXedH6H5G0+Yob7OvKud5cLnCDHtH/JeraamrL22Hn0iBzxitcjCan66/OiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSWZpJdo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771875163; x=1803411163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lem6w1jewrFyvuZOTw9pH+Kcu+aFFKzXD6fyndfz50c=;
  b=RSWZpJdoV4fHKlu8XPMOpK3HNok44qO+uubp7M6UEnNByLYun3Hleznr
   fzyw0HB+5sTPDWBvbR1kDdLnQhFONSVgbBeSJDxKbQniOBNsIvAuRLgzu
   +S3ZEw3TKeg0XYmm5ke+b+SexWlbJD0trGjpCKJgsctvaqQxDtNKF2I6q
   jG+yiQEExdzr7hRegMjlm7mDACjW/khF/aprdIT78tLgxUq6OM9a6Bjhu
   qCPHVQ3J+UsBB/+hI424efsHmx5lk4BLdYznSZANRaFpYVurfKJkIBHBl
   Dk3ZTEZA3U8k34Y5+BRZvIv2buruGmC3nUBvNPxvOqe/X91et+SYXoeuy
   Q==;
X-CSE-ConnectionGUID: TXZIXExeSLSP9CJYhFXMTA==
X-CSE-MsgGUID: iaGQRkOERAGn8ze3GSDUOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="60455408"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="60455408"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:32:42 -0800
X-CSE-ConnectionGUID: vaBrAISISVK8UhZN1Vuo4g==
X-CSE-MsgGUID: GYWSkmxBTpyBxpFgOtsRUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="213022002"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:32:39 -0800
Date: Mon, 23 Feb 2026 21:32:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <aZyrVWYQKT-JUYR3@smile.fi.intel.com>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
 <aZyUY3ZsmrwHw4X_@smile.fi.intel.com>
 <CAMRc=MfpzgOPf4pkHd_tNQ4wBNMhfUBOh=ptajhhZwDpFUPGBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfpzgOPf4pkHd_tNQ4wBNMhfUBOh=ptajhhZwDpFUPGBQ@mail.gmail.com>
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
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21079-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 49D5317C68A
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 07:28:48PM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 23, 2026 at 6:54 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Feb 23, 2026 at 04:40:52PM +0100, Bartosz Golaszewski wrote:
> > > Export fwnode_is_primary() in fwnode.h for use in driver code.

...

> > > --- a/include/linux/fwnode.h
> > > +++ b/include/linux/fwnode.h
> > > @@ -230,4 +230,9 @@ void fwnode_links_purge(struct fwnode_handle *fwnode);
> > >  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> > >  bool fw_devlink_is_strict(void);
> > >
> > > +static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> > > +{
> > > +     return fwnode && !IS_ERR(fwnode->secondary);
> > > +}
> >
> > This is inconsistent. Please, split out fwnode stuff from device.h to
> > device/fwnode.h and share it there.
> >
> > This reminds me to look what I have locally in development...
> >
> >
> > (With your patch it will be in device.h and fwnode.h and in the latter
> >  it's even not properly grouped with other non-fwdevlink related stuff.)
> 
> Please rephrase the entire email because I have no idea what you mean. :(

The primary/secondary and other device-fwnode related stuff is currently
exposed via include/linux/device.h. The problem is that device.h is overloaded
and starves for more splitting, which I'm doing (very slowly, though).
The idea is to have all device-fwnode  (and maybe of_node) stuff to be gathered in
include/linux/device/fwnode.h

You, guys, missed the keyword 'device' in the pathname for the proposed
[include/linux/device/]fwnode.h.

-- 
With Best Regards,
Andy Shevchenko



