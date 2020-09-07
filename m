Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DE225F586
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 10:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgIGImJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 04:42:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:61125 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgIGImJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 04:42:09 -0400
IronPort-SDR: Pf0lB/XQLqaHBxTrC5HPJf4jlKkPQCW4uztrd78Bf/Zmh+cOUZpGxkfaisn45e/w2CENB8lqeB
 92GWxOF7DGJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="155472812"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="155472812"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 01:42:09 -0700
IronPort-SDR: xKOMvHVE5fGnkLBEAdi2IYA8yI+ONaIVJ8f1JFKRLklgL6KtQyb/+ViLf7HBGLvQC1N8OCZmm6
 T5pcB56bnylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406773702"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 07 Sep 2020 01:42:06 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 07 Sep 2020 11:42:06 +0300
Date:   Mon, 7 Sep 2020 11:42:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pinctrl: cherryview: Preserve
 CHV_PADCTRL1_INVRXTX_TXDATA flag on GPIOs
Message-ID: <20200907084206.GY2495@lahna.fi.intel.com>
References: <20200904172141.180363-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904172141.180363-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 07:21:41PM +0200, Hans de Goede wrote:
> One some devices the GPIO should output the inverted value from what
> device-drivers / ACPI code expects. The reason for this is unknown,
> perhaps these systems use an external buffer chip on the GPIO which
> inverts the signal. The BIOS makes this work by setting the
> CHV_PADCTRL1_INVRXTX_TXDATA flag.
> 
> Before this commit we would unconditionally clear all INVRXTX flags,
> including the CHV_PADCTRL1_INVRXTX_TXDATA flag when a GPIO is requested
> by a driver (from chv_gpio_request_enable()).
> 
> This breaks systems using this setup. Specifically it is causing
> problems for systems with a goodix touchscreen, where the BIOS sets the
> INVRXTX_TXDATA flag on the GPIO used for the touchscreen's reset pin.
> 
> The goodix touchscreen driver by defaults configures this pin as input
> (relying on the pull-up to keep it high), but the clearing of the
> INVRXTX_TXDATA flag done by chv_gpio_request_enable() causes it to be
> driven low for a brief time before the GPIO gets set to input mode.
> 
> This causes the touchscreen controller to get reset. On most CHT devs
> with this touchscreen this leads to:
> 
> [   31.596534] Goodix-TS i2c-GDIX1001:00: i2c test failed attempt 1: -121
> 
> The driver retries this though and then everything is fine. But during
> reset the touchscreen uses its interrupt pin as bootstrap to determine
> which i2c address to use and on the Acer One S1003 the spurious reset
> caused by the clearing of the INVRXTX_TXDATA flag causes the controller
> to come back up again on the wrong i2c address, breaking things.
> 
> This commit fixes both the -121 errors, as well as the total breakage
> on the Acer One S1003, by making chv_gpio_clear_triggering() not clear
> the INVRXTX_TXDATA flag if the pin is already configured as a GPIO.
> 
> Note that chv_pinmux_set_mux() does still unconditionally clear the
> flag, so this only affects GPIO usage.
> 
> Fixes: a7d4b171660c ("Input: goodix - add support for getting IRQ + reset GPIOs on Cherry Trail devices")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
