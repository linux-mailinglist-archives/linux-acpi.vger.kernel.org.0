Return-Path: <linux-acpi+bounces-310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A4D7B46DB
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A1B631C20845
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5D615ADF
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 10:30:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A2258C
	for <linux-acpi@vger.kernel.org>; Sun,  1 Oct 2023 09:17:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCFBAC;
	Sun,  1 Oct 2023 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696151852; x=1727687852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oCG7jOCcU3wYWkbsh+OYQxwNNnSBA4Q4h2ZKv3nOzPc=;
  b=aXtbdmGLtkeGyjApW/PIsk2xTx/vX1GH/cOUVyE6Vuy5AhV6TTcdEYgf
   9Dn0BOXqQhTGtQHCUI0fzD2NODr5oxsx4RBWg9dLhWvlvVJPZKuWEQnxz
   wu5IxQ0nRyzt9miK6BAJ/oIRd1uhOHsddlAVFOZJPC/TbqcQhosXzCgZB
   cl+gagjWGZsZbhiBqsztiDnPSrwQWFnMtTS+JURali5FDXdlh3j5x66IB
   qPVg61tlTTpPdkYR04CgNXcLelk5UZc7iu+0flYb4R3lExASdgioGRgbI
   /Hi91i2Wl4hTc4Ku2niq8p6hGjVKY6k4a1PkhBse+UllWWWZa7wFwt/wu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="4084909"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="4084909"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 02:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="924002428"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="924002428"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 02:17:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qmsZp-00000001rVH-16dD;
	Sun, 01 Oct 2023 12:17:25 +0300
Date: Sun, 1 Oct 2023 12:17:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/5] platform/x86: int3472: don't use
 gpiod_toggle_active_low()
Message-ID: <ZRk5JNUZt2JzTszJ@smile.fi.intel.com>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 02:40:03PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is a v2 of Bartosz' "don't use gpiod_toggle_active_low()" series.
> 
> New in v2:
> - Rework to deal with ACPI path vs gpiod_lookup.key differences:
>   acpi_get_handle(path) -> acpi_fetch_acpi_dev(handle) -> acpi_dev_name(adev)

Code-wise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But please fix tags here and there...

-- 
With Best Regards,
Andy Shevchenko



