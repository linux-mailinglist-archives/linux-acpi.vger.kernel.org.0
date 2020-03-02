Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3324E175CD9
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCBOXP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 09:23:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:24977 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgCBOXP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Mar 2020 09:23:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 06:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="351551237"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2020 06:23:12 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 02 Mar 2020 16:23:11 +0200
Date:   Mon, 2 Mar 2020 16:23:11 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/4] gpiolib: acpi: Correct comment for HP x2 10
 honor_wakeup quirk
Message-ID: <20200302142311.GD2667@lahna.fi.intel.com>
References: <20200302111225.6641-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302111225.6641-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 02, 2020 at 12:12:22PM +0100, Hans de Goede wrote:
> Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
> quirk mechanism") added a quirk for some models of the HP x2 10 series.
> 
> There are 2 issues with the comment describing the quirk:
> 1) The comment claims the DMI quirk applies to all Cherry Trail based HP x2
>    10 models. In the mean time I have learned that there are at least 3
>    models of the HP x2 10 models:
> 
>    Bay Trail SoC + AXP288 PMIC
>    Cherry Trail SoC + AXP288 PMIC
>    Cherry Trail SoC + TI PMIC
> 
>    And this quirk's DMI matches only match the Cherry Trail SoC + TI PMIC
>    SoC, which is good because we want a slightly different quirk for the
>    others. This commit updates the comment to make it clear that the quirk
>    is only for the Cherry Trail SoC + TI PMIC models.
> 
> 2) The comment says that it is ok to disable wakeup on all ACPI GPIO event
>    handlers, because there is only the one for the embedded-controller
>    events. This is not true, there also is a handler for the special
>    INT0002 device which is related to USB wakeups. We need to also disable
>    wakeups on that one because the device turns of the USB-keyboard built
>    into the dock when closing the lid. The XHCI controller takes a while
>    to notice this, so it only notices it when already suspended, causing
>    a spurious wakeup because of this. So disabling wakeup on all handlers
>    is the right thing to do, but not because there only is the one handler
>    for the EC events. This commit updates the comment to correctly reflect
>    this.
> 
> Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism")

Not sure if Fixes tag is needed if you only correct comment but fine :)

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
