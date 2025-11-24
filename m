Return-Path: <linux-acpi+bounces-19205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F3C7FEFE
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 11:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB183A9BB7
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EEB2FABED;
	Mon, 24 Nov 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI+Vy+Hk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1162F9DB8
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980528; cv=none; b=HSCIyETLaEhClqS+FNSDTHKvR/seQjNt4HNst4q1J15eehIyT8Db7m6ayK/uyQRMteqRcIqCfBL1lwnaWkfrg4Q51nZ4MLncBXeE6HRXzpuiRoiFcP0aINaoxPE/74FBWYMnbrpJldE0ExRRaqot3rHqTJkkyFChiBQuHNsxzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980528; c=relaxed/simple;
	bh=MyhVfaLuUMB4FJ2DvvqxwnUvFdn4Yuvt+apgQWbex0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awNu4Yu61mmde9K5lRKi0JI92ZEvlO1CdmgVdTNyqYU9VOQPNjZjedeu1JKEZmbzrPNa9tAvmZTzoUqfPmcsdF2Hw1UzMY/ViAmw/DHFhnFQVE/4Zn2EuTZoGrGT9Kp7WaxOV+WuoOChm1iC+HZW3+LBNuVuZ6XlmUTnIBl8C/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YI+Vy+Hk; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5957e017378so4263534e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 02:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763980524; x=1764585324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvxeS/74nBAEFSf4nVKv65BSIxiE58qrGcTM82uuMOU=;
        b=YI+Vy+HkMgCzsalFj/mE79j6oTEfj2O9RGUd423tov5I76cD7A2zskvsyHRsVdoUIx
         B5cMlwgaxJ/TZwS8X8q+QuZYnO4i60BQHjlub1ORonH8fRD5NuNP+uPAd+GXofRL2q9P
         yZOmj3337NdRiMxuyRE2JPBjTq4L89pMMcAPoak1bgZk8Joi1hgNJc9nHdPyIU1knEiF
         zZW102rJnKBXBJHGTaBLJQFhUqAQ33hakKCa/DtFyoZs26dm0PgsxCFRY1p7mvvD5pX5
         ayL9GQbAb2gP151lsLcdY5QMIogz6EneD1+NbmzkMU4TPmbSAHnYKA0GTczpmWMBXycJ
         pY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980524; x=1764585324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvxeS/74nBAEFSf4nVKv65BSIxiE58qrGcTM82uuMOU=;
        b=YH72ahlFjfrnmzR1po4Xinj2VsZeQAksKMrsgcFnlj9HGEmYgBW8UFhmhw4sTRSkU7
         Uen7FgsPXp3kQfqKrIi3V8fiFAAXYhzVQNw5acHeOyLwADshHfujlG3z7F0Hiw6XDgIE
         ZJNVMV0luILmxHTL74p0+xddtZeqYOzcawG2W3BZ9O2oRJbcnMWdBTfBYr/qZoZW4l1g
         hM8tN/Ht3kSYGqHCp65kJJPIS6e3f5rSgPMueE0qMXeMSE35jW1bgyKcsR1vtBaoLh8k
         bJuY518brnTw6UK115QKiRYTi5Cu+/EhvdtT+dPVHJDAiwySGt85g0PsT72+dQUeZ/Kg
         B81w==
X-Forwarded-Encrypted: i=1; AJvYcCXcT0gcn3mHbn+DTsJdYyBzyXBU3zRRfLNbaIh4HyUU9NxdkHnGLJlo3gHgVQE59yxTYJcb52gEqTZ2@vger.kernel.org
X-Gm-Message-State: AOJu0YylMH7GxGor0fj1aEsj/F0Bww4iYC3fcsd6yv0JjKZatfQolnC6
	sBfwTxkPbDkwnlWCEIS7veVbJcTpSjHczzTxIRa82hjdPovzhW3m/pciz0VUWVtp
X-Gm-Gg: ASbGncuf/fvKQ2MzKOEELgdnsqwSGfYGvUR9LxQpKrzRp9ViIgfQcpwK96tOM6zdQSQ
	bba4ouPmUuNh5Uv/ymjCbImltisQT/k+nP1kAK5oeH5VfcWIymX5C2aIJhUpFRX3JD2orY0Tu2l
	ak8EbH/rIEqupDttdhN7wwDeWXrGHim4pxRYpZeMHxJbRL1r5awOrYx5MGWY72GVAQERxCwYpfV
	v2B/zUN0BGvJLccy+4SpYtGWR2zsw2raaYsY2p0vbLP/5AkinYQKQMH+qO9PiF2EhRs4lY7lQPe
	zCLADeFi6AxhwPIS8TJB/dpKVDSML4H3vJ3oEQ5ZqW4Zz87Y26iQXD7yilvbj6y6RKaiky6niUo
	lMUflOLgSnfVYBCzIpUtpCOhlf6/7KG5vLkM19whAODrpDtSXXXKAKCcDH57hCP1xpD+4/z8lUU
	1CJpuH7hkK1/l5J1DzocLHKzta
X-Google-Smtp-Source: AGHT+IGzb+yApYHtjewkoQzx7FPWIVvgfb9lCElhP6A4EWOQNvayCoMjjLyY5L5QUpilRr8Cj3haxw==
X-Received: by 2002:a05:6512:104a:b0:595:90ee:f476 with SMTP id 2adb3069b0e04-596a3edab46mr4292946e87.28.1763974136131;
        Mon, 24 Nov 2025 00:48:56 -0800 (PST)
