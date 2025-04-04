Return-Path: <linux-acpi+bounces-12743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A4AA7BAA3
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 12:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71CAA7A9A8F
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247FF1A2860;
	Fri,  4 Apr 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PELMesK0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87919E83E;
	Fri,  4 Apr 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762229; cv=none; b=W06Rzt4YJuYnL7LqkeBlis2nMBBmlOKG5HwFs+JKFSuFxuL+VSQUOqizmih05//xjGF3bbxmFl4JrjB0ZchOXQyNwffvzS0t5f5p+xcAkZrp/ILp2qgIh/zodENa5zWxvm3GSV/3Sqo1R6NFQLNKM5LKxBMwW6jR3kG+xyCMBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762229; c=relaxed/simple;
	bh=G3DHRykAJsFPNtKywFuVLMidcuSrP/szhRTE/I/+bwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+1LD0OLwMrsKAyNBjdaZdnC26x7hlb2faExsEY8F/xE8cRZgUHZKlGJSHJrF3Qc8ntZX49umyMRrdwxW7bjY2BdMKDUqZabIaBpFbZYJmxvETt/PY5+UDwOInoBbzuCaIUMnPFRsWM3p0xpf26k2KAxgHsYGntRfoHqlqjqJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PELMesK0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743762227; x=1775298227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G3DHRykAJsFPNtKywFuVLMidcuSrP/szhRTE/I/+bwQ=;
  b=PELMesK0imhUtfJPTvAjxzEQVTBB9SlF66VdnJP8IPYUoGZhNAabScjJ
   ukAR6bsFpI0nhafchMOMVe1NNRO4hCSwQ5WUReDGP71r8QvQn8Oih9agi
   lpjtAzUpGehOJdugjY+8iD0BmKbABMtDXfmtSFCzkc9//1ScXS/uzifwo
   Ky7CG0HVhaoRJWD+b2eHEVZL6sYwzMILVI/NLjJwg3e47lmzZgz1wOhGI
   X4sZzRN808YxUPfSuvFebt8gCrpRYbpseJl8k8OmHfc90SJCyCdzY3TkS
   51rHCZvCTl9vpAYPGic/cTFOIKT2MzKaGOrTb5BjoIAUX7PQvSKWlAEOE
   Q==;
X-CSE-ConnectionGUID: gYqho+gSSgCn+Ww6p95NeA==
X-CSE-MsgGUID: QoQ6AI5nRvipGX4kpYxhEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="55862232"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="55862232"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:23:46 -0700
X-CSE-ConnectionGUID: tEEkrku3TiaLvZ4AdByl2Q==
X-CSE-MsgGUID: Cw3Kzba3SwSiXPCrApk87w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="127084346"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:23:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0eD8-0000000968G-2vfA;
	Fri, 04 Apr 2025 13:23:42 +0300
Date: Fri, 4 Apr 2025 13:23:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/6] gpiolib: acpi: Refactor to shrink the code by ~8%
Message-ID: <Z--zLv23Qg5vobNB@smile.fi.intel.com>
References: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mf8AyxAeNbBbiQn1HdkrEdODmTAhTmrtiAp6H3=HUPSWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf8AyxAeNbBbiQn1HdkrEdODmTAhTmrtiAp6H3=HUPSWg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 04, 2025 at 10:38:04AM +0200, Bartosz Golaszewski wrote:

...

> Will you take it through your tree or do you want me to pick it up next week?

Via my tree as usual.

-- 
With Best Regards,
Andy Shevchenko



