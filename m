Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A9A5BC585
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Sep 2022 11:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiISJgy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Sep 2022 05:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiISJgq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Sep 2022 05:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AE91E3C4
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 02:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663580204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEYmGh+PMWiS2BEqPP9TO2aHkOs4Q+xcRp0xvyeEL74=;
        b=SxCRVprQDv5C46Ej29iNU4tkJMvx7m+uYiEKKeFU6u2o8QlK79qp0pybzuWyu9pTK+5GmI
        5HvROol4s0cuXBLqhkWflBK6TBnAW5i/MvBB5X93cwqYgXn6lctaOP9zCMuBjwo3gdziMF
        JPncxq2oKwyP89IM6hJLlbx8s+cNMwM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-404-_GetUJ4_NIOq2KajQw0ycg-1; Mon, 19 Sep 2022 05:36:41 -0400
X-MC-Unique: _GetUJ4_NIOq2KajQw0ycg-1
Received: by mail-ed1-f71.google.com with SMTP id f10-20020a0564021e8a00b00451be6582d5so16025621edf.15
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 02:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YEYmGh+PMWiS2BEqPP9TO2aHkOs4Q+xcRp0xvyeEL74=;
        b=5eOVXq15lic+PQKODvESSmqJOAAl+4kjPdDUPf2plF2SuswaG06hgTo2TaF/zqsjXw
         XBuG51VLjiuPNxTrGmb7MJ0NuIlDX828gDGLs/dLHdr/+alYnkAuj2CkU9e5+H9ppYi/
         qlHkHJs4/0SPhZKwqmUbE76CYatUkQnmKw/uYg+h5mmRoq4v4S5tE+Q3jeNmZgHW3mP4
         7EGiN1tabxPt8RfE9GdsaO57NDvlRRrHwcS5HpHSLX3K5GF5OnpxkxjKfEnidTW4da24
         YtBo9aMRR67V1geJ5xcdUma7/d9HnO07KgVPNJ/W48qQC3CWEifLsS3O7ZK2o663pEhK
         ACBw==
X-Gm-Message-State: ACrzQf3DXx3mvtBm3yi5hsFo+E37cY9JNT40MlfHFOH1V+oDwlB0SrtT
        o7aDRamRDRo4HjgaE+i37TGzPqnYANzibOdp6Sa5zsPhaXaiZjblpoISV9ZoFESQ4RV44ndbg1G
        xt3Fo7JpiJyJC9mY0tFPXwA==
X-Received: by 2002:a17:907:96ab:b0:779:b7d8:41ba with SMTP id hd43-20020a17090796ab00b00779b7d841bamr12372225ejc.449.1663580199663;
        Mon, 19 Sep 2022 02:36:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6mOzsWeH471OpmYDLDV6q9iKY584TBmV1COq6XI9rxlAi8n6Rn2JlChqe71qycB/oShRtdug==
X-Received: by 2002:a17:907:96ab:b0:779:b7d8:41ba with SMTP id hd43-20020a17090796ab00b00779b7d841bamr12372212ejc.449.1663580199472;
        Mon, 19 Sep 2022 02:36:39 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id j7-20020a170906278700b007324aa2ca77sm15091123ejc.85.2022.09.19.02.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 02:36:38 -0700 (PDT)
Message-ID: <34d556ef-a1b9-bdf1-c7c7-843866279b92@redhat.com>
Date:   Mon, 19 Sep 2022 10:36:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC 2/2] platform/x86: toshiba_acpi: Add quirk for buttons
 on Z830
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
References: <20220911194934.558019-1-lkml@vorpal.se>
 <20220911194934.558019-3-lkml@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220911194934.558019-3-lkml@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/11/22 20:49, Arvid Norlander wrote:
> The Z830 has some buttons that will only work properly as "quickstart"
> buttons. To enable them in that mode, a value between 1 and 7 must be
> used for HCI_HOTKEY_EVENT. Windows uses 0x5 on this laptop so use that for
> maximum predictability and compatibility.
> 
> As there is not yet a known way of auto detection, this patch uses a DMI
> quirk table. A module parameter is exposed to allow setting this on other
> models for testing.
> 
> Signed-off-by: Arvid Norlander <lkml@vorpal.se>

Instead if adding a second dmi_system_id table please convert the existing one
into a generic quirk table. The idea is to make it look something like this:

#define QUIRK_TURN_ON_PANEL_ON_RESUME		BIT(0)
#define QUIRK_HCI_HOTKEY_QUICKSTART		BIT(1)

