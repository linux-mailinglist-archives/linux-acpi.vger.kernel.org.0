Return-Path: <linux-acpi+bounces-19230-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B67C83836
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 07:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DABD94E4FE7
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 06:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F6629BDB5;
	Tue, 25 Nov 2025 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXM4Oi51"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C5292B54
	for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764052979; cv=none; b=V6OSh4m/jrLBDjMEz//pL37xjzpYx0HG63NMBSaOYnqtZ772x5d30dRYCupN+z2p5kkOG7iYt8xa4NXdiAT9yNutCVyn7yxLZN66POJ52TW5vbRFDZhhGMekS3JzyL7Rg4s+pqmqNPKnv38zjQsMrNczLiKVMLjl3irp2FaU3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764052979; c=relaxed/simple;
	bh=bMVM6nwiRnBB3ygequtCXeKaSYZ8JKMr74Alu8bdTfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/2zg+mKFIKszBo3EOBmZnU0T9573NQKBfXeHInT/AIXOygtyMGJf6GHpKtgT4K3YeA58exDAl6tR+zj1o6MmNbqfcMIjNGYKsE+cUfANk+R4buXjtq4+SlF/hoJ55EEhIhqHCsFIscfYzmySX/BGvpcrmrTfFQVi2wyZQGZIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXM4Oi51; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37bbb36c990so50373061fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 22:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764052975; x=1764657775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDwgPrbqR3WPQpKO2RN5Ep6D/2LO+UnqChlfZRK6eKg=;
        b=PXM4Oi51/FPSyFM+6n3W1MkZ8lRcQmQDf5xTo4W0x/8klPd2i17BG+PpU/k99qVrEd
         8FhrIhgvL/oMBEixwIderB1Ww0ZYJApyL96SU76Usb+75ViTYcgBbNIJmkdB2sqglt39
         EHyCtOP7rzTY2LMk/dKOF1maizgzB3exwy6gBuLAE/kfnFoF1jwJzDmiGDfDXLV4J1hr
         fHJIyFU4x2tpUq0fiJRIhox+RXrqjVWTwCFxxGlJtK13wa3x8sCRrXjhS17HwHoQn1a3
         abGsydVqkqA5KRHnBiiW/E6itTeHdADHv/d7USbpF/FQoDWy/pxy9oSZYL14nXXU1RoR
         xnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764052975; x=1764657775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDwgPrbqR3WPQpKO2RN5Ep6D/2LO+UnqChlfZRK6eKg=;
        b=ulB4Aul42fsbv6V3KDOpD/R0vSwxpcqdYzOCtuQT2kZprpjy2MvMCUTBWraCYfSrh8
         20hb/vEXDyxqETh72yy6NyZYkKf5IstAywlxqSl7l1nUKBajdw7PC8CQSCf3cIV3Mo4I
         IqC6Bldro8UF8FmRWt1VHZzZWooBrsLiJXadCNjgArXONrmQmNEiiueUeZR68dJ6l4HY
         +f2zTJZ0NPkA3bMeSmE2gQJZaiTN48jh3g8Vba6v5usR6Mi/bHl7CS/09wHvCOuvHoBm
         4dmJ60i1ULKvf7GKtWwo4/ukmbg7NLapgqTzbF975ORCu6GPd2SVjJXI2fWANhzMR6Wa
         jcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOyIqAVO8WjXeCH1V4jdP2hRTLB1kIdbBpqGf6IskWuX3xNZ6LcsfKfQ9XNAUOHOJxuKZGPps7Yczs@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmRNq6eLdxqcrrTdadkiDyYnx7PkStnAoP1FgCVvqeSowX8Nq
	oqgrQwXbOKLdPnqVKxeVJXx42Zoj1CwUiiONnrkO3snZNP5ob4q6278W
