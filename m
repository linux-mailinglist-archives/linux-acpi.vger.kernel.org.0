Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7779F2311E7
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jul 2020 20:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgG1Sp5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jul 2020 14:45:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:41006 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729006AbgG1Sp5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jul 2020 14:45:57 -0400
IronPort-SDR: XeW4WF+1wbl0UmX6qtflTGskyKxc7g+ig6RmicoM6uOrFNiG/RHfspQ4ZGx4ObwllBKWUY8Yol
 8NDWzXgiDKWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="236156596"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="236156596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 11:45:56 -0700
IronPort-SDR: wwWappNoJfKls/eFsEdb++nFi5WOaro8lC2t0gajQmO4NdQk54sfqMRwrDFI40pe+1MnoCMCo0
 VeDEfvP1Pujw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="394420092"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2020 11:45:53 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0Ubp-004W6J-2e; Tue, 28 Jul 2020 21:45:53 +0300
Date:   Tue, 28 Jul 2020 21:45:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 05/16] pwm: lpss: Add pwm_lpss_prepare_enable() helper
Message-ID: <20200728184553.GZ3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717133753.127282-6-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 17, 2020 at 03:37:42PM +0200, Hans de Goede wrote:
> In the not-enabled -> enabled path pwm_lpss_apply() needs to get a
> runtime-pm reference; and then on any errors it needs to release it
> again.
> 
> This leads to somewhat hard to read code. This commit introduces a new
> pwm_lpss_prepare_enable() helper and moves all the steps necessary for
> the not-enabled -> enabled transition there, so that we can error check
> the entire transition in a single place and only have one pm_runtime_put()
> on failure call site.
> 
> While working on this I noticed that the enabled -> enabled (update
> settings) path was quite similar, so I've added an enable parameter to
> the new pwm_lpss_prepare_enable() helper, which allows using it in that
> path too.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
But see below.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss.c | 45 ++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index da9bc3d10104..8a136ba2a583 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -122,41 +122,48 @@ static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
>  		pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
>  }
>  
> +static int pwm_lpss_prepare_enable(struct pwm_lpss_chip *lpwm,
> +				   struct pwm_device *pwm,
> +				   const struct pwm_state *state,
> +				   bool enable)
> +{
> +	int ret;
> +
> +	ret = pwm_lpss_is_updating(pwm);
> +	if (ret)
> +		return ret;
> +
> +	pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
> +	pwm_lpss_cond_enable(pwm, enable && lpwm->info->bypass == false);
> +	ret = pwm_lpss_wait_for_update(pwm);
> +	if (ret)
> +		return ret;
> +
> +	pwm_lpss_cond_enable(pwm, enable && lpwm->info->bypass == true);
> +	return 0;
> +}
> +
>  static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  const struct pwm_state *state)
>  {
>  	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
> -	int ret;

> +	int ret = 0;

We can avoid this change...

>  	if (state->enabled) {
>  		if (!pwm_is_enabled(pwm)) {
>  			pm_runtime_get_sync(chip->dev);
> -			ret = pwm_lpss_is_updating(pwm);
> -			if (ret) {
> -				pm_runtime_put(chip->dev);
> -				return ret;
> -			}
> -			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
> -			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
> -			ret = pwm_lpss_wait_for_update(pwm);
> -			if (ret) {
> +			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, true);
> +			if (ret)
>  				pm_runtime_put(chip->dev);
> -				return ret;
> -			}
> -			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);
>  		} else {
> -			ret = pwm_lpss_is_updating(pwm);
> -			if (ret)
> -				return ret;
> -			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
> -			return pwm_lpss_wait_for_update(pwm);

> +			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, false);

...by simple return directly from here. But I admit I haven't seen the next patch yet.

>  		}
>  	} else if (pwm_is_enabled(pwm)) {
>  		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
>  		pm_runtime_put(chip->dev);
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


