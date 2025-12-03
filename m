Return-Path: <linux-acpi+bounces-19404-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D04C9EAAE
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 11:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7894F4E4498
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972F2E8881;
	Wed,  3 Dec 2025 10:13:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A92E889C
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756827; cv=none; b=qiI776MwjsN+DAKqVeixnMbBnMBjoHHO+XFpFML2im9E0POkkTnibTovj6sqktjR7R76wXy6t4Zu5PWjuyAFPjubT4TkUHsUI3A83+uS1/lnvPsFm8eQnEe6Y9yL2lxXiM6Vq2x59J+7fsnp6aXDkBiJ2DMwt7ac8MtmzVviw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756827; c=relaxed/simple;
	bh=7ykrGGwCG5UVuu6S46Y+mkYJETdoJx86HhNwtYYoBJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOmuLj144NXCfMPGqAofaFNpVGjy2idnhluXfRAI7axoN0lqrbnYGnZxoJcjyJmpYqEtL0y9ZXwEh2nRPIxGcD3VoWEt97p3GSblT0gSRmOMw17L4c46P3raaDmyugQ42/PTwQKcmUfSILzvMOiwlJKQKTgxD8T9X6BAXqKqA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93a9f6efe7cso3544887241.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2025 02:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764756824; x=1765361624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08y1I8cftAKXa2ZRDPk1QAbO3eRq2UKMz/WOuMZJTrE=;
        b=W7wPAAnIZOMgJS0vibzspDuzkCaVcGqIbLygOGC3CH/annrzsrWLT5Vu9T82AJPFa8
         szciyx9nwXNmUSe6TVXb0KQmH09P3xVldZAkw5Ixk//gRCTcM0URbqWBHwe/2LgKnOmx
         fT3E3hknRpAp5EzAL7sdhkHP1UcDbEknxsUr4XgMSv1KwdwI3I+VlupXjrbwLbjIWDRA
         ynrN7suFswZj9W4ZIGUKkCyU3lAQVWWz9MLidsxMsdQZ8vxPthXmLpo2Nc3fkBJo9SLP
         s0YlDR/Yy0uvBo7GeRMHc2ZBuMvtRjvFykPIVPRJ+pYAtrETvmF4FQAkD8jnyGR19q4/
         +QDA==
X-Forwarded-Encrypted: i=1; AJvYcCUMe8lkI8iIkIpAWPSurZzLoIF7fMal1soyzvigQCp35dioALPl5UCAt1bleg2qYAtXV/YKlMQaNvcQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7PWjGVu6CeH4e0XTR0cYRyVX3rhKU5MEJKV/7A9j5ahYtCPq
	S+Tw7eYERBxIIC9k9qY/hNbkF3rCpb73rQME3p3cl5QVZo2uTzOeUIPUzf7YSkWq
X-Gm-Gg: ASbGnctdtrd8QIQzBVL4oCAfod0aecFs7g6QRgF/lTO5ktf0zCDSuXs4O7h9+y3l83w
	MjuLLCWYQVmcgYdRsr3uXvxt5Lfq0tDS0j/0xoEDd9tmNFMjLDasx3H8sb9x9u9Woj+FXC0jTcA
	/fUNHSwvopCqa0GUSf5uS7LBgVlrTIYRd9z+PmSPo5iig/cFjAZHH26Ieu0iAOkwnMNbv2U9ngi
	S45fS40jeEt4Sbm4NkcGM9nE/0cwxCgnfWgWJ2EvZ7o0t8gy9uriMxIcCfkO8tsmfz0RdsJMvuI
	qK7mCdZLupvgLjx2IkUwen3JNTFsaDQ5AvgkGNfvWGjLvm3c5TcEhcV2SZ+R/uMeXbTv+efZEaa
	6b2daHc2+ftaT0tHqJytcE8pZ9FYWoqv0/5i4AV147iuU5x80o93qHe+2lxQ1i5Fp3CmWUZv0tD
	Whtsc0WXOypUpce5yKuSBVA8TxArrVz8Ikv6sBU1o8rO6eKh2S
