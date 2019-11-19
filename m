Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 741D710288F
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 16:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfKSPrZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 10:47:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:27077 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbfKSPrY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 10:47:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 07:47:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; 
   d="scan'208";a="209453942"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 19 Nov 2019 07:47:18 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 19 Nov 2019 17:47:17 +0200
Date:   Tue, 19 Nov 2019 17:47:17 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/i915: DSI: select correct PWM controller to use
 based on the VBT
Message-ID: <20191119154717.GA1208@intel.com>
References: <20191119151818.67531-1-hdegoede@redhat.com>
 <20191119151818.67531-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119151818.67531-4-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2019 at 04:18:18PM +0100, Hans de Goede wrote:
> At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
> different PWM controllers for controlling the LCD's backlight brightness.
> Either the one integrated into the PMIC or the one integrated into the
> SoC (the 1st LPSS PWM controller).
> 
> So far in the LPSS code on BYT we have skipped registering the LPSS PWM
> controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
> present, assuming that in this case the PMIC PWM controller will be used.
> 
> On CHT we have been relying on only 1 of the 2 PWM controllers being
> enabled in the DSDT at the same time; and always registered the lookup.
> 
> So far this has been working, but the correct way to determine which PWM
> controller needs to be used is by checking a bit in the VBT table and
> recently I've learned about 2 different BYT devices:
> Point of View MOBII TAB-P800W
> Acer Switch 10 SW5-012
> 
> Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
> PWM controller (and the VBT correctly indicates this), so here our old
> heuristics fail.
> 
> This commit fixes using the wrong PWM controller on these devices by
> calling pwm_get() for the right PWM controller based on the
> VBT dsi.config.pwm_blc bit.
> 
> Note this is part of a series which contains 2 other patches which renames
> the PWM lookup for the 1st SoC/LPSS PWM from "pwm_backlight" to
> "pwm_pmic_backlight" and the PWM lookup for the Crystal Cove PMIC PWM
> from "pwm_backlight" to "pwm_pmic_backlight".
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/i915/display/intel_panel.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
> index bc14e9c0285a..ddcf311d1114 100644
> --- a/drivers/gpu/drm/i915/display/intel_panel.c
> +++ b/drivers/gpu/drm/i915/display/intel_panel.c
> @@ -1840,13 +1840,22 @@ static int pwm_setup_backlight(struct intel_connector *connector,
>  			       enum pipe pipe)
>  {
>  	struct drm_device *dev = connector->base.dev;
> +	struct drm_i915_private *dev_priv = to_i915(dev);
>  	struct intel_panel *panel = &connector->panel;
> +	const char *desc;
>  	int retval;
>  
> -	/* Get the PWM chip for backlight control */
> -	panel->backlight.pwm = pwm_get(dev->dev, "pwm_backlight");
> +	/* Get the right PWM chip for DSI backlight according to VBT */
> +	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
> +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_pmic_backlight");
> +		desc = "PMIC";
> +	} else {
> +		panel->backlight.pwm = pwm_get(dev->dev, "pwm_soc_backlight");
> +		desc = "SoC";
> +	}

Might we want the same thing for the panel enable gpio?

> +
>  	if (IS_ERR(panel->backlight.pwm)) {
> -		DRM_ERROR("Failed to own the pwm chip\n");
> +		DRM_ERROR("Failed to get the %s PWM chip\n", desc);
>  		panel->backlight.pwm = NULL;
>  		return -ENODEV;
>  	}
> @@ -1873,6 +1882,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
>  				 CRC_PMIC_PWM_PERIOD_NS);
>  	panel->backlight.enabled = panel->backlight.level != 0;
>  
> +	DRM_INFO("Using %s PWM for LCD backlight control\n", desc);
>  	return 0;
>  }
>  
> -- 
> 2.23.0

-- 
Ville Syrjälä
Intel
