Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3E610DA6E
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 21:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfK2UHn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 15:07:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:9917 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfK2UHn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Nov 2019 15:07:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 12:07:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,258,1571727600"; 
   d="scan'208";a="411065291"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 29 Nov 2019 12:07:40 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iamYF-0000um-KR; Fri, 29 Nov 2019 22:07:39 +0200
Date:   Fri, 29 Nov 2019 22:07:39 +0200
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
Subject: Re: [PATCH 0/2] drm/i915/vlv_dsi: Control panel and backlight enable
 GPIOs on BYT
Message-ID: <20191129200739.GB32742@smile.fi.intel.com>
References: <20191129185836.2789-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129185836.2789-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 29, 2019 at 07:58:34PM +0100, Hans de Goede wrote:
> Hi All,
> 
> On Bay Trail devices the MIPI power on/off sequences for DSI LCD panels
> do not control the LCD panel- and backlight-enable GPIOs. So far, when
> the VBT indicates we should use the SoC for backlight control, we have
> been relying on these GPIOs being configured as output and driven high by
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
> This series contains 2 patches which together fix this.
> 
> To avoid new errors in the intel-gfx CI (assuming there is atleast 1
> BYT device there with a DSI panel), we need both of these patches to
> be merged through the drm-intel tree.
> 
> Unfortunately there is some churn currently going on in the
> pinctrl-baytrail.c code, but not in the part of the file which this
> touches, so merging the pinctrl-baytrail.c changes through the
> drm-intel tree should not lead to conflicts later.
> 
> Andy, Mika, assuming you are happy with the changes, can I get your ack
> for merging the pinctrl-baytrail patch throught the drm-inteol tree?

I'm not okay with this. I will tell more next week how I see this to be
implemented in a better way.

Happy Black Friday! :-)

-- 
With Best Regards,
Andy Shevchenko


