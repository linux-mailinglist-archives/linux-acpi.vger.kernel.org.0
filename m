Return-Path: <linux-acpi+bounces-19549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 526A1CB6191
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 14:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70340304DA2C
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431A7280324;
	Thu, 11 Dec 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5qVzYVn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D3F23EAB8
	for <linux-acpi@vger.kernel.org>; Thu, 11 Dec 2025 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461156; cv=none; b=LD1ndLinUss+cEwWjPw/w3N/vX1cPS/C76+8iuwKkA6YACI/7yOKub+J10U8ubeIF56OfXC9tQHiaiFSUaKhhVAowjKXN6M2o8F8x1rU9BpNPKRPoHntrMd04s/GmNkiT2a3vb8laWeCZzNN/Rf52SW0fm6do/gNkhf5jTshl9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461156; c=relaxed/simple;
	bh=G75QtHwaXyoGaF97/dwbuAjoqGb0m37v7wfeVaP4ZQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTW1DgIRGTNN2lKbBPDGdADcVm4Gcqut3sXAivRVtqNkrvjfI6qJ3s8vNpqohFJdyHKqfinmgVV+LYL2UuUy27kYzUnixzkjlq0h3xNKbGkix+PAwd902pj3YjwxqxO8Kbt7odejSZL0A79s4MeaJmWwOva4wf3cFVn1Q82d9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5qVzYVn; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so92666e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 11 Dec 2025 05:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765461152; x=1766065952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyF8Llfg/KLa+0XknFO643JOUJVOQHSA+WqT/UvRncg=;
        b=O5qVzYVnkNAcBM0yU6/ECghA5DRIx/1vVPyJlHnBpRP0GapnWkpi6WRp2s3WP3FJdS
         kQTdbNBmDRPs5RP2zVC05U2ryvX5+DMju0KLFgWs8XDo4xpjFH5p6dlS/iF283SUjROq
         /jlL+BzBFrzCYPsre33fFUM3wq+N1G3gnplPBg7ZjgE5ESofxOJzGqZnmbXkjF8nmRAv
         lmHtzHR4/t+AHezqADCg2QD8t2s+e8FCRCTMVhbXWuXzPpyevNM+lyuYTEtvGrBptNpN
         vQGQtBx4c5yYcARkXeK/lMvMRShdukWmJi9T4IiYhSkFOK5joxJvnxZQUy+qfKxTewrN
         sptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765461152; x=1766065952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyF8Llfg/KLa+0XknFO643JOUJVOQHSA+WqT/UvRncg=;
        b=h+ICwe5rAmQC+U4xiaalzFpGNyTCEe96NUNVFek/OHBIcaC3oEOYswOwdhLolvmHEl
         FoTcz5UTKP+OLyRy0+7hzyFOM8KpPzp42oO8zRGD4sqj0HZIMlhjTt42rvo4vzqRqRJ3
         HVBUhH68zgpniICsLNe2IwzFBVi81OIHVrJIZblViBS5VCpKRm9oCr3vDp8oGtEDWrDO
         0KDwNDOwQ6JiUr0FGX/JN+EJKowG0EP8L/Q72nvSzC1opxe5hoTnhaHCFg22MeD4SZhM
         8Kr8+bFfOzB9/im8crzgdwIPOL3KlPVUbRRz5dPQEe5aG9WXVgh1o3GRCdsrm2TytrO9
         TnTg==
X-Forwarded-Encrypted: i=1; AJvYcCWs3DQsFFiWxwOCOPOvqAq31oFpbiNjPvKituANbZIClpBqDHMW+hYnyyrTLLADeC0RW5k2JncQY8/1@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1LPAWkA0HeoIgJCJ3qBG/mrsnjXFBNemB0lqDFAC558Fumc5
	N+KrScjn/KHfz3a7CJlUa7hwEROufo456Q//S/7nbFSlj1x20ezzCKtM
X-Gm-Gg: AY/fxX5bfmkQFSLmVSBBHBG+FXkonoBYTJ7/vN94QBRG8MD/uKjJ/XiTzLIiktYSu1a
	3hHi8ZxpAaIXeQvRjOF2RKy6TC+W5kZnYbei7J/kQRMGrfeuJO1UwF2tH5gHq4kfz0zBBmHIcHN
	eOLTQFHdpJQ2L3snICUX+xA05zKiY4GcvU6rqChzlUJzHySMtbZZ9rCdfOxcQfGS1iRwVyZwfP7
	zSK3NJdaYwjJDh7gDE65Ouwi9OVoTxHlELvX/ClUh77KurKrZ+1ZQnXAwqDLYdf64fHqVrsMQuU
	dTdmaaN7AZnJxP1eB06Mn+J4Mh0nEqc3PJxtrU21zhEm0eU7OWCtWQnTsZPyc9DZp67+ckt3Jns
	+hC9SkDsNNLrC66zUxa85p5SDdl02jpBdstdYKhHrORkkff0dusIyERPuiKqGcya9gwahFoWTxL
	XMjzQK64JFpDmFhHpeycH71Mv5JYSFmkqW3qfPR5gYxHLi+xb2ZJCzK/1Q1L8yzzf1ZY7x
X-Google-Smtp-Source: AGHT+IFWJFGGAGC5oB/hILZqbH9Fl+tM9Ekock+BvVcvC2+WO2RAGZK2t4qHgeuRfvNMm8ED4+amVw==
X-Received: by 2002:a05:6512:1390:b0:594:28f6:b065 with SMTP id 2adb3069b0e04-598ee47cf27mr2467104e87.17.1765461151758;
        Thu, 11 Dec 2025 05:52:31 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f37951sm877935e87.4.2025.12.11.05.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 05:52:30 -0800 (PST)
Message-ID: <1b9fa77b-d74a-4fa7-b2e7-8b389d59a5a0@gmail.com>
Date: Thu, 11 Dec 2025 15:52:28 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT
 overlays"
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Kalle Niemi <kaleposti@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
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
 Bjorn Helgaas <bhelgaas@google.com>,
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
 Dan Williams <dan.j.williams@intel.com>, Wolfram Sang <wsa@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
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
 <55076f4b-d523-4f8c-8bd4-0645b790737e@gmail.com>
 <20251202102619.5cd971cc@bootlin.com>
 <088af3ff-bd04-4bc9-b304-85f6ed555f2a@gmail.com>
 <20251202175836.747593c0@bootlin.com>
 <dc813fc2-28d2-4f2c-a2a3-08e33eec8ec7@gmail.com>
 <20251204083839.4fb8a4b1@bootlin.com>
 <CAMuHMdXdwf7La1EYBWTJadsTAJG3nKQVW6wtBn-bUqshA=XHRw@mail.gmail.com>
 <20251210132140.32dbc3d7@bootlin.com>
 <c50c40cc-69f6-436c-a94e-94a3a10f6727@gmail.com>
 <20251211132044.10f5b1ea@bootlin.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251211132044.10f5b1ea@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2025 14:20, Herve Codina wrote:
> Hi Matti,
> 
> On Thu, 11 Dec 2025 10:34:46 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
/snip

> 
> Do you see the same trace with:
> - "pinctrl-0 = <&i2c1_pins>;" in your overlay
> - fragment0 removed from the overlay (i2c1_pins definition removed from
>    the overlay.
> - i2c1_pins node defined in your base DT.

Just tested. The i2c1 appears and the test-overlay probe gets called, 
when the i2c1_pins is in the base-dt and not in the overlay.

> In other word, is the issues related to adding a pinctrl sub-node (pinctrl
> pins definition) in the overlay or is it something else?

Seems to be related to the pinctrl.


Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

