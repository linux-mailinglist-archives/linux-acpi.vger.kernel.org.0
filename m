Return-Path: <linux-acpi+bounces-17946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A9FBED5B3
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 19:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DC7A34D670
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA197262FCD;
	Sat, 18 Oct 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpC7/fHM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2325A326;
	Sat, 18 Oct 2025 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808911; cv=none; b=ByCH7zF4s/4eMj17dbFDP2CjpKdJ7Sfx6gLzU+V/eITjGW8riFnYtKE79JG51G9Vp5+C5/q7PQPGONXMoM3Wj77UetQWn6B+3mUrjxvvPG6iSoxAE5YBARrjZGfzM44zN+FMnuS+T5qySSi9rRt+lq2xFDm6Kqbrd8UY9G9ClYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808911; c=relaxed/simple;
	bh=EuIHqk+EuuT5H1FI7GlkxqnL4fl6kFXuPsScQWcJbnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTODMOBMoCsbSUd+V68ivDTVQADIj47saQaF8R58DR8IKyE/+ACXStGn2pJQ0HIS7MtG6l0OFcCUn2rftBmJw1SUOYTlcUYHKPKpQyW9I+xXOMew18kyIBHNsQR8yjQn8hqRv/vEcM5ij5196F5AKtZJf1g1qoA4hUOv8SkDzT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpC7/fHM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808910; x=1792344910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EuIHqk+EuuT5H1FI7GlkxqnL4fl6kFXuPsScQWcJbnQ=;
  b=lpC7/fHMiqZ6sd7NKXJ4DithvpNUXb1m8aYGgd7qRaq9HTA55X630FNI
   U7S0rCdYtHIK1DsQNVDhcEmBPqEPn/B/YEn36l0p5e+yS/jqlS4kXJqip
   yKdsfAErkuWFaWWcgMQhw+3EF9kXiIXoTCl3wjPsczlIBb4cqqZgZIuf8
   d6CdO72MD2k+Mlov4T4N0JV8fQJRe509PGut78a7rGvvZuwgQAXQLb24G
   POWSLezZy6uacNHDQVss2Bevje+2AMGi+hXxY4Mo2OgS8mnffVYSYL+ju
   hp3O7BvgmAFY+GW0IWWdP5zkKWE6HuqNqu+yG9JRVwvoB6ZC3ZN1LuzaY
   w==;
X-CSE-ConnectionGUID: uFDXfObxRIKyEeWAMwVa0A==
X-CSE-MsgGUID: chwcyplqQ5KkJ4OGGiHvuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63039370"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="63039370"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:09 -0700
X-CSE-ConnectionGUID: CLjlCa/HRNG8eulfELhDFg==
X-CSE-MsgGUID: QhNhpGK/SAulV1anUVJC3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="188287992"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:06 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v8Ona-000000002a7-3omB;
	Mon, 13 Oct 2025 23:05:38 +0300
Date: Mon, 13 Oct 2025 23:05:38 +0300
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
Subject: Re: [PATCH 1/9] software node: read the reference args via the
 fwnode API
Message-ID: <aO1bkraNrvHeTQxE@smile.fi.intel.com>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-1-6d3325b9af42@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006-reset-gpios-swnodes-v1-1-6d3325b9af42@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 06, 2025 at 03:00:16PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Once we allow software nodes to reference all kinds of firmware nodes,
> the refnode here will no longer necessarily be a software node so read
> its proprties going through its fwnode implementation.

This needs a comment in the code.

-- 
With Best Regards,
Andy Shevchenko



