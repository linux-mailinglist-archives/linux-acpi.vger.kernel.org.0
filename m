Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FD910D54D
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 12:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfK2L7n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 06:59:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:65510 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2L7n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Nov 2019 06:59:43 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 0bd48a9c974178a2; Fri, 29 Nov 2019 12:59:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Len Brown <lenb@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ACPI / LPSS: Rename pwm_backlight pwm-lookup to pwm_soc_backlight
Date:   Fri, 29 Nov 2019 12:59:40 +0100
Message-ID: <3461808.dMKB6b565b@kreacher>
In-Reply-To: <20191119151818.67531-2-hdegoede@redhat.com>
References: <20191119151818.67531-1-hdegoede@redhat.com> <20191119151818.67531-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, November 19, 2019 4:18:16 PM CET Hans de Goede wrote:
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
> Since only the i915 driver has access to the VBT, this commit renames
> the "pwm_backlight" lookup entries for the 1st BYT/CHT LPSS PWM controller
> to "pwm_soc_backlight" so that the i915 driver can do a pwm_get() for
> the right controller depending on the VBT bit, instead of the i915 driver
> relying on a "pwm_backlight" lookup getting registered which magically
> points to the right controller.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or please let me know if you want me to take the whole series.

Thanks!

> ---
>  drivers/acpi/acpi_lpss.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 751ed38f2a10..63e81d8e675b 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -69,10 +69,6 @@ ACPI_MODULE_NAME("acpi_lpss");
>  #define LPSS_SAVE_CTX			BIT(4)
>  #define LPSS_NO_D3_DELAY		BIT(5)
>  
> -/* Crystal Cove PMIC shares same ACPI ID between different platforms */
> -#define BYT_CRC_HRV			2
> -#define CHT_CRC_HRV			3
> -
>  struct lpss_private_data;
>  
>  struct lpss_device_desc {
> @@ -158,7 +154,7 @@ static void lpss_deassert_reset(struct lpss_private_data *pdata)
>   */
>  static struct pwm_lookup byt_pwm_lookup[] = {
>  	PWM_LOOKUP_WITH_MODULE("80860F09:00", 0, "0000:00:02.0",
> -			       "pwm_backlight", 0, PWM_POLARITY_NORMAL,
> +			       "pwm_soc_backlight", 0, PWM_POLARITY_NORMAL,
>  			       "pwm-lpss-platform"),
>  };
>  
> @@ -170,8 +166,7 @@ static void byt_pwm_setup(struct lpss_private_data *pdata)
>  	if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
>  		return;
>  
> -	if (!acpi_dev_present("INT33FD", NULL, BYT_CRC_HRV))
> -		pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
> +	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
>  }
>  
>  #define LPSS_I2C_ENABLE			0x6c
> @@ -204,7 +199,7 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
>  /* BSW PWM used for backlight control by the i915 driver */
>  static struct pwm_lookup bsw_pwm_lookup[] = {
>  	PWM_LOOKUP_WITH_MODULE("80862288:00", 0, "0000:00:02.0",
> -			       "pwm_backlight", 0, PWM_POLARITY_NORMAL,
> +			       "pwm_soc_backlight", 0, PWM_POLARITY_NORMAL,
>  			       "pwm-lpss-platform"),
>  };
>  
> 




