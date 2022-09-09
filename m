Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E945B3E13
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Sep 2022 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIIRlS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Sep 2022 13:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIIRlR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Sep 2022 13:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BA996FC6
        for <linux-acpi@vger.kernel.org>; Fri,  9 Sep 2022 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662745275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9M0kqItM9plhK1KFlZ7clm4OCYC2Cx+YQmfHN1M/8m0=;
        b=PBhCF+mi/wkqreGcWNdBY8rTybWRMFtG3HnhQOxMf0fkOlj3n/D4xp7JXIB1dD3Ww+h0Eb
        ObJwy8glMgcfwQNoFxxbIgsfGqJQEQm0U7wtLOYrBGdAYoCHxtxAqS95MuBFPr65UiUrIQ
        bU9kMpJQffGNHD2Z1F+xYDzBVWCS/5A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-M5RAB3lPPsGZ8cETt05SDw-1; Fri, 09 Sep 2022 13:41:13 -0400
X-MC-Unique: M5RAB3lPPsGZ8cETt05SDw-1
Received: by mail-ej1-f70.google.com with SMTP id nc21-20020a1709071c1500b0076120d57502so1361438ejc.18
        for <linux-acpi@vger.kernel.org>; Fri, 09 Sep 2022 10:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9M0kqItM9plhK1KFlZ7clm4OCYC2Cx+YQmfHN1M/8m0=;
        b=PkDh8PCkHgjumQQqA6sQAi/vuDL7Box1BfDfitfdSVclh9+qpUTkBggP2BkVOXCDHP
         uLP9UTnlqegWGpob7cjgkAVL7ws5jFMaMzUmvBIoV5dC3+I6h9gxpohdFWk/qmshC/lH
         YWyicD++PiAGlyPuyypoMiqZBOBpLDDsaNH90/QjtvNFrLxkyx0VFi5g5Alj9aT5oqoI
         6+KouvliMYPjOV/Ga6seXsFl+4MGDomplbntPaSW3nou8M2XiszR3prMBUx18cCZ5uMR
         USeNzdZj3aCqIIyjyQj9DfINZ/P5oHJipw+vbWxcaTOn/g9lJ3h6NrRgT5Er7fd7kKMV
         3C1g==
X-Gm-Message-State: ACgBeo1zB4t9A6nkSq3NjYWpPnm9WgwWRiUhy16vo2XTt96Juqei6sR0
        litr/WsXDP3WBx4PfsTymHzFyGvJmemplwO5pzyqnvRh6pAH3cRfy8rSMATmEKhcPXzNlr7Wd7A
        uX7jzhm/HmrTvYEpgL7w1/Q==
X-Received: by 2002:a17:907:8686:b0:773:6f77:f110 with SMTP id qa6-20020a170907868600b007736f77f110mr7484569ejc.547.1662745272372;
        Fri, 09 Sep 2022 10:41:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5g51v7A56nWF33hp1ZuydAQ3ObgUmrUx/xmVtZgT9K967VFJqOVfKnbXLU2WP1/VDl9oIEHQ==
X-Received: by 2002:a17:907:8686:b0:773:6f77:f110 with SMTP id qa6-20020a170907868600b007736f77f110mr7484555ejc.547.1662745272116;
        Fri, 09 Sep 2022 10:41:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id b4-20020aa7df84000000b0044dbecdcd29sm729398edy.12.2022.09.09.10.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 10:41:11 -0700 (PDT)
Message-ID: <43c52d4c-3355-6699-7ad9-02a62e63fbd9@redhat.com>
Date:   Fri, 9 Sep 2022 19:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] drivers/platform: toshiba_acpi: Call
 HCI_PANEL_POWER_ON on resume on some models
Content-Language: en-US
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Arvid Norlander <lkml@vorpal.se>,
        Mark Gross <mgross@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20220909153239.34606-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220909153239.34606-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/9/22 17:32, Hans de Goede wrote:
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

I have added these 2 patches to my review-hans (soon to be for-next)
branch now.

Regards,

Hans




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