X-Google-Smtp-Source: AGHT+IHhsamUaZEjSW1iD6zTWqY3Cqu9RrD4PsR2CCjGBenCRuRHXjZrY4YvORiU9LZNR9mUz5GncQ==
X-Received: by 2002:a05:6102:560e:b0:5db:d60a:6b1f with SMTP id ada2fe7eead31-5e48e365c07mr437318137.23.1764756824379;
        Wed, 03 Dec 2025 02:13:44 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24d7f11c8sm7629066137.0.2025.12.03.02.13.44
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 02:13:44 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-93a9f6efe7cso3544883241.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2025 02:13:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqg4fvvw3F3a4BMgw0tghgOIEArAYvkzSE4guka010R1T+p6KFlk8Q7wrvNyQUvUfUqN3KXMD1x0b1@vger.kernel.org
X-Received: by 2002:a05:6102:579a:b0:5df:c1ac:8ad4 with SMTP id
 ada2fe7eead31-5e48e01012fmr426535137.0.1764756375911; Wed, 03 Dec 2025
 02:06:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
 <20251015071420.1173068-2-herve.codina@bootlin.com> <f74ab0a2-b74b-4b96-8469-a716c850e230@gmail.com>
 <CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com>
 <5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com> <CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
 <072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com> <CAL_JsqKyG98pXGKpL=gxSc92izpzN7YCdq62ZJByhE6aFYs1fw@mail.gmail.com>
 <55076f4b-d523-4f8c-8bd4-0645b790737e@gmail.com> <20251202102619.5cd971cc@bootlin.com>
 <CAMuHMdXogrkTAm=4pC0B+Sybr=PR3XovnBgmiEyTvUMmJHvBRA@mail.gmail.com> <20251202182834.65d7f0a1@bootlin.com>
In-Reply-To: <20251202182834.65d7f0a1@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Dec 2025 11:06:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4y3Faz1nJo5CeYdPY9dgetWrLE9bMdba_QeWwXX41CQ@mail.gmail.com>
X-Gm-Features: AWmQ_bm_vwtlSlkiVojLd-rzxo_k4pikXV0aLj6bs5bAdLDXgMj28SXkaqQFKI0
Message-ID: <CAMuHMdU4y3Faz1nJo5CeYdPY9dgetWrLE9bMdba_QeWwXX41CQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT overlays"
To: Herve Codina <herve.codina@bootlin.com>
Cc: Kalle Niemi <kaleposti@gmail.com>, Rob Herring <robh@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Tue, 2 Dec 2025 at 18:29, Herve Codina <herve.codina@bootlin.com> wrote:
> On Tue, 2 Dec 2025 17:35:35 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, 2 Dec 2025 at 10:26, Herve Codina <herve.codina@bootlin.com> wr=
ote:
> > > On Fri, 28 Nov 2025 10:34:57 +0200
> > > Kalle Niemi <kaleposti@gmail.com> wrote:
> > > > >>>>>> Test system testing drivers for ROHM ICs bisected this commi=
t to cause
> > > > >>>>>> BD71847 drivers probe to not be called.
> > > > >>>>> This driver (and overlay support) is in linux-next or somethi=
ng out of
> > > > >>>>> tree on top of linux-next?
> > > > >>>>>
> > > > >>>>> Rob
> > > > >>>> Yes the driver is in mainline linux: /drivers/mfd/rohm-bd718x7=
.c
> > > > >>> I don't see any support to apply overlays in that driver.
> > > > >> Ah. Sorry for the confusion peeps. I asked Kalle to report this =
without
> > > > >> proper consideration. 100% my bad.
> > > > >>
> > > > >> While the bd718x7 drive indeed is mainline (and tested), the act=
ual
> > > > >> 'glue-code' doing the overlay is part of the downstream test
> > > > >> infrastructure. So yes, this is not a bug in upstream kernel - t=
his
> > > > >> falls in the category of an upstream change causing downstream t=
hings to
> > > > >> break. So, feel free to say: "Go fix your code" :)
> > > > >>
> > > > >> Now that this is sorted, if someone is still interested in helpi=
ng us to
> > > > >> get our upstream drivers tested - the downstream piece is just t=
aking
> > > > >> the compiled device-tree overlay at runtime (via bin-attribute f=
ile),
> > > > >> and applying it using the of_overlay_fdt_apply(). The approach i=
s
> > > > >> working for our testing purposes when the device is added to I2C=
/SPI
> > > > >> node which is already enabled. However, in case where we have th=
e I2C
> > > > >> disabled, and enable it in the same overlay where we add the new=
 device
