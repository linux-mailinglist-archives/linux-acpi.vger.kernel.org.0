Return-Path: <linux-acpi+bounces-319-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB117B5064
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 21CA9282613
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A2B10A06
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90E8F78
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:46:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20183;
	Mon,  2 Oct 2023 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696240004; x=1727776004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+rojfav0AEhdlKxJ7yP2mhSeCWfVBVJaA5FY6zYujt8=;
  b=Ys05JtOXh1C35jRr4IwrZUmxSgRxWE2zjuMOGfNYwFfRWaXsN0Zfkkik
   lVfWA6r5qHs2c8L14IEtslhdjuuHzOJZ/620q4k4ZI57PHdLlbl1IQegE
   a/f3Z2lWu7Sc7HnvqeOsiJS5Yha09HRpFzPSC5Lo6poUIytfRPTIEBwrM
   azQMACN1ZCTPF8dS5Zg1fvSn9SCs4WdqGC5rkOLFS4Y9h4YM+a5YYDuAv
   oIeM3XIrQzDj1KolH4IVrKi/LRzs8LVJjcb31tKi0lwqaNUHbWtYf8MK6
   rx+VjhSznhWsXzMSJGZFdvwS9grXgX6rUMjdFVrm0wu7Rz7eoMo6KsNx+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="372960262"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372960262"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="754005124"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754005124"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:46:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qnFVf-000000027gX-048L;
	Mon, 02 Oct 2023 12:46:39 +0300
Date: Mon, 2 Oct 2023 12:46:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 05/11] gpiolib: provide gpio_device_get_desc()
Message-ID: <ZRqRfss5oI+xcS3o@smile.fi.intel.com>
References: <20230927142931.19798-1-brgl@bgdev.pl>
 <20230927142931.19798-6-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927142931.19798-6-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 04:29:25PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Getting the GPIO descriptor directly from the gpio_chip struct is
> dangerous as we don't take the reference to the underlying GPIO device.
> In order to start working towards removing gpiochip_get_desc(), let's
> provide a safer variant that works with an existing reference to struct
> gpio_device.

...

> +EXPORT_SYMBOL_GPL(gpiochip_get_desc);

> +struct gpio_desc *
> +gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum)

I'm wondering if you move this to be upper than gpiochip_get_desc() and
diff will look better...

-- 
With Best Regards,
Andy Shevchenko



