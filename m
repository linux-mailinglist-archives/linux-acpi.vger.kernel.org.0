Return-Path: <linux-acpi+bounces-19349-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEE3C919D4
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 11:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB75B3ABB55
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F352D30BF78;
	Fri, 28 Nov 2025 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuPrq8pB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36EC30C36E
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325545; cv=none; b=SVnjVXEdH16p7I71hCnbpZbel39GuiW5rU3JyG4YpAyNCHr5QOmj5Wg3VjnYYj3XaTXFO9/vZ1NhYuq7dX/nILGrnUr2NhNOwqpbH4Jui0dlVkI/MNjyi2FxH/5VB8t/R5e83dqooJUXd7AsN+SY2rPaPlbiZga363JiMUIUX40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325545; c=relaxed/simple;
	bh=TaRZM71/5VBjSq639Phe6Hwz5f1btLjNNYEyAwc/qwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/CvSftlE5xt0oZLAJZ9HAvoVklv3Yo+Ouhu7qt8851s+jp3jhkr4VdTp3osZ7+PVagAAxHfczTksdjARJXsBpbHqNLtkrxR10VDts1guc5i0TYjhuPFlq2eFyKC7ih0MCAOtlRmdlJwYIOF14wH9y1sSvGQ9oZHCLkvzBz6dDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuPrq8pB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so3031471a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 02:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764325542; x=1764930342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uX5AKFlE3KaTGTC6lsIDfjTJSY5MRYErJSJUEI7kZs=;
        b=BuPrq8pBFf1k6B8wBpvhWITAWzxGJYZnR9X3vEZpKuCaMu1jStKZERjzemG2qFuNTo
         fCSk6M6z78KtgVKtKNWUDFTaQ1ZClPmXXGO3XKhbevTPq79cW6LgPUYRNn3vYeSatN1g
         mBozMGs3e65YzCn4i6L3YIxc49SC5/neYIEmssqR9pzLDK4in5RjhSAXo6mj2iWiThYa
         oInmgx5lILeKLh82RUquxlD8PCxGOGw3+WMpv/iqw657sHy5ifO9YBLpC7m+DvKRCYH+
         bMIEcrU8Gr71ORKtMGKOyyfoZTXnM9J+6LtNhEe6A9grH0tFEfTqOZjXkT6xSvwIFL2W
         fMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764325542; x=1764930342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uX5AKFlE3KaTGTC6lsIDfjTJSY5MRYErJSJUEI7kZs=;
        b=WyRoP/mrWDl4wGAFAs1bQ/gvkde9Z0lIfX6GuUDXE5yF9aO++G50rgsvt6a/Oyi6mq
         5G0eLzHyIlo+Vy2JZTJim1LY99NF9LViBdX/XKy32Abomq94azJZvlRIY74bklyYB1o9
         Uo79tgLcUS2I6MeB4uY8STPmABdObzLqaaJFJlU5VjwR6j7BOcet9hpJgEe1Ka7zQKlI
         GAmM2PSrqsGOSzVtRnDdgrIGMlU/Ap5obQWugafMDc6J6g/XxubOT7feRxl9mcLP91Ol
         D7Oqpip8gZZ1gBELgk2qr8gvN8kz1oxGmAu8ylCAYJ783jW73Hqmk+nAGxmnrgUnKfAI
         HJGA==
X-Forwarded-Encrypted: i=1; AJvYcCW0nOnIfI2JQid9nFC1wrOqG/KpA096reQ2HMIyWZDV65gcJwe9NRcqVueoyLsDPGk+Hhk2wJSZZ87g@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Fz2kwJX9uMNDL43j3HWgpziuK2zQ+KaXpDKm6FNfVed996tr
	yw3pLxodQ7UbhtUeu2GuH2Jwam8XhBRAMuA9ZLx1/mYBn6j7wEnnlO5YN8DphHjg
X-Gm-Gg: ASbGnct95UQLG5WbmOLelir+Jrf0dTdRQrHnmpLmeaCZ4sVIvSrnORiy9w7eyHnHGYi
	6tocdibmaism9s6J9nS2PDAE0ZWm4OMRTcSewyAnf/fFkLo44sSY5DWTrwNR/NP0z8ahhxnyIOP
	J5MTwNlJWkx/jdSDxRE51HyyqpqwRNFc/gG3VnbJPhSjxYdE9W/zvY5/pbLuENPuGzXXwtNtlY4
	Q0OZxp5Lm6UasJrXV7tSZOhfcriPW9t2kq48hJiN/JOngulGyO1/BtoThHvEi7TFLm/g9BSkQeK
	PgyemPDP0RhNxGt2DngOsXY5djNPJ4IArNQ/d0opaoFWoCMUdEYleR67pTXJKW0IRYOTE5p/iTo
	KB6TvVl6Pf9YNxbbsZlFLRwCskEXtOC+ZOnOjJj1QGqjOmClfpjoLzj26zZc1e6fHJV9iZyoE7F
	ySQu4dkdDjHWJMPiSdIlC/iqeXRGLDJ+D8Tj7LC/MWwySNqom1azH31aj9wgtUZnc=
