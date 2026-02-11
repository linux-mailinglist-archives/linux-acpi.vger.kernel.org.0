Return-Path: <linux-acpi+bounces-20930-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFVZB/U+jGlyjwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20930-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 09:33:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7256512245C
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 09:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 411D83019BA2
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01B324B0C;
	Wed, 11 Feb 2026 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArZ5enyO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF4221FB4;
	Wed, 11 Feb 2026 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798797; cv=none; b=d3WeUQOWA5qozzDW37LUubwq7OAzVIjsVTSHq6B1tcn7EHooEAmSSRO3xc5I7wQ3pPx2BKVYB3A6VCj/yp9kLKQ0fMeONkKG294f138JwCFYQKaUMApL2ALWpYZJM8dQIfEJpbHtBLUGsxIehVDJw3yged0XCk73l0PpIVjwo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798797; c=relaxed/simple;
	bh=nY1zDwIFtizozkOQvdT3Io4yyQot8DXqdXtNdIM+wcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNq6nXm4WmMU32a2R83aPTAZiGnIvL62DrlPDC71h1/MUei5Xtd6aoqpYBevrDELB4SARvpmMpDuBb7jHJP3aQ5/MN5wmktOQmvIaU6if20eR6VzJcz+010zywt3XsuHNqlZgtuqrOybL8mtzFjJfuOUaAA2Heqjb5C8O2NIjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArZ5enyO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770798796; x=1802334796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nY1zDwIFtizozkOQvdT3Io4yyQot8DXqdXtNdIM+wcw=;
  b=ArZ5enyOkKr9l7v1Gr5BwfisDZXjFKML6+2KvdioIqHepbEu4X6pz602
   Dpk/QRCy8LIofAY6BxwR2+d6IM3k5veJE7pNVWxVrTSsR5+HSMHplRf6g
   zKyc6HLEWiPEoIue6JotgVIs0ZaK17DYRUI/cXXcUpeg1XG9n0pARWZnY
   6K+HCc9L+ei2/QC8FSuTmNCWYgvYwC+v1712mRhdbeXmq8mBnejCO29BX
   EitKA7a/yBBePrbTPETVVp3ui83naeVxurrfxRNH1iBpEJu6u9KsYGxdy
   UQr3t+wys8m6T+UPuHalxg8ODr3PuoH/8yeIQETeZ7b9PKVAIDzXxXVmd
   w==;
X-CSE-ConnectionGUID: W5Bsa4IDSpKUyHfkxgrcBw==
X-CSE-MsgGUID: WF5BUzVqSmm15TD35oputw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71982550"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71982550"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:33:15 -0800
X-CSE-ConnectionGUID: QgcgqTc6QhW3mbQqCcrPew==
X-CSE-MsgGUID: jVLfTpHaQkaFzZtyRy63Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211240512"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:33:13 -0800
Date: Wed, 11 Feb 2026 10:33:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] device property: Allow secondary lookup in
 fwnode_get_next_child_node()
Message-ID: <aYw-x0fKcjRz3RdC@smile.fi.intel.com>
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
 <aYurEV6kKQfI3cs8@kekkonen.localdomain>
 <aYw6g-R5hXd2jnwQ@smile.fi.intel.com>
 <aYw9cHENHUhxtzZP@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYw9cHENHUhxtzZP@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.intel.com,linuxfoundation.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-20930-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7256512245C
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:27:28AM +0200, Sakari Ailus wrote:
> On Wed, Feb 11, 2026 at 10:14:59AM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 11, 2026 at 12:02:57AM +0200, Sakari Ailus wrote:
> > > On Tue, Feb 10, 2026 at 02:58:22PM +0100, Andy Shevchenko wrote:

...

> > > As the function becomes trivial, I'd move it to property.h.
> > 
> > Yes, but the same applies to many functions in the property.c. I don't want to
> > treat this specially:
> > - exceptionally for this function (what about the rest?)
> > - for the matters of backporting
> 
> There are other similar functions in property.h already. Moving the other
> trivial ones there, too, wouldn't hurt.

There is actually a potential issue that I would like to avoid. Id est
the device.h is a mess and first of all I want to split it to a few other
headers (one of which for the fwnode stuff), and only after that reshuffle
this, because blindly moving everything to the header is not a good
strategy in long term.

...

> > TL;DR: I would like to move this patch forward as is. After that I will
> > consider cleaning up as suggested taking into account other places.
> 
> Sounds good to me.
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



