Return-Path: <linux-acpi+bounces-15148-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1081FB0463D
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 19:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E63B1894215
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95965262FD3;
	Mon, 14 Jul 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UePoBlRt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1EF35942;
	Mon, 14 Jul 2025 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513191; cv=none; b=X5Lzk/odazjTYaxhWMC/+7tGkTptSp19gy2YsmqcnjdlD78jm83zmzsXnW/MRXzJRs9Nzt+17+brXDU4M1CF9XO474HG+d2HDDWr9hfAPpmlynYCnQlgLrzzhQPSyYCRj3Z7YzUObdijdtLwIUk3ENuDPPUxELAo4NqYcPxNxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513191; c=relaxed/simple;
	bh=1rEOYhdL+DAikrTqoRGBr/4ySSg5iKr6IK8WpawiH14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3tF3OXG1aRtKUe0Asw74nRgRRJlxueWHDBjo/y7lNpPzc9GwGeV4lUMKoVkilqpWECCJmaGcOyUj5SgslQ3Y48hMb1fV0w6xel9yyvq6ZTsCOppo/MDSl/MaSqDJKKppgedaR3xJyhO9AsHo074xXG1lD6Hju8K6amiPhryy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UePoBlRt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752513190; x=1784049190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1rEOYhdL+DAikrTqoRGBr/4ySSg5iKr6IK8WpawiH14=;
  b=UePoBlRtjsnVVgc+oSROpBc/KXDjel3Sz8KqdgHtpiE9tYp2LYoajcJp
   R01PTducIpqNugH23CLEzPYq9Vq1DERSQJ9k9UEYyKR/hJhDszBdtU0HD
   gn3y+8h2snBUf1rCuT3y6RIHxzINmTqwBIN8bzd/oeRwMzIchwN7WHKwr
   Poe2oOlWznk8OEZqgUtVDFKyM9/ZuXy/EgJQMO9dh8Z/S4CdL7gaD+ZlX
   +ioXorX9FUoLJl5lDEbsZYy1NJIsegPj7CLFYDBkhgpfjBLlL97gq4777
   QoN5ZdqpbWdaF7aZi8K6GJKznZdffgcdWBaw/ZCVeMWrFoTPKxIeLccEP
   Q==;
X-CSE-ConnectionGUID: up7/6z+sRA6yv29LyQ7awg==
X-CSE-MsgGUID: 9FqeSzX/TQmfCt5k5ofEvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72163073"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="72163073"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 10:10:40 -0700
X-CSE-ConnectionGUID: XG8NKM8oRY+P1328vBBlBg==
X-CSE-MsgGUID: zBcYLkVYSRep1BjrTdYM3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="160998129"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 10:10:39 -0700
Date: Mon, 14 Jul 2025 10:10:38 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <aHU6Ds1vrbB-Zbcp@agluck-desk3>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>

On Mon, Jul 14, 2025 at 09:57:29AM -0700, Breno Leitao wrote:
> Add a global variable, ghes_recovered_erors, to count hardware errors
> classified as recoverable or corrected. This counter is exported and
> included in vmcoreinfo for post-crash diagnostics.
> 
> Tracking this value helps operators potentially correlate hardware
> errors across system events and crash dumps, indicating that RAS logs
> might be useful while analyzing these crashes. This discussion and
> motivation could be found in [1].
> 
> Atomic operations are deliberately omitted, as precise accuracy is not
> required for this metric.

[snip]

> @@ -1100,13 +1106,16 @@ static int ghes_proc(struct ghes *ghes)
>  {
>  	struct acpi_hest_generic_status *estatus = ghes->estatus;
>  	u64 buf_paddr;
> -	int rc;
> +	int rc, sev;
>  
>  	rc = ghes_read_estatus(ghes, estatus, &buf_paddr, FIX_APEI_GHES_IRQ);
>  	if (rc)
>  		goto out;
>  
> -	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
> +	sev = ghes_severity(estatus->error_severity);
> +	if (sev == GHES_SEV_RECOVERABLE || sev ==  GHES_SEV_CORRECTED)
> +		ghes_recovered_erors += 1;

		ghes_recovered_erors++:

> +	else if (sev >= GHES_SEV_PANIC)
>  		__ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
>  
>  	if (!ghes_estatus_cached(estatus)) {
> @@ -1750,6 +1759,8 @@ void __init acpi_ghes_init(void)
>  		pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit.\n");
>  	else
>  		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
> +
> +	ghes_recovered_erors = 0;

Unnecessary. Global variables all start at zero unless otherwise
initialized.

>  }

-Tony

