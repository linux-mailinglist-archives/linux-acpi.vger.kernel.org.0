Return-Path: <linux-acpi+bounces-21152-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPBcHGvbnmkTXgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21152-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 12:22:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3761965E4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 12:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FBA4301BDF7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 11:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99F5342C9E;
	Wed, 25 Feb 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqEYay01"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5D392C27;
	Wed, 25 Feb 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018534; cv=none; b=GIV7gT7T+5tyo3k1jXfHLq8BDM6uoCI9Q3TGnzw+aL3py2WSnAkvveS1OW/aGkwNV7ahXLDJgIuQbdXuEAT4ZfXVAoY+GwvQzo1WbwL88ot4ESbvVXswjxn6xT26oNXVbsv3Z9ghyVIeVVmxxzpQo6LuDJ75LjMXZnyhyxBV6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018534; c=relaxed/simple;
	bh=rUzBkuQkbcby7iWW2iWJc3QofzuYy/ux28qQ20LwUq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5pod6N2OWQ4RfM03Mrf0TAbiycIKZM6LgjdcG5XgVFCYmdh5CGPI3Kso9/pnXhtiUf6QFDNGW30Sd8jmGcuxPbyz7hDb1YcdqmUmrMsHRI2HQxU0lZvutsq3VMNWsg89N3xI9dPrBYiZNyF21jQJsPSwdL+mHdxg3prgirFagU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqEYay01; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772018532; x=1803554532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rUzBkuQkbcby7iWW2iWJc3QofzuYy/ux28qQ20LwUq4=;
  b=JqEYay01kGP+2jaL89nXDuPewritBFT7kP2gA8jJeVniU7FiAmsxswgt
   ho0YiqLvsJFN1YI3NEQR8wTtRft2T37+4f3r+d0j9VRAP61rwFVGsjck4
   UZX/ucn8kjIba/SWZsvHYeUWsk6ZcCoxtQjPnJnJA3QxQOii3Uci4IwlZ
   NSjiJyzIR0L9Tsxn5iyCiS6dHC6PJfi7ChkHDjqBNfD2cW83bC48311C3
   o2/VR8KcUikICzLmYJp80XotJsyGemgOVghCdQlhRe6pwnQX9BSImQJEp
   5DM1DUoSujcg+w44vjkjsLV9q4pUVYRg/MC1w7TahNzSKzPRbX+RqcX30
   g==;
X-CSE-ConnectionGUID: y1XyCPvgQE68SmqrVwZPFA==
X-CSE-MsgGUID: 9jWpVIJUSn6SJxAscPgapg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="75660994"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="75660994"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:22:11 -0800
X-CSE-ConnectionGUID: xt+iP5quSM6A4s6OyK9Kvg==
X-CSE-MsgGUID: 5MupqhvFQZK/5wwKyYX9AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="220809845"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:22:09 -0800
Date: Wed, 25 Feb 2026 13:22:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mike.isely@cobaltdigital.com
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sofware node: Only the managing device can
 unreference managed software node
Message-ID: <aZ7bX4SIoxKTPtoi@smile.fi.intel.com>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
 <20260224191922.2972974-2-mike.isely@cobaltdigital.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224191922.2972974-2-mike.isely@cobaltdigital.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,pobox.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21152-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cobaltdigital.com:email,pobox.com:email]
X-Rspamd-Queue-Id: EB3761965E4
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 01:19:22PM -0600, mike.isely@cobaltdigital.com wrote:
> From: Mike Isely <mike.isely@cobaltdigital.com>

Author's and...

> A scenario exists where device_create_managed_software_node() is used
> to create an swnode instance that will be implicitly shared to a child
> device despite best intentions not to permit such sharing (per the
> comment in device_create_managed_software_node()).  I encountered this
> with the sfp kernel module when it was instantiated with properties

SFP? Or is it the name of the actual module in the kernel?

> via a call to platform_device_register_full() - it will create hwmon
> child devices which get all property references.  Unfortunately with
> just a "managed" boolean in struct swnode handling this, then
> kobject_put() gets called for the managed aspect when the child device
> goes away instead of the parent.  This leads to premature freeing of
> the swnode structure, followed by use-after-free problems, heap
> corruption, and generally chaos / crashes / misbehavior in the kernel.
> 
> This commit changes that boolean into a pointer to the actual managing
> struct device, which is then checked against the struct device
> instance that is actually going away (via the usual call back into
> software_node_notify_remove()).  Thus the child device removal is
> ignored as it should, and we only do the kobject_put() when the actual
> managing struct device instance goes away.  We effectively carry a
> little bit more information now so that we can be sure to clean up
> only when the correct struct device instance is actually going away.
> 
> Note that while we are now keeping a pointer to a struct device here,
> this is safe to do because the pointer itself only stays in use while
> the pointed-to device remains valid.  (So no need to be concerned
> about additional reference counting.)

The term is called "object lifetime".

> Signed-off-by: Mike Isely <isely@pobox.com>

...submitter's addresses are different. Either it should be send from the
mentioned address, or you should have

  From: Author <...>
  ...

  SoB: Author <...>
  SoB: Submitter <...>

...

What about the use case (don't know if it's pure theoretical or practical)
when there is a parent and a few children and the managed swnode appears
in one of the children? With some other dependencies between children
it might affect how swnode is get cleaned up. Simple and regular approach
is to cleanup children in the reversed order, but I can't say that it's
always the case. Some children in some corner cases might have their own
dependencies (I saw some strange devices or device drivers where the HW
is a bit complicated and driver is written without much care).

-- 
With Best Regards,
Andy Shevchenko



