Return-Path: <linux-acpi+bounces-13416-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8BBAA7489
	for <lists+linux-acpi@lfdr.de>; Fri,  2 May 2025 16:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D087A816A
	for <lists+linux-acpi@lfdr.de>; Fri,  2 May 2025 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C34D255E54;
	Fri,  2 May 2025 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9LTaApJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D923C4EB;
	Fri,  2 May 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195085; cv=none; b=h1DNRnyYBm1bNtK7q9KAQoEu6vHhS7kQSSbNIEXgjqyt3SEkqFn62ggR79RWdmgZsFv7Hp7pfzItP5vaAvfWztSAG7OkENwVscnPxjobuC+O/rSCPeg//f3yvY049gn5lImpHfJMDEitaPNXBwtVnMCvPTRuyEVQjwNmqLOh2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195085; c=relaxed/simple;
	bh=fI8int6GwyFtK95rMNSsItsfvmo8TsGY6WIgwq2pULA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvtINsnvrGTQ4I7noni82AQdat8Rv8jLoRcKHLgWMltlL5nv93pQdHnzbQFeCyPDATm6U8xTgzP78X0Hkxwjmm9enOXApDaizmDZspE72/qD0Df95uExqxFA7JTzgHSMpWWED1NGfMlV2FTrLSdwvHoKM2HFAOPQeBpukzwDPT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9LTaApJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746195083; x=1777731083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fI8int6GwyFtK95rMNSsItsfvmo8TsGY6WIgwq2pULA=;
  b=f9LTaApJspN1dSK9olRab/s5Yd62d97/jkMxDGNdi8VTdAWsczvBNyaD
   Sp3g1jtPSXNFLvXjQP3I7F3w17hoEt7hnR4f0YUvqEPnwuRBSvkFscvns
   oPcd2BFC0oKVC9leVhH4XFbauf5l8KxlihsP8YbogqPnbO3Ozu64RExZy
   kiESJW9X/ZZdFCTG1T9YxN3zGPG9/sL2aJduXZ4E/dvDWXP8hX72093E7
   vwnBjqQlkfYvP3XKCRSCj0tbl6hmfto767RQNU1v67elwjPHSzTGcClh6
   Scg7siH8AXDTr6KjJgB+MrKLEFH0VXeM06+615tOWwUmSQc/ADW4h84mb
   g==;
X-CSE-ConnectionGUID: r5O3unCRQ6eVKqmKGJj3Lg==
X-CSE-MsgGUID: VynxQGSkTTyu4CCiVaP+Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59260332"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59260332"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 07:11:23 -0700
X-CSE-ConnectionGUID: DRwbBmS9TIy4ifmd3DufGA==
X-CSE-MsgGUID: 4tGEwZXgR9WRZFJAQBgJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="135631033"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 07:11:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uAr6k-00000002Dhy-1qf7;
	Fri, 02 May 2025 17:11:18 +0300
Date: Fri, 2 May 2025 17:11:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: VIOT: Remove (explicitly) unused header
Message-ID: <aBTShn_UpN7ySKX7@smile.fi.intel.com>
References: <20250331072311.3987967-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331072311.3987967-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 31, 2025 at 10:23:11AM +0300, Andy Shevchenko wrote:
> The fwnode.h is not supposed to be used by the drivers as it
> has the definitions for the core parts for different device
> property provider implementations. Drop it.
> 
> Note, that fwnode API for drivers is provided in property.h
> which is included here.

Any comments? Can it be applied?

-- 
With Best Regards,
Andy Shevchenko



