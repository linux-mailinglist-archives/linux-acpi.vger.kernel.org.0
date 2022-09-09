Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B95B3DF7
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Sep 2022 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIIR3s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Sep 2022 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIIR3r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Sep 2022 13:29:47 -0400
Received: from vorpal.se (unknown [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8DF58B;
        Fri,  9 Sep 2022 10:29:32 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 8B1F4142D4;
        Fri,  9 Sep 2022 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662744555; bh=YxV1bcA7852pBmchzb8H20s3XoEh/vN7giCg2FvWDIA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G7fb4E9lTq9AWL3QhRnWulJ3xuCqmB2rRwItoppeaUwPtsMPTZrK3lda7TBkE3tMd
         otB2o1SxijJbKOv6s6Hu6+0SJDzyzmrdvhvlFdakxT7rvt0mqrLu1VQ1wdC4PX936n
         WaftnGfBlI7nH3g9OSWzKc095A6u/1nEvq9AL8pRy0Y+x+2EsWCBfMy/jabC+lsyCu
         z3cVNAkshqWnsn009u3iQH0Hzwq8MlbtMXHfw4vfJfpY9lw1MRLfVeSPxO12DLPwLL
         3MB7AHH90kX4HGmu/Tg5lFJJUNDsfCWZU8L0d2BOhs0S9JFiKV/UAzk93GpKCH8kLF
         06w+qWzhFEOmA==
Message-ID: <ee77aadf-8adc-c812-55ae-c534fb523de5@vorpal.se>
Date:   Fri, 9 Sep 2022 19:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/2] drivers/platform: toshiba_acpi: Call
 HCI_PANEL_POWER_ON on resume on some models
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20220909153239.34606-1-hdegoede@redhat.com>
Content-Language: en-US
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <20220909153239.34606-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,NO_DNS_FOR_FROM,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Given the changes, do you want me to test this again? If so, on what branch?

Best regards,
Arvid Norlander

On 2022-09-09 17:32, Hans de Goede wrote:
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
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Add a turn_on_panel_on_resume module parameter to allow overriding
>   the DMI quirk based setting
> ---
>  drivers/platform/x86/toshiba_acpi.c | 50 +++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 900ee68a4c0b..aa55ed0d029d 100644
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
> @@ -50,6 +51,11 @@ MODULE_AUTHOR("John Belmonte");
>  MODULE_DESCRIPTION("Toshiba Laptop ACPI Extras Driver");
>  MODULE_LICENSE("GPL");
>  
> +int turn_on_panel_on_resume = -1;
> +module_param(turn_on_panel_on_resume, int, 0644);
> +MODULE_PARM_DESC(turn_on_panel_on_resume,
> +	"Call HCI_PANEL_POWER_ON on resume (-1 = auto, 0 = no, 1 = yes");
> +
>  #define TOSHIBA_WMI_EVENT_GUID "59142400-C6A3-40FA-BADB-8A2652834100"
>  
>  /* Scan code for Fn key on TOS1900 models */
> @@ -100,6 +106,7 @@ MODULE_LICENSE("GPL");
>  #define TOS_NOT_INSTALLED		0x8e00
>  
>  /* Registers */
> +#define HCI_PANEL_POWER_ON		0x0002
>  #define HCI_FAN				0x0004
>  #define HCI_TR_BACKLIGHT		0x0005
>  #define HCI_SYSTEM_EVENT		0x0016
> @@ -3002,6 +3009,43 @@ static const char *find_hci_method(acpi_handle handle)
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
> @@ -3144,6 +3188,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	ret = get_fan_status(dev, &dummy);
>  	dev->fan_supported = !ret;
>  
> +	if (turn_on_panel_on_resume == -1)
> +		turn_on_panel_on_resume = dmi_check_system(turn_on_panel_on_resume_dmi_ids);
> +
>  	toshiba_wwan_available(dev);
>  	if (dev->wwan_supported)
>  		toshiba_acpi_setup_wwan_rfkill(dev);
> @@ -3260,6 +3307,9 @@ static int toshiba_acpi_resume(struct device *device)
>  			rfkill_set_hw_state(dev->wwan_rfk, !dev->killswitch);
>  	}
>  
> +	if (turn_on_panel_on_resume)
> +		hci_write(dev, HCI_PANEL_POWER_ON, 1);
> +
>  	return 0;
>  }
>  #endif

