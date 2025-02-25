Return-Path: <linux-acpi+bounces-11463-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB31A4429C
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 15:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5951882D11
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDB426B2C6;
	Tue, 25 Feb 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ht7FGo4h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB626B0B6;
	Tue, 25 Feb 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493243; cv=none; b=VyAq6r01aAA3hHR0H2s+R/NQLfhIMwfSTEtczlNLMpTQ5yjdH9YuVQGQ07u2wsH7n11RNouRFOY8lLFcqH6djlACDc+AWOY2b4Jx9TJ5QIcIZfzrB+AsWKJoidFsHlcuwXhpSM7qk5ySgtmSv7/Vog0kdJzYvLLR3Q1EL5XEFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493243; c=relaxed/simple;
	bh=0nB8zD88/ETArJkz+n7GmRzMANgETAdoS3ICvt6uEn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOGh6sSsUW+pfnJdedywn2FpZtzT/xz1fsvI4ctDX83Mpij3f2J6ZDRFQ9qCSNVikeRV3ZeIuKPHG5PF+BJCNjP2OlLHsHK3gu54khnCHkgEMFGzB2gardHx0ERMzgR+XbfizM97lWZ8+59NCfCJNy6BWL/JkHoVOyJ9aE8Hcvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ht7FGo4h; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740493242; x=1772029242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0nB8zD88/ETArJkz+n7GmRzMANgETAdoS3ICvt6uEn8=;
  b=Ht7FGo4hUjYBW4OYicoXXIvEpIf44DuUxlX7jewgd/Nm341q1xamcPLY
   soGKYibuPS5vQWvs3EVMm9DjhaHEQt0e/b6RBGCCpxM4cuuZZAXujDlsP
   5WkTPO33IwcSDFeCWwmsWVecPpfWPV/3npXuHm1m87ggisNdZBjAa4uzn
   1XClJB7qd8N9P1knAoAz3aU9Be7jqeYqtd6lJGMisgaXD3OmRGwFgDlNA
   sY8fIq0ekVVxh4kuT/He9+Mi2FboQje9T3bmPyLY0hNZo85TrUIdpFJKz
   JcXVtcDB6HuGK/5bUpKXTgu2s72iceplY9zw7IMbnVzEUGUmgacXKcqT2
   A==;
X-CSE-ConnectionGUID: BQICi72dQpKe6s7EJ/2vLg==
X-CSE-MsgGUID: GFSbOynnQ1uYcLOy1AwneA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41003327"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41003327"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:20:41 -0800
X-CSE-ConnectionGUID: mYOz7AmTQoGiMPFODo97HQ==
X-CSE-MsgGUID: Ssj3M0sgSRSCOWvPV3AbRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116889296"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:20:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmvnW-0000000F10y-1RF9;
	Tue, 25 Feb 2025 16:20:34 +0200
Date: Tue, 25 Feb 2025 16:20:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v4 2/2] of: Align macro MAX_PHANDLE_ARGS with
 NR_FWNODE_REFERENCE_ARGS
Message-ID: <Z73RssDaLZ1NLpSZ@smile.fi.intel.com>
References: <20250225-fix_arg_count-v4-0-13cdc519eb31@quicinc.com>
 <20250225-fix_arg_count-v4-2-13cdc519eb31@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-fix_arg_count-v4-2-13cdc519eb31@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 09:58:07PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Macro NR_FWNODE_REFERENCE_ARGS defines the maximal argument count
> for firmware node reference, and MAX_PHANDLE_ARGS defines the maximal
> argument count for DT node reference, both have the same value now.
> 
> To void argument count inconsistency between firmware and DT, simply
> align both macros by '#define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS'.

I would add here that the of.h includes fwnode.h already, so it doesn't
add any new compile time dependency.

Both patches LGTM,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



