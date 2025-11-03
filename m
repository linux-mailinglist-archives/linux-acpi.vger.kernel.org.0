Return-Path: <linux-acpi+bounces-18439-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E83C2ADB5
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 109714E3679
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282AE2F9D89;
	Mon,  3 Nov 2025 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATsEXhg6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5C2F39BE;
	Mon,  3 Nov 2025 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163505; cv=none; b=caRB+a8iwK8cP3WOlQuWtvftGAXF858bK7JqjaquWuu8czzY6cYzfJv1H3dD/cGMzYkugR/qR2z6Y9A85a4NRLT0i7bBWyhf19kmOrCeYHEKnucCcwZEVLtb545yUOJS//K+7LbP+HK4ArefMF9SABm7Vb8+ZOfnm28cRmjRU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163505; c=relaxed/simple;
	bh=8zi5AcR2Mg/yD2BQovd2zudZAr3Gpc9rMYhGtPOl1Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRjFEkdaAPoVn2DbP33si8YOFKWV/HFVDwFweT1gYiSB7x9TOFJBwk2yKsTSirxuRcal3wKHOu6wCxi2fH/jJTOO2pTKDRiykMAG9snSYt9uYAuzFYCmMtef9pp+qJzdaAHZecBOSPGrOu4Q3Hdqo/0Hy8jOiszfntox42LoRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATsEXhg6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762163503; x=1793699503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8zi5AcR2Mg/yD2BQovd2zudZAr3Gpc9rMYhGtPOl1Ig=;
  b=ATsEXhg6mLJVfeTD8beA/im55G6pTpPGJQTDJBm1XgTAtxfxOcDt9gYi
   lhUmZWlK2Ivm8XecVQ1BMBE/kGK3meYu4+odiaZMyPsxRG96TOAKtu0re
   e/TQoi6df5FQPs3dH+gUJ4Adp4WQOBX14U1YF2764AE1LhqQ4+FqehVdQ
   LGOp3xaSX0n4VsxAK6g5xJBz0qTSJoH93mql0P6bIvyLMYKc5SOaMYEmb
   ficvnCrn6akmU0WkxTccR/1ejZnzpMNCi1e6KkLa9GhOYqnEdTmSuIRxE
   766OC8fHhkrQojnTgYAX80ZPvAuo2xFegQfI0TYZ8U0HMXjblDnBdctbp
   w==;
X-CSE-ConnectionGUID: Tzfd5ACZSsGiTUBDGQqo/g==
X-CSE-MsgGUID: XxMEH2jKTFC8iiRQSX1KeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="63439461"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="63439461"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:51:42 -0800
X-CSE-ConnectionGUID: 6OvxSGv5SL6rU6+10m47JA==
X-CSE-MsgGUID: Ir9fSt4nRY2ek3Ev3L0xDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186698221"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:51:40 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vFrDq-000000056yp-33n5;
	Mon, 03 Nov 2025 11:51:34 +0200
Date: Mon, 3 Nov 2025 11:51:33 +0200
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
Subject: Re: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as
 the key for GPIO lookup
Message-ID: <aQh7JUeQ84WwUzW9@smile.fi.intel.com>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:35:24AM +0100, Bartosz Golaszewski wrote:
> 
> Looking up a GPIO controller by label that is the name of the software
> node is wonky at best - the GPIO controller driver is free to set
> a different label than the name of its firmware node. We're already being
> passed a firmware node handle attached to the GPIO device to
> swnode_get_gpio_device() so use it instead for a more precise lookup.

Sounds to me like a ready-to-go patch and even maybe with a Fixes tags, but
it's up to you. So, why not apply it so we have less churn in the next version
of the series?

-- 
With Best Regards,
Andy Shevchenko



