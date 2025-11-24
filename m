Return-Path: <linux-acpi+bounces-19215-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6112C81BB2
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 17:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981C73A9F64
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43F3168E9;
	Mon, 24 Nov 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e00nhuYR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F53168E1
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003217; cv=none; b=dw9u2BuAv87D+mGf80g/6zPogeJmowyi96Jkm1I3Rw6VKCDmM85PJ4R3hMwCnT2+lHjEqAH9y0enNJtAqjWOlnw1B79upQonX276OF1ZDpSDgSyhR40Gh6QgerIWNjt9B99soXVBH7AHgaM0Q7Lnu2MB+4U3PcliKBbLzKPkf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003217; c=relaxed/simple;
	bh=U6A+dJ20pXp86qjZBRsjEm03OXYUbqKULhGIn2BanqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s90hQxG+X6PVKczY02ulYaXJozD5hqPXN2WEIB+mxDtX1fF7qcrAWFTx53tNPwlS6jb578rzHs/pOLnVPmp2ijhrFj8vDUAyBkBcrD0kZUbaLGFc7pPtEujmsinjxS+IsqFTGrkyIoAwK3n0nRMM/Jg1f4WISfVwzCUBMSyTPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e00nhuYR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b739ef3f739so278967666b.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 08:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764003214; x=1764608014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMEOFKOu3v4GJbo9FdKNZBfHGx8q7d1+trMyWhqy/A8=;
        b=e00nhuYRJ4TUm6C4WkIDcGwKLXgjAvkpM4YXm0zK37rcdjn3LYN3AAPebtu54ZovQR
         /56S3UttjqF5ahNaRos3W+qbfYZcIklnt2/T4FAc+CSkTwNN3lM9bj+y5rvra7SU5uNj
         BabMmoBh051QK3dj4WNuiZjCsHRZ6K1V3wKiI9iIfo6RjZd/HjyLVDqheBSMCs9u6BzI
         zdy9sD1MW2edryd9hcfzoyC2myri/1sfo1N1rX8Vbm9UixLX+y+v78Lrgc/ziWN/pKLC
         COVceI2EcMHy1OOvMvYLdp7E/Dr0FSw0sNGOxX2Y3sB6KYHYVPGQZCuhx2mtdixOXKZs
         QW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764003214; x=1764608014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMEOFKOu3v4GJbo9FdKNZBfHGx8q7d1+trMyWhqy/A8=;
        b=IrQvKTdu1jcgF4e7E24UBtK8TKYmm0pEW/TkEKDhLq35RlDN4VHSr5egMX1RWVs/ca
         JLb/JxaRRrhplilaMiEDTyTXNYqmhRcJC7QiCmJ/52OsTjZFC2xWVtGNGAF7AmNON7ow
         X1uo/eAtX9tk72SZ6r57ZzlJCEBPzRzSSwYvrmhD0heHqtxoJOIo+ws2hlVO2vQuXa/T
         OND32YuDjqwDtK2kXyMXIgjrZghqvz1XCJF0B/uT73ekL5w76Nt4nzLtzb1NFA6ICJez
         1rjdFti95cwyXCnxf3tRm72D8uZSHW+Gnj1+mj2hDJwlnoZhR3XuN2n8zrwowor2oEPf
         rKAg==
X-Forwarded-Encrypted: i=1; AJvYcCWF3tFQgA3cLoteBQ6uHNsthkCl8vIbNJlJP25MgQLrhcwXc9b3176srzMa7thhq4w6r3mPD9AvBL0e@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2yv3O1taEZmPsb+fG/8gJ1/Fx1wXBYicxU+51P5sKyBqlCIHC
	CNMAIf9kMP6ok0rGgCyrPhnK4egG6tEl+A4s75Bs6huG2bghXTv2cvj4V+HgeW5Q
X-Gm-Gg: ASbGncv04YEuCmWaGW7cG02WQTgCu9orXWjrnn7rMNKH9D6VAmC1gDjUFpm+oE0x3W9
	e/R5pQIe0eDywD99VNDe7cOJEz6kZzjP9086wXCploOxRKp+wp/pOTpHeHQNVUViwv7RHAHR+uv
	aWHeRoGe0ub4Rsc/Awke8Axil5uBsvD2qE1SoxMHiEmikRPUz6Sb23iVogO8wAWouDePNEDg45f
	OpXHKk95hG9AhUlPENUPddN7OaepcZukWfJvGzmcr37bF9K7gvuuICYLKByjuUD18Zm9Ak2FN2b
	dyZbW1zdByC/dZG3xlsU7/A2qmnIkbOp2Cl8uNSgsfE5gcfMDKzZMiUuofkBG/EwD0VpTclZCV5
	trFX/coWTEmEi+08cPzQ7c1TS719SUwc3VS0o0rRTROnOwmsk3guMC7yF4Rew09yZEctvOFJYOL
	HGdrGeAwWxlCGZ8yw2gf9lQp0UsdiXks8/8x5JT86ICZqjcReDazNwBRrSK1sWAAw=
X-Google-Smtp-Source: AGHT+IG13tPufOeCe62IkziqEjMKy77jRIw/n2p1+sO/PACFs+P5/tLtartbx+qzXMxnMkmQoCTh7g==
X-Received: by 2002:a05:6512:39d5:b0:595:9152:b921 with SMTP id 2adb3069b0e04-596a3ea79camr4199632e87.7.1763996851410;
        Mon, 24 Nov 2025 07:07:31 -0800 (PST)
