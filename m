Return-Path: <linux-acpi+bounces-19957-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FABCF48A2
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 16:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF223118DC6
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0FB30594E;
	Mon,  5 Jan 2026 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5W5urWc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE22F7445;
	Mon,  5 Jan 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628250; cv=none; b=kcFE0W24wPCwFOuv5AN0KQf30u+AQA2SA0vHMknUleC0sK80qxnr/5xBWQDaKTA+Zm4tLPhZs0xqbbGfYcJyoSSrAjtwS0mlfKlijkIwhCuBFyi5MoYT6VOrOrS+jMiXLTvWzuTVoifIBhF7/jwCU9GAAr4qAg/RdjK9IkjHi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628250; c=relaxed/simple;
	bh=0L5OpmgcsHy8TM9O7I7UCQ9GEF/CN2eJ2h4YRsMehxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGe1NTgxYvg7TDykyKWIdMfDwlD8pwlQRAyy/MorlwsJwhzQLYYM8nIP37zLkrFlSe1ZRIUqZPK21LvUhzzuJgmv4AJCQF2G+RdS2NurkuOzghj75+wRXVd8GoWugOr4gx3/o9eo8Y/wr3+NuimT8SWrDTRUGWEVLlkzHPpUFhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5W5urWc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767628249; x=1799164249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0L5OpmgcsHy8TM9O7I7UCQ9GEF/CN2eJ2h4YRsMehxw=;
  b=e5W5urWcP9/Fg8bSdhBEzd1f/1QSOXxlJVD2aPZ15OadW5wmvvgcx6TI
   OAHIC6Wl4WWypjtSA/QOqC7Aaj/SXFwW4GDZLUvNwtDUou3qK2qlkExyk
   Sn905UlRsg16RyHLD0t3X9cOorAjxCM2Xj8Nvu8uoDDX5q1N68Li9yVUH
   UWpQHDrsP78wDC1OGH65696Jm5ADhDR0h/gIErFTn+59SLPLY0IuAUz81
   U7YRWI80PUttirRiTeqFBvDLyWfdjO2i2TBWTZTIL1gN6owb+hZ6Ksb7I
   MnyLXn4o3AqdGMBI0HD2eRKT50X7sxbA+2HOgWF1V45V6WKSMt3CpdUz2
   Q==;
X-CSE-ConnectionGUID: oO/sMrogRTuzD8ueJsPWfA==
X-CSE-MsgGUID: 7Bk4YEsJTlCZzBJSFGESmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="72621137"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="72621137"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 07:50:47 -0800
X-CSE-ConnectionGUID: oFqT3bHYTEae9hbnP5qbyQ==
X-CSE-MsgGUID: yoZRCtVkRc2L6iuHBrsYSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="207451524"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 07:50:44 -0800
Date: Mon, 5 Jan 2026 17:50:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Armin Wolf <w_armin@gmx.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
Message-ID: <aVvd0eYC7Qs5_ZdD@smile.fi.intel.com>
References: <5977355.DvuYhMxLoT@rafael.j.wysocki>
 <2026010553-capable-chip-88d7@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026010553-capable-chip-88d7@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 05, 2026 at 02:47:30PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 05, 2026 at 12:25:04PM +0100, Rafael J. Wysocki wrote:

> Documenting this is fine, but really, just moving all of the existing
> drivers to not use this and deleting the api entirely might be simplest.
> Looks like the only "new" acpi drivers that show up are in the
> platform/x86/ subsystem, so just tell the maintainers there not to take
> any new ones?

I believe that with or without documentation this will take a few cycles
to get rid of (as there are more than just the PDx86 being involved as of
today). Also there were (and might be in the future) a few attempts to convert
in the opposite direction, i.e. from platform to ACPI driver. Doing something
temporary for a few cycles is okay, no? From my point of view it helps avoiding
the above mentioned cases.

-- 
With Best Regards,
Andy Shevchenko



