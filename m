Return-Path: <linux-acpi+bounces-16891-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F2FB57098
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150BA188FD7D
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 06:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C49A2773FD;
	Mon, 15 Sep 2025 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxyqoPhu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68317BA6;
	Mon, 15 Sep 2025 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918778; cv=none; b=E3jbMktFuWnF3/tuU0gmxfs1tGT3yZGf0etFxEg0YM16DBEGHi55dpTKtsue/PQCue21j28wZl6Ok15HquDv3SnA7VxthoRKsv5sO8CplYyt60+kdXDSPlZQh+mqX2WNDIj5iQJZ/VUx7OK12mhAmPZ02pyBEpfBStwfnXwgbww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918778; c=relaxed/simple;
	bh=NFNnCpOh/37SGnRaFO3Li3CU7DAJxxunjZO5vf9p/uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx0QPd7M4CVnzJfFl3CEIxr+GZw6kbbpOca+ymOT0NYNxuOKAb2TmFYGDWcbJCQWPy54I9vVfhZf6QmVsWqRFn0Choa7oQ0dZtzobojFPVzeX3sj8gi6EZzCtQYNAgY6ZoG5032he62Ldr1LUWC1ko5Rb9IgdT0WRWqigXJfuro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxyqoPhu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757918777; x=1789454777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NFNnCpOh/37SGnRaFO3Li3CU7DAJxxunjZO5vf9p/uM=;
  b=RxyqoPhuqprI0reSlDTSrcm4EtsyM6SqOHuAEYpBuZLqHUcgDD6NFX9p
   AjjnkwEsVdZNr+ASzAG+4CteyK5UYkcE59nO2mFMSA381Dte13gnX/Spn
   rclT693jvRSPkp0Jk6LPWSRokjx8f77gbAI/SMkzHspS97yUsr3ilq181
   Y84BGqAw1ms7Wh5uvMcCnXivVsLjERJEioDi6wl+AoZVbs6U6JRLiVvKE
   mci+y5WstK28omHqjzkX0JgAxO9U0cj4qy2KAQCq3RHovPxrU/HkP5+E7
   9W+cXjrSndtUv/m70YFtQgrGboEK9cCA09+9Z96SNefFCXtVaYv5u1vmK
   Q==;
X-CSE-ConnectionGUID: rThCDsxOQQag2VsfGkICEw==
X-CSE-MsgGUID: G29DDB3/SVufSow3gf2YKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60109421"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60109421"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:46:13 -0700
X-CSE-ConnectionGUID: tb/kfT84RACG0apKR5x0Qg==
X-CSE-MsgGUID: e0pZI3OCSk6hsCh5bhX1og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="211687003"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 14 Sep 2025 23:46:11 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1838594; Mon, 15 Sep 2025 08:46:10 +0200 (CEST)
Date: Mon, 15 Sep 2025 08:46:10 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: initialize acpi_gpio_info struct
Message-ID: <20250915064610.GB476609@black.igk.intel.com>
References: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>
 <20250915044703.GA476609@black.igk.intel.com>
 <aMeyluS3KuzkTJy2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMeyluS3KuzkTJy2@smile.fi.intel.com>

On Mon, Sep 15, 2025 at 09:30:46AM +0300, Andy Shevchenko wrote:
> On Mon, Sep 15, 2025 at 06:47:03AM +0200, Mika Westerberg wrote:
> > On Fri, Sep 12, 2025 at 10:18:50PM +0200, Sébastien Szymanski wrote:
> > > Since commit 7c010d463372 ("gpiolib: acpi: Make sure we fill struct
> > > acpi_gpio_info"), uninitialized acpi_gpio_info struct are passed to
> > > __acpi_find_gpio() and later in the call stack info->quirks is used in
> > > acpi_populate_gpio_lookup. This breaks the i2c_hid_cpi driver:
> > > 
> > > [   58.122916] i2c_hid_acpi i2c-UNIW0001:00: HID over i2c has not been provided an Int IRQ
> > > [   58.123097] i2c_hid_acpi i2c-UNIW0001:00: probe with driver i2c_hid_acpi failed with error -22
> > > 
> > > Fix this by initializing the acpi_gpio_info pass to __acpi_find_gpio()
> > > 
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220388
> > > Fixes: 7c010d463372 ("gpiolib: acpi: Make sure we fill struct acpi_gpio_info")
> > > Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> > 
> > Should have stable tag too, I think. Andy can add that once he applies.
> 
> I can add, but this won't appear in the respective mailing list. Or did I miss
> a new tag for stable?

It does not need to go to the mailing list. It's enough that it is
mentioned in the commit. E.g

  Cc: stable@vger.kernel.org

And the stable "machinery" will notice it once it hits the mainline.

