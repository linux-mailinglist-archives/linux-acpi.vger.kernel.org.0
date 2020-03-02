Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E82D175CF0
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 15:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCBOZb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 09:25:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:2360 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgCBOZb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Mar 2020 09:25:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 06:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="351551677"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2020 06:25:27 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 02 Mar 2020 16:25:26 +0200
Date:   Mon, 2 Mar 2020 16:25:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/4] gpiolib: acpi: Add quirk to ignore EC wakeups on
 HP x2 10 BYT + AXP288 model
Message-ID: <20200302142526.GF2667@lahna.fi.intel.com>
References: <20200302111225.6641-1-hdegoede@redhat.com>
 <20200302111225.6641-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302111225.6641-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 02, 2020 at 12:12:24PM +0100, Hans de Goede wrote:
> Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
> quirk mechanism") was added to deal with spurious wakeups on one specific
> model of the HP x2 10 series. In the mean time I have learned that there
> are at least 3 different HP x2 10 models:
> 
> Bay Trail SoC + AXP288 PMIC
> Cherry Trail SoC + AXP288 PMIC
> Cherry Trail SoC + TI PMIC
> 
> And the original quirk is only correct for (and only matches the)
> Cherry Trail SoC + TI PMIC model.
> 
> The Bay Trail SoC + AXP288 PMIC model has different DMI strings, has
> the external EC interrupt on a different GPIO pin and only needs to ignore
> wakeups on the EC interrupt, the INT0002 device works fine on this model.
> 
> This commit adds an extra DMI based quirk for the HP x2 10 BYT + AXP288
> model, ignoring wakeups for ACPI GPIO events on the EC interrupt pin
> on this model. This fixes spurious wakeups from suspend on this model.
> 
> Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
