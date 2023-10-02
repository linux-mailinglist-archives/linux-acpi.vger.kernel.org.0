Return-Path: <linux-acpi+bounces-315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768C7B5060
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E1A212821DA
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13CD519
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63616C8F4
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:39:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF6D83;
	Mon,  2 Oct 2023 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696239551; x=1727775551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/27+h6lJjy43p5hcDbnDy7awTHYeKeY4MUaHc4rnRVo=;
  b=XYeOwJ6OrnbNdf1BxSAqJyfEL12d/+tX2OG+K0QttfPmHX5OwtCS61L2
   jKHKlIpAwbQR3WpPiS3lqug2R1PCLMN+X7vTXtNB4Hs4hIw8IWmfcXwgw
   UOWw05OOPsJYBiZho1w2jMvygm6MTk7wdMkdnwDAHYf/fpFBqBzzn5Qi7
   KVhASdtGAcpnC9VlqgsiJ68jtZElO6B1OuWRJ+2BA/tdSL9faD89ldPOI
   ENorf9qrXMNU+VSMS8+eGHe6aIumlVtjXgkcvY1UCVAP5R3Oe651ULFNo
   BuSVoBIYI566GnEfg6eqBQbElG4iFDQAfLmQTDV4gXjaFet1256O1Quyh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="4185514"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="4185514"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="924215400"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="924215400"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:39:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qnFOL-000000027b1-0s9c;
	Mon, 02 Oct 2023 12:39:05 +0300
Date: Mon, 2 Oct 2023 12:39:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 01/11] gpiolib: make gpio_device_get() and
 gpio_device_put() public
Message-ID: <ZRqPuI820PXVRV7O@smile.fi.intel.com>
References: <20230927142931.19798-1-brgl@bgdev.pl>
 <20230927142931.19798-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927142931.19798-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 04:29:21PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In order to start migrating away from accessing struct gpio_chip by
> users other than their owners, let's first make the reference management
> functions for the opaque struct gpio_device public in the driver.h
> header.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



