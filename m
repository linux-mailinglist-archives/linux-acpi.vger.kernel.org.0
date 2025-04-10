Return-Path: <linux-acpi+bounces-12948-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6FA8494A
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21E53AB75F
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CD81EB5CF;
	Thu, 10 Apr 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6Ti3+rN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650AF1DA62E;
	Thu, 10 Apr 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301390; cv=none; b=Sm6enoNX54zA1UYJF+Ja9Z5WhHoCMqgZI0xC+7Tc9nEPev7uazma/EHVfsyss2hxUN6bcu1x9+5Avia14iBkH6qcAKsJJlun5U2iy0oCtgJXtrxbeG88NMRgHA5dZ+2hB5pFI0CkTnqP0HPSm9EXQBeCIuWULT/KBMn7egidyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301390; c=relaxed/simple;
	bh=NFpQUkvyGO0CSiFWwpzKCXGX2UCXDnX2F1Av82SBDcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaLeoOzMMpVpFow+0Akm0sHYsYkgujRnTHRBgnj35omAblR/i8An7nZm1i/1tdQl4jisM61zO6HOtHmUWz/a0OQ41DcnHqJ9J/Ej5r3/5YGKFZnqFgccQU4FLC6nZb467bFZYopKsxxQDIybUuu35ISYnCE5YSS9NHRCoYK8pyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6Ti3+rN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744301389; x=1775837389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFpQUkvyGO0CSiFWwpzKCXGX2UCXDnX2F1Av82SBDcI=;
  b=i6Ti3+rN8bFAf7+c8T1NKCxi28CVnCVhchCqc7S4YB4Keklk71RS8eZJ
   bsMUnA1m2XDd/eTPzbqO6FEeRUdowQ+ed0MdOVKhh+xAuWh0JK7bTnRsK
   Tm86MfAlAMswcFL5oZYBzCrcf7FzmzmufBLKaNixfXm7XYZCltFitn6sX
   eiJMfM23ltuHjupyaZ5dgz64qJHpTA8sUKz8nevBhv3+AfetbWJM64Ty9
   kZAro8lfiq8WMniM4WAc+zzCzP/hDiDqHqH4KzmYGq0WiF0CobIBqAnPm
   TJ33O8doGEiiWrADmh0Jnb9liWYdsdImmt9LIMS5MHjKmC5U+/iqNpytK
   Q==;
X-CSE-ConnectionGUID: jdu2XIfmTmCDRq8RzcquOQ==
X-CSE-MsgGUID: OgpuN0/1Sg6v6Jpf9FNptw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45732754"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45732754"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:09:47 -0700
X-CSE-ConnectionGUID: hSaDRAm1TxWzjMAwBymNNg==
X-CSE-MsgGUID: GfBz++65Ty+MoZ+DiYYdfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129486754"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:09:44 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6F12B11F74E;
	Thu, 10 Apr 2025 19:09:41 +0300 (EEST)
Date: Thu, 10 Apr 2025 16:09:41 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] property: Use tidy for_each_named_* macros
Message-ID: <Z_ftRZ98X6nYNvlK@kekkonen.localdomain>
References: <Z_ew4DN0z71nCX3C@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_ew4DN0z71nCX3C@mva-rohm>

On Thu, Apr 10, 2025 at 02:52:00PM +0300, Matti Vaittinen wrote:
> Implementing if-conditions inside for_each_x() macros requires some
> thinking to avoid side effects in the calling code. Resulting code
> may look somewhat awkward, and there are couple of different ways it is
> usually done.
> 
> Standardizing this to one way can help making it more obvious for a code
> reader and writer. The newly added for_each_if() is a way to achieve this.
> 
> Use for_each_if() to make these macros look like many others which
> should in the long run help reading the code.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

