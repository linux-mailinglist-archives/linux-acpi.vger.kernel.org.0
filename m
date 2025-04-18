Return-Path: <linux-acpi+bounces-13117-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3792EA93E56
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 21:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2A1463705
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233E2253A4;
	Fri, 18 Apr 2025 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYWclzb/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290C921CC64;
	Fri, 18 Apr 2025 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005018; cv=none; b=u68Lhdz3KJcKoehWig7BV7Yl5YsNG4WMiLxnK4nIz7aPSedhBLqBLJPO+IKDkV/hRkmG625+jsiKsjevl1GamN8SP9xLU4zBxG9iYYb+2RGwBv0gmWZ4SAKwDybBdBCJYdfOzD0SNE0FZjYnvJ1mTTHkqFHDavUewmREyZyE2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005018; c=relaxed/simple;
	bh=ddFq+XbaIYe+xxyTjGKCHf7Wx8DBGJPljaLE03Zd1lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1OyLTu9Foll2mLsTnuFy//FIcEaHbxLnOeV4Jec1gtRXvUET0dctqOOwx8Sn1S6ZgoyMOx+TH0ju/GO9GzPzrGavaly8x0hCH1oXUhmmRJiswWzhfYfC7T/yh4q4pdWVSnVZL2olMnbHhJUEsvrfw1b6oeoHpCsJPgPG9GfMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYWclzb/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745005016; x=1776541016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ddFq+XbaIYe+xxyTjGKCHf7Wx8DBGJPljaLE03Zd1lE=;
  b=LYWclzb/fmj4PYbN8t1TKMp797N0Lg34kok0QtE1zfWAdqgCM1jEh6f5
   cTuvxpGQdWNnmUDUNjLaGPPSgO0fqUxgq8xL6htRt+s9xCiSL1Y9N/iX5
   z7VkaCliKDnyoU7ySuUydt6N4Z766Qb3D2iv0vrYoqG9F93Vu8w7f7J+p
   E2IpTLdPCTshpuSxsGB1Sf1S56ReUu0RFkbBj+cctnaQinv/jaJSeTBv9
   2jpN+sEztFgT88GYmMIDbGC9VaDT1tNVkdDGD82i5KEOg5fn+3H62CGBo
   3mji6bDJQ0KyOtoU8sPYxuiPr+eqkNrlDTIB6wNAT3WRffAPGu7PT15g9
   w==;
X-CSE-ConnectionGUID: frZANLRUSyalRc4Gt5dE+w==
X-CSE-MsgGUID: gtI/HgeKQWqhTtIJKHYyDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50437145"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50437145"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 12:36:56 -0700
X-CSE-ConnectionGUID: 6mpy4zH9ToeoFUi+lkbaZw==
X-CSE-MsgGUID: g1SIbYy2RQ2k80veywqGrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="162236731"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 12:36:55 -0700
Date: Fri, 18 Apr 2025 12:36:53 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com, Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v6 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <aAKp1c5oDUICkTkf@agluck-desk3>
References: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
 <20250417220019.27898-6-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417220019.27898-6-zaidal@os.amperecomputing.com>

On Thu, Apr 17, 2025 at 03:00:15PM -0700, Zaid Alali wrote:
> +static ssize_t error_type_set(struct file *file, const char __user *buf,
> +				size_t count, loff_t *ppos)
>  {
>  	int rc;
> +	u64 val;
> +
> +	memset(einj_buf, 0, sizeof(einj_buf));
> +	if (copy_from_user(einj_buf, buf, count))
> +		return -EFAULT;
> +
> +	if (strncmp(einj_buf, "V2_", 3) == 0) {

It's twice as common in Linux kernel code to see string equality checked with:

	if (!strncmp(einj_buf, "V2_", 3))

> +		if (!sscanf(einj_buf, "V2_%llx", &val))

More comprehensive error checking with this:

		ret = kstrtoull(einj_buf + 3, 16, &val);
		if (!ret)
			return -EINVAL;

> +			return -EINVAL;
> +	} else {
> +		if (!sscanf(einj_buf, "%llx", &val))

Ditto kstrtoull() use.

> +			return -EINVAL;
> +	}
>  
>  	rc = einj_validate_error_type(val);
>  	if (rc)
> @@ -722,11 +767,13 @@ static int error_type_set(void *data, u64 val)
>  
>  	error_type = val;
>  
> -	return 0;
> +	return count;
>  }