X-Gm-Gg: ASbGncs+BHpv8rTYZx8656Gud7FGpZL2dtK4NUhjUzCm4nPKEYaY+kuQhh+Sk5JvGYO
	U8/fhkH6+kOPDMFL8RVkt30TkXl0eMAUm9j+SJEm0Y1OGVU+rNLLkx7DbdDy85pDHBLN61aGufO
	icjD4VmGT43Fop7VyuG6Y0NlXBQtoAgNF7jtDhaKc8PUOrzvtlKQN/BInh7Etk850cw/I4I/h1E
	oQoCF0UJ09CKKzWcgYbU+M6Y5FERoKXIJ1hwq/Hd4TpzzN6Syswe3MDCYAxf677qEM6NVpCzDEt
	j6tt5C8CWAe1pPuTE1CPRcxG7NHfYMQT7eEw/7XBZTInnEiH2PlixucJTQs6CRzzUAHauL8DBVI
	OHaj2v5dirZY6LVhWmVwWpP5bwS8lPTsFZS8YtjkIaeiAVpA0EXb0XGnHQvsBgJfmed5eGrJxum
	97RHGirtSBLK+d5i79bRxf3hY5tnHjB1heIeLl1xIrWYh9QcSf7ijdO7L0D7rJtCGIAZSC
X-Google-Smtp-Source: AGHT+IGn4O/LdPwrRfIUFu/wkzsPRHVD6YOLdNx92wJy+rnsWi85zUpEuMS1eU2wO8cl4kItz2sVag==
X-Received: by 2002:a2e:a805:0:b0:37a:3910:6c77 with SMTP id 38308e7fff4ca-37cc82af4a6mr55071391fa.5.1764052974535;
        Mon, 24 Nov 2025 22:42:54 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b59ff5sm31356131fa.15.2025.11.24.22.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 22:42:53 -0800 (PST)
Message-ID: <072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com>
Date: Tue, 25 Nov 2025 08:42:50 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT
 overlays"
To: Rob Herring <robh@kernel.org>, Kalle Niemi <kaleposti@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
 <20251015071420.1173068-2-herve.codina@bootlin.com>
 <f74ab0a2-b74b-4b96-8469-a716c850e230@gmail.com>
 <CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com>
 <5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com>
 <CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/11/2025 19:01, Rob Herring wrote:
