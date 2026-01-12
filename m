Return-Path: <linux-acpi+bounces-20181-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB81CD116B1
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 10:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD07430019DA
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4930634678B;
	Mon, 12 Jan 2026 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iM613WTZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F1A30BF60;
	Mon, 12 Jan 2026 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209074; cv=none; b=O9yU6Ov8m+ksUOL0KIbb8+I2w3Qu3aAUhzFkhLs9W1ubyS8LUDUsr3ZF7Hd605yTHci0r1bkHqRl49J580VsXYa078/IXNEaiNXGKUcT3M3oUQGnrnaLDJAVOGWbqhI+Ma4DkusOSJpLUY11/JB5lDW09o489/Mcf13rvcRusXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209074; c=relaxed/simple;
	bh=XOzr0aBgdBI0lDPpqRNOlY9Q+HV8jpnpQIfio1I3xuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDLzSDDYVvc68c30bF5INtbIKm8TL9QTFotADwLS5R6vD7A6l1uDSXV3q1Cfe4ns2E6FjvJnTqx6zFYA/zzfLiJMBLajeYL9dqDerJXQ/gcpxI4HXpkL7eBlXgLlkE9w7SYT7wFxt7YI/R24F+DpfgPF/FThKRoheNlXaOEyEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iM613WTZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768209073; x=1799745073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XOzr0aBgdBI0lDPpqRNOlY9Q+HV8jpnpQIfio1I3xuI=;
  b=iM613WTZPZ/xMAaBmxNfjwUFeKvpE0q/bhePx9auV7kd7pyCdcP39QgF
   1Jw1E9VIaV7ZaBEJg3bCFToE+kZIOnn9IFlv5u01NdFlYwUiGBomibUpr
   Koqp0P7N4HCcKu1sz/087z40iuAMb2+MbyaUHqMJXkQhTbxDCgNX+1SI3
   WVDcdH4nr2G+/+SFEy8jlQSg4872PeHZ5gp1osCYID5JD9nPxoLyzTg8i
   Kw8jIGUQQqlABjaljULQ+WbkdFbrshIfYkC87IzrOrLHb7NFQbYmQkBgh
   QFA+BisOOyJorEQc+rVTtePqfgskAUB5z0LGgrrIXK7+AuKJffaQYJ46m
   g==;
X-CSE-ConnectionGUID: 4hcTgkatSoy4CWYXS2TgkA==
X-CSE-MsgGUID: BKoIaHENQhuxbcjCM6ifqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="72056982"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="72056982"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 01:11:12 -0800
X-CSE-ConnectionGUID: 0Hr4iWLjSyeS8xuOgtJUrQ==
X-CSE-MsgGUID: 30OrFxf9RkSB9BISX2Eh7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208874828"
Received: from zzombora-mobl1 (HELO kekkonen.fi.intel.com) ([10.245.245.52])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 01:11:10 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id D844D121DC3;
	Mon, 12 Jan 2026 11:11:07 +0200 (EET)
Date: Mon, 12 Jan 2026 11:11:07 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kartik Rajput <kkartik@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, lenb@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: bus: Use OF match data for PRP0001 matched
 devices
Message-ID: <aWS6q3tBlppsWXXl@kekkonen.localdomain>
References: <20260109095358.24265-1-kkartik@nvidia.com>
 <20260109101302.GW2275908@black.igk.intel.com>
 <aWDhEBjy9b9_uzoR@smile.fi.intel.com>
 <aWDmt3CA5h_i9Hij@kekkonen.localdomain>
 <aWE0uuZjB1iMGF2B@smile.fi.intel.com>
 <CAJZ5v0ijTQC2cFTt+hW-ofJwMqdEeES8d5MMbbq8_Bqg+_9E3g@mail.gmail.com>
 <aWQdz37vK-SXVQBv@kekkonen.localdomain>
 <377fbbc3-5f79-424a-b986-4617048e5e3c@nvidia.com>
 <aWS3HRIlZQqI1hP5@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWS3HRIlZQqI1hP5@smile.fi.intel.com>

Hi Kartik, Andy,

On Mon, Jan 12, 2026 at 10:55:57AM +0200, Andy Shevchenko wrote:
> > 	if (!__acpi_match_device(adev, acpi_ids, of_ids, &acpi_id, &of_id))
> > 		return NULL;
> > 
> > 	if (acpi_id)
> > 		return (const void *)acpi_id->driver_data;
> > 
> > 	if (of_id)
> > 		return of_id->data;
> > 
> > 	return NULL;
> > 
> > Then, we can also remove acpi_of_device_get_match_data()?
> 
> At brief look it's indeed seems to be a good optimisation as well.

Looks good to me, too!

-- 
Sakari Ailus

