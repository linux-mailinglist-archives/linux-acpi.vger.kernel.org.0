Return-Path: <linux-acpi+bounces-19992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7112CFD71A
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 12:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6674A3013558
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 11:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CCE2FD69E;
	Wed,  7 Jan 2026 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvhM0YMM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D527FD75;
	Wed,  7 Jan 2026 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786167; cv=none; b=TND1vYT015PCi2syiYTQWWexIv9gQwmEmwJFiU+utE4JGsE9SBS+K7mW0byH3kUH7hBoqvwo/5qZb6Gw9Hd73CtvqBnXahfDiEFpr2sQrCJnBm4GNxDJ53I3CDOYwS647kxILYx7AUw/m7Li+j86C5H5TvWK9ph5SY6FFDNLQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786167; c=relaxed/simple;
	bh=MVqEnOOJ5e5jVvhedg90e4x9k6H6hPXWjU1gBBjZSVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV6bp9d8M0MEJSlKxe5ksqR/0ErbTX0O+EMfs/G0qrtL1Tuhxgj45FS+ycCubs65ASNCZFV1/KKaP3tedI5cRcYl+vym1WA55bYQOIabSq3VhMMK5b2jR3NFlzVLmboCkBPHL3CapzLt0en+ISVzptci1St2t5ytdjqa41aZDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvhM0YMM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767786166; x=1799322166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MVqEnOOJ5e5jVvhedg90e4x9k6H6hPXWjU1gBBjZSVg=;
  b=VvhM0YMMxrodM/Sg3SeneIFlxVeX6yvKx5+Y8LfkyfRj/xAbTrbhtVwA
   tT9z1bBZgbx1eS3ZhOCT1kXFMKe0dUvOh/ORqsg5OFffTFv+/ZlabbO7+
   Ypz7zVK+4vq3PZKwSz3OoyTZo146fjyp+tY5zys6SstOk2CsOvLf5CBs/
   p1UCtTU7RjvJ84ltykN4HoL9H1RcZ3p3B1MLk5xrs8ZwkEaD8xV9jskfv
   FeuYb7+ZBOGkj/yRvmN42DkkYx9RU72qRortuEsDhhqDcFtdc76UioVVg
   +OIjDPk2g1pUa6p/Eebt9kAWAhLVx1X5m9Iw78jG9MqhxDpvCfmrlAeyl
   Q==;
X-CSE-ConnectionGUID: JIYgNXYKQ/mD8pFhHFOIvw==
X-CSE-MsgGUID: 9jYLHGYUSxajIEY9caND8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69068030"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="69068030"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 03:42:45 -0800
X-CSE-ConnectionGUID: gzNNsmA1Qu2ffQwz4agg9Q==
X-CSE-MsgGUID: o5i0lWjYS5SoWc3GbOlgOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="202034800"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.143])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 03:42:43 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 80D37121D80;
	Wed, 07 Jan 2026 13:42:56 +0200 (EET)
Date: Wed, 7 Jan 2026 13:42:56 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: lenb@kernel.org, mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: bus: Use OF match data for PRP0001 matched devices
Message-ID: <aV5GwEzOLtgIEnYp@kekkonen.localdomain>
References: <20260107062453.10893-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107062453.10893-1-kkartik@nvidia.com>

Hi Kartik,

On Wed, Jan 07, 2026 at 11:54:52AM +0530, Kartik Rajput wrote:
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
>  drivers/acpi/bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 5e110badac7b..4cd425fffa97 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1031,8 +1031,9 @@ const void *acpi_device_get_match_data(const struct device *dev)
>  {
>  	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
>  	const struct acpi_device_id *match;
> +	struct acpi_device = ACPI_COMPANION(dev);

Oops!

>  
> -	if (!acpi_ids)
> +	if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev))
>  		return acpi_of_device_get_match_data(dev);
>  
>  	match = acpi_match_device(acpi_ids, dev);

-- 
Regards,

Sakari Ailus

