Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281025ACEFB
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Sep 2022 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiIEJiL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Sep 2022 05:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiIEJiK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Sep 2022 05:38:10 -0400
Received: from vorpal.se (unknown [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC254D261;
        Mon,  5 Sep 2022 02:37:59 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 56868142D4;
        Mon,  5 Sep 2022 09:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662370662; bh=J5JUSFFWXYN8Eh2dbaXPhc4dL6qTEks/U3SCHPKb8p0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UcZH04dvjhlROl9dfJ27dPjUZikabkjOcbLtxDhhc8ggb9Ojm7QPLUXO+rUGJzcJK
         QnS3crsheoDyULhjqLg6Fk+E3U1wGZVD06rbTio9gMyLash41Be4PtJEYTU7JIXRZ3
         Vo0hJzoJQaquL5RSUFrJn7a0P+VKCI+y4566xvzyrwd2YOXxa2yW7b33y8FrcoGSZy
         3uKDr19aGFvSXYkgX53QgQZY7gFcWOZq62yUqKi4DhQRiLQCe1+T6gK2mGHM10zV0V
         Vxksi1Tf/kborp4RjBqy/4JDcNiqiVIz0zNbjZpsp1Ggkr3IeknyTSTv+6tbw5Mah9
         4lBHfCRwXcVaQ==
Message-ID: <ce4ba704-c02f-a417-e3a5-98f31bfd9a2d@vorpal.se>
Date:   Mon, 5 Sep 2022 11:37:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/2] drivers/platform: toshiba_acpi: Call
 HCI_PANEL_POWER_ON on resume on some models
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20220905090005.333429-1-hdegoede@redhat.com>
 <20220905090005.333429-2-hdegoede@redhat.com>
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <20220905090005.333429-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,NO_DNS_FOR_FROM,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2022-09-05 11:00, Hans de Goede wrote:
> Some Toshibas have a broken acpi-video interface for brightness control, so
> far these have been using a special workaround in drivers/acpi/acpi_video.c
> which gets activated by the disable_backlight_sysfs_if module-param/quirks.
> 
> The recent x86/acpi backlight refactoring has broken this workaround:
> 1. This workaround relies on acpi_video_get_backlight_type() returning
>    acpi_video so that the acpi_video code actually runs; and
> 2. this relies on the actual native GPU driver to offer the sysfs
>    backlight interface to userspace.
> 
> After the refactor this breaks since the native driver will no
> longer register its backlight-device if acpi_video_get_backlight_type()
> does not return native and making it return native breaks 1.
> 
> Keeping the acpi_video backlight handling on resume active, while not
> using it to set the brightness, is necessary because it does a _BCM
> call on resume which is necessary to turn the panel back on on resume.
> 
> Looking at the DSDT shows that this _BCM call results in a Toshiba
> HCI_SET HCI_LCD_BRIGHTNESS call, which turns the panel back on.
> 
> This commit makes toshiba_acpi do a HCI_SET HCI_PANEL_POWER_ON call
> on resume on the affected models, so that the (now broken)
> acpi_video disable_backlight_sysfs_if workaround will no longer
> be necessary.
> 
> Note this uses HCI_PANEL_POWER_ON instead of HCI_LCD_BRIGHTNESS
> to avoid changing the configured brightness level.

With the previous ACPI Video based approach this quirk was possible to
control from the kernel command line. This does not seem to be the case
here. This raises the difficulty for users with as of yet unlisted models
to test if this quirk would help. Would it be worth adding support for the
enabling this from the kernel command line?

> 
> Fixes: b1d36e73cc1c ("drm/i915: Don't register backlight when another backlight should be used (v2)")
> Tested-by: Arvid Norlander <lkml@vorpal.se>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/toshiba_acpi.c | 46 +++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 030dc37d50b8..826ffac4af1c 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -23,6 +23,7 @@
>  #define PROC_INTERFACE_VERSION	1
>  
>  #include <linux/compiler.h>
> +#include <linux/dmi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> @@ -100,6 +101,7 @@ MODULE_LICENSE("GPL");
>  #define TOS_NOT_INSTALLED		0x8e00
>  
>  /* Registers */
> +#define HCI_PANEL_POWER_ON		0x0002
>  #define HCI_FAN				0x0004
>  #define HCI_TR_BACKLIGHT		0x0005
>  #define HCI_SYSTEM_EVENT		0x0016
> @@ -206,6 +208,7 @@ struct toshiba_acpi_dev {
>  
>  	bool kbd_event_generated;
>  	bool killswitch;
> +	bool turn_on_panel_on_resume;

You added this bool to the section that changes at runtime, rather than
the feature section just above.

Also, many of the bools are bitfields, especially (almost) all the ones
that are about detecting a feature once then setting it. (I belive
"special_functions" is an exception since it can take more values, and
when I add support for the non-working buttons on the 830 this will be
significant).

In summary I thus believe it would make sense to add your new boolean to
bitfield section above this one.

>  };
>  
>  static struct toshiba_acpi_dev *toshiba_acpi;
> @@ -2999,6 +3002,43 @@ static const char *find_hci_method(acpi_handle handle)
>  	return NULL;
>  }
>  
> +/*
> + * Some Toshibas have a broken acpi-video interface for brightness control,
> + * these are quirked in drivers/acpi/video_detect.c to use the GPU native
> + * (/sys/class/backlight/intel_backlight) instead.
> + * But these need a HCI_SET call to actually turn the panel back on at resume,
> + * without this call the screen stays black at resume.
> + * Either HCI_LCD_BRIGHTNESS (used by acpi_video's _BCM) or HCI_PANEL_POWER_ON
> + * works. toshiba_acpi_resume() uses HCI_PANEL_POWER_ON to avoid changing
> + * the configured brightness level.
> + */
> +static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
> +	{
> +	 /* Toshiba Portégé R700 */
> +	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
> +		},
> +	},
> +	{
> +	 /* Toshiba Satellite/Portégé R830 */
> +	 /* Portégé: https://bugs.freedesktop.org/show_bug.cgi?id=82634 */
> +	 /* Satellite: https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
> +		},
> +	},
> +	{
> +	 /* Toshiba Satellite/Portégé Z830 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
> +		},
> +	},
> +};
> +
>  static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  {
>  	struct toshiba_acpi_dev *dev;
> @@ -3141,6 +3181,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	ret = get_fan_status(dev, &dummy);
>  	dev->fan_supported = !ret;
>  
> +	dev->turn_on_panel_on_resume =
> +		dmi_check_system(turn_on_panel_on_resume_dmi_ids);
> +
>  	toshiba_wwan_available(dev);
>  	if (dev->wwan_supported)
>  		toshiba_acpi_setup_wwan_rfkill(dev);
> @@ -3257,6 +3300,9 @@ static int toshiba_acpi_resume(struct device *device)
>  			rfkill_set_hw_state(dev->wwan_rfk, !dev->killswitch);
>  	}
>  
> +	if (dev->turn_on_panel_on_resume)
> +		hci_write(dev, HCI_PANEL_POWER_ON, 1);
> +
>  	return 0;
>  }
>  #endif

Best regards,
Arvid Norlander
