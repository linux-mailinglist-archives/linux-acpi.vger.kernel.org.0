Return-Path: <linux-acpi+bounces-20102-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3857D08751
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 11:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 585603013EA5
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5C33556E;
	Fri,  9 Jan 2026 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hr70UvlX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343863328F3;
	Fri,  9 Jan 2026 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953587; cv=none; b=LFnN6k2/v7mfvguW9iWekcpOUuvOPQB8O4/9OJPgXEml2fwYn0tjdNO6icz997VszneE+AsZMJ0WMJ6P7LbgheclASMjB6Yb+WcEVblsIII0Cv3UWaRgiH+Mg+5o7wWSNlzaRnSD5zd05eqBZxIr1o/WWgM+s3Y5JPSS8TGg3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953587; c=relaxed/simple;
	bh=iRiQ9K0QKu4iZqkwQ5f+Ol6DNZ0bsYqfujryBOcaRRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYoav8LKgDIPoiG1whRcOuN3DL8hIcdx5KN/y+CWYDO6CXGlN/4S6ZRUs9/m06VP2QsV2rCGTEz2Ou3KtD7sUwSQuzl5v+LyT+xjRbqVHJAz4HLduMYibK4Am9qE9HJWJyE7YLsOkzkV1mZsV08u20Bwrktgaj9tsO8/EBcbQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hr70UvlX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767953587; x=1799489587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iRiQ9K0QKu4iZqkwQ5f+Ol6DNZ0bsYqfujryBOcaRRE=;
  b=Hr70UvlX9I1I0SP4Wf0XLi5pSqowAwg5lnkRk6t4mqa08bRJsjoHW3O4
   B3XoA8B3Z7gHTYUEiWA5/lXBYwm/KoUertH+Pt7G2bGhjB+Xl8EvqjugO
   A1yt3Pi1/P41vzLuhe5YI+VuqoAUrGAAE9yjz4Nl//zSlOoZFtrETNODA
   2hB6QjlSIv8iTD8E+PqXSu2wgwl0Ted0OC3VPqwGOudx3sCK29yjPxJsJ
   PJZmMrxwq/GlWnQ2ueEQIXYMui9sj7aMnIhNB1Ft4WyB6fVVr1ScL7zo5
   20f983nAZYjkgG26Ui379nI3HjLt5fDXguVgXfcZp/K3jUpKJhVA/GUDY
   A==;
X-CSE-ConnectionGUID: SdrGfhFGTXCo8jEzlI3elA==
X-CSE-MsgGUID: 6IIPizYdTb+cPEMbNDzIPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="80786556"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="80786556"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 02:13:06 -0800
X-CSE-ConnectionGUID: fHR1CsMsTG6nh++ipEBfMg==
X-CSE-MsgGUID: veMdfmK8SrysslCfMFpryw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="207966972"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 09 Jan 2026 02:13:04 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A429994; Fri, 09 Jan 2026 11:13:02 +0100 (CET)
Date: Fri, 9 Jan 2026 11:13:02 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: lenb@kernel.org, sakari.ailus@linux.intel.com,
	andriy.shevchenko@linux.intel.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: bus: Use OF match data for PRP0001 matched
 devices
Message-ID: <20260109101302.GW2275908@black.igk.intel.com>
References: <20260109095358.24265-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109095358.24265-1-kkartik@nvidia.com>

On Fri, Jan 09, 2026 at 03:23:58PM +0530, Kartik Rajput wrote:
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
> Explicitly detect PRP0001 and fetch match data from the driver's
> OF match table via acpi_of_device_get_match_data().
> 
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> ---
> Changes in v3:
>         * Swap arguments while comparing HID against PRP0001.
>         * Check value of adev against NULL.
>         * Declare variables in reversed xmas tree order.
>         * Update commit message.
> Changes in v2:
>         * Fix build errors.
> ---
>  drivers/acpi/bus.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 5e110badac7b..e960df2fcea7 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1030,9 +1030,13 @@ static const void *acpi_of_device_get_match_data(const struct device *dev)
>  const void *acpi_device_get_match_data(const struct device *dev)
>  {
>  	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>  	const struct acpi_device_id *match;
>  
> -	if (!acpi_ids)
> +	if (!adev)
> +		return NULL;
> +
> +	if (!strcmp(acpi_device_hid(adev), ACPI_DT_NAMESPACE_HID))
>  		return acpi_of_device_get_match_data(dev);
>  
>  	match = acpi_match_device(acpi_ids, dev);

Should you check with !acpi_ids still here?

> -- 
> 2.43.0

