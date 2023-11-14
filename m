Return-Path: <linux-acpi+bounces-1479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED927EB4EF
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8835E1F25536
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1B41748
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDpvcv93"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C441753;
	Tue, 14 Nov 2023 15:30:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16729113;
	Tue, 14 Nov 2023 07:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699975805; x=1731511805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=azvOt7r8oQJ/mqDc4i5GXzwItNkMaFRI5tRlj+i45y0=;
  b=WDpvcv93Chx4rnlhJ1pJaQY1OOlkQf3yYY8ne93jbAZKDYbtiM/9PJZI
   idP0yRAfsYt+fvgG89gaT5v9w0XzxSbR/mAwZrtwyVdfhQ4tb+39NWSgL
   drHrjpQXoCpwmAueght/B5qhEteK+Yy8/vcWuGQyLjiXTkPSvQ5YqZkga
   EMF1xLXksiQxx52q/b8gGzcE2KPbzQy02xrfykQIt+M+ZDvIy+0xFs3vA
   jjwgG/ci3xo4PeVt6zOInB2BIxLHMD2Kd1+BhZI3Y1KVrAhFXDUS/BXPn
   991DTyjfJ5Ahboa3KyNjysRDiZW+IBiNmRXxSUKtbZHezsuFoBBZFvV8v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370021866"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="370021866"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 07:30:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="938121726"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="938121726"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 07:30:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r2vMV-0000000DrHJ-2z74;
	Tue, 14 Nov 2023 17:29:59 +0200
Date: Tue, 14 Nov 2023 17:29:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Hans de Goede <hdegoede@redhat.com>,
	Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 2/3] gpiolib: Fix debug messaging in
 gpiod_find_and_request()
Message-ID: <ZVOSd62yCz4lFIP1@smile.fi.intel.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
 <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
 <ZTGBqEUzgGCcZP1B@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTGBqEUzgGCcZP1B@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 19, 2023 at 12:21:12PM -0700, Dmitry Torokhov wrote:
> On Thu, Oct 19, 2023 at 08:34:56PM +0300, Andy Shevchenko wrote:
> > When consolidating GPIO lookups in ACPI code, the debug messaging
> > had been broken and hence lost a bit of sense. Restore debug
> > messaging in gpiod_find_and_request() when configuring the GPIO
> > line via gpiod_configure_flags().
> 
> Could you give an example of the before/after messages to show exavtly
> what is being improved?

Before your patch:

[    5.266823] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
[   14.182994] gpio-40 (?): no flags found for gpios

After your patch:

[    5.085048] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
[   13.401402] gpio-40 (?): no flags found for (null)

After this patch:

[    3.871185] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
[   12.491998] gpio-40 (?): no flags found for gpios

...

Looking at this it's definitely a fix.

-- 
With Best Regards,
Andy Shevchenko



