Return-Path: <linux-acpi+bounces-19998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D17CFDB6C
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 13:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA1EB300A1FA
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 12:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032032ABF7;
	Wed,  7 Jan 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmYh8Nxx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4BB30F53A;
	Wed,  7 Jan 2026 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789523; cv=none; b=ikUW4qQiAmGKX054Mq2oo4ysAVMbzpzl2lSmKy9/0WeKkVPX6W0QprBBpEhMtLXb4J1mplUBnoQTFT5vpQOLHpqdlvrHxYMoO+TdglVYs7uPxMUaoR+yPw5syFuLOk3wJOctMpXEkdOiSNBopwK2eDc1vqbI0J5lmgrqQpq9lO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789523; c=relaxed/simple;
	bh=INGoSJqW3QVZMj1hKdooxNdiy9NWmTEZr0eyf+jlfec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM3RA1iK5Ylicqg1uAch5QkQBnCoS+GznX3+pGgGDLNchmln8Chbny6ey9uLMpr9wPWcqtuj/g6GOPMnNMMx+U0X+y3MPf3RGu0tHe7hhXXA6yXGAMI6DzLZuDoEfk02iLD2CKCEgC4pOtWjK30As6UWOhj2d6lMaynBJYY4yUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmYh8Nxx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767789521; x=1799325521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=INGoSJqW3QVZMj1hKdooxNdiy9NWmTEZr0eyf+jlfec=;
  b=TmYh8NxxDRyF6f7fnlhGIW42KzFmX/mhTIfR+f2lOQkFwofiPgS61xN7
   EMDwbZKCoipTftuV0oFcOXnxh4o9mtoSPrC5jtD+Jl49SzC8utMBcc47w
   3w2EkO7A+u0LMks8UlJbJ3t2CH8dM/fs0jddc4nes+JEs9hm1Su5yBqev
   ewhKfisi/ko16xa5j+Nii0sUNS29GxY5OQacXxHZUg7VH/Bp+DdEYZK3V
   rCsYnA4ququJ2pD6mCaZcuon/QTY1GsntKTBQx8wZUgXbaMlNgp+b+4Ks
   rChF6Va9kyq9XKgRTbxRskzHgju3ilXres0JDLsLN8DGqOX/Xo0wgtYJM
   Q==;
X-CSE-ConnectionGUID: ASXNqI3jSSmiq3FAvpOAyg==
X-CSE-MsgGUID: JsPYsYqAT3+HFq1tWFBMxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="56718273"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="56718273"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:38:41 -0800
X-CSE-ConnectionGUID: tRfhYJeDQqm4fYMClX3h4A==
X-CSE-MsgGUID: G37sNdg7R4e2tg4oR/nUeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="207780386"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.143])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:38:39 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id ED1A8121D80;
	Wed, 07 Jan 2026 14:38:52 +0200 (EET)
Date: Wed, 7 Jan 2026 14:38:52 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: lenb@kernel.org, mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: bus: Use OF match data for PRP0001 matched
 devices
Message-ID: <aV5T3Lh4TxvpOZi4@kekkonen.localdomain>
References: <20260107120318.13130-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107120318.13130-1-kkartik@nvidia.com>

Hi Kartik,

On Wed, Jan 07, 2026 at 05:33:18PM +0530, Kartik Rajput wrote:
> When a device is matched via PRP0001, the driver's OF (DT) match table
> must be used to obtain the device match data. If a driver provides both
> an acpi_match_table and an of_match_table, the current
> acpi_device_get_match_data() path consults the driver's acpi_match_table
> and returns NULL (no ACPI ID matches).
> 
> Explicitly detect PRP0001 and fetch match data from the driver's
> of_match_table via acpi_of_device_get_match_data().
> 
> Fixes: 886ca88be6b3 ("ACPI / bus: Respect PRP0001 when retrieving device match data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> ---
> Changes in v2:
> 	* Fix build errors.

Thanks for the update.

> ---
>  drivers/acpi/bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 5e110badac7b..6658c4339656 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1031,8 +1031,9 @@ const void *acpi_device_get_match_data(const struct device *dev)
>  {
>  	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
>  	const struct acpi_device_id *match;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>  
> -	if (!acpi_ids)
> +	if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev)))

I'd swap the arguments to have the static one on the right, i.e.

	if (!strcmp(acpi_device_hid(adev), ACPI_DT_NAMESPACE_HID))

The patch looks good apart from that IMO.

>  		return acpi_of_device_get_match_data(dev);
>  
>  	match = acpi_match_device(acpi_ids, dev);

-- 
Kind regards,

Sakari Ailus