X-Google-Smtp-Source: AGHT+IEGkgK12Pivg49NR/ZOgpbdU3G5UdskYoGlRBNhkhTeK8ns6GTXdVkYN5ONzey9AOU/AvVmTQ==
X-Received: by 2002:a05:6512:10cd:b0:595:80d2:cfdf with SMTP id 2adb3069b0e04-596a3e98385mr9843309e87.6.1764318899877;
        Fri, 28 Nov 2025 00:34:59 -0800 (PST)
Received: from ?IPV6:2001:14ba:437:c00::198? (2001-14ba-437-c00--198.rev.dnainternet.fi. [2001:14ba:437:c00::198])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa48aaasm1029238e87.71.2025.11.28.00.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 00:34:59 -0800 (PST)
Message-ID: <55076f4b-d523-4f8c-8bd4-0645b790737e@gmail.com>
Date: Fri, 28 Nov 2025 10:34:57 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT
 overlays"
To: Rob Herring <robh@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>
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
 <072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com>
 <CAL_JsqKyG98pXGKpL=gxSc92izpzN7YCdq62ZJByhE6aFYs1fw@mail.gmail.com>
Content-Language: en-US
From: Kalle Niemi <kaleposti@gmail.com>
In-Reply-To: <CAL_JsqKyG98pXGKpL=gxSc92izpzN7YCdq62ZJByhE6aFYs1fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/27/25 03:54, Rob Herring wrote:
> On Tue, Nov 25, 2025 at 12:43 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>> On 24/11/2025 19:01, Rob Herring wrote:
>>> On Mon, Nov 24, 2025 at 10:44 AM Kalle Niemi <kaleposti@gmail.com> wrote:
>>>>
>>>> On 11/24/25 16:53, Rob Herring wrote:
>>>>> On Mon, Nov 24, 2025 at 8:48 AM Kalle Niemi <kaleposti@gmail.com> wrote:
>>>>>> On 10/15/25 10:13, Herve Codina wrote:
>>>>>>> From: Saravana Kannan <saravanak@google.com>
>>>>>>>
>>>>>>> This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
>>>>>>>
>>>>>>> While the commit fixed fw_devlink overlay handling for one case, it
>>>>>>> broke it for another case. So revert it and redo the fix in a separate
>>>>>>> patch.
>>>>>>>
>>>>>>> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
>>>>>>> Reported-by: Herve Codina <herve.codina@bootlin.com>
>>>>>>> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com/
>>>>>>> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
>>>>>>> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
>>>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>>>> Link: https://lore.kernel.org/lkml/20240411235623.1260061-2-saravanak@google.com/
>>>>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>>>>>> Acked-by: Mark Brown <broonie@kernel.org>
>>>>>>> ---
>>>>>>>      drivers/bus/imx-weim.c    | 6 ------
>>>>>>>      drivers/i2c/i2c-core-of.c | 5 -----
>>>>>>>      drivers/of/dynamic.c      | 1 -
>>>>>>>      drivers/of/platform.c     | 5 -----
>>>>>>>      drivers/spi/spi.c         | 5 -----
>>>>>>>      5 files changed, 22 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
>>>>>>> index 83d623d97f5f..87070155b057 100644
>>>>>>> --- a/drivers/bus/imx-weim.c
>>>>>>> +++ b/drivers/bus/imx-weim.c
>>>>>>> @@ -327,12 +327,6 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
>>>>>>>                                   "Failed to setup timing for '%pOF'\n", rd->dn);
>>>>>>>
>>>>>>>                  if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
>>>>>>> -                     /*
>>>>>>> -                      * Clear the flag before adding the device so that
>>>>>>> -                      * fw_devlink doesn't skip adding consumers to this
>>>>>>> -                      * device.
>>>>>>> -                      */
>>>>>>> -                     rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>>>>>                          if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
>>>>>>>                                  dev_err(&pdev->dev,
>>>>>>>                                          "Failed to create child device '%pOF'\n",
>>>>>>> diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
>>>>>>> index eb7fb202355f..30b48a428c0b 100644
>>>>>>> --- a/drivers/i2c/i2c-core-of.c
>>>>>>> +++ b/drivers/i2c/i2c-core-of.c
>>>>>>> @@ -176,11 +176,6 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
>>>>>>>                          return NOTIFY_OK;
>>>>>>>                  }
>>>>>>>
>>>>>>> -             /*
>>>>>>> -              * Clear the flag before adding the device so that fw_devlink
>>>>>>> -              * doesn't skip adding consumers to this device.
>>>>>>> -              */
>>>>>>> -             rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>>>>>                  client = of_i2c_register_device(adap, rd->dn);
>>>>>>>                  if (IS_ERR(client)) {
>>>>>>>                          dev_err(&adap->dev, "failed to create client for '%pOF'\n",
>>>>>>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>>>>>>> index 2eaaddcb0ec4..b5be7484fb36 100644
>>>>>>> --- a/drivers/of/dynamic.c
>>>>>>> +++ b/drivers/of/dynamic.c
>>>>>>> @@ -225,7 +225,6 @@ static void __of_attach_node(struct device_node *np)
>>>>>>>          np->sibling = np->parent->child;
>>>>>>>          np->parent->child = np;
>>>>>>>          of_node_clear_flag(np, OF_DETACHED);
>>>>>>> -     np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
>>>>>>>
>>>>>>>          raw_spin_unlock_irqrestore(&devtree_lock, flags);
>>>>>>>
>>>>>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>>>>>> index f77cb19973a5..ef9445ba168b 100644
>>>>>>> --- a/drivers/of/platform.c
>>>>>>> +++ b/drivers/of/platform.c
>>>>>>> @@ -739,11 +739,6 @@ static int of_platform_notify(struct notifier_block *nb,
>>>>>>>                  if (of_node_check_flag(rd->dn, OF_POPULATED))
>>>>>>>                          return NOTIFY_OK;
>>>>>>>
>>>>>>> -             /*
>>>>>>> -              * Clear the flag before adding the device so that fw_devlink
>>>>>>> -              * doesn't skip adding consumers to this device.
>>>>>>> -              */
>>>>>>> -             rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>>>>>                  /* pdev_parent may be NULL when no bus platform device */
>>>>>>>                  pdev_parent = of_find_device_by_node(parent);
>>>>>>>                  pdev = of_platform_device_create(rd->dn, NULL,
>>>>>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>>>>>> index 2e0647a06890..b22944a207c9 100644
>>>>>>> --- a/drivers/spi/spi.c
>>>>>>> +++ b/drivers/spi/spi.c
>>>>>>> @@ -4791,11 +4791,6 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
>>>>>>>                          return NOTIFY_OK;
>>>>>>>                  }
>>>>>>>
>>>>>>> -             /*
>>>>>>> -              * Clear the flag before adding the device so that fw_devlink
>>>>>>> -              * doesn't skip adding consumers to this device.
>>>>>>> -              */
>>>>>>> -             rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>>>>>                  spi = of_register_spi_device(ctlr, rd->dn);
>>>>>>>                  put_device(&ctlr->dev);
>>>>>>>
>>>>>> Sorry, some of you will receive this message now for second time. First
>>>>>> message was sent to older series of patches.
>>>>>> -
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> Test system testing drivers for ROHM ICs bisected this commit to cause
>>>>>> BD71847 drivers probe to not be called.
>>>>> This driver (and overlay support) is in linux-next or something out of
>>>>> tree on top of linux-next?
>>>>>
>>>>> Rob
>>>> Yes the driver is in mainline linux: /drivers/mfd/rohm-bd718x7.c
>>> I don't see any support to apply overlays in that driver.
>> Ah. Sorry for the confusion peeps. I asked Kalle to report this without
>> proper consideration. 100% my bad.
>>
>> While the bd718x7 drive indeed is mainline (and tested), the actual
>> 'glue-code' doing the overlay is part of the downstream test
>> infrastructure. So yes, this is not a bug in upstream kernel - this
>> falls in the category of an upstream change causing downstream things to
>> break. So, feel free to say: "Go fix your code" :)
>>
>> Now that this is sorted, if someone is still interested in helping us to
>> get our upstream drivers tested - the downstream piece is just taking
>> the compiled device-tree overlay at runtime (via bin-attribute file),
>> and applying it using the of_overlay_fdt_apply(). The approach is
>> working for our testing purposes when the device is added to I2C/SPI
>> node which is already enabled. However, in case where we have the I2C
>> disabled, and enable it in the same overlay where we add the new device
>> - then the new device does not get probed.
>>
>> I would be really grateful if someone had a pointer for us.
> Seems to be fw_devlink related. I suppose if you turn it off it works?
> There's info about the dependencies in sysfs or maybe debugfs. I don't
> remember the details, but that should help to tell you why things
> aren't probing.
>
> I've dropped the changes for 6.18 for now. No one really seems to be
> in need of them yet AFAICT.
>
> Rob
Hello,

Thank you for the help. We are going to look into sysfs / debugfs as 
soon as we have time.

I tried with this and result was the same, BD71847 was not probed:
[    0.000000] Kernel command line: console=ttyO0,115200n8 root=/dev/nfs 
rw nfsroot=192.168.255.126:/home/user01/nfs,nfsvers=3 
ip=192.168.255.1:192.168.255.126::255.255.255.0:bbb1:eth0 nfsrootdebug  
fw_devlink=no


With todays linux-next the BD71847 got probed; I assume the changes got 
dropped for the moment.

Kalle


