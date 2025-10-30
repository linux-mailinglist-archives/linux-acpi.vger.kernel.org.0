Return-Path: <linux-acpi+bounces-18360-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C77C1F529
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 10:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DBD94E6FEA
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77133F376;
	Thu, 30 Oct 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myh00R13"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7C2E5B1D;
	Thu, 30 Oct 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816895; cv=none; b=sFPUY36ADMRwl7Mvrt5NTxUh2PReLW/YRCezzQ9qf3+FtlAWlCoTiC53b8QuaeX+po/Xb5Em2XlY8QU5ZkYmR5r10WtK1fpZ9wZYBVhDaYlMghVZnSrzDZciQpxye2vw6m0VV5jWimU9gS+14ZKdE+HkwRMkL+N9uTUhtEF+i3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816895; c=relaxed/simple;
	bh=rvMHMWSaRTtM3sUcXJIOCKQk5avbx1N2srj3Al582BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8/Ey1tpgvB/poLmVNBZpyI+/5cPLPyApNtFeIjfR+xPBXyDVkK71GbnYTjdWPk7APx+hQtjxve88tnt5Azj5PxgwVuH6oRlK9l0RWrKfboYBFd+mC6lJ0PNRg2klrrPT3jkDVg1grusRRS9JbEAJmAhDannBtlcmpfKrQw8vsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myh00R13; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761816893; x=1793352893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rvMHMWSaRTtM3sUcXJIOCKQk5avbx1N2srj3Al582BY=;
  b=myh00R13T+LXZ+AmwHkxAshBvAc7uVLWKwewNkqL/y39/HnC63Lr5J68
   x/5rYkcyDkm8qd6EHMGrxTTGUgx6G0srkGfyYGzgPEoIG4D95dGnub4Vs
   dyqEh5u7nh5Gi8GyrDfSiGZh9erGTKBzVJXqQejyqjxoEhT67arBGEdo+
   hDWYYQAyIZDqrjUPZ97wqUtZBVVuC472q2V8RTZFTd94nLee6J2oJymOL
   mefX6Pto4nOq8VsxvLy+lrMtrxcSuC+BxtMHrcXjCfC80LhO2DJsHmaBU
   iwUh9HKUc++El4MRr3nLfeHvxacOsf77qWO4VptubrK1HZ6CQ1V5qOo02
   g==;
X-CSE-ConnectionGUID: xp3Rgd/GRmCdD7b9HANv5w==
X-CSE-MsgGUID: TYsElDcLRwuV+fZ91GLTrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64049239"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="64049239"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:34:53 -0700
X-CSE-ConnectionGUID: N7DN3YolRP6Vvs71rwrytQ==
X-CSE-MsgGUID: cYrfyeNeRcS+a/IaYIT3hA==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:34:50 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEP3P-00000003rLi-0ers;
	Thu, 30 Oct 2025 11:34:47 +0200
Date: Thu, 30 Oct 2025 11:34:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 02/10] software node: increase the reference of the
 swnode by its fwnode
Message-ID: <aQMxNgC9SWQp-yUy@smile.fi.intel.com>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 01:28:36PM +0100, Bartosz Golaszewski wrote:
> 
> Once we allow software nodes to reference other kinds of firmware nodes,
> the node in args will no longer necessarily be a software node so bump
> its reference count using its fwnode interface.

Same, a short comment (or an update of a kernel-doc if present, I don't
remember).

-- 
With Best Regards,
Andy Shevchenko



