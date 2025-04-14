Return-Path: <linux-acpi+bounces-13004-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8B3A879A4
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 10:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A1116D5BA
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FA11B042C;
	Mon, 14 Apr 2025 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESOIuztz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F331A315D;
	Mon, 14 Apr 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617645; cv=none; b=L/305KVict+6Ww3MnTRcQwvkInIPHNEhqzHI6/+M8qM4H2Gcx31VhwWRd6Na8ytJVTpFVPTj7FcCPR1P/P7c94wbE7ETjXVllZJKBlvFwDxGDE1nLiL8/41m4GkWeoNGjwXjVYFv6tjD9oxmW8tYmICp3iDaW+/WsZyXYhi1BK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617645; c=relaxed/simple;
	bh=nS8kGgRmgXOiX5GF7XmZCLzBuK9J+u/+QZu8JOEZlzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyQ1XpAdf4OYW55Y35u+grf0h3CqWksVbYub+WARQjaqzEQzU0PEBWwbLVN8pqGBmTR1uOqZiECtsE/WsnH4BVPkskCHF5h/fe4awZaMkqupmkfDI/fxtygKkSe3BtaeAuzHNzU2yr1jkgiUrEN4t7TJZgXwABZWTJgf6LQ+tLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESOIuztz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744617644; x=1776153644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nS8kGgRmgXOiX5GF7XmZCLzBuK9J+u/+QZu8JOEZlzI=;
  b=ESOIuztzaL5rFJ0PfyxO2DF0T4ilSNVVYALX3P1oWTHwBmbaP4NMnbQu
   YorE9cbeDI2ze3CO/eE9R+zRhqr9aUh0PIRJ+vFvh6+Z8o8Ur0YYSpcG0
   0DJjjFQm8F3fxUizkCaWV3WhlSIlch8OOF7FUy14bGjEdpkFvje4imf+m
   mvWOQLsix/L1hdQxTEU8aCMmLOe31H3KI7uJovbq0aQSlkmurUKCFTpdt
   Nk/nv1WKFJ5UJLgeaQaPPiJHU/be6+BIYfi+Gm2uB3DxKmvlb/mH8jYeo
   DvQhw1ee7q7eYy9tlNNFPN/ZgJmFp2Z5qnBPw/0IUqA0AIsanIcIyi2/p
   g==;
X-CSE-ConnectionGUID: TDXTRQ7zRrankB5W+rEXNA==
X-CSE-MsgGUID: gK2Xuw3oTG2DK2HSjLkNGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="63479153"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="63479153"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:00:41 -0700
X-CSE-ConnectionGUID: 9M0tR60UTj2lWctQ0L2vsg==
X-CSE-MsgGUID: 16cMDGvZRMWFk0Cgipp3xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="134899807"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:00:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4Ek7-0000000CAez-2Vt5;
	Mon, 14 Apr 2025 11:00:35 +0300
Date: Mon, 14 Apr 2025 11:00:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 1/2] software node: Add comment for the first ERR_CAST()
 in fwnode_create_software_node()
Message-ID: <Z_zAo3PTEWH9nkTt@smile.fi.intel.com>
References: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
 <20250410-fix_swnode-v1-1-081c95cf7cf9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-fix_swnode-v1-1-081c95cf7cf9@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 10, 2025 at 09:12:11PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> ERR_CAST() is normally used to cast an error-valued pointer type to
> another different type, But the first ERR_CAST() is to cast away the
> const in fwnode_create_software_node().
> 
> Add comment for this unusual ERR_CAST() usage.

...

> +	/* Only cast away the const by ERR_CAST() */
>  	if (IS_ERR(parent))
>  		return ERR_CAST(parent);

TBH, I don't see the value of this comment. And looking into the code, I would
rather drop this part. The current users do not rely on the any specific code
to be returned and also they check parent to be valid beforehand.

But let's hear others first.

-- 
With Best Regards,
Andy Shevchenko



