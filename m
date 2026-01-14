Return-Path: <linux-acpi+bounces-20278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DED1D764
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 10:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68113302F801
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3FE38736B;
	Wed, 14 Jan 2026 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRK4QmX3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1838735C;
	Wed, 14 Jan 2026 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382074; cv=none; b=hBJOvzBPPq/1CJb804OecmzaSNBy18bGiAH6rzTJNgCzyNq6z5VKbcYbijlw9akGYOGVh5pfAZ3aqERHnMCHZXdtHakxZW7ivzdPKFHcSgbU/QbtDpCrCtQTPKkzSwAHjAbfzfQMWNC0IDnfRWK7BNtG72Jmw3w0ZEZnvEWVCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382074; c=relaxed/simple;
	bh=x3UaktN1PuQd0z10cfzXxPvaaMFDmlD5HZRrpyaKjC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLv8U3JdIu1mKAscacxwOXEMpfpEG/lX1UsSNdjITXvCMp4hy0DvjuCA1VNklCR/TetBtS/teXo6PieYM4AAH244Oy/JcVRPIa6MdoakF1SYAlYDP2X9vOXpn2OJIYz3qDghaBetuPEaF4p9LVOgJ9nQb/jPVsf2G2U641wiRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRK4QmX3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768382071; x=1799918071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=x3UaktN1PuQd0z10cfzXxPvaaMFDmlD5HZRrpyaKjC8=;
  b=gRK4QmX3C/uR7TlXflqru7xgjROdw5W5zf+TFUnK9824M+2DOAHsAJtI
   LL7oqNku8346kOHuuqEdXHDzRz0b1J8GsQZtT8QMrUz+JZG+9SzsVcv/A
   2H7aaP3Pnrw6VqVLrmqRciu6Pz97tokwScBiC6rdgpojiQP2rOZxGZ2/k
   eGBKzc0wS0mZUa6h234ncYubonG9Crj20ZlrPiAslJFlns7WTcYcj8zMy
   K/ShiETEn4P0PNyhWO/9LQZAA4Mz785Q7yV24ZXDyZXdvoi+9gFxR148Q
   iVL55tOuDDB3TzyP8VQUItZQP74T/9XOM/0zOedpK10HutmiRXINtPq/6
   w==;
X-CSE-ConnectionGUID: pWKR32JNQEiFo48NGKl4tg==
X-CSE-MsgGUID: oKyy0hlkRXSCPETG50Cg5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69586192"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69586192"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:14:30 -0800
X-CSE-ConnectionGUID: ugDHFQ9BRRSo557UlY8Hkw==
X-CSE-MsgGUID: y6dqOOveSuSQTEo+e0WdQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="204413403"
Received: from zzombora-mobl1 (HELO kekkonen.fi.intel.com) ([10.245.244.116])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:14:28 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1FB7F11F9B2;
	Wed, 14 Jan 2026 11:14:25 +0200 (EET)
Date: Wed, 14 Jan 2026 11:14:25 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: lenb@kernel.org, mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com, rafael@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: bus: Align acpi_device_get_match_data() with
 driver match order
Message-ID: <aWdecdvZZbai0qrv@kekkonen.localdomain>
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

Hi Kartik,

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
> 
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>

Thank you for the update, this looks really nice now.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

