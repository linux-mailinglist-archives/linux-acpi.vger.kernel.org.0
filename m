Return-Path: <linux-acpi+bounces-19420-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E78CA356C
	for <lists+linux-acpi@lfdr.de>; Thu, 04 Dec 2025 11:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50AF53044854
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Dec 2025 10:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858BB334C30;
	Thu,  4 Dec 2025 10:55:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871733343F
	for <linux-acpi@vger.kernel.org>; Thu,  4 Dec 2025 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764845738; cv=none; b=h5oYCtFyWdQvYmu6CJtczH1SPJRqS9WtemNuVI4AZUl/p5Fv94QKfENm4tiYQmUsQr3dsTig5rHDyzb+G/E+Raic+kjveoDq68Yu4NdfDc6bwDwi4Bn3QCQUmD7chArMomaVVcGWh0eSGo6B9syFLjMbbz8JOJC/DFLewYhiWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764845738; c=relaxed/simple;
	bh=6slcK3EQrAXupPVJr9jM3Pcmh+QTUwh+iVFWsaKxXWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRAHR7WTbJggNnvKOr8a0ayI/WsyVidWmcmXKsAFWreGndHOj0JhJtDEVD1IV4sJ0Iz7+oKqi+QKcsSgIzexP0ycxFjXzIU1LDkOUQk296itfnXSkTC6kPkqmfbHRgVC868uxZ3F3vqy2+nxmCWwRvxZXPYbO18uBYIn8i8nZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-341988c720aso583585a91.3
        for <linux-acpi@vger.kernel.org>; Thu, 04 Dec 2025 02:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764845736; x=1765450536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfnzYJnOAkS7SHNqKKzIeFzoFbDZmoEYIAPmuyxm7j4=;
        b=HZEzOb0Zwm9XoNfSOkqpV8lMkzd8/XDNCc/qY4ZQTN4juE+03/uF085UilIIIOyrdX
         Us1vrZWPTmw8G7lzLbdGduDXK/hgM/S1GwkI/gxv5q4Du1YXF2mwStb7GPnMz58Ju3rc
         DY6MJKrU0DSA2EWaPgPMWn9dOiBvR4PgH4NDN8RD+hae6AsqQrhq/U2wzGFtBY8ElE0h
         2OTgz0n6Z+wfgSjzIah2TjGRu31Mag77G04iXevU6sb4Jdb/K7bsqGgZqAvlM44zDCB4
         pNFN7PyhQ1Nnz6z4T8hoKOZzmzMXeAuUjorIRRZ3EUATq1pOYFh6ICnDZW5vtoyV2Bt6
         XJXw==
X-Forwarded-Encrypted: i=1; AJvYcCWDJto8FEV7KIKAVmtXa+iYzdf0RBO5guJvQEuGHV0YOiO49enP6wM1MJj8ieiptYXvrzLp1Ggf6E3U@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOuIlY3AW0PaMV1LBT+M617DbkmvsJMWbg2c5wX6GfOaetPab
	TEKPuPjDZWKHJ5bwZ51oLRt65yuX2AodGQX3XMCHaQTU60gBJlQyF7g1HHpZOjOp
X-Gm-Gg: ASbGncv/8aZREK+ubNVoxEFwA/8an5QV+4GCQQEVaMfoJBuXHN98m/aZJAlZXuIOzE0
	6scXYTBw7Jr3nrmVJgry5O7rGlAD8llAuEJPNO0HKCeUfl+cyw6kkZWvnuhs0dN7qbrhr5GC4Ee
	H2v1ofSZyqchgC1LVoOmxk34YQF9SB96VBEl4LKPbz1qrTzEv5TNmt7/Egsd0+fQ4Pagzl4mFaA
	NVARr5Hq5f0riYcbBDso1i1fBovnyYLEwtVUKpVl+6XYBcdT0DiNR81vsrKRQwDyHYYfyS3OnxB
	Pp0xF+shoRDuzJEF8Dxgo7kQgO4jjXrY1cKGkt3TcDzGGaySYH1MHh0aDmelqbp11kmbduVykya
	TKo/keShg+Lq53XPhahEwrhIFN/3kHq4pANFOeqZ5toh65EKi1ycGZzTkqEn+aZ6iEyx1SYol03
	Ez2MrfL22k1jTo8HMxg7bajkJ69KTUR0qLwdz/lOn0m/s88tNJz9AJ