static const struct dmi_system_id toshiba_dmi_quirks[] = {
	{
	 /* Toshiba Portégé R700 */
	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
	 .matches = {
		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
		},
	 .driver_data = (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
	},
	{
	 /* Toshiba Satellite/Portégé R830 */
	 /* Portégé: https://bugs.freedesktop.org/show_bug.cgi?id=82634 */
	 /* Satellite: https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
	 .matches = {
		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
		},
	 .driver_data = (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
	},
	{
	 /* Toshiba Satellite/Portégé Z830 */
	 .matches = {
		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
		},
	 .driver_data = (void *)QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOTKEY_QUICKSTART,
	},
};

And then in toshiba_acpi_add() use:

	const struct dmi_system_id *dmi_id;
	long quirks = 0;

	dmi_id = dmi_first_match(toshiba_dmi_quirks);
	if (dmi_id)
		quirks = (long)dmi_id->driver_data;

	if (turn_on_panel_on_resume == -1)
		turn_on_panel_on_resume = !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUME);

	if (hci_hotkey_quickstart == -1)
		hci_hotkey_quickstart = !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);

This avoids duplicating the DMI match for the Z830 models and will also make it easier
to add more DMI based quirks in the future.

Regards,

Hans




> ---
>  drivers/platform/x86/toshiba_acpi.c | 31 ++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 9f1394b73895..dce1f5049bf8 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -58,6 +58,11 @@ module_param(turn_on_panel_on_resume, int, 0644);
>  MODULE_PARM_DESC(turn_on_panel_on_resume,
>  	"Call HCI_PANEL_POWER_ON on resume (-1 = auto, 0 = no, 1 = yes");
>  
> +static int hci_hotkey_quickstart = -1;
> +module_param(hci_hotkey_quickstart, int, 0644);
> +MODULE_PARM_DESC(hci_hotkey_quickstart,
> +	"Call HCI_HOTKEY_EVENT with value 0x5 for quickstart button support (-1 = auto, 0 = no, 1 = yes");
> +
>  #define TOSHIBA_WMI_EVENT_GUID "59142400-C6A3-40FA-BADB-8A2652834100"
>  
>  /* Scan code for Fn key on TOS1900 models */
> @@ -137,6 +142,7 @@ MODULE_PARM_DESC(turn_on_panel_on_resume,
>  #define HCI_ACCEL_MASK			0x7fff
>  #define HCI_ACCEL_DIRECTION_MASK	0x8000
>  #define HCI_HOTKEY_DISABLE		0x0b
> +#define HCI_HOTKEY_ENABLE_QUICKSTART	0x05
>  #define HCI_HOTKEY_ENABLE		0x09
>  #define HCI_HOTKEY_SPECIAL_FUNCTIONS	0x10
>  #define HCI_LCD_BRIGHTNESS_BITS		3
> @@ -2731,10 +2737,15 @@ static int toshiba_acpi_enable_hotkeys(struct toshiba_acpi_dev *dev)
>  		return -ENODEV;
>  
>  	/*
> +	 * Enable quickstart buttons if supported.
> +	 *
>  	 * Enable the "Special Functions" mode only if they are
>  	 * supported and if they are activated.
>  	 */
> -	if (dev->kbd_function_keys_supported && dev->special_functions)
> +	if (hci_hotkey_quickstart)
> +		result = hci_write(dev, HCI_HOTKEY_EVENT,
> +				   HCI_HOTKEY_ENABLE_QUICKSTART);
> +	else if (dev->kbd_function_keys_supported && dev->special_functions)
>  		result = hci_write(dev, HCI_HOTKEY_EVENT,
>  				   HCI_HOTKEY_SPECIAL_FUNCTIONS);
>  	else
> @@ -3287,6 +3298,21 @@ static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
>  	},
>  };
>  
> +/*
> + * Some Toshibas use "quickstart" keys. On these, HCI_HOTKEY_EVENT must use
> + * the value HCI_HOTKEY_ENABLE_QUICKSTART.
> + */
> +static const struct dmi_system_id hci_hotkey_quickstart_dmi_ids[] = {
> +	{
> +	 /* Toshiba Satellite/Portégé Z830 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
> +		},
> +	},
> +};
> +
> +
>  static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  {
>  	struct toshiba_acpi_dev *dev;
> @@ -3447,6 +3473,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	if (turn_on_panel_on_resume == -1)
>  		turn_on_panel_on_resume = dmi_check_system(turn_on_panel_on_resume_dmi_ids);
>  
> +	if (hci_hotkey_quickstart == -1)
> +		hci_hotkey_quickstart = dmi_check_system(hci_hotkey_quickstart_dmi_ids);
> +
>  	toshiba_wwan_available(dev);
>  	if (dev->wwan_supported)
>  		toshiba_acpi_setup_wwan_rfkill(dev);

