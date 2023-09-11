Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90B379A2CD
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Sep 2023 07:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjIKFYv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 01:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjIKFYv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 01:24:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC021AD;
        Sun, 10 Sep 2023 22:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694409887; x=1725945887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ao1sqJ7hfTfLlekSmtXPP+I4bRpJTUclR32DDyjBDZo=;
  b=j7DP+dpuO+8s85hbjim+/bcAcb5E+BnbHwxDzxuQ6ohQi2M/dj7zuPeL
   LjBNYNGzNeMrgAKbMV4sGsM4NGpYr4Vaulkw/JMbhsOQRvT4ld4nbl+z8
   dxhj4f22H4JqX80f4FVy1ivdpp7h1tLC1+8rPwrFlf4PHF+hkWyXXAhv3
   COmQ6G65NptZSlTP+WJ/eKmCbHRDT/jYm9tbGRze+qakhmNjauGPG5p7t
   8t61nC50amzYeqwmYVxlKo7qwjfjedNEKwVRVq7lN4dQM0KadCqGwqArJ
   SOxwuBQkaJgwsj6XX0en1wthSPUtTgUisNspU+FvjKBtJUvCewAliXePA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="464374851"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="464374851"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 22:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778258600"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778258600"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Sep 2023 22:24:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 903F8497; Mon, 11 Sep 2023 08:24:43 +0300 (EEST)
Date:   Mon, 11 Sep 2023 08:24:43 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/8] gpiolib: acpi: Add a ignore interrupt quirk for Peaq
 C1010
Message-ID: <20230911052443.GW1599918@black.fi.intel.com>
References: <20230909141816.58358-1-hdegoede@redhat.com>
 <20230909141816.58358-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230909141816.58358-3-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 09, 2023 at 04:18:10PM +0200, Hans de Goede wrote:
> On the Peaq C1010 2-in-1 INT33FC:00 pin 3 is connected to
> a "dolby" button. At the ACPI level an _AEI event-handler
> is connected which sets an ACPI variable to 1 on both
> edges. This variable can be polled + cleared to 0 using WMI.
> 
> Since the variable is set on both edges the WMI interface is pretty
> useless even when polling. So instead of writing a custom WMI
> driver for this the x86-android-tablets code instantiates
> a gpio-keys platform device for the "dolby" button.
> 
> Add an ignore_interrupt quirk for INT33FC:00 pin 3 on the Peaq C1010,
> so that it is not seen as busy when the gpio-keys driver requests it.
> 
> Note this replaces a hack in x86-android-tablets where it would
> call acpi_gpiochip_free_interrupts() on the INT33FC:00 GPIO
> controller. acpi_gpiochip_free_interrupts() is considered private
> (internal) gpiolib API so x86-android-tablets should stop using it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
