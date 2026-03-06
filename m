Return-Path: <linux-acpi+bounces-21466-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP7sJ9QjqmkOMAEAu9opvQ
	(envelope-from <linux-acpi+bounces-21466-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 01:46:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D4219F30
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 01:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D98B303FDCA
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 00:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC91E0DE8;
	Fri,  6 Mar 2026 00:45:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E12E11C7
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757903; cv=none; b=Wu3VpgxHV3HHhqXCiQ/rLqwWU3+vDvDd3VcdASyhXv8oUx56BVRQhoA8ddwLAWaWQ8sXJ4PWjsqPdltp/QnwqpYPRJtwYTEKp4egH0drmknpZxxMMFKtcjfLyXxn8dmwKMCdK7oEy2hXDgkYi9qLu7Sek7iTlcQStMXmHAYXNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757903; c=relaxed/simple;
	bh=G9zzbkUUMAkORAuT7yKEFCmmFIF56otd76cutMRNMYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJCjUBlVOaDEwRDAGd61kMkj1mbFVusvhS/GxLw1vn8f3Jm1qOmEIMonQdXlgXCKbBiO+a9NE9gGt5QgNXsEdGj31+eOI5ngh9EutSFIJPkzOZ7rTrPI4S2QUlIRuRhe4gtDRucII0qqHSWu3Mt5tDZp5p3kTMJW9x5CgnlkTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab39b111b9so40733415ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 16:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757900; x=1773362700;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBIID2C3tYCLC3ROIp9HZ27Vwpuc9s7YKBLnBBIirXY=;
        b=TP4EM+9igW/XVnBmFo4GwMrtArBflUH/g4R+7YuUy/Pbrk/jruLIuypKu3KbvpgI+G
         McRJZM5zjH/5KzzRPFjsY+3yM9hqvsdWDNsu7SVoMN/1K2fhHX+Hs2xUeDMQ0lu7G41f
         3P4dwp/A1arc/TmnmZ4JF1f2Gp8+5OxQyB90UZ073nXb0mAVJbGZZ+KU61YNU7UeSlsR
         e/VFdBU0PumIHvrjOK2ZOHnEb3897Zf65+QGe74a7S4vzWKWcLqxduaLIuZt2Tm++F/a
         LdxTGbJ7BhbIGChlOMrQL9LaAAyZIZvq5Jdtv0W1cwPhelxBIMFyuUp8pyUcxjLQ5Y23
         Mj3A==
X-Forwarded-Encrypted: i=1; AJvYcCXWCqqFktlrH1QM+eD6gZL82NiKwL9ABV2ynA0W8JF8RZNuedSH5lgXQF6ocNiv6xBHl/ik4B5Mloyw@vger.kernel.org
X-Gm-Message-State: AOJu0YyyS8+ZQ+j8myxqhc+JNesOqq+smUMUUWmbEwKDPTdCuvP0sDd+
	UfbZb/aHGfmfDCnefwa2+sTxFXs7C1ti6bD58rKYCgm0TypTzSxUZtcYJnYdYq8278E=
X-Gm-Gg: ATEYQzxk97VoiF0UrEWt9ugdE0jQ/Cp/h0OCVrG8HglaCbx1H31Si69rHRxzbTcXrON
	RH0jbaPAvRkcpN4vdIy75jZhQGIe9PetNLjxnzFWPxGP/Gq/U6gV+SbBT2OoZY22QYl4gx//4QX
	9Cw9ZIWnJo2jwyW08qSeI1esuOnFA2KMZ7J0yiUJ1i5Wd75/ONKCuR7bh63PT55iohFET7ja/pt
	zGyAoI7wCI71mIbzo2dS4fJ/m7m5sKux94QCvHPh8oc0p642ttjtMHF6q/6cFzuGc0fEPXYN28l
	Q8TJ6Gqjd8Swwln7M9fQx4GjLqwVfHTMRzJjAaW9fJHjMmAq867U+Gkoat6YVtGhHGt4uAQ06fK
	hB8adSKMIb652xaMrSs1QOicOt9ViKFM1GYw5WFVEDsFm31IFfEEiNeKPa7fJ4MVz284nfJ5sNS
	2p02oIXIeb3pZiEYPBNCON
X-Received: by 2002:a17:903:18d:b0:2ae:5eee:7a5 with SMTP id d9443c01a7336-2ae8241df4emr3858265ad.12.1772757900350;
        Thu, 05 Mar 2026 16:45:00 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm180143885ad.44.2026.03.05.16.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:44:59 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Frank Rowand
 <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony
 Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-doc@vger.kernel.org, brgl@kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] ARM: omap1: ams-delta: convert GPIO hogs to using
 firmware nodes
