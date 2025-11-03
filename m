Return-Path: <linux-acpi+bounces-18441-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0ECC2AE40
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6765B3A7A80
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206632F9DBB;
	Mon,  3 Nov 2025 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0Ok27gP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0542D063F;
	Mon,  3 Nov 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163846; cv=none; b=exSEtwlYLlb7vw3qp/C40L9nXMbqKzAH+H9wjEqSUFGdjTj9p8Ewgb0ogfhrMFsV9ZC06KsJz35+GJ1Z6+LV05obMSAF45evPt1HZlyerl9eyr/AcS2FczOHBnfTbr/yPU0LXccAQgczJKJVWkLG9WtKO6kHMqEq32EU5tgOG4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163846; c=relaxed/simple;
	bh=z/TA5h570uq5vw2oklRA3CJ6CUxs6qCvrPbp4mFTWao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss7dLAu8/YAkgPp0BpionxKHgcpDKyHFMXgYuFmXLqauIOH8gw/ne/GkUUDKTTBCYZ5hfp0iLVqTJ8PZ8T1gurvb0IS5vJQhs6mJ8+nEeLsJ5gO/hdwvmGlpPAJYsfh6IwQp+FxJPWeo+mEG6qrJcky4fgPN8ez9vCotXMtv6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0Ok27gP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762163845; x=1793699845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z/TA5h570uq5vw2oklRA3CJ6CUxs6qCvrPbp4mFTWao=;
  b=J0Ok27gPP8liCTV42wd2zjWUN+y3nvLS8tAfYI573Barb1a68djzY+O3
   dQDEPUM/nt7k/Ybs4ENTDYflxvVP3ZYqyMQu7tOl7VRnOJEOn1UpzTMpS
   WfFoZrh1s9PuxV3efLYjj7ausBPUfx0WzhpFFxQIz5Sli6Mn77tl4mrYG
   Lj+WqzrX7VFRMlL/aS74LpqHpgtfCY8pS+3RUBxC+/z5YggioWvrk+4OW
   wo87uDsWxPJo7LfxrpLSJcBCb7mAqI7OC1EWgdINxLRunc/QzkY9EL0v5
   dNZ/23LHK3WnrWJZDVUAl8SS1lXnxfTlf0mEUu7e/Hmx8GuPKldNP3BBx
   g==;
X-CSE-ConnectionGUID: 55Cy+RWiRa6byVqqM/dNOw==
X-CSE-MsgGUID: NW4CduB3Rm2rcqAuzU915A==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="68095540"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="68095540"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:57:24 -0800
X-CSE-ConnectionGUID: QGUqGttuRmCyRj0lldfMmA==
X-CSE-MsgGUID: Yswh+lbETFiKTHWBdVCzmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="187142817"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:57:21 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vFrJL-0000000573P-2Ht0;
	Mon, 03 Nov 2025 11:57:15 +0200
Date: Mon, 3 Nov 2025 11:57:14 +0200
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
Subject: Re: [PATCH v4 06/10] gpio: swnode: update the property definitions
Message-ID: <aQh8etcksSmStNgz@smile.fi.intel.com>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-6-6461800b6775@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-reset-gpios-swnodes-v4-6-6461800b6775@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:35:26AM +0100, Bartosz Golaszewski wrote:
> 
> Use the recommended macros for creating references to software and
> firmware nodes attached to GPIO providers.

Do we need now this patch at all?
See comments to the patch 3.

-- 
With Best Regards,
Andy Shevchenko



