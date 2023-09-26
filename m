Return-Path: <linux-acpi+bounces-147-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7CE7AF0C0
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 53878281BF1
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C9E3418C
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D077479
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 15:28:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669AC10E;
	Tue, 26 Sep 2023 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695742081; x=1727278081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gmy3AqMcLkURDUPVRN0R9ITETg1R0Zr8P8UlSqqQHlU=;
  b=bSVdwde1wj/F2t/EUlYPYiO+myEkrkYqWg/WOFfcxuIy4B3JrjQ5zPWb
   4qlFce6WwJy9xZeoapBWXAI9C32G2MZvNg2RQWW8M8biguuQMXlP2F2OD
   RiPy0+PQ1qr3bVHG+7JiDgO1lbDjMlY4DekDziKt5UAcUUEholZ6raY+h
   9hPD4PIXKEkMwpVwvZppwsn/dItk1h0FxToFBnHPLd2SxUv8Rc3K5N+yr
   gO9C+ScDt8zw2deHSgXn+m5fIY4ZESjwY6RZPgVM7zPY6gmoSGcdxmvh+
   DsnV2xqok4rSH6tyVFTHHkS2/gLYgHfuewcLKsr60gHxN1msKI28wLG8w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361843461"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="361843461"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819062447"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="819062447"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:27:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ql9yd-00000000eLp-0nKD;
	Tue, 26 Sep 2023 18:27:55 +0300
Date: Tue, 26 Sep 2023 18:27:54 +0300
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
Subject: Re: [RFT PATCH 4/4] gpio: acpi: remove acpi_get_and_request_gpiod()
Message-ID: <ZRL4epTUrDmHCk8K@smile.fi.intel.com>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <20230926145943.42814-5-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926145943.42814-5-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 04:59:43PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With no more users, we can remove acpi_get_and_request_gpiod().

The best patch in the series!
Reviewed-by: From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