> > > > >> - then the new device does not get probed.
> > > > >>
> > > > >> I would be really grateful if someone had a pointer for us.
> > > > > Seems to be fw_devlink related. I suppose if you turn it off it w=
orks?
> > > > > There's info about the dependencies in sysfs or maybe debugfs. I =
don't
> > > > > remember the details, but that should help to tell you why things
> > > > > aren't probing.
> > >
> > > Rob reverted patches but I plan to continue my work on it.
> > > On my side, I need the reverted patches but I fully understand that, =
on
> > > your side, you need a working system.
> > >
> > > In order to move forward and find a solution for my next iteration, c=
an you
> > > send your overlay (dtso) used in your working and non working cases?
> >
> > Hmm, I must have missed when Rob applied (part of) this series, as I
> > do an overlay test (using the out-of-tree configfs) on top of every
> > (bi-weekly) renesas-drivers release, and saw no issues during the last
> > few months.
> >
> > So I applied this series and tested loading my SPI EEPROM overlay.
> > And it indeed breaks, with the culprit being this particular patch.
> >
> > Interestingly, quoting from this patch:
> >
> >    "While the commit fixed fw_devlink overlay handling for one case, it
> >     broke it for another case. So revert it and redo the fix in a separ=
ate
> >     patch."
> >
> > Where is the separate patch that redid the fix? I assume it is "[PATCH
> > v4 03/29] of: dynamic: Fix overlayed devices not probing because
> > of fw_devlink"?  Unfortunately that doesn't fix the issue for me.
> >
> > Quoting more from this patch:
> >
> >    "Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_=
rJgyo8x6=3D9F9rZ+-KzjOg@mail.gmail.com/"
> >
> > Strange that it claims to fix the issue reported there, as the failure
> > mode I am seeing is exactly the same as documented in that report?
> >
> > Do you know what is wrong? The overlay I am using is referenced in
> > the bug report linked above.
>
> The first patch "Fix probing of devices in DT overlays" didn't fix all ca=
ses
> and so Saravana reverted this patch and proposed "of: dynamic: Fix overla=
yed
> devices not probing because of fw_devlink".
>
> This second patch was needed to fix my use case even if more modification=
 were
> needed to have my use case fully fixed (other patches in my series).
>
> Rob applied those first patches from my series and some systems were brok=
en.
> The breakage has been reported my Kalle and Matti and led to a revert of =
culprit
> patches.
>
> I tried to understand what was wrong. I am pretty convinced that modifica=
tion
> done in "of: dynamic: Fix overlayed devices not probing because of fw_dev=
link"
> are really better than modification available in "treewide: Fix probing o=
f
> devices in DT overlays".
>
> I proposed an update [0] and I will be glad if you can also test this upd=
ate
> on your side and give me your feedback.
>
> [0] https://lore.kernel.org/lkml/20251202175836.747593c0@bootlin.com/

Thank you!

Unfortunately this does not fix the problem: I still need to do an extra
overlay rm/add cycle to make the SPI EEPROM work.

In addition, it triggers a bunch of new scary error messages:

rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-0
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-1
[...]
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-9
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-0
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-1
[...]
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-9
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-0
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-1
[...]
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-9
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-0
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-1
[...]
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-9

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

