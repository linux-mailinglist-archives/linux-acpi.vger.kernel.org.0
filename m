Return-Path: <linux-acpi+bounces-16892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF54B570BD
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB3D17C050
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 06:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A942C0292;
	Mon, 15 Sep 2025 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izAiKuDQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A528DB76;
	Mon, 15 Sep 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919329; cv=none; b=MxmtoZrIzHDF4tQQBXHYLZKDuexYXawspKIhjNeErtYlMKFtys3/RT9W0ETc7bB2x09zc/EhY7ekVV9OJ2yU4JQyCwCtg4MhnATR4IyKFY/3Oe7qrEnfSIMGwGysc6ZXOG5/tRVSVGE6qnRJDypdfvVUJhzZA5N/eCc/b4oiL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919329; c=relaxed/simple;
	bh=mj4wufavMuY2fxpyOIXvXwqdI3054kcIDTKut3wmk6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdDf3Ox+3HkzazY5JcJuEjLK2WJiCx36bJH1cSvLYZLye/87k1XJu7h9r9ZQZ54cVKskieh38XfTtC7QEG7zzSHta5ARsym51/aNwYZgcmdWkJ99t54IohkXQ/ir44qq5w0tRHTYSn0/R21iVRp+2FckIsfqy8L/BgaLUeq8GjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izAiKuDQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757919327; x=1789455327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mj4wufavMuY2fxpyOIXvXwqdI3054kcIDTKut3wmk6A=;
  b=izAiKuDQv7RRok/e7rKUyym0MLKP3m8NijxpGnOhP9y56B+7SySbZc2k
   JKMOUCxMuFSBE9nNPAVM48Ybjeayhn27Xjgvx/B2Kw0UtxIZA5k4DQCPj
   cLQEEHUi1di+0ULAgBeqtm8PbLhWTm9IJ9LDgcVlqpQm43hv51fUETKdD
   vwIEwxCMM/130sounLzQDyDlACk5HGVrVLZXuz883BIxB+qAmjdHJlgMB
   8KjKvdxesYYS0NDaFXjzCXOEmzj2aX9p8+Yv5DUdyYuzXZqTUeGNFfdfU
   uv4w07/yKHIFCj+HQVr9tsUnIG7JmOEFFTaPPqV0+hUgq9zCKVaI3JFA9
   g==;
X-CSE-ConnectionGUID: 2w/aMf1mQvG8asWtwfR9yA==
X-CSE-MsgGUID: exVYhDC9Q/SrtEHOOcMnxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="60100423"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="60100423"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:55:26 -0700
X-CSE-ConnectionGUID: n8uUyZHYSuqPl/T4d8ZSww==
X-CSE-MsgGUID: 89ZYP1tvQd+s1z8eE8K90A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="173828406"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:55:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uy37R-00000003BBF-3c1t;
	Mon, 15 Sep 2025 09:55:21 +0300
Date: Mon, 15 Sep 2025 09:55:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: initialize acpi_gpio_info struct
Message-ID: <aMe4WblWqHAl4fzU@smile.fi.intel.com>
References: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>
 <20250915044703.GA476609@black.igk.intel.com>
 <aMeyluS3KuzkTJy2@smile.fi.intel.com>
 <20250915064610.GB476609@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915064610.GB476609@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 15, 2025 at 08:46:10AM +0200, Mika Westerberg wrote:
> On Mon, Sep 15, 2025 at 09:30:46AM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 15, 2025 at 06:47:03AM +0200, Mika Westerberg wrote:
> > > On Fri, Sep 12, 2025 at 10:18:50PM +0200, Sébastien Szymanski wrote:
> > > > Since commit 7c010d463372 ("gpiolib: acpi: Make sure we fill struct
> > > > acpi_gpio_info"), uninitialized acpi_gpio_info struct are passed to
> > > > __acpi_find_gpio() and later in the call stack info->quirks is used in
> > > > acpi_populate_gpio_lookup. This breaks the i2c_hid_cpi driver:
> > > > 
> > > > [   58.122916] i2c_hid_acpi i2c-UNIW0001:00: HID over i2c has not been provided an Int IRQ
> > > > [   58.123097] i2c_hid_acpi i2c-UNIW0001:00: probe with driver i2c_hid_acpi failed with error -22
> > > > 
> > > > Fix this by initializing the acpi_gpio_info pass to __acpi_find_gpio()
> > > > 
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220388
> > > > Fixes: 7c010d463372 ("gpiolib: acpi: Make sure we fill struct acpi_gpio_info")
> > > > Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> > > 
> > > Should have stable tag too, I think. Andy can add that once he applies.
> > 
> > I can add, but this won't appear in the respective mailing list. Or did I miss
> > a new tag for stable?
> 
> It does not need to go to the mailing list. It's enough that it is
> mentioned in the commit. E.g
> 
>   Cc: stable@vger.kernel.org
> 
> And the stable "machinery" will notice it once it hits the mainline.

Fine, I'll add this, thanks!

-- 
With Best Regards,
Andy Shevchenko



