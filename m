Return-Path: <linux-acpi+bounces-652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BE57C98A9
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Oct 2023 12:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7DE1C208D4
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Oct 2023 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493C563BF
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Oct 2023 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdJCGD+k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06931878
	for <linux-acpi@vger.kernel.org>; Sun, 15 Oct 2023 09:15:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0749BDD
	for <linux-acpi@vger.kernel.org>; Sun, 15 Oct 2023 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697361353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6GHnZPE9tqaUE7IUXr8Kjm0FNAiXOJNmp9dZGcG/hI=;
	b=GdJCGD+k/LkThO7UafHpw8H2PeB871XsJE6NCgg/KKiupXdYSsLFGy59XPcTH5c97P0PSk
	CnNb2kLMjCp/06QX4iU9AE4HKlnRtRzeyU66ZCJA5UUzSWxa26NcbFSFRWaUyIDUF8ZPQ6
	XSENMD5yJrqdwnSR9wSaA+uRajueW3w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-L0kVjBQmNMSug47MeKorcA-1; Sun, 15 Oct 2023 05:15:50 -0400
X-MC-Unique: L0kVjBQmNMSug47MeKorcA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9be601277c2so73680766b.2
        for <linux-acpi@vger.kernel.org>; Sun, 15 Oct 2023 02:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697361349; x=1697966149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6GHnZPE9tqaUE7IUXr8Kjm0FNAiXOJNmp9dZGcG/hI=;
        b=Bwyuuy0HLCfp/4xfWIiI4IGABPdFmER8xiz1lKh4wvWAPJWzpwbRySLTrCXgrBjNGr
         jzfjsnYi8b9Af4wrmVAnCR7ZZSanhGK61/aQCO5shysPKoYlREeF6ill/UPJx1MaC+Ik
         nmBheZcKXx3jfTM9GdQhXbwWcVadFE9eHHfhQbJMIqdWFV74MfBsuweADZ4pcQ5p8zOI
         0Bvo8zu3uRn8NmtaQ5lDlzis8CV5tC8ni/25YnODGV+uFhctQJO/RufzfVFJQLCCQxKF
         Jpk4lXHgjn2RNH4vwLz/eVDu7WRip9cCcXVJnJ1gmdni8qKDn0oN7RcfRtQzM03umfb1
         uLhA==
X-Gm-Message-State: AOJu0YxqOiAQuns1S6WybFS7J2+U3FD7VtLtDTpX3U6wSRhFa0mmS4x+
	VRnxrKT4pxckZRFiBO5WzwYDtxS5pxhX2/+aohqccH0IcfpV3BWusz/8yUNLWebbQ+MJKi5Z47t
	PfdVpAPoQ6o4Qfwfz11wsVg==
X-Received: by 2002:a17:907:94cb:b0:9c3:8242:e665 with SMTP id dn11-20020a17090794cb00b009c38242e665mr621930ejc.8.1697361348992;
        Sun, 15 Oct 2023 02:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqiav65BAH59PFNrCGQmrRuqmpL/4GwmkL4TGEakPFwgpPBWODuKzPJ2GvjbRfyr0QlkIXpQ==
X-Received: by 2002:a17:907:94cb:b0:9c3:8242:e665 with SMTP id dn11-20020a17090794cb00b009c38242e665mr621916ejc.8.1697361348594;
        Sun, 15 Oct 2023 02:15:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ks18-20020a170906f85200b009a193a5acffsm2010141ejb.121.2023.10.15.02.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 02:15:47 -0700 (PDT)
Message-ID: <65cb8c8c-1a07-922b-db7a-dba54afc76b6@redhat.com>
Date: Sun, 15 Oct 2023 11:15:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] platform/x86: x86-android-tablets: Add audio codec
 info for Lenovo Yoga Tab 3 Pro YT3-X90F
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <20231014205314.59333-1-hdegoede@redhat.com>
 <20231014205314.59333-5-hdegoede@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231014205314.59333-5-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/14/23 22:53, Hans de Goede wrote:
