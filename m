Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB810EA85
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2019 14:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLBNJL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Dec 2019 08:09:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:47799 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfLBNJL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Dec 2019 08:09:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 05:09:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="218363457"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2019 05:09:07 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iblRq-0002ET-Sb; Mon, 02 Dec 2019 15:09:06 +0200
Date:   Mon, 2 Dec 2019 15:09:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] pinctrl: baytrail: Add GPIO lookup and pinctrl-map
 for i915 DSI panel ctrl
Message-ID: <20191202130906.GH32742@smile.fi.intel.com>
References: <20191129185836.2789-1-hdegoede@redhat.com>
 <20191129185836.2789-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129185836.2789-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 29, 2019 at 07:58:35PM +0100, Hans de Goede wrote:
> On Bay Trail devices the MIPI power on/off sequences for DSI LCD panels
> do not control the LCD panel and backlight GPIOs. So far we have been
> relying on these GPIOs being configured as output and driven high by
> the Video BIOS (GOP) when it initializes the panel.
> 
> This does not work when the device is booted with a HDMI monitor connected
> as then the GOP will initialize the HDMI instead of the panel, leaving the
> panel black, even though the i915 driver tries to output an image to it.
> 
> Likewise on some device-models when the GOP does not initialize the DSI
> panel it also leaves the mux of the PWM0 pin in generic GPIO mode instead
> of muxing it to the PWM controller.
> 
> This commit adds GPIO lookups and a pinctrl-map which the i915 driver can
> use to get the panel- and backlight-enable GPIOs and to mux the PWM0 pin
> to the PWM controller.
> 
> Note it may seem a bit weird to add a pinctrl-map for the i915 driver,
> so that it can set the PWM0 pinmux. Doing this from the LPSS PWM driver
> would be more logical. But the only thing telling us that the pin should
> definitely be muxed to the PWM controller is the VBT to which the PWM
> driver does not have access.

My concern here, as one of Linus', is a pollution the driver with board code.
Aren't we able to split this to a separate file under PDx86 realm and do nasty
quirks there?

-- 
With Best Regards,
Andy Shevchenko