Received: from ?IPV6:2001:14ba:437:c00::190? (2001-14ba-437-c00--190.rev.dnainternet.fi. [2001:14ba:437:c00::190])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596a0d1493bsm3863273e87.73.2025.11.24.07.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 07:07:30 -0800 (PST)
Message-ID: <5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com>
Date: Mon, 24 Nov 2025 17:07:28 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT
 overlays"
To: Rob Herring <robh@kernel.org>
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, mazziesaccount@gmail.com
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
 <20251015071420.1173068-2-herve.codina@bootlin.com>
 <f74ab0a2-b74b-4b96-8469-a716c850e230@gmail.com>
 <CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com>
Content-Language: en-US
From: Kalle Niemi <kaleposti@gmail.com>
In-Reply-To: <CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/24/25 16:53, Rob Herring wrote:
> On Mon, Nov 24, 2025 at 8:48 AM Kalle Niemi <kaleposti@gmail.com> wrote:
>> On 10/15/25 10:13, Herve Codina wrote:
>>> From: Saravana Kannan <saravanak@google.com>
>>>
>>> This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
>>>
>>> While the commit fixed fw_devlink overlay handling for one case, it
>>> broke it for another case. So revert it and redo the fix in a separate
>>> patch.
>>>
>>> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
>>> Reported-by: Herve Codina <herve.codina@bootlin.com>
>>> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com/
>>> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
>>> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>> Link: https://lore.kernel.org/lkml/20240411235623.1260061-2-saravanak@google.com/
>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>> Acked-by: Mark Brown <broonie@kernel.org>
>>> ---
>>>    drivers/bus/imx-weim.c    | 6 ------
>>>    drivers/i2c/i2c-core-of.c | 5 -----
>>>    drivers/of/dynamic.c      | 1 -
>>>    drivers/of/platform.c     | 5 -----
>>>    drivers/spi/spi.c         | 5 -----
>>>    5 files changed, 22 deletions(-)
>>>
>>> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
>>> index 83d623d97f5f..87070155b057 100644
>>> --- a/drivers/bus/imx-weim.c
>>> +++ b/drivers/bus/imx-weim.c
>>> @@ -327,12 +327,6 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
>>>                                 "Failed to setup timing for '%pOF'\n", rd->dn);
>>>
>>>                if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
>>> -                     /*
>>> -                      * Clear the flag before adding the device so that
>>> -                      * fw_devlink doesn't skip adding consumers to this
>>> -                      * device.
>>> -                      */
>>> -                     rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>                        if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
>>>                                dev_err(&pdev->dev,
>>>                                        "Failed to create child device '%pOF'\n",
>>> diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
>>> index eb7fb202355f..30b48a428c0b 100644
>>> --- a/drivers/i2c/i2c-core-of.c
>>> +++ b/drivers/i2c/i2c-core-of.c
>>> @@ -176,11 +176,6 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
>>>                        return NOTIFY_OK;
>>>                }
>>>
>>> -             /*
>>> -              * Clear the flag before adding the device so that fw_devlink
>>> -              * doesn't skip adding consumers to this device.
>>> -              */
>>> -             rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>                client = of_i2c_register_device(adap, rd->dn);
>>>                if (IS_ERR(client)) {
>>>                        dev_err(&adap->dev, "failed to create client for '%pOF'\n",
>>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>>> index 2eaaddcb0ec4..b5be7484fb36 100644
>>> --- a/drivers/of/dynamic.c
>>> +++ b/drivers/of/dynamic.c
>>> @@ -225,7 +225,6 @@ static void __of_attach_node(struct device_node *np)
>>>        np->sibling = np->parent->child;
>>>        np->parent->child = np;
>>>        of_node_clear_flag(np, OF_DETACHED);
>>> -     np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
>>>
>>>        raw_spin_unlock_irqrestore(&devtree_lock, flags);
>>>
>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>> index f77cb19973a5..ef9445ba168b 100644
>>> --- a/drivers/of/platform.c
>>> +++ b/drivers/of/platform.c
>>> @@ -739,11 +739,6 @@ static int of_platform_notify(struct notifier_block *nb,
>>>                if (of_node_check_flag(rd->dn, OF_POPULATED))
>>>                        return NOTIFY_OK;
>>>
>>> -             /*
>>> -              * Clear the flag before adding the device so that fw_devlink
>>> -              * doesn't skip adding consumers to this device.
>>> -              */
>>> -             rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>                /* pdev_parent may be NULL when no bus platform device */
>>>                pdev_parent = of_find_device_by_node(parent);
>>>                pdev = of_platform_device_create(rd->dn, NULL,
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>> index 2e0647a06890..b22944a207c9 100644
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>> @@ -4791,11 +4791,6 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
>>>                        return NOTIFY_OK;
>>>                }
>>>
>>> -             /*
>>> -              * Clear the flag before adding the device so that fw_devlink
>>> -              * doesn't skip adding consumers to this device.
>>> -              */
>>> -             rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>>>                spi = of_register_spi_device(ctlr, rd->dn);
>>>                put_device(&ctlr->dev);
>>>
>> Sorry, some of you will receive this message now for second time. First
>> message was sent to older series of patches.
>> -
>>
>> Hello,
>>
>> Test system testing drivers for ROHM ICs bisected this commit to cause
>> BD71847 drivers probe to not be called.
> This driver (and overlay support) is in linux-next or something out of
> tree on top of linux-next?
>
> Rob

Yes the driver is in mainline linux: /drivers/mfd/rohm-bd718x7.c

Kalle