> On Mon, Nov 24, 2025 at 10:44 AM Kalle Niemi <kaleposti@gmail.com> wrote:
>>
>>
>> On 11/24/25 16:53, Rob Herring wrote:
>>> On Mon, Nov 24, 2025 at 8:48 AM Kalle Niemi <kaleposti@gmail.com> wrote:
>>>> On 10/15/25 10:13, Herve Codina wrote:
>>>>> From: Saravana Kannan <saravanak@google.com>
>>>>>
>>>>> This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
>>>>>
>>>>> While the commit fixed fw_devlink overlay handling for one case, it
>>>>> broke it for another case. So revert it and redo the fix in a separate
>>>>> patch.
>>>>>
>>>>> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
>>>>> Reported-by: Herve Codina <herve.codina@bootlin.com>
>>>>> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com/
>>>>> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
>>>>> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>> Link: https://lore.kernel.org/lkml/20240411235623.1260061-2-saravanak@google.com/
>>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>>>> Acked-by: Mark Brown <broonie@kernel.org>
>>>>> ---
>>>>>     drivers/bus/imx-weim.c    | 6 ------
>>>>>     drivers/i2c/i2c-core-of.c | 5 -----
>>>>>     drivers/of/dynamic.c      | 1 -
>>>>>     drivers/of/platform.c     | 5 -----
>>>>>     drivers/spi/spi.c         | 5 -----
>>>>>     5 files changed, 22 deletions(-)
>>>>>
>>>>> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
>>>>> index 83d623d97f5f..87070155b057 100644
>>>>> --- a/drivers/bus/imx-weim.c
>>>>> +++ b/drivers/bus/imx-weim.c
>>>>> @@ -327,12 +327,6 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
>>>>>                                  "Failed to setup timing for '%pOF'\n", rd->dn);
>>>>>
>>>>>                 if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
>>>>> -                     /*
>>>>> -                      * Clear the flag before adding the device so that
>>>>> -                      * fw_devlink doesn't skip adding consumers to this
>>>>> -                      * device.
>>>>> -                      */
>>>>> -                     rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>>>                         if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
>>>>>                                 dev_err(&pdev->dev,
>>>>>                                         "Failed to create child device '%pOF'\n",
>>>>> diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
>>>>> index eb7fb202355f..30b48a428c0b 100644
>>>>> --- a/drivers/i2c/i2c-core-of.c
>>>>> +++ b/drivers/i2c/i2c-core-of.c
>>>>> @@ -176,11 +176,6 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
>>>>>                         return NOTIFY_OK;
>>>>>                 }
>>>>>
>>>>> -             /*
>>>>> -              * Clear the flag before adding the device so that fw_devlink
>>>>> -              * doesn't skip adding consumers to this device.
>>>>> -              */
>>>>> -             rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>>>                 client = of_i2c_register_device(adap, rd->dn);
>>>>>                 if (IS_ERR(client)) {
>>>>>                         dev_err(&adap->dev, "failed to create client for '%pOF'\n",
>>>>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>>>>> index 2eaaddcb0ec4..b5be7484fb36 100644
>>>>> --- a/drivers/of/dynamic.c
>>>>> +++ b/drivers/of/dynamic.c
>>>>> @@ -225,7 +225,6 @@ static void __of_attach_node(struct device_node *np)
>>>>>         np->sibling = np->parent->child;
>>>>>         np->parent->child = np;
>>>>>         of_node_clear_flag(np, OF_DETACHED);
>>>>> -     np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
>>>>>
>>>>>         raw_spin_unlock_irqrestore(&devtree_lock, flags);
>>>>>
>>>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>>>> index f77cb19973a5..ef9445ba168b 100644
>>>>> --- a/drivers/of/platform.c
>>>>> +++ b/drivers/of/platform.c
>>>>> @@ -739,11 +739,6 @@ static int of_platform_notify(struct notifier_block *nb,
>>>>>                 if (of_node_check_flag(rd->dn, OF_POPULATED))
>>>>>                         return NOTIFY_OK;
>>>>>
>>>>> -             /*
>>>>> -              * Clear the flag before adding the device so that fw_devlink
>>>>> -              * doesn't skip adding consumers to this device.
>>>>> -              */
>>>>> -             rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>>>                 /* pdev_parent may be NULL when no bus platform device */
>>>>>                 pdev_parent = of_find_device_by_node(parent);
>>>>>                 pdev = of_platform_device_create(rd->dn, NULL,
>>>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>>>> index 2e0647a06890..b22944a207c9 100644
>>>>> --- a/drivers/spi/spi.c
>>>>> +++ b/drivers/spi/spi.c
>>>>> @@ -4791,11 +4791,6 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
>>>>>                         return NOTIFY_OK;
>>>>>                 }
>>>>>
>>>>> -             /*
>>>>> -              * Clear the flag before adding the device so that fw_devlink
>>>>> -              * doesn't skip adding consumers to this device.
>>>>> -              */
>>>>> -             rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>>>                 spi = of_register_spi_device(ctlr, rd->dn);
>>>>>                 put_device(&ctlr->dev);
>>>>>
>>>> Sorry, some of you will receive this message now for second time. First
>>>> message was sent to older series of patches.
>>>> -
>>>>
>>>> Hello,
>>>>
>>>> Test system testing drivers for ROHM ICs bisected this commit to cause
>>>> BD71847 drivers probe to not be called.
>>> This driver (and overlay support) is in linux-next or something out of
>>> tree on top of linux-next?
>>>
>>> Rob
>>
>> Yes the driver is in mainline linux: /drivers/mfd/rohm-bd718x7.c
> 
> I don't see any support to apply overlays in that driver.

Ah. Sorry for the confusion peeps. I asked Kalle to report this without 
proper consideration. 100% my bad.

While the bd718x7 drive indeed is mainline (and tested), the actual 
'glue-code' doing the overlay is part of the downstream test 
infrastructure. So yes, this is not a bug in upstream kernel - this 
falls in the category of an upstream change causing downstream things to 
break. So, feel free to say: "Go fix your code" :)

Now that this is sorted, if someone is still interested in helping us to 
get our upstream drivers tested - the downstream piece is just taking 
the compiled device-tree overlay at runtime (via bin-attribute file), 
and applying it using the of_overlay_fdt_apply(). The approach is 
working for our testing purposes when the device is added to I2C/SPI 
node which is already enabled. However, in case where we have the I2C 
disabled, and enable it in the same overlay where we add the new device 
- then the new device does not get probed.

I would be really grateful if someone had a pointer for us.

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

