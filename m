Return-Path: <linux-acpi+bounces-10961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE40A2F1D3
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 16:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A3B1882568
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8223DEB1;
	Mon, 10 Feb 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdqRKF1t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B444E23CF11;
	Mon, 10 Feb 2025 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201693; cv=none; b=KmyyT1nx1gh67O3eDDBJONq1jXAkLokQXMrJ3KQ9TbdHKAWNwRmG8mgXZzwTqparn+Nx/RyNp+rwmPI05+pBmuzD7ZkBInUnryHirO7STWDD3Y5doxf7z6dkb4G+AlnufYXTmIkE2nLxOxv2swFKgwjEPBTa9ZbSVc9LIHKfpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201693; c=relaxed/simple;
	bh=JOtO8MOgOSuWAOb0ClB3AM7hMayERB0B8VgrQ5ui5/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHHI6lIhsrVrTVgteMkQqAf51hmaNkYmpKMReb0doGntWuv3dswGNpbEL7t1Oejqsyt0Vam7Ub+GTFRbh2exeE3WHfHFAzgT6D96tYtyrPNMpiAhJnAfnq04qEswSnxHCv81PEPvejF43aQ+Wf+3gAXbBR8qkfEL23Bi0JIJ28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdqRKF1t; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739201692; x=1770737692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JOtO8MOgOSuWAOb0ClB3AM7hMayERB0B8VgrQ5ui5/c=;
  b=hdqRKF1teMeuuczzokvbk/HuV7TiNyi2iJ9HMms1Jtp/vFIIbIGUHtFh
   RyckKvhFCCEdEHUM/pKfZcCBJofxKaIXFRMeBN7ZKBYboQx4RABuIRr82
   EmYEPiHmt6aD03JK2WVFn5sJvyUuoQgSOGVZcoo/PqlpEZE7YJsYX8E/H
   Ouev2eEL47k/q/+LyWx5PelvgM1GMR6z8c8CaAQT5F0FT6F/mEqmaCozL
   JWnnNvRAWOACh//hswKCDu2AuIHmB1OLDC/8nTjMLgUrzsps8Lvk+kcdE
   7CMDdRX6dlbpi7L08aOhWaiQjAJyeBlGBuNQT7ewCGRrSehIHJ+ZHm0hU
   A==;
X-CSE-ConnectionGUID: 3rr32fspTVeMFXHXkPm5Ig==
X-CSE-MsgGUID: w9D0TE5yRK2DviJkpEF7kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50417835"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="50417835"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 07:34:51 -0800
X-CSE-ConnectionGUID: 9mnFK0SHS6O9mxIrWaidvw==
X-CSE-MsgGUID: nxOWyucCTsC1e9Egd/MCjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112060795"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 07:34:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thVo5-0000000ADiu-0sbR;
	Mon, 10 Feb 2025 17:34:45 +0200
Date: Mon, 10 Feb 2025 17:34:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3] of: property: Increase NR_FWNODE_REFERENCE_ARGS
Message-ID: <Z6oclML_DC1Vnf6z@smile.fi.intel.com>
References: <20250210-fix_arg_count-v3-1-a084a5013008@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-fix_arg_count-v3-1-a084a5013008@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 10, 2025 at 11:00:32PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Currently, the following two macros have different values:
> 
> // The maximal argument count for firmware node reference
>  #define NR_FWNODE_REFERENCE_ARGS	8
> // The maximal argument count for DT node reference
>  #define MAX_PHANDLE_ARGS 16
> 
> It may cause firmware node reference's argument count out of range if
> directly assign DT node reference's argument count to firmware's.
> 
> drivers/of/property.c:of_fwnode_get_reference_args() is doing the direct
> assignment, so may cause firmware's argument count @args->nargs got out
> of range, namely, in [9, 16].
> 
> Fix by increasing NR_FWNODE_REFERENCE_ARGS to 16 to meet DT requirement.

...

> -#define NR_FWNODE_REFERENCE_ARGS	8
> +#define NR_FWNODE_REFERENCE_ARGS	16

Thinking of the case, perhaps you also want

static_assert(NR_FWNODE_REFERENCE_ARGS == MAX_PHANDLE_ARGS);

to be put somewhere, but I don't think we can do it in this header file.

-- 
With Best Regards,
Andy Shevchenko



