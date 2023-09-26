Return-Path: <linux-acpi+bounces-145-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C17AF0BE
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 79EF5281BDB
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D734188
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826297479
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 15:27:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00B1194;
	Tue, 26 Sep 2023 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695742022; x=1727278022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EL5E/4NncYmKUL+520Iyp+Uj3MNs/WEgnKcUVFXSP5s=;
  b=fGEwg8BGqjN7UrxgqyxaQFxsamo511wt+AhVvRylDGS11ZqJxmH7P7Wo
   a3G1ne2uEBTSHtgD8EBexk7Zaqg2lHbgI5gnSvzMM0HFJgATH9CJOqX/6
   Je2c5f0618+cYnq7rEvHWxVLzicEKoWeXlN6zvZkY3mbx+c16oxdHKC5m
   1/4J6BY9gtsKilgD0cYyRCngPTChi1JRH5wrrzIkqR67LMhHEBKp98t5Q
   gRaFAjjxNl+6/WQugEjtQWHVnOfNK0t+jytwuJdN3m0tGrz58RTThY526
   La20Q3QR1RMGsbddqJ0riXPmWbRtfXdNtcCpJqS4kESbinUNsFOKdKokt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378871151"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378871151"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="839060442"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="839060442"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:26:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ql9xe-00000000eKO-0NGt;
	Tue, 26 Sep 2023 18:26:54 +0300
Date: Tue, 26 Sep 2023 18:26:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH 2/4] platform/x86: int3472: led: don't use
 gpiod_toggle_active_low()
Message-ID: <ZRL4PYeX21bwCPR0@smile.fi.intel.com>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <20230926145943.42814-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926145943.42814-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 04:59:41PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Instead of acpi_get_and_request_gpiod() + gpiod_toggle_active_low(), use
> temporary lookup tables with appropriate lookup flags.

...

> +	int3472->pled.gpio = skl_int3472_gpiod_get_from_temp_lookup(
> +				int3472->dev, path, agpio->pin_table[0],
> +				"int3472,privacy-led", polarity,
> +				GPIOD_OUT_LOW);

Personally I found this style weird. I prefer to have longer line over
the split on the parentheses.

-- 
With Best Regards,
Andy Shevchenko



