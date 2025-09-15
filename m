Return-Path: <linux-acpi+bounces-16887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B940B56F87
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 06:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AC37A0616
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 04:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D02E1D63F7;
	Mon, 15 Sep 2025 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUEu5ico"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F52DC77E;
	Mon, 15 Sep 2025 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757911629; cv=none; b=AVKBtKzZg/OMsa6rC2dCGJjE1eptpC8g94KStBnPv2KPhxvh3LpOnPbBjeJeAFoPxLWrSY4ToMPO/hQvpkZSGLlxVn3OY1+BC72SECOTcRUcAlpulUBXhdnwqbg+dZ9crnNTWZ898DQXSs+EdGltHwbLpVA9yJpdXU4QfZa34Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757911629; c=relaxed/simple;
	bh=O+NCMkR0n/qMQIfxHkPyef5o544Jxh6f/x5koCgrmB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pac20g93I2jRYZUxSd2Brd5fFX8vkKXWVrzI4wABi9rqURwKVCG9axipr8d5LwQQUGHMMDe56xCjNSjt7m257R+uy3yDkpeD62ke3/kuQl9+x4twakY0ORuk9ubMGWqoFIFdAbmb33uCBxFxoPHYlrDb7FXM9W/dQBB1FAw3zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUEu5ico; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757911628; x=1789447628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=O+NCMkR0n/qMQIfxHkPyef5o544Jxh6f/x5koCgrmB0=;
  b=jUEu5icoKvraiooZDst6lpvypHso/lqrHFWcAuePxzoP9dBw6h6HjNrv
   nFaPfpxNOFScwNNBVisfYslq+/zn7ZZKJ2/4N30G2aOHu8p+suTYLM7xf
   JFxfHp+OyKJchYn0yur1zDrnYdiyDYqv/L48j08jzsdWKcl/3BShyuwR8
   F9IedP4VnFEMmnu56Vk6RXixmpm22KZwDMXRyeuEWS5XA7nJq2NFOoOe0
   lXpQ4ntyPgVWOeTc4SsD9bQRQ0pT9uqHLWv+XvZfpGeOxQ5uUqt68apof
   sRsiQTtp9ReixWmvsBi0S+w5yktzIMl124Ahwm+TsZe5BM3HbDRpzpszV
   g==;
X-CSE-ConnectionGUID: KVPAG60ERsCRuWh65jLASg==
X-CSE-MsgGUID: SJnQxZymR1KkNHzyT8CWjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="70409063"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="70409063"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 21:47:07 -0700
X-CSE-ConnectionGUID: 3I86ZipSQoKMBUIiohpTaw==
X-CSE-MsgGUID: J8Ryg6TxRNCdR+q/U4lDnw==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 14 Sep 2025 21:47:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 866E794; Mon, 15 Sep 2025 06:47:03 +0200 (CEST)
Date: Mon, 15 Sep 2025 06:47:03 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: =?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: initialize acpi_gpio_info struct
Message-ID: <20250915044703.GA476609@black.igk.intel.com>
References: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>

On Fri, Sep 12, 2025 at 10:18:50PM +0200, Sébastien Szymanski wrote:
> Since commit 7c010d463372 ("gpiolib: acpi: Make sure we fill struct
> acpi_gpio_info"), uninitialized acpi_gpio_info struct are passed to
> __acpi_find_gpio() and later in the call stack info->quirks is used in
> acpi_populate_gpio_lookup. This breaks the i2c_hid_cpi driver:
> 
> [   58.122916] i2c_hid_acpi i2c-UNIW0001:00: HID over i2c has not been provided an Int IRQ
> [   58.123097] i2c_hid_acpi i2c-UNIW0001:00: probe with driver i2c_hid_acpi failed with error -22
> 
> Fix this by initializing the acpi_gpio_info pass to __acpi_find_gpio()
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220388
> Fixes: 7c010d463372 ("gpiolib: acpi: Make sure we fill struct acpi_gpio_info")
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Should have stable tag too, I think. Andy can add that once he applies.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

