Return-Path: <linux-acpi+bounces-13049-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624FA89414
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 08:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D103B7281
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 06:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C40C274FF3;
	Tue, 15 Apr 2025 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GH3sgxKY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E065274667;
	Tue, 15 Apr 2025 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744699347; cv=none; b=N69Ga2P2fgOoKRKIbm9Ldpw+L+7LRsL2Wd0ffpBKyxeb1QmMXAqwqh1DX9JR1pQdZVgEQp5rMhDon7iBR8rH7rfWNmYqIId584mij5p1KkHY0CshtpGANnikVeLP15AGp3CDOK07oe+tbxTbW+B2fx2/akKvFUUnwcOe727e24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744699347; c=relaxed/simple;
	bh=K2AbIrX1FH4nIalS0DSLv4PIKSumjkkHve93sNSsPOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGl7JiUky5H3sapYd5mR03A120gJlQYm9JgFDTMafGrfuSIteYA9LFo4UkMYnoup8b4MCRg2iHDPHSrZ8lVVxz2AQuMQB6YmrIkrWf8+IqzHFr4n/2NAaEMFP8Ikdy+98uQnuiHsb7DJ8jeg0AJm49Wy9xlXJL3pUPV392/yDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GH3sgxKY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744699346; x=1776235346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K2AbIrX1FH4nIalS0DSLv4PIKSumjkkHve93sNSsPOc=;
  b=GH3sgxKYZVFWUxPzzVoDGecMWLi0dZ86XhK7ceFREzQL+ua/L4N7QQE3
   T+iiI//CoEwicJPSogLQrZyB0VSMM8dAWx7d94wRkxStm3AiLNfgZqlWp
   JApiBqgkgbsHDqnhO1s3HkKve3Oh3/QAwMwtjmzeeHWDQghFGhXz4AZUL
   MEPDpEKxWWLC80H5CKpejUJXzuFKhcB5kW+JDNQz68hGkmWQOpyzncXT5
   IiS5ljwxtbSQQTn25sv80Z038z8SUqdM63wr+z4cw9yv4oItcXKz+Eu6K
   KtN/KgJbdCFpQpfrsKkkEjU9695FB4SxAAeEUabkv98lP4ZHxRA6iWEQG
   w==;
X-CSE-ConnectionGUID: +iy02/4UTxuOCg60aS3DWg==
X-CSE-MsgGUID: AYz9bRCgRwexCdTkTrqALA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="45901623"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="45901623"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 23:42:25 -0700
X-CSE-ConnectionGUID: xDWLzVhOQ2OA5rTpy+ytdg==
X-CSE-MsgGUID: suOE4PDaQYGVuZnvmMD98Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="129792965"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 23:42:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4Zzv-0000000CSpk-11u0;
	Tue, 15 Apr 2025 09:42:19 +0300
Date: Tue, 15 Apr 2025 09:42:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 2/2] software node: Correct a OOB check in
 software_node_get_reference_args()
Message-ID: <Z_3_yrvxHBwY6LBn@smile.fi.intel.com>
References: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
 <20250410-fix_swnode-v1-2-081c95cf7cf9@quicinc.com>
 <Z_zCeHu9MKgLG0jN@smile.fi.intel.com>
 <fb77f98a-7e1e-40ac-bccb-0023da6bc297@icloud.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb77f98a-7e1e-40ac-bccb-0023da6bc297@icloud.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 14, 2025 at 07:12:27PM +0800, Zijun Hu wrote:
> On 2025/4/14 16:08, Andy Shevchenko wrote:
> > On Thu, Apr 10, 2025 at 09:12:12PM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> software_node_get_reference_args() wants to get @index-th element, so
> >> the property value requires at least '(index + 1) * sizeof(*ref)' bytes.
> >>
> >> Correct the check to avoid OOB access.
> > Any real traceback?
> 
> no, find this issue during reading code.

Please, mention this in the commit message.

-- 
With Best Regards,
Andy Shevchenko



