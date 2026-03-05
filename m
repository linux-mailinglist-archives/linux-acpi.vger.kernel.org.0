Return-Path: <linux-acpi+bounces-21393-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EARbGKMsqWlK2wAAu9opvQ
	(envelope-from <linux-acpi+bounces-21393-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 08:11:31 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E82AE20C384
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 08:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06C72302691B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C59F313543;
	Thu,  5 Mar 2026 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWBvRItV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D930FF1C;
	Thu,  5 Mar 2026 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694688; cv=none; b=Ctab/RfoB6aVHJU7ML+2Igb2shzUSWCfDMLQjI48hbO0qwylPLYBD/Nx+/b3vIH+ScSL6591b7IIi9RskRYbaPQIbzkmXVOStfZNSVwK5YLxFbtZLSKPkWQkkDd9n5msULj7F/Qfd2NbVz2qDMxGw0DvB5iQ7wbJZMWmgllF3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694688; c=relaxed/simple;
	bh=YrghpefAVzvUhvtMqW1qS8G69fAOW9+vaNoRlMTENBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/qmsZ+ztzb/ZwXaERDe2IBlocSinGL7tyvNJ5lCfqM+Pru5VIdjJJtDcKrrvyIuKBClrMLRebOUXSoniiq49jgC1SL0HKrUxFR5FyaZTnHdh59qDGB11jDBu5lYwPvY8eG25/v1DdEkDuKokF5MDvviWZEf1DZwilhSD/ZJYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWBvRItV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772694687; x=1804230687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YrghpefAVzvUhvtMqW1qS8G69fAOW9+vaNoRlMTENBU=;
  b=gWBvRItVYDL74bfy6BaGJ1o70ZCFpbQRmkaz2lse99nmq6cB0vOqd4ev
   D3nuL8d6H+0kL7SIZihPtlQa0OSmpHFm3no2oGO3RLfkN2g/3+AaxJGtR
   csAabpK2CFrAl7odl/DvopZIRZJsNH3Rso8qkNw1OG1wI6NsVPV/3klT0
   hGNkr7D3EJCT2qScGKM3twRrNkiDGvKqg1hGfovMtP6wFtMRyJskb5swx
   UPqAXBMny7iHomqPw8pqllTdBEymhgysfnSGEnWM+ANtfMJdONAFz6nnu
   zynOH9KPF5ZfwTbaMXclfDPdaGBTKdlaeCIkLhnRV9Qu+fSptuG5sQz/T
   w==;
X-CSE-ConnectionGUID: Cwx+19fqRB+gFT1mi0dT7Q==
X-CSE-MsgGUID: iSewA5lUQ/O25FKOWeXbUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77643358"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="77643358"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:11:27 -0800
X-CSE-ConnectionGUID: cJBd+nTpQvidc5RSA9ByOw==
X-CSE-MsgGUID: qO1hoR8kQcWH1H3VXCHsHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="215864624"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:11:25 -0800
Date: Thu, 5 Mar 2026 09:11:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iio: light: acpi-als: Register ACPI notify
 handler directly
Message-ID: <aaksmnbDUIfCUTqv@ashevche-desk.local>
References: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
 <8702898.NyiUUSuA9g@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8702898.NyiUUSuA9g@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: E82AE20C384
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21393-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:32:26PM +0100, Rafael J. Wysocki wrote:

> To facilitate subsequent conversion of the driver to a platform one,
> make it install an ACPI notify handler directly instead of using
> a .notify() callback in struct acpi_driver.
> 
> No intentional functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