In-Reply-To: <20260305-gpio-hog-fwnode-v1-4-97d7df6bbd17@oss.qualcomm.com>
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
 <20260305-gpio-hog-fwnode-v1-4-97d7df6bbd17@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 16:44:59 -0800
Message-ID: <7hy0k5okfo.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 026D4219F30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21466-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_NEQ_ENVFROM(0.00)[khilman@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,baylibre.com:mid,baylibre.com:email]
X-Rspamd-Action: no action

Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com> writes:

> Setup a software node hierarchy for the latch2 GPIO controller defining
> the required hog and stop using legacy machine hog API.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  arch/arm/mach-omap1/board-ams-delta.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 16392720296cd224732450c85419c35bbab506f6..1bec4fa0bd5e8bfc58103d1f24b22176707fd26f 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -556,10 +556,30 @@ static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
>  	&ams_delta_nand_gpio_table,
>  };
>  
> -static struct gpiod_hog ams_delta_gpio_hogs[] = {
> -	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT, "keybrd_dataout",
> -		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
> -	{},
> +static const struct software_node latch2_gpio_swnode = {
> +	.name = LATCH2_LABEL,
> +};
> +
> +static const u32 latch2_hog_gpios[] = { LATCH2_PIN_KEYBRD_DATAOUT, 0 };
> +
> +static const struct property_entry latch2_gpio_hog_props[] = {
> +	PROPERTY_ENTRY_BOOL("gpio-hog"),
> +	PROPERTY_ENTRY_U32_ARRAY("gpios", latch2_hog_gpios),
> +	PROPERTY_ENTRY_STRING("line-name", "keybrd_dataout"),
> +	PROPERTY_ENTRY_BOOL("output-low"),
> +	{ }
> +};
> +
> +static const struct software_node latch2_gpio_hog_swnode = {
> +	.parent = &latch2_gpio_swnode,
> +	.name = "latch2-hog",
> +	.properties = latch2_gpio_hog_props,
> +};
> +
> +static const struct software_node *const latch2_gpio_swnodes[] = {
> +	&latch2_gpio_swnode,
> +	&latch2_gpio_hog_swnode,
> +	NULL
>  };
>  
>  static struct plat_serial8250_port ams_delta_modem_ports[];
> @@ -684,7 +704,6 @@ static void __init ams_delta_init(void)
>  
>  	omap_gpio_deps_init();
>  	ams_delta_latch2_init();
> -	gpiod_add_hogs(ams_delta_gpio_hogs);
>  
>  	omap_serial_init();
>  	omap_register_i2c_bus(1, 100, NULL, 0);
> @@ -693,6 +712,9 @@ static void __init ams_delta_init(void)
>  	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
>  
>  	platform_device_register_full(&latch1_gpio_devinfo);
> +
> +	software_node_register_node_group(latch2_gpio_swnodes);
> +	latch2_gpio_devinfo.fwnode = software_node_fwnode(&latch2_gpio_swnode);
>  	platform_device_register_full(&latch2_gpio_devinfo);
>  
>  	/*
>
> -- 
> 2.47.3

