Return-Path: <linux-acpi+bounces-13007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE52AA87AE3
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842843ADF21
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7731A83E8;
	Mon, 14 Apr 2025 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2o23tF/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D622E2367A0;
	Mon, 14 Apr 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620341; cv=none; b=LWcHhm4BTmU/EWDTkmKQoL3jkl7xlVovoFnfi4E79PGq1nuztxXi6MX36dSzpk/gDQA1SMSCnDxVNB3rUiNNyWNQMu8bGAJN3xIZtw69lw/GOut7kezIJTxbAn2oBx4SuLpxcBaKg/qhkiWZLhZLB4pf7rMjnZ3XK9GrMc4H5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620341; c=relaxed/simple;
	bh=9XdhgbIIhat3P/v/qb4F2GQ7Fl5lK7U7hIIGMjLDfvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayo+pBqpWgn7sKBydh7ukMA3n6WZCG8vPF5aKjhRy9CvD6Uy+M5cmSVjsW6SLRFpIXz5I72ceW+zm7NT6z6XAu5LejhB5Joh8rJ0M4+qoPBi9iXhjV4NzuCkcAZ947APXcVt9oVoyegyyuYa74uEBG8IBbDSUO2huDPv6AKp83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2o23tF/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744620340; x=1776156340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9XdhgbIIhat3P/v/qb4F2GQ7Fl5lK7U7hIIGMjLDfvY=;
  b=B2o23tF/oS1xQUumjav+FkqbHKEtKKFc7a416XrCQIfgyBxW8mVp4AKL
   UjPt6DTGvJoXOyZFRKSwryHl6+cuRjOnknj1kJ144ezhkDRlJD9i9Zc40
   D3IutPMD8eDbWqYgYQTj3djOElRVqhhTxzTOJSDkyfjjnlPP6fbpsqBpJ
   FVOZUu0kI3GUJrSVwmsIDJNn0L36TIG3FWypQh/l32cw/Fc5DzY8WDmDU
   Lyv9SLYudHQe/U/kaCBsrYdsIDePzTtTXOyKT3iZRuA7h0MJsozoRwetp
   NjWSTWI9qGgrO6d75J3DYOoEIyeVFh7jHv8iag4ZHATpP2f0VtnKhtTCG
   Q==;
X-CSE-ConnectionGUID: rPAIfTVBRKak2RKgDlIfBw==
X-CSE-MsgGUID: ctJhe+XjQAudae+o941KRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45216913"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="45216913"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:45:37 -0700
X-CSE-ConnectionGUID: 9VZE5wDaQlSPyo2fnIvaqg==
X-CSE-MsgGUID: eN0lkXvdTXmd8B+wcD5I+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="134912156"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:45:35 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 21A4C11F871;
	Mon, 14 Apr 2025 11:45:32 +0300 (EEST)
Date: Mon, 14 Apr 2025 08:45:32 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 2/2] software node: Correct a OOB check in
 software_node_get_reference_args()
Message-ID: <Z_zLLPlbiRObl20l@kekkonen.localdomain>
References: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
 <20250410-fix_swnode-v1-2-081c95cf7cf9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-fix_swnode-v1-2-081c95cf7cf9@quicinc.com>

On Thu, Apr 10, 2025 at 09:12:12PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> software_node_get_reference_args() wants to get @index-th element, so
> the property value requires at least '(index + 1) * sizeof(*ref)' bytes.
> 
> Correct the check to avoid OOB access.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
>  drivers/base/swnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 67040fff99b02c43999b175c2ba7e6d04322a446..efaac07f8ba38fae55214b71c2ecee15b5a711b1 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -529,7 +529,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  	if (prop->is_inline)
>  		return -EINVAL;
>  
> -	if (index * sizeof(*ref) >= prop->length)
> +	if ((index + 1) * sizeof(*ref) > prop->length)
>  		return -ENOENT;
>  
>  	ref_array = prop->pointer;
> 
> -- 
> 2.34.1
> 

-- 
Sakari Ailus

