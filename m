Return-Path: <linux-acpi+bounces-21231-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL8UNM+poWm1vQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21231-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:27:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 454C41B8E76
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B139E317EF52
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C84413223;
	Fri, 27 Feb 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjbJPicf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFBF413239
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201486; cv=none; b=iHK9qmMrZnnK9ldEvnMX9jmPgVekKqjtsxAzG/gWekSUc6UKNdhb3zWuTSteQvS6/zIyNubQcBlAVzuZC5jldRoO9VTDiRbtmRk2JyYNRO4VOJZZ89PI1awHXvHS70ydVOaYcv5jLs4Ibcg0l1sg2nT7IHjmr9KM3gPxl0y/LOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201486; c=relaxed/simple;
	bh=ShiqjwbVycNVDc/NOYYT7WllWbuKawKGkYhqIEShcUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGO1S5T2IdCDUqVQT/255nyLMOsEJuGGvSfqYZI5r93X8yjLzZyxyJLWrFTuP8WI/GYREJUT/Xf7jxhrAcjZzm0PHwwZ4P8g+2/Vz3AcW5O3kGv+VJA0UxaC23sxFvyS+LfYKol2Q7tji4CkZZFf6dL0D7XntTexLBYyh0JyPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjbJPicf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19F7C2BCAF
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201485;
	bh=ShiqjwbVycNVDc/NOYYT7WllWbuKawKGkYhqIEShcUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LjbJPicfTZrG9zq8p4ZRfbl4/SDr6MDB6YvJK4CvrYw1xUGm6WBB3Nlf+dW6mJ8k6
	 C/bdfYk7bAk/NlfGd0Dxz+YYbkiP2EYCqqciKRSzEEH4cWEQjiF/U4KxLeuFfhbOpG
	 pvyzHOhLfFUoR3mw+K2CQ++41PQhfSTcEfBpu8SGJvHDBIr+og5048RDwRgPFYsrDs
	 AQ9jb8ol1NxeqlFLk0Gf78MhmMITIqOqE6oCCCX9yNgkei8f8wOjbB9D9a/xOMzAzN
	 Se9NdmBS8ezQmEeeazWkRAdkqNtkpWyWlnuR1eMpHAbKlk84UkbbLQiwmOM5gPWUQF
	 TLsPeldJWa1Vw==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ad79df972so2313639d50.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 06:11:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKg8Wvv8VlMmtztTxb1VSAlyeYPZIiCDL82J7+bT8/tGu2XYyd7Ja/y06xu5MsRM2xaH6pCHFkpYKQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyVBWdV4fTrTXK22Lehzs66HSY4sUzn1Twzm1g0RhL+oONV9gSj
	qBndk9GOXfbAXBtLMJJ0gqCquG51AOP/CaT8H36XmJj2Dj8WSxM+IPmPPkFyk7UH/TFmlN3VHTR
	N1+3R8UGTzRzYL/XY+qbJhAXtu/Yak6Q=
X-Received: by 2002:a05:690c:60c4:b0:798:6666:26bd with SMTP id
 00721157ae682-7988557f476mr30565677b3.37.1772201484696; Fri, 27 Feb 2026
 06:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-10-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-10-herve.codina@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 27 Feb 2026 15:11:13 +0100
X-Gmail-Original-Message-ID: <CAD++jLmbg1FVGxv_7Lq4rOEbLAGh72YPTppOBcdpcsdLDo8B_A@mail.gmail.com>
X-Gm-Features: AaiRm51ZxE6GtTyodhFmvZhWZO__2ijK76G9lNPmnmTqvkqKfSl89e994OIKOE4
Message-ID: <CAD++jLmbg1FVGxv_7Lq4rOEbLAGh72YPTppOBcdpcsdLDo8B_A@mail.gmail.com>
Subject: Re: [PATCH v5 09/28] pinctrl: cs42l43: Use fw_devlink_set_device()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kalle Niemi <kaleposti@gmail.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,huawei.com,intel.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com,bootlin.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21231-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 454C41B8E76
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 2:57=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:

> The code set directly fwnode->dev field.
>
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Linus Walleij <linusw@kernel.org>

Tell me if I should apply this directly to the pinctrl tree, right
now I'm under the impression that all patches need to go in
together?

Yours,
Linus Walleij