Received: from [10.38.18.76] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbc5c5dsm4019850e87.79.2025.11.24.00.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 00:48:55 -0800 (PST)
Message-ID: <6ee209b3-4d7a-45a8-bd65-6a51730d458d@gmail.com>
Date: Mon, 24 Nov 2025 10:48:54 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Revert "treewide: Fix probing of devices in DT
 overlays"
To: Saravana Kannan <saravanak@google.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
 Len Brown <lenb@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: kernel-team@android.com, Wolfram Sang <wsa@kernel.org>,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-acpi@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>
References: <20240411235623.1260061-1-saravanak@google.com>
 <20240411235623.1260061-2-saravanak@google.com>
Content-Language: en-US
From: Kalle Niemi <kaleposti@gmail.com>
In-Reply-To: <20240411235623.1260061-2-saravanak@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 02:56, Saravana Kannan wrote:
> This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
> 
> While the commit fixed fw_devlink overlay handling for one case, it
> broke it for another case. So revert it and redo the fix in a separate
> patch.
> 
> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com/
> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>   drivers/bus/imx-weim.c    | 6 ------
>   drivers/i2c/i2c-core-of.c | 5 -----
>   drivers/of/dynamic.c      | 1 -
>   drivers/of/platform.c     | 5 -----
>   drivers/spi/spi.c         | 5 -----
>   5 files changed, 22 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 837bf9d51c6e..caaf887e0ccc 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -331,12 +331,6 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
>   				 "Failed to setup timing for '%pOF'\n", rd->dn);
>   
>   		if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
> -			/*
> -			 * Clear the flag before adding the device so that
> -			 * fw_devlink doesn't skip adding consumers to this
> -			 * device.
> -			 */
> -			rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>   			if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
>   				dev_err(&pdev->dev,
>   					"Failed to create child device '%pOF'\n",
> diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
> index a6c407d36800..a250921bbce0 100644
> --- a/drivers/i2c/i2c-core-of.c
> +++ b/drivers/i2c/i2c-core-of.c
> @@ -178,11 +178,6 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
>   			return NOTIFY_OK;
>   		}
>   
> -		/*
> -		 * Clear the flag before adding the device so that fw_devlink
> -		 * doesn't skip adding consumers to this device.
> -		 */
> -		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>   		client = of_i2c_register_device(adap, rd->dn);
>   		if (IS_ERR(client)) {
>   			dev_err(&adap->dev, "failed to create client for '%pOF'\n",
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 4d57a4e34105..19a1a38554f2 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -224,7 +224,6 @@ static void __of_attach_node(struct device_node *np)
>   	np->sibling = np->parent->child;
>   	np->parent->child = np;
>   	of_node_clear_flag(np, OF_DETACHED);
> -	np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
>   
>   	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>   
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 389d4ea6bfc1..efd861fa254f 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -743,11 +743,6 @@ static int of_platform_notify(struct notifier_block *nb,
>   		if (of_node_check_flag(rd->dn, OF_POPULATED))
>   			return NOTIFY_OK;
>   
> -		/*
> -		 * Clear the flag before adding the device so that fw_devlink
> -		 * doesn't skip adding consumers to this device.
> -		 */
> -		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>   		/* pdev_parent may be NULL when no bus platform device */
>   		pdev_parent = of_find_device_by_node(rd->dn->parent);
>   		pdev = of_platform_device_create(rd->dn, NULL,
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ff75838c1b5d..17cd417f7681 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4761,11 +4761,6 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
>   			return NOTIFY_OK;
>   		}
>   
> -		/*
> -		 * Clear the flag before adding the device so that fw_devlink
> -		 * doesn't skip adding consumers to this device.
> -		 */
> -		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>   		spi = of_register_spi_device(ctlr, rd->dn);
>   		put_device(&ctlr->dev);
>   
Hello,

Test system testing drivers for ROHM ICs bisected this commit to cause 
BD71847 drivers probe to not be called.

The devicetree blob overlay describing bd71847 enables I2C1 bus on 
BeagleBone Black aswell.

Probe is called when the driver is used with HW connected to I2C2 bus. 
I2C2 bus is enabled before overlaying devicetree blobs.


---- BD71847 Devicetree overlay source ----

/dts-v1/;
/plugin/;

/{ /* this is our device tree overlay root node */

	compatible = "ti,beaglebone", "ti,beaglebone-black";
	part-number = "BBB-I2C1";
  	version = "00A0";

	fragment@0 {
		target = <&am33xx_pinmux>; // this is a link to an already defined 
node in the device tree, so that node is overlayed with our modification

		__overlay__ {
			i2c1_pins: pinmux_i2c1_pins {
				pinctrl-single,pins = <
           			0x158 0x72 /* spi0_d1.i2c1_sda */
           			0x15C 0x72 /* spi0_cs0.i2c1_sdl */
         			>;
			};
		};
	};
....
....

	fragment@2 {
		target = <&i2c1>;

		__overlay__ {
			pinctrl-0 = <&i2c1_pins>;
			clock-frequency = <100000>;
			status = "okay";

			pmic: pmic@4b { /* the "test" defined as child of the i2c1 bus */
				compatible = "rohm,bd71847";
				reg = <0x4b>;
				....
				....
}; /* root node end */

---- END OF BD71847 Devicetree overlay source ----

Reverting this patch from linux-next from last friday fixes the issue.

BR
Kalle Niemi

