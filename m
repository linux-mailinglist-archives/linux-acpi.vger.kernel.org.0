Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495F96CB13
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2019 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfGRIme convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 18 Jul 2019 04:42:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53604 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRImd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jul 2019 04:42:33 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 7b95f5cc5e7aeb8f; Thu, 18 Jul 2019 10:42:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-acpi@vger.kernel.org,
        Kacper =?utf-8?B?UGl3acWEc2tp?= <cosiekvfj@o2.pl>
Subject: Re: [PATCH] ACPI / video: Add new hw_changes_brightness quirk, set it on PB Easynote MZ35
Date:   Thu, 18 Jul 2019 10:42:30 +0200
Message-ID: <5150566.QdWsabkNQC@kreacher>
In-Reply-To: <20190712100033.4087-1-hdegoede@redhat.com>
References: <20190712100033.4087-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, July 12, 2019 12:00:33 PM CEST Hans de Goede wrote:
> Some machines change the brightness themselves when a brightness hotkey
> gets pressed, despite us telling them not to. This causes the brightness to
> go two steps up / down when the hotkey is pressed. This is esp. a problem
> on older machines with only a few brightness levels.
> 
> This commit adds a new hw_changes_brightness quirk which makes
> acpi_video_device_notify() only call backlight_force_update(...,
> BACKLIGHT_UPDATE_HOTKEY) and not do anything else, notifying userspace that
> the brightness was changed and leaving it at that fixing the dual step
> problem.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204077
> Cc: Kacper Piwiński <cosiekvfj@o2.pl>
> Reported-and-tested-by: Kacper Piwiński <cosiekvfj@o2.pl>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_video.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 9489ffc06411..4f325e47519f 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -60,6 +60,12 @@ module_param(report_key_events, int, 0644);
>  MODULE_PARM_DESC(report_key_events,
>  	"0: none, 1: output changes, 2: brightness changes, 3: all");
>  
> +static int hw_changes_brightness = -1;
> +module_param(hw_changes_brightness, int, 0644);
> +MODULE_PARM_DESC(hw_changes_brightness,
> +	"Set this to 1 on buggy hw which changes the brightness itself when "
> +	"a hotkey is pressed: -1: auto, 0: normal 1: hw-changes-brightness");
> +
>  /*
>   * Whether the struct acpi_video_device_attrib::device_id_scheme bit should be
>   * assumed even if not actually set.
> @@ -405,6 +411,14 @@ static int video_set_report_key_events(const struct dmi_system_id *id)
>  	return 0;
>  }
>  
> +static int video_hw_changes_brightness(
> +	const struct dmi_system_id *d)
> +{
> +	if (hw_changes_brightness == -1)
> +		hw_changes_brightness = 1;
> +	return 0;
> +}
> +
>  static const struct dmi_system_id video_dmi_table[] = {
>  	/*
>  	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
> @@ -529,6 +543,21 @@ static const struct dmi_system_id video_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V131"),
>  		},
>  	},
> +	/*
> +	 * Some machines change the brightness themselves when a brightness
> +	 * hotkey gets pressed, despite us telling them not to. In this case
> +	 * acpi_video_device_notify() should only call backlight_force_update(
> +	 * BACKLIGHT_UPDATE_HOTKEY) and not do anything else.
> +	 */
> +	{
> +	 /* https://bugzilla.kernel.org/show_bug.cgi?id=204077 */
> +	 .callback = video_hw_changes_brightness,
> +	 .ident = "Packard Bell EasyNote MZ35",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Packard Bell"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "EasyNote MZ35"),
> +		},
> +	},
>  	{}
>  };
>  
> @@ -1612,6 +1641,14 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
>  	bus = video_device->video;
>  	input = bus->input;
>  
> +	if (hw_changes_brightness > 0) {
> +		if (video_device->backlight)
> +			backlight_force_update(video_device->backlight,
> +					       BACKLIGHT_UPDATE_HOTKEY);
> +		acpi_notifier_call_chain(device, event, 0);
> +		return;
> +	}
> +
>  	switch (event) {
>  	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
>  		brightness_switch_event(video_device, event);
> 

Applied, thanks!




