Return-Path: <linux-acpi+bounces-13919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F42BAC7274
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 22:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A191BC4D90
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 20:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D888121ADD3;
	Wed, 28 May 2025 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHDlS/eA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE9210F59;
	Wed, 28 May 2025 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748465736; cv=none; b=AagLs7qWJcBOwwNFweZ9swOH3NeWFe2pXx3B85DklOzcmFIZcbYYtdg6ctj0NPhcpFqUZUrVoJ+3LEaT+Jrp1Tzag0ePpItSI3nPyMT7LPDgAbG/brqkFi6pgKULLY8rIMJfJPU/M0WieN5kjLTZutOkTvuy7pSQ0M/P8mbxeko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748465736; c=relaxed/simple;
	bh=KBEI+0F5XZGs9ecP4UChtml9MphRwAe5vpYbKetN1Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1eB1m9wRCfExWMls6w9UgJWq+FM4gyiLUNhujnoHylNP8+Jh5ggugIP5Re6OhJo//9IiC4duJ8hXhhlTcDcLSP00lKrGLYIqhngxOVeaM9l/vZrX+3ziMFh3YOyfex2fYiCj+DdKYoj+FEOekyHot4YFuwNCx8DSilky42mtHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHDlS/eA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748465735; x=1780001735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KBEI+0F5XZGs9ecP4UChtml9MphRwAe5vpYbKetN1Gg=;
  b=HHDlS/eAA4jUzmmqLx3CTgAEhCLRci2frrQgAv8urfzrWB2XET4K/MBi
   KzeKv0w3z9/OQC4kqs58B+BsYl5hIml8AFmIVuN8Zfj4D37u0syiX4EIt
   Wtaqs+VhNJ29K3VFQAY2atR8PRdboTBfyCR2o5wRzW1gXps19ihamjPNB
   zRCSOMoszNUjg3uWnMZmrGKfhJ2lBwCFzeuEApf7015zS82tKfUOZgEiB
   gGRVcHoJtCVhON3FeQc2uSftmkRfDszmJ6kPy+1hrQ888P7Hl6oWthcKH
   zEp/bHEwrwE01hP5iK13UqKIKKDeKIXxC6LH0ZsXV1hbKPyuDeEOxvEEy
   w==;
X-CSE-ConnectionGUID: 9pOFE9r8Re+7ExOLzHdCnw==
X-CSE-MsgGUID: /ewkzxU0SaCiY8W5ll95+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="75895742"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="75895742"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 13:55:35 -0700
X-CSE-ConnectionGUID: GAyXn6REQMC+J2Dvn7xEPg==
X-CSE-MsgGUID: Km/GkQ8zSASFPsz3AO562g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="143816832"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 13:55:34 -0700
Date: Wed, 28 May 2025 13:55:32 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com, Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <aDd4RA5vHz1RjFuk@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-6-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506213814.2365788-6-zaidal@os.amperecomputing.com>

On Tue, May 06, 2025 at 02:38:09PM -0700, Zaid Alali wrote:
> -static int error_type_set(void *data, u64 val)
> +static ssize_t error_type_set(struct file *file, const char __user *buf,
> +				size_t count, loff_t *ppos)
>  {
>  	int rc;
> +	u64 val;
> +
Add
	if (count > sizeof(einj_buf) - 1)
		return -EINVAL;

to make sure copy_from_user() can't corrupt memory after
the einj_buf[].

> +	memset(einj_buf, 0, sizeof(einj_buf));
> +	if (copy_from_user(einj_buf, buf, count))
> +		return -EFAULT;
> +
> +	if (strncmp(einj_buf, "V2_", 3) == 0) {
> +		if (!sscanf(einj_buf, "V2_%llx", &val))
> +			return -EINVAL;
> +	} else {
> +		if (!sscanf(einj_buf, "%llx", &val))
> +			return -EINVAL;
> +	}

-Tony

