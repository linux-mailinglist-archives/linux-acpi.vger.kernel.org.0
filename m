Return-Path: <linux-acpi+bounces-10630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356E2A10CEC
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57223A989F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531931B5EB5;
	Tue, 14 Jan 2025 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAORVBUW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC0814AD2E;
	Tue, 14 Jan 2025 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874094; cv=none; b=UI2chuLKVu3iUHTKBRTsnVPzaEVXSni3VfYr0qFsuR0d/qFRZmeAgZyL7UNGA/M4sbKxY2NE0A0x/uh0NzZoLkQSIvplwhj9j89IWbCFGoclWdWXtT4Hw9YGbR+fRDOzg3ZvUblroYB5ABGY+DdFhjiyzvD5MpjZB8nM9FShiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874094; c=relaxed/simple;
	bh=65QG1tW/4sR2DHC8rI2tNWUPtgLKP6zXWi1YJ2S+qkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF92NCoXiqb9MJTWM/kDvSvTfB6rqFXbBfbbS1kLIkOudpKIKs25tsC50wxlB0mtoUJ6D3rp/TvGUzbMHy0fLz/BKuhbjyka3ixjI7GBj8TfcJ8u9AGY41X2C+iyGWqD1JZN4QefkffjXyxGmd8/Evud1EeXmJdqgIHOWXHnubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAORVBUW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736874093; x=1768410093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=65QG1tW/4sR2DHC8rI2tNWUPtgLKP6zXWi1YJ2S+qkU=;
  b=OAORVBUW6CrNecTlPHnt/H7JqmwJTl8YnWE1sW1rllk0Y5HwtwvmUtd8
   gP9ghUAuypyV0TckgorVLCpr2RNkgI1ng9DxcTHYXfrY35/55dPr1kKmH
   LJ1LxpTfxf74ATLEaqnjpxffBSvMQP4wr0O07OIoNkSNpWmd2WCQLobKP
   GGo9I2DIF8xQEl/orHWA4bbHShXF9r/jop1HWa/T4DQxM6EnvfLkdEQiX
   cBnA3+GmGkidlUh2C1qveRWi56YiAFHFgxlGi1mGhoDWYzxTudzeYd3sc
   Lq2JbvENyqBeJkxMMhwRGgtebotbui0hbHpcIOV8l8wG7uHYj68ZLQtY0
   Q==;
X-CSE-ConnectionGUID: NdAqTaJpSpCsgfxv/ebOYQ==
X-CSE-MsgGUID: 1CKM3H52REmsiGDCd3+NMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48589815"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48589815"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:01:32 -0800
X-CSE-ConnectionGUID: jc5iAFGqQt+4BMYKPmH3/A==
X-CSE-MsgGUID: SqJ5++GhQ6ObZYLNTWGmPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108918680"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:01:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tXkIB-00000000vlZ-01bv;
	Tue, 14 Jan 2025 19:01:27 +0200
Date: Tue, 14 Jan 2025 19:01:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH RFC v2] of: property: Fix potential firmware node
 reference's argument count got out of range
Message-ID: <Z4aYZtR3WcbpCRui@smile.fi.intel.com>
References: <20250114-fix_arg_count-v2-1-efa35ee6572b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114-fix_arg_count-v2-1-efa35ee6572b@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 14, 2025 at 11:51:13PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Currently, the following two macros have different values:
> 
> // The maximal argument count for firmware node reference
>  #define NR_FWNODE_REFERENCE_ARGS	8
> // The maximal argument count for OF node reference
>  #define MAX_PHANDLE_ARGS 16
> 
> But of_fwnode_get_reference_args() directly assigns OF node
> reference argument count @of_args.args_count to frimware

firmware

> @args->nargs, and may cause firmware node reference argument
> count @of_args.args_count got out of range, namely, in [9, 16].
> 
> Fix by increasing NR_FWNODE_REFERENCE_ARGS to 16 to meet OF requirement.

-- 
With Best Regards,
Andy Shevchenko



