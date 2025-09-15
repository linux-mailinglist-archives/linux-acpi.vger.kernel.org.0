Return-Path: <linux-acpi+bounces-16890-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C52B5704D
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68CBC4E1194
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 06:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3144C285078;
	Mon, 15 Sep 2025 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0hNUypx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A3325A328;
	Mon, 15 Sep 2025 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917854; cv=none; b=nAm4j3KvWEzJJFMMnnzKSZQsEmquLPqfCr+uVXiOZClG2k3YcDBGLy6ulCuwMFB7LnLIe+sndqVcOiWrIOHrq1DNmQ5GTccem/J1jEzr4GTaSvT51+FzJ3rWv3ss3z1EvCtpraFGtDSDDVlgSgy32YJuVovdyPddOuhtp7VgR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917854; c=relaxed/simple;
	bh=RyHVz7Q9v/zAvfrIw/SnNgHQqda+a783WgwEfzqAFP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyqsLsZv3zbwOmpqlGP4KAITydYga3MFtnuNhIUt9dzhwOcSO3HdWa6yX50ZNNLx6DFVyLNoKnZd+8SCY1bD2Hbdm9ccBNYCy1Dk0q9XERjk8qznMYdg4MduQXdH3U0V9aINF1+4lBGyjNxXDhD5zh7Jffg46RdzTu9nDKlIDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0hNUypx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757917852; x=1789453852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RyHVz7Q9v/zAvfrIw/SnNgHQqda+a783WgwEfzqAFP4=;
  b=Q0hNUypxXeiPk5OdfREK3zIgw2nQU59GCIMb0CiWvXM0BDzaFLuKGV7E
   gSAiu5CoBRo+fSWTNg0EISqZxXX1Z/ScLAS8Ps2j0cpNt4ZvAs3VAak17
   HPy2WQKEchxAmM0LeJsjVX6NdJdRvVO9tDGQsjw4kgWx6CFd5YkHR4Rdq
   ffq34GZi2SZ3OypBEHdcnEaiUOFTa34Fh3Xsyo/WMIGnXslLVtb+j2BTs
   jIzD0riV3jGIMQHFeNwXw2npLP2VdbE51mZyLc1ZB1Ml2fiN47HR7TLQ9
   DSwO+5WGmTg55D/fUUw8DbocEe7IXYB2LXFSjA+AY6u8fLXg9uoFw2oxj
   g==;
X-CSE-ConnectionGUID: OCNPVJ2hRKififkNe4WU+Q==
X-CSE-MsgGUID: GqS+z9b7TeWWokjZRCc5MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="82750328"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="82750328"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:30:52 -0700
X-CSE-ConnectionGUID: 1fvw/BQSQe2QK0jH/+4XvA==
X-CSE-MsgGUID: yn3zaLhaT3KCKjjhxG9mrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="173676993"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:30:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uy2je-000000036ju-3SZb;
	Mon, 15 Sep 2025 09:30:46 +0300
Date: Mon, 15 Sep 2025 09:30:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: initialize acpi_gpio_info struct
Message-ID: <aMeyluS3KuzkTJy2@smile.fi.intel.com>
References: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>
 <20250915044703.GA476609@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915044703.GA476609@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 15, 2025 at 06:47:03AM +0200, Mika Westerberg wrote:
> On Fri, Sep 12, 2025 at 10:18:50PM +0200, Sébastien Szymanski wrote:
> > Since commit 7c010d463372 ("gpiolib: acpi: Make sure we fill struct
> > acpi_gpio_info"), uninitialized acpi_gpio_info struct are passed to
> > __acpi_find_gpio() and later in the call stack info->quirks is used in
> > acpi_populate_gpio_lookup. This breaks the i2c_hid_cpi driver:
> > 
> > [   58.122916] i2c_hid_acpi i2c-UNIW0001:00: HID over i2c has not been provided an Int IRQ
> > [   58.123097] i2c_hid_acpi i2c-UNIW0001:00: probe with driver i2c_hid_acpi failed with error -22
> > 
> > Fix this by initializing the acpi_gpio_info pass to __acpi_find_gpio()
> > 
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220388
> > Fixes: 7c010d463372 ("gpiolib: acpi: Make sure we fill struct acpi_gpio_info")
> > Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> 
> Should have stable tag too, I think. Andy can add that once he applies.

I can add, but this won't appear in the respective mailing list. Or did I miss
a new tag for stable?

> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



