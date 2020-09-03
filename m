Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1C25C150
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Sep 2020 14:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgICMtC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Sep 2020 08:49:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:56721 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbgICMsg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Sep 2020 08:48:36 -0400
IronPort-SDR: jOQMual3UjcANafx7/ZjsoNzQ5r8tD5UqZS0HGR7/36VGpxL2RALffDOuaMnjvVkKmaVC3BrAU
 zVblArJzxhmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="137617081"
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="137617081"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:48:23 -0700
IronPort-SDR: mh51FDKo99BE3cv0RW3w0m4s8JavAdmniQs7f/pZrNz9Tilv1Tn1ItIk2TVtjQCT2LF4jamd/Y
 4TZLrcqY2j3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="331776973"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2020 05:48:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kDof2-00E1pw-Qb; Thu, 03 Sep 2020 15:48:16 +0300
Date:   Thu, 3 Sep 2020 15:48:16 +0300
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
Subject: Re: [PATCH v10 07/17] pwm: lpss: Remove suspend/resume handlers
Message-ID: <20200903124816.GA1891694@smile.fi.intel.com>
References: <20200903112337.4113-1-hdegoede@redhat.com>
 <20200903112337.4113-8-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903112337.4113-8-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 03, 2020 at 01:23:27PM +0200, Hans de Goede wrote:
> PWM controller drivers should not restore the PWM state on resume. The
> convention is that PWM consumers do this by calling pwm_apply_state(),
> so that it can be done at the exact moment when the consumer needs
> the state to be stored, avoiding e.g. backlight flickering.
> 
> The only in kernel consumers of the pwm-lpss code, the i915 driver
> and the pwm-class sysfs interface code both correctly restore the
> state on resume, so there is no need to do this in the pwm-lpss code.
> 
> More-over the removed resume handler is buggy, since it blindly
> restores the ctrl-register contents without setting the update
> bit, which is necessary to get the controller to actually use/apply
> the restored base-unit and on-time-div values.

While this is okay

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

the question is do we need to have similar in acpi_lpss.c?
For example,
	static const struct lpss_device_desc byt_pwm_dev_desc = {
		.flags = LPSS_SAVE_CTX,
		^^^^^^^^^^^^^^
		.prv_offset = 0x800,
		.setup = byt_pwm_setup,
	};

	static const struct lpss_device_desc bsw_pwm_dev_desc = {
		.flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
		^^^^^^^^^^^^^^
		.prv_offset = 0x800,
		.setup = bsw_pwm_setup,
	};


> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v9:
> - This is a new patch in v9 of this series
> ---
>  drivers/pwm/pwm-lpss-platform.c |  1 -
>  drivers/pwm/pwm-lpss.c          | 24 ------------------------
>  drivers/pwm/pwm-lpss.h          |  3 ---
>  3 files changed, 28 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
> index 48f34d20aecd..c6502cf7a7af 100644
> --- a/drivers/pwm/pwm-lpss-platform.c
> +++ b/drivers/pwm/pwm-lpss-platform.c
> @@ -89,7 +89,6 @@ static int pwm_lpss_prepare(struct device *dev)
>  
>  static const struct dev_pm_ops pwm_lpss_platform_pm_ops = {
>  	.prepare = pwm_lpss_prepare,
> -	SET_SYSTEM_SLEEP_PM_OPS(pwm_lpss_suspend, pwm_lpss_resume)
>  };
>  
>  static const struct acpi_device_id pwm_lpss_acpi_match[] = {
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 9c5c7217c9b6..3444c56b4bed 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -260,30 +260,6 @@ int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
>  }
>  EXPORT_SYMBOL_GPL(pwm_lpss_remove);
>  
> -int pwm_lpss_suspend(struct device *dev)
> -{
> -	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
> -	int i;
> -
> -	for (i = 0; i < lpwm->info->npwm; i++)
> -		lpwm->saved_ctrl[i] = readl(lpwm->regs + i * PWM_SIZE + PWM);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pwm_lpss_suspend);
> -
> -int pwm_lpss_resume(struct device *dev)
> -{
> -	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
> -	int i;
> -
> -	for (i = 0; i < lpwm->info->npwm; i++)
> -		writel(lpwm->saved_ctrl[i], lpwm->regs + i * PWM_SIZE + PWM);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pwm_lpss_resume);
> -
>  MODULE_DESCRIPTION("PWM driver for Intel LPSS");
>  MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> index 7909fa12fca2..70db7e389d66 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/drivers/pwm/pwm-lpss.h
> @@ -19,7 +19,6 @@ struct pwm_lpss_chip {
>  	struct pwm_chip chip;
>  	void __iomem *regs;
>  	const struct pwm_lpss_boardinfo *info;
> -	u32 saved_ctrl[MAX_PWMS];
>  };
>  
>  struct pwm_lpss_boardinfo {
> @@ -37,7 +36,5 @@ struct pwm_lpss_boardinfo {
>  struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
>  				     const struct pwm_lpss_boardinfo *info);
>  int pwm_lpss_remove(struct pwm_lpss_chip *lpwm);
> -int pwm_lpss_suspend(struct device *dev);
> -int pwm_lpss_resume(struct device *dev);
>  
>  #endif	/* __PWM_LPSS_H */
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko


