Return-Path: <linux-acpi+bounces-16947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5726EB5811C
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49051885D10
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 15:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707E214801;
	Mon, 15 Sep 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKz2iEw5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91E2DC786;
	Mon, 15 Sep 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950826; cv=none; b=rgEFP8FNL69PvKRtTNm+aIjo2KWQCTXOJhxyo7NvfTxJmj0YjTDfVsk4phOB/HhDa1OD8BJBCb8fpP/5SdZPPwsRweAlcVysVeSgz0scu6DBt2soxbB4Lvyd67qF5fphqkb+MuHPNLeBhSPMed/TchF/GNGezNKRvU5OiYvJ6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950826; c=relaxed/simple;
	bh=Pk6D9lV4pLzfRVkOAYasCLtsJzsCxwcDyjYDQJ1hP1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef3gYNfrj/zynHzWsYqVFFVUQN/pfFsctfQn06FDG9qNScTiSoYmh17/KN5MrJODFEtczub3y3EbK7pt7YYNmQ3Kx9tv1aUy8ZkvQsoVws0CATWnrPSOrCMoa5PBUAn20V3RC18SFZoAMsi1Cz4xuOF3SWYzj3G9bitVQC6h2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKz2iEw5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757950824; x=1789486824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Pk6D9lV4pLzfRVkOAYasCLtsJzsCxwcDyjYDQJ1hP1w=;
  b=aKz2iEw53TJyz8idJKh4LkNnaWSa3q7WOq1ByJrvfISbk+O/sNISdK5w
   EiVppuWhm60iXxUohWrvH4rCZczt48qSRxsBmYcamIdBOlWF+V5YKtJHD
   vRNZxHC490xY5n7hpXMsBfW8TjQQ/A8NGnQj/VqVxDWxC/K9yjHjogbU9
   o0Uxw+aylqXY9NCnJkPgwIG1iU3+zLIaO1FdvB4XUFJOGV76sbVubiBUC
   38w5lpD7no0ttj7hUBG0poIT+yxe1Rg7nF3xkDv8iGcBQen8eTK/pS/DT
   0VfnzyNO7J1aJwBtUpaf+HhLZ6x6z9SLqwC7P35QU/6zPcS69n/VG/F6A
   w==;
X-CSE-ConnectionGUID: 6ckpduVYToanCIWcvqiV4w==
X-CSE-MsgGUID: CcfAJRSpS9OeNer3RfrgLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59438706"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="59438706"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 08:40:23 -0700
X-CSE-ConnectionGUID: ykgN3T4NQzyzbAJC8MHMAA==
X-CSE-MsgGUID: OnnQbopQRVebJyE1w/1B8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174750315"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 08:40:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyBJR-00000003I5V-3wP9;
	Mon, 15 Sep 2025 18:40:17 +0300
Date: Mon, 15 Sep 2025 18:40:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: initialize acpi_gpio_info struct
Message-ID: <aMgzYa-I5SQHaAY2@smile.fi.intel.com>
References: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

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

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