X-Google-Smtp-Source: AGHT+IGf09eD2H4We7gxE278XIV+bUmbwr0mBCrX8BrYZ0wMEfiUUGSPZYLfbjYyv29mZYnZJI0lHA==
X-Received: by 2002:a17:90b:38ce:b0:340:ad5e:c3 with SMTP id 98e67ed59e1d1-349125c09bbmr5599216a91.1.1764845736125;
        Thu, 04 Dec 2025 02:55:36 -0800 (PST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com. [209.85.210.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494e836ae0sm1651100a91.3.2025.12.04.02.55.35
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 02:55:35 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso841276b3a.3
        for <linux-acpi@vger.kernel.org>; Thu, 04 Dec 2025 02:55:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDM683iYMlBKkMFEOruJwlLPLWQtdIk4Nw23doD/vKofZnJlXl0UQIH0Qc3mBA+i74pqt9LpC/i9cM@vger.kernel.org
X-Received: by 2002:a05:6102:6889:b0:5dd:b69a:cdce with SMTP id
 ada2fe7eead31-5e48e28ea62mr1665640137.1.1764845364523; Thu, 04 Dec 2025
 02:49:24 -0800 (PST)
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
 <088af3ff-bd04-4bc9-b304-85f6ed555f2a@gmail.com> <20251202175836.747593c0@bootlin.com>
 <dc813fc2-28d2-4f2c-a2a3-08e33eec8ec7@gmail.com> <20251204083839.4fb8a4b1@bootlin.com>
In-Reply-To: <20251204083839.4fb8a4b1@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Dec 2025 11:49:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXdwf7La1EYBWTJadsTAJG3nKQVW6wtBn-bUqshA=XHRw@mail.gmail.com>
X-Gm-Features: AWmQ_blMXTXWTKLb__jRgM2vj510G0Mh23mSqsI1Cojt34ffki3w4wmdXTg_pQg
Message-ID: <CAMuHMdXdwf7La1EYBWTJadsTAJG3nKQVW6wtBn-bUqshA=XHRw@mail.gmail.com>
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT overlays"
To: Herve Codina <herve.codina@bootlin.com>
Cc: Kalle Niemi <kaleposti@gmail.com>, Rob Herring <robh@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Thu, 4 Dec 2025 at 08:39, Herve Codina <herve.codina@bootlin.com> wrote:
> Indeed, Kalle, Geert, I don't have your hardware, your related overlay or
> a similar one that could be used for test and also I don't have your out =
of
> tree code used to handle this overlay.
>
> I know overlays and fw_devlink have issues. Links created by fw_devlink
> when an overlay is applied were not correct on my side.
>
> Can you check your <supplier>--<consumer> links with 'ls /sys/class/devli=
nks'
>
> On my side, without my patches some links were not correct.
> They linked to the parent of the supplier instead of the supplier itself.
> The consequence is a kernel crash, use after free, refcounting failure, .=
..
> when the supplier device is removed.
>
> Indeed, with wrong links consumers were not removed before suppliers they
> used.
>
> Looking at Geert traces:
> --- 8< ---
> rcar_sound ec500000.sound: Failed to create device link (0x180) with
> supplier soc for /soc/sound@ec500000/rcar_sound,src/src-0
> rcar_sound ec500000.sound: Failed to create device link (0x180) with
> supplier soc for /soc/sound@ec500000/rcar_sound,src/src-1
> [...]
> --- 8< ---
>
> Even if it is not correct, why the soc device cannot be a provider?
> I don't have the answer to this question yet.

I have no idea. These failures (sound) are also not related to the
device I am adding through the overlay (SPI EEPROM).
Note that these failures appear only with your suggested fix, and are
not seen with just the patch in the subject of this email thread.

> Without having the exact tree structure of the base device-tree, the over=
lay
> and the way it is applied, and so without been able to reproduce the issu=
e
> on my side, investigating the issue is going to be difficult.
>
> I hope to find some help to move forward and fix the issue.

Base DTS is [1], overlay DTS is [2].
Applying and removing the overlay is done using OF_CONFIGFS[3],
and "overlay [add|rm] 25lc040"[4].

I assume you can reproduce the issue on any board that has an SPI
EEPROM, after moving the SPI bus enablement and SPI EEPROM node to an
overlay. Probably even with an I2C EEPROM instead.  Or even without
an actual EEPROM connected, as even the SPI bus fails to appear.

> Saravana's email (Saravana Kannan <saravanak@google.com>) seems incorrect=
.
> Got emails delivery failure with this email address.

Yeah, he moved company.
He is still alive, I met him in the LPC Training Session yesterday ;-)

Thanks!

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drive=
rs.git/tree/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drive=
rs.git/tree/arch/arm64/boot/dts/renesas/r8a77990-ebisu-cn41-msiof0-25lc040.=
dtso?h=3Dtopic/renesas-overlays-v6.17-rc1
[3] https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drive=
rs.git/log/?h=3Dtopic/overlays-v6.17-rc1
[4] https://elinux.org/R-Car/DT-Overlays#Helper_Script
[5] https://lore.kernel.org/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=3D9F9rZ+=
-KzjOg@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

