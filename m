Return-Path: <linux-acpi+bounces-11485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C8A45845
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 09:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A937A8C59
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC9224238;
	Wed, 26 Feb 2025 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcU4NCYj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B251E1DF4;
	Wed, 26 Feb 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558619; cv=none; b=SNG6YcQre1NwTZwAPwZ26EtYm7rKtkc0SxTZLqakRaPnpKWfm1ociBYBl9aFgmR/LPqzqivXa+VUrxR5/mUGUL7wbgwLFNQT53PUy1wR+A8h+lsKjZbmoblmnPeXjZXvulaifcbQA43EKK4R+diysfL9xh059rCvtF8xJhhxoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558619; c=relaxed/simple;
	bh=QKs0aJw/4pMrdH1t4ztDQx4qoHjE3cMoGY3wK9VeYDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDhkHxsCQV/SKPUpmmdhhecJG9rb/sfbvn0pw4nOJDkdkd1U8lp84fGqQkNc6guQNZyIkIKrjeFzYZLvwvIVrTTSCCJPa9efGykQtK5qymIHlUsW5fl1zgUkbGgHBYspn4e+yiveG8I+vxncLHTBNyPrq1oFF36efaim84hz/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcU4NCYj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740558618; x=1772094618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QKs0aJw/4pMrdH1t4ztDQx4qoHjE3cMoGY3wK9VeYDY=;
  b=ZcU4NCYjXp3k+u7tIVAEVAKkH7YS18xx8qGmkOSFaW6W8zjTIjISsTAy
   ZsVHxMsse7yyaMAnr1RBlc5n9UMh6F6J/35rg9QCMV7VwOBnCWhapIQcr
   rhJMT/BRU1YqNfuZ0nMuA71A1BCO+i33o95f9wE4+NyxbmXV6VFx5O6ov
   HIc6ND3Rfy6+J1Ss1TzihLNjTlxfQ1txdbOGvGCt2LCuiMtMFoD80pHCp
   36nyrfKRAhTbwMEielwPCi2yIPrH25Y5IkHEHa7aSpZGswtlucdgNdVKc
   ouSY+VsXiaJLNdHOVsZ9TMr6O4iquijlJH/ww2+U12uZRlXg8GZJ0kBGQ
   w==;
X-CSE-ConnectionGUID: 4BqkXgd/SPGFpJpcGTSz2w==
X-CSE-MsgGUID: 8P1HuV1TTgi2rOgPbudFRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41273081"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41273081"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 00:30:15 -0800
X-CSE-ConnectionGUID: 3DYcpwisTYuPlgqUgmglkw==
X-CSE-MsgGUID: gexfeNlPRXmCAuBmQ3NTvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116639758"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 00:30:12 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7021711F944;
	Wed, 26 Feb 2025 10:30:09 +0200 (EET)
Date: Wed, 26 Feb 2025 08:30:09 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v4 1/2] of: property: Increase NR_FWNODE_REFERENCE_ARGS
Message-ID: <Z77REZL8538tZLzs@kekkonen.localdomain>
References: <20250225-fix_arg_count-v4-0-13cdc519eb31@quicinc.com>
 <20250225-fix_arg_count-v4-1-13cdc519eb31@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-fix_arg_count-v4-1-13cdc519eb31@quicinc.com>

On Tue, Feb 25, 2025 at 09:58:06PM +0800, Zijun Hu wrote:
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
> Will align both macros later to avoid such inconsistency.
> 
> Fixes: 3e3119d3088f ("device property: Introduce fwnode_property_get_reference_args")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

