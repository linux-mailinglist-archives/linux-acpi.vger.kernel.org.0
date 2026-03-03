Return-Path: <linux-acpi+bounces-21305-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDJdK/icpmlqRwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21305-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 09:34:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C201EAD84
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 09:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B30E2305E9B1
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 08:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59333EAF8;
	Tue,  3 Mar 2026 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aC7OzZK2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3858224AF2;
	Tue,  3 Mar 2026 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526574; cv=none; b=PSA1d5L8DRw0kCgFVdqGjCgVfIjnHlDg5oIbtEV0Wy2T8YREWsWsciMFxsV8fM0LAspum/UT/AkK99DzNBhy/oy3Q0Ms9bkjdXhr8Iyedizhn+7qjY1kMuaq1K/q6EC2WnOcEeSMRYfrNkCmlvkdVWFRAW68jfQLVgyNXEzYuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526574; c=relaxed/simple;
	bh=Z40HTiHgrXxjC2EJL/B8E5iwIjzImNkoLE0tgCtHRrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHGt4bxRGakgKpWbSgbmOprv1u/ku6ky2fhsSBqDZUgJbx0Md1/N/q9iG/vPS+ose1eYhsT+3bIcXfcjM8UW6FGxzGQZVol2UB8fYVKMgzh7TXsLH5BnXp3OTo86ht2tDpN3LNo0S+pZLtTOE/bb1k4h5m1nmhkngfwhaaGj440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aC7OzZK2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772526574; x=1804062574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z40HTiHgrXxjC2EJL/B8E5iwIjzImNkoLE0tgCtHRrY=;
  b=aC7OzZK2+pKLOaJUc9ktDmXuvRHtcysaG/aS2QnrzEd6Tl5Ahx92UY3t
   NYe/S2EFgX4O02mROD4i3A2NXmtjPoLcmmQii7YrEb0o+ULaWbVoY0rKf
   3r6cZKMLpngCYZlwRQkmz1p/QJ16ZPF1yMGOYFkD1Tnz7oo+Ue3mfV6AX
   z1G6kJOS4sBuDfwidd3tE0XLH+y8YyTRSEGALpc4SZCFaKv+MvHudKzVu
   /zSZmIvCzX3gB25yAz1mVmtjnLBRLBZ5YEGyr1PEfR7/Stk+sL2j6cxDQ
   itkJfdttgwKJdKNZSXF/z9zMKGQchAwj3Gj/s8zPHNbfR3CRakz/HLtjd
   g==;
X-CSE-ConnectionGUID: d+Dm6CHAR7qF2ivi2KOz8Q==
X-CSE-MsgGUID: K+LpiEM8QASa8Vf1JVd3Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73666102"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73666102"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 00:29:33 -0800
X-CSE-ConnectionGUID: kHmxBRoISrWqT7i5ItB4qg==
X-CSE-MsgGUID: pRi3PV+eSteJApC7DHIXTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="217165185"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 00:29:30 -0800
Date: Tue, 3 Mar 2026 10:29:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mike.isely@cobaltdigital.com
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sofware node: Only the managing device can unreference
 managed software node
Message-ID: <aaab5wCWG8MJJb9u@ashevche-desk.local>
References: <20260303052146.1166717-1-mike.isely@cobaltdigital.com>
 <aaabo5LqR3Ors5er@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaabo5LqR3Ors5er@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 06C201EAD84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,pobox.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21305-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,cobaltdigital.com:email,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:28:24AM +0200, Andy Shevchenko wrote:
> On Mon, Mar 02, 2026 at 11:21:41PM -0600, mike.isely@cobaltdigital.com wrote:
> 
> Can you send it with proper version given (I think v2) and changelog?
> Also in the Subject a typo should be fixed: "software node" is the correct
> spelling.

Note, changelog goes to the place after '---' line in the given patch format.

-- 
With Best Regards,
Andy Shevchenko