> The SPI attached WM5102 codec on the Lenovo Yoga Tab 3 Pro YT3-X90F
> is not described in the ACPI tables.
> 
> Add info to instantiate the SPI device for the codec manually.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../platform/x86/x86-android-tablets/lenovo.c | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
> index 585f10a57810..d5d815940ce1 100644
> --- a/drivers/platform/x86/x86-android-tablets/lenovo.c
> +++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
> @@ -12,6 +12,8 @@
>  
>  #include <linux/efi.h>
>  #include <linux/gpio/machine.h>
> +#include <linux/mfd/arizona/pdata.h>
> +#include <linux/mfd/arizona/registers.h>
>  #include <linux/mfd/intel_soc_pmic.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/machine.h>
> @@ -677,6 +679,89 @@ static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
>  	}
>  };
>  
> +/*
> + * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
> + * Function A Play/Pause:           0 ohm
> + * Function D Voice assistant:    135 ohm
> + * Function B Volume Up           240 ohm
> + * Function C Volume Down         470 ohm
> + * Minimum Mic DC resistance     1000 ohm
> + * Minimum Ear speaker impedance   16 ohm
> + * Note the first max value below must be less then the min. speaker impedance,
> + * to allow CTIA/OMTP detection to work. The other max values are the closest
> + * value from extcon-arizona.c:arizona_micd_levels halfway 2 button resistances.
> + */
> +static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
> +	{ .max =  11, .key = KEY_PLAYPAUSE },
> +	{ .max = 186, .key = KEY_VOICECOMMAND },
> +	{ .max = 348, .key = KEY_VOLUMEUP },
> +	{ .max = 752, .key = KEY_VOLUMEDOWN },
> +};
> +
> +/* YT3 WM5102 arizona_micd_config comes from Android kernel sources */
> +static struct arizona_micd_config lenovo_yt3_wm5102_micd_config[]={
> +	{ 0, 1, 0 },
> +	{ ARIZONA_ACCDET_SRC, 2, 1 },
> +};
> +
> +static struct arizona_pdata lenovo_yt3_wm5102_pdata = {
> +	.irq_flags = IRQF_TRIGGER_LOW,
> +	.micd_detect_debounce = 200,
> +	.micd_ranges = arizona_micd_aosp_ranges,
> +	.num_micd_ranges = ARRAY_SIZE(arizona_micd_aosp_ranges),
> +	.hpdet_channel = ARIZONA_ACCDET_MODE_HPL,
> +
> +	/* Below settings come from Android kernel sources */
> +	.micd_bias_start_time = 1,
> +	.micd_rate = 6,
> +	.micd_force_micbias = 1,
> +	.micd_configs = lenovo_yt3_wm5102_micd_config,
> +	.num_micd_configs = ARRAY_SIZE(lenovo_yt3_wm5102_micd_config),
> +        .micbias={
> +           [0]={ /*MICBIAS1*/
> +                 .mV =2800 ,
> +                 .ext_cap=1,
> +                 .discharge =1 ,
> +                 .soft_start =0,
> +                 .bypass =0,
> +           },

Note I messed up the indentation here (spaces instead of tabs)
when copy pasting this from one terminal to another,
I'll go and fix this up locally.

Regards,

Hans




> +           [1]={ /*MICBIAS2*/
> +                 .mV =2800 ,
> +                 .ext_cap=1,
> +                 .discharge =1 ,
> +                 .soft_start =0,
> +                 .bypass =0,
> +           },
> +           [2]={ /*MICBIAS3*/
> +                 .mV =2800 ,
> +                 .ext_cap=1,
> +                 .discharge =1 ,
> +                 .soft_start =0,
> +                 .bypass =0,
> +           },
> +        },
> +};
> +
> +static const struct x86_spi_dev_info lenovo_yt3_spi_devs[] __initconst = {
> +	{
> +		/* WM5102 codec */
> +		.board_info = {
> +			.modalias = "wm5102",
> +			.platform_data = &lenovo_yt3_wm5102_pdata,
> +			.max_speed_hz = 5000000,
> +		},
> +		.ctrl_path = "\\_SB_.PCI0.SPI1",
> +		.irq_data = {
> +			.type = X86_ACPI_IRQ_TYPE_GPIOINT,
> +			.chip = "INT33FF:00",
> +			.index = 91,
> +			.trigger = ACPI_LEVEL_SENSITIVE,
> +			.polarity = ACPI_ACTIVE_LOW,
> +			.con_id = "wm5102_irq",
> +		},
> +	}
> +};
> +
>  static int __init lenovo_yt3_init(void)
>  {
>  	int ret;
> @@ -720,14 +805,28 @@ static struct gpiod_lookup_table lenovo_yt3_hideep_gpios = {
>  	},
>  };
>  
> +static struct gpiod_lookup_table lenovo_yt3_wm5102_gpios = {
> +	.dev_id = "spi1.0",
> +	.table = {
> +		GPIO_LOOKUP("INT33FF:00", 75, "wlf,spkvdd-ena", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("INT33FF:00", 81, "wlf,ldoena", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("INT33FF:00", 82, "reset", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("arizona", 2, "wlf,micd-pol", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
>  static struct gpiod_lookup_table * const lenovo_yt3_gpios[] = {
>  	&lenovo_yt3_hideep_gpios,
> +	&lenovo_yt3_wm5102_gpios,
>  	NULL
>  };
>  
>  const struct x86_dev_info lenovo_yt3_info __initconst = {
>  	.i2c_client_info = lenovo_yt3_i2c_clients,
>  	.i2c_client_count = ARRAY_SIZE(lenovo_yt3_i2c_clients),
> +	.spi_dev_info = lenovo_yt3_spi_devs,
> +	.spi_dev_count = ARRAY_SIZE(lenovo_yt3_spi_devs),
>  	.gpiod_lookup_tables = lenovo_yt3_gpios,
>  	.init = lenovo_yt3_init,
>  };


