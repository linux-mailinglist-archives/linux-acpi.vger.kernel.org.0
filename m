Return-Path: <linux-acpi+bounces-20277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD49D1D257
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 09:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 619D33012DFE
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAD37F722;
	Wed, 14 Jan 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXfYbOga"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692337F721;
	Wed, 14 Jan 2026 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379738; cv=none; b=Anp6YmZRolX9M5DYTxzOOHonwmhd4B0l3+ER/HedObC7cMZlAnLu1nYmgTTqF72HJvrTZdipnEqYKhh5Dd77dq/OpnY4OKzG8sghNlQoN9cBlvjXKHPeX/Hdeyl8lNo5eLmdle0j5n7ykGyLX/FjcKVl5CBfuBSrPLTZZzxV/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379738; c=relaxed/simple;
	bh=/gaUDu99/aYnGRbF1PhdbQ7sMkv+TUUFoW9w1HQnal8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+aMBl6Q4zb+n3pn6Dp33kqDE6eUOpGwIom4DHd3Kjll/d4TsoVhvSCOHzC70w/nECyOY294ESetpZWiv4AtiqM4GKlUfkKpTWrPHuXzNMmUVwys+1sIRlqlkVwDAXTa7d2osACsKHojMDSNjhzhXCwM/L4mEw0/TZ6eMaPRw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXfYbOga; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768379736; x=1799915736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/gaUDu99/aYnGRbF1PhdbQ7sMkv+TUUFoW9w1HQnal8=;
  b=aXfYbOgaYLuy0ooX5tuI+ht72wN95tlczUioOZhg5uzXCji6JQAu5TQw
   axBeGkJhzAafuIV3KcHSznY1L6cqg0Dtj2CbXqbVYchnv6YtIoSFtf/w3
   aZuUnB+mgmR2Qrivqcmz0Q5rN1yHBaH6degyJmUQelj59OQXW02P1ec5W
   9yc0AdAug7Syr1vgZXdNLQp9MEz7AT7Wpx+Nrlz0/iupWExSL4wZTrU+J
   Vx4y8WawMl2YOgwQsKs5sUg/ZE8Nkz7Yg96weMOq4KimC8KoBZJ7rNz4D
   RQxHjYESOv5j2iTAl1GYXpCktkjC513txyzN66gmqPT3tZQBQQAy0YOHw
   g==;
X-CSE-ConnectionGUID: AtnQgUFPQ3GGU030UyPi0Q==
X-CSE-MsgGUID: Wpep8PRRQoWnAx/llzb8kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69575229"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69575229"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:35:34 -0800
X-CSE-ConnectionGUID: i95k26uuR9qZOVviTWrNjA==
X-CSE-MsgGUID: Hk0Bh4sYRh+Ug6pJ+08DEg==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:35:32 -0800
Date: Wed, 14 Jan 2026 10:35:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: lenb@kernel.org, sakari.ailus@linux.intel.com,
	mika.westerberg@linux.intel.com, rafael@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: bus: Align acpi_device_get_match_data() with
 driver match order
Message-ID: <aWdVUXjU-Zzgjlg5@smile.fi.intel.com>
References: <20260114082306.48119-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114082306.48119-1-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 01:53:06PM +0530, Kartik Rajput wrote:
> During pre-production development, drivers may provide both ACPI and OF
> match tables while a formal ACPI HID for the device is not yet
> allocated. Such devices are enumerated via PRP0001. In this case,
> acpi_device_get_match_data() consults only the driver’s ACPI match table
> and returns NULL, even though the device was successfully matched via
> PRP0001.
> 
> This behavior also risks breaking existing PRP0001 setups if a driver
> later gains an ACPI HID, as the presence of an ACPI match table changes
> the match-data lookup path.
> 
> Make acpi_device_get_match_data() use the same precedence as driver
> matching by using __acpi_match_device(). Return match data from the
> acpi_id or of_id that was actually matched.
> 
> Remove now-unused acpi_of_device_get_match_data().

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



