Return-Path: <linux-acpi+bounces-14760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18396AEAE0E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 06:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1491018954FA
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 04:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48131B4F0A;
	Fri, 27 Jun 2025 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2jh1LEf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB12AF1D;
	Fri, 27 Jun 2025 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999649; cv=none; b=l9vGrW/adxglQQ8m4ejdqr//UhEq6GGE6DApBjH1D6MLXxus0o1CCT/KhPZRvQ7kzhop1nvkqhHDDg6ps72mfSEV6JacnkKg+wWVmUdh8Nju2c6X6O42orlyy0FllyoCHHZMmIWSHoCRwNLrKyrjuvVt5H3u+/W/MgukXqqA6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999649; c=relaxed/simple;
	bh=HAhFXH1w/2DE6MeW6eWSsQO8R+2tYxbZbAHOxE8Y6kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9tX/84lORLl7aI8Dz69ruUSwkvzNEcCL6bdpm1dvTMzktnRTr21NXeLWD15pPaosueCE7FOYwnoXE4EhaK63EQpSamJ0wjpBCbrj8p59w8fVjG9Mm26Q8XRVjtVB9pfKFjrVTR7uZ+L3bkCmUHjICBpaxMQykypVOLLTZEnogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2jh1LEf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750999648; x=1782535648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HAhFXH1w/2DE6MeW6eWSsQO8R+2tYxbZbAHOxE8Y6kE=;
  b=c2jh1LEfvRQ/KLgy22960CkpRLp37rfTXM2lmlp9TaCbyrSqN9sV/VdB
   m1ZW94yUZs8s0Q4EWBUVyS5HLot88Qr8Lg/8qoIGcYhaM1wXdGZxxQZdf
   XTG8VWKCiCi2mvlu/bnXKcYIqczCzCf1j5UXgwhj2pUjF3uhBKgUzjdg3
   /LZGb6bG4G7kAMmD3Tnl9BJ6HbRwh4MsvYj+ydfAvDqVkyUetdjUEMeju
   h1bOaYtu3wgs3tY/XsMNp77QTJVP794L6sJFxe3DNUmiAtZkddhpE7HUL
   omevGTWQj9APNLDDZKxOCv/KLyTeXAnAT2oSmq8oIgCZIuHRg0/HdmvI0
   A==;
X-CSE-ConnectionGUID: fjAMXWrvSc+KPz/omg266A==
X-CSE-MsgGUID: u6VaYVamQZGlHXe8KvI9nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57114237"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="57114237"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 21:47:26 -0700
X-CSE-ConnectionGUID: 4WvGYQyQR+6bK6MRdV02CA==
X-CSE-MsgGUID: Zird+nJeQOuWw/4OPM/LEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="153206263"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 26 Jun 2025 21:47:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B83FC21E; Fri, 27 Jun 2025 07:47:22 +0300 (EEST)
Date: Fri, 27 Jun 2025 07:47:22 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] Documentation: firmware-guide: gpio-properties:
 Spelling and style fixes
Message-ID: <20250627044722.GN2824380@black.fi.intel.com>
References: <20250626130109.215848-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626130109.215848-1-andriy.shevchenko@linux.intel.com>

On Thu, Jun 26, 2025 at 04:01:09PM +0300, Andy Shevchenko wrote:
> - Use consistent style for active-high and active-low
> - For C and ASL code snippets use 4-space indentation consistently
> - Interleave case examples with the explanations of the certain case
> - Remove or add commas when appropriate
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

