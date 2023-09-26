Return-Path: <linux-acpi+bounces-148-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A187AF0C1
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 212B1281C43
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0938B34CC1
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D476AA3
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 15:28:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6410A;
	Tue, 26 Sep 2023 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695742129; x=1727278129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Azqz3iO0NkVsfqO6YJVLja8AjJSSDwK3vxTeudwyf+o=;
  b=beO7wNaVv9z565a3R6IR26p6pp2pHUye3LkEZfNewZPn/umST9Wqi7eM
   ne3AhJDOndWXvWOgl/CFtq02cC3fmgY63BzG0Dsy/MrA5VrQVhvmhqImy
   v/mQBrBy3zOoTFmDMyibCQGrna+S9OjPfI67snaPwVf8qgNr+jP1ZCA1j
   w10sRa5t8X5CXrxE78u5q5kR6daPB57kL+fqsRzIhHpM3DdUA/p7XHT5Z
   LNNrNOUXJbgo7e2rOQKIibjaURCrvpYiDwIA8R6cWD+VBXEFiLcDJfhN3
   cTlnFp9VluZaXmCKt8nix+DRhKTiOne4fQuMXdUwkMmWynhVXrVE+UAwS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="371925709"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="371925709"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864439912"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="864439912"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:28:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ql9zB-00000000eMJ-3BsD;
	Tue, 26 Sep 2023 18:28:29 +0300
Date: Tue, 26 Sep 2023 18:28:29 +0300
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
Subject: Re: [RFT PATCH 0/4] platform/x86: int3472: don't use
 gpiod_toggle_active_low()
Message-ID: <ZRL4nQPTo1e5tf6Z@smile.fi.intel.com>
References: <20230926145943.42814-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926145943.42814-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 04:59:39PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpiod_toggle_active_low() is a badly designed API that should have never
> been used elsewhere then in the MMC code. And even there we should find
> a better solution.
> 
> Replace the uses of it in the int3472 driver with the good old temporary
> lookup table trick. This is not very pretty either but it's the lesser
> evil.

Good jon!
I have only style issues, otherwise
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



