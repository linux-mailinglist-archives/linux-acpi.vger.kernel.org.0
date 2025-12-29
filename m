Return-Path: <linux-acpi+bounces-19888-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F2CE6F85
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 15:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136B53007FE5
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CA41E9B3D;
	Mon, 29 Dec 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRSVdvBT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8C1397;
	Mon, 29 Dec 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767017037; cv=none; b=qFw6wKm0el4EmEhkMgXT7uwPLTxZZFtBYehIKmNHscWUrb6kP8pr1KfDPEGMQfzggO6Wps4J65DF4+kU7sC2DMdFocqlCobY7AfSMwKIaBURdmbI2fPtnztbROmjm3TuVx7RKPh9mC//7o8PmScHkAKbhj06AbPAO+rQgyGPPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767017037; c=relaxed/simple;
	bh=YEpow8uioqVCskI4qD4NaUIgFGs522Au0KsiE/vabVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvar50paA89dKJilcJKZ0e8c3/Ydb0uMx2Zs6CtsHjmF8ijCwo61xQtUjjrbYxtt4SjD4RnDqMHcI/9DCQhgwxZhhOAIo9S3IIKRjD4zbRo8syunBeJ093/E/95etQ0kkB4HsnF/ak0Fhkq/zkow0s1e0wCDGs1Br3pkyjl3Tp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRSVdvBT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767017035; x=1798553035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YEpow8uioqVCskI4qD4NaUIgFGs522Au0KsiE/vabVI=;
  b=RRSVdvBTVm8mNNq1ZQqMCQUFRd7tklfX8LLs7yBB+e5CaiiKmkYoxVT4
   /emkrNL+amTWEgf8XoKaJL0lXDjUtlCars0TTJ0+UNf7qdrWLXzSsVB3R
   NEyOVy03Zn7ocel8dkQfXDwbC7ljjoeawVMqzsf5MNdz+5tgznul7/496
   G3hYRIKhiT5Q3vttssf8JTh1oLbfVytSNBPY5KjkgWYXMY2pomqYctAKK
   9RejWYWxM35HuxCRnqIWbNnGCPd0eE6jgfXsc8Zf5XC7FdVcKFZLzDYsU
   jdu7Z01/bbUWfKjpmmt1oAV9AOSWaANaVCz7CgjJOUMXaxOeS3iXfcYQ3
   g==;
X-CSE-ConnectionGUID: TKilDRYTRIuM7YO75gS24A==
X-CSE-MsgGUID: 8c/uHIPNRw+fLPkXVj7zaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="67625836"
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="67625836"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 06:03:55 -0800
X-CSE-ConnectionGUID: FJRFb2EvRjKP5LHaykU+pw==
X-CSE-MsgGUID: 3WvaJIsOQqGwREQQDFv9Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="238335784"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 06:03:54 -0800
Date: Mon, 29 Dec 2025 16:03:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2] ACPI: sysfs: Add device cid attribute for exposing
 _CID lists
Message-ID: <aVKKRxlbBglS1zA7@smile.fi.intel.com>
References: <5957407.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5957407.DvuYhMxLoT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 29, 2025 at 02:29:59PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a new sysfs attribute called "cid" under struct acpi_device for
> exposing the list of compatible device IDs returned by the device's
> _CID object, if present.
> 
> The new attribute will be present only if the _CID object is present.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



