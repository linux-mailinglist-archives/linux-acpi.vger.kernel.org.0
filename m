Return-Path: <linux-acpi+bounces-8923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1E9AB95C
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 00:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449971F23EE0
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 22:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E21CCEE9;
	Tue, 22 Oct 2024 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9dxbeq8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA231CCB50;
	Tue, 22 Oct 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635073; cv=none; b=h836lPvM/a0T+N1ukC5ukSfn1WwJ9KOgTKnkwQeZPYCirStXEPeSR+I7qNEL11bpyeF/hXHw2BQcv+8F2GA8fkBWtdTrn83tbIm166gmdJK3yhQElcR8gXHgx/i+DAOzHDQGf7MwxAoFjdFSALuAsKl8TYIIz0517ASkLVe6H6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635073; c=relaxed/simple;
	bh=HhjXGOIoQmTl111qLHD0aSi7QzSy2hSuthAv88Ng8Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLvrLonQbG9bJHfR/1FTohsYKWH0L7V7cROBYHKAbQ4mFon8NwoLmiFI61rNS5rBb/kNuDOY2N+9JTfg5BfPuhaUsJRtCiM7AZUTlhAi6Fh4l7Tz8GerK2+DjlAd6JJvLhwp5sCVyktD2imZ0+pzbDlJT/JEiLFTgWWfEh+vVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9dxbeq8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729635072; x=1761171072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HhjXGOIoQmTl111qLHD0aSi7QzSy2hSuthAv88Ng8Pg=;
  b=H9dxbeq806TPfeoLGzGpwlQlw+wG0G07nL4WCGvJE1dEsYpJSnozzGF5
   829tVJ5jlJEBRz0/d1WCepbOtGT4Djka7FnCoXgg8NYFHmpQmpdu1ISsK
   yrj6/pPzn4EJJsiiw8QTdE8wFOaf8R8Zwr98lLJ1P5c2BlkoTPQqiNq4M
   r1l7nM36EkF9xPRd+jYtz8YRx5rOT2zFLLtg4Rhr8gIeaMMEILK4QIkiT
   6MyXWYWbdIhPJ29uErJNJ2E61IM1ZTMCvZh5JNxhm8tEv2xA20G0VvDqq
   DyGCzSdGf59HcTamLZwPeqXBIYr+IslhMVh5YhKsWmlgHEfaI9jLXIhE7
   w==;
X-CSE-ConnectionGUID: MDn2ThmQSd2kyKBxMYCaPA==
X-CSE-MsgGUID: Cze2e7oNT2eCjjiE227Wzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46661311"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46661311"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 15:11:10 -0700
X-CSE-ConnectionGUID: j7ea8Mo0Q3WhidcU3RqWAQ==
X-CSE-MsgGUID: ROGVkmVsSfOu1cwnRhFiKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="110801841"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 15:11:02 -0700
Date: Tue, 22 Oct 2024 15:10:59 -0700
From: Tony Luck <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 4/8] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <Zxgi87DJvsUKTAyb@agluck-desk3.sc.intel.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
 <20241022213429.1561784-5-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213429.1561784-5-zaidal@os.amperecomputing.com>

On Tue, Oct 22, 2024 at 02:34:25PM -0700, Zaid Alali wrote:
> @@ -692,7 +704,7 @@ int einj_validate_error_type(u64 type)
>  	if (tval & (tval - 1))
>  		return -EINVAL;
>  	if (!vendor)
> -		if (!(type & available_error_type))
> +		if (!(type & (available_error_type)))

Extra parentheses around available_error_type not needed.

-Tony

