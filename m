Return-Path: <linux-acpi+bounces-21118-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM9SABprnWnhPwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21118-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:10:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8E51844B8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 261A831287F4
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DBE36A01A;
	Tue, 24 Feb 2026 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKUeI7bb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABD366834;
	Tue, 24 Feb 2026 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923945; cv=none; b=Xt4xrKau6yQ0/G9Fdtioo+Zs3z+VTxFgSw1PLut47SG7SYr2vvbUuQ0ItOMpcgQimnqc0j9hPLa9zkEGxoE6L5tgy1ta+dOap/YUnE/L0ePTF8RKNAfcVTevRFmH0efuNh4RjvNmYavDnGXQTR5jExHxIjYohvG/LijgwP1ZRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923945; c=relaxed/simple;
	bh=C6eDX850qudJZzZ/jP94djXo3aPCGTQw8yPmyNKOlS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0hALOyXNjuDlfe3RYRMkNCyYGCGUIYaVZaJNer+DK7bmMZPSju3VUqwYQyMh3bB/+wxeubjz4WH943+fPP9Jm7nBNzxH97sz6NIu1GOS3PNfngvjGhCwgt9dRKWARvAxhjqqL7+8l25fXiYxtsI8vM87OyYKLBlSLUMMtlo+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKUeI7bb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771923944; x=1803459944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=C6eDX850qudJZzZ/jP94djXo3aPCGTQw8yPmyNKOlS8=;
  b=SKUeI7bbKS18Vh5Pxn3kBvQEr4SQYrIRN9tND3rtqkn1Z8HscdtUKSEb
   ztBFtzMEjGlOmVToSXvkR3jZW4Uei/iRuT7QlneonlRqdBSBkd8TQXfWT
   0M4WFj8C7psLlgP0VAHnvyc1ivVv4aIYLvsIb6WE2W7u/rgE8YTJA9i/g
   nfWLNBTm+awFl8uMuXSUDrKzJ+gWpllI6zVgm+IQh4yvcFTjFwMf6p2Iy
   NBuE65Qg1OOmLMrji51CBVz2Rosggn6eqAFCLobKrhpnBjh7SbTdEGcnU
   +s/NybS0bcmDzjIAWUXwV/120yAHcbAtjnY7zxRKn32rbwc7sxxEYjjZU
   A==;
X-CSE-ConnectionGUID: F4dunvGYTVW+E9NoQVuIUA==
X-CSE-MsgGUID: yETdulGfRJ+/rG2njjd29w==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72843936"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72843936"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:05:43 -0800
X-CSE-ConnectionGUID: RBZVd6pGRyu088ozheeutA==
X-CSE-MsgGUID: o3rXDO2HT3SBbEhQk2lvvQ==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:05:41 -0800
Date: Tue, 24 Feb 2026 11:05:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/3] driver core: Split device data types to
 device/types.h
Message-ID: <aZ1p4lgioFlxhFr_@smile.fi.intel.com>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
 <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lists.linux.dev,linuxfoundation.org,kernel.org,gmail.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-21118-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 6C8E51844B8
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 09:53:17PM +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 23, 2026 at 9:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > device.h is a huge header which is hard to follow and easy to miss
> > something. Improve that by splitting device data types to device/types.h.
> >
> > In particular this helps to speedup the build of the code that includes
> > device.h solely for a device data types.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> But why do you want to move the struct device definition out of device.h?

Because it's a data type, and we have many drivers that may require it
(embed the struct device), but no device.h API is called directly —
only via a certain framework).

device.h also includes many unrelated headers in such a case.

-- 
With Best Regards,
Andy Shevchenko



