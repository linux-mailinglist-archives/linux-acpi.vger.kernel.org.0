Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8979512CEA5
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2019 11:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfL3KKk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Dec 2019 05:10:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:24814 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfL3KKk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Dec 2019 05:10:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2019 02:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,374,1571727600"; 
   d="scan'208";a="224202162"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 30 Dec 2019 02:10:36 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 30 Dec 2019 12:10:36 +0200
Date:   Mon, 30 Dec 2019 12:10:36 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pinctrl: baytrail: Do not clear IRQ flags on direct-irq
 enabled pins
Message-ID: <20191230101036.GE2628@lahna.fi.intel.com>
References: <20191227230447.32458-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227230447.32458-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 28, 2019 at 12:04:47AM +0100, Hans de Goede wrote:
> Suspending Goodix touchscreens requires changing the interrupt pin to
> output before sending them a power-down command. Followed by wiggling
> the interrupt pin to wake the device up, after which it is put back
> in input mode.
> 
> On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
> in combination with listing the pin as a normal GpioIo resource.
> 
> This works fine, until the goodix driver gets rmmod-ed and then insmod-ed
> again. In this case byt_gpio_disable_free() calls
> byt_gpio_clear_triggering() which clears the IRQ flags and after that the
> (direct) IRQ no longer triggers.
> 
> This commit fixes this by adding a check for the BYT_DIRECT_IRQ_EN flag
> to byt_gpio_clear_triggering().
> 
> Note that byt_gpio_clear_triggering() only gets called from
> byt_gpio_disable_free() for direct-irq enabled pins, as these are excluded
> from the irq_valid mask by byt_init_irq_valid_mask().
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
