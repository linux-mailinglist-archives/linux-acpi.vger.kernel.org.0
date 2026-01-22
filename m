Return-Path: <linux-acpi+bounces-20540-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8On+F/cYcmksawAAu9opvQ
	(envelope-from <linux-acpi+bounces-20540-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:32:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CFC66ACA
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8169D84C03C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817E3429813;
	Thu, 22 Jan 2026 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UEFpYXOg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7C429801;
	Thu, 22 Jan 2026 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082108; cv=none; b=T7pUyXQ9ui0d4yMOy8sqZL8PVWM5T/g3/UgX0OlIR0f/YQKOmHWFSuGXqBeySlmJUc0zynluKcv+kQd5NTWSnv+tZRjeWwkyIF6NOLDUKvVJWzMneiWWArtVvxyvAHYt00ZaSmeusKUZq+qBVr7DFQUoG29uBYztZ/3/6TEmyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082108; c=relaxed/simple;
	bh=NqQtXUERc3v4NzNZ99SDCcNfgBv7D/bmH0cyLocfDQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsweMJqw5vGSTvAAem1FrZsEFu0UZ551e6YGpbxxY+PtBh3yAv6RTNhgctYu+pJI9BjrZdgT8rdDZGHJp/6JDvZwA74Ryir5P2SlDa0Q1Hi8gKb1cVg/VBYzb71Jr1Lb9KHfgfpw/v96JpOpvYTDILglHb814rm2EQCZLFCGHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UEFpYXOg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A8075C21AA0;
	Thu, 22 Jan 2026 11:41:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B573A606B6;
	Thu, 22 Jan 2026 11:41:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0CD5119B0105;
	Thu, 22 Jan 2026 12:41:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769082094; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Fl2SnsCgDRhlccmCWpsQ4CBlDuamahnW5kxpsohCwvo=;
	b=UEFpYXOgJL+WIY89Mx/EpOyceBBILQiL0TxFQWpW01yiEySAJH2g1HcWGNeQm8jHeKv+xN
	O2csc+HhLdo2gWFITsAzh6mTWYo9h+2QnQHxO2GdqZlsPvpTAG/XFqvOefokUsJca73PWu
	919NjC9kftG/xECA0iNKY+BT7G6XeddTLl+YrGq6EFQ7innqv2Qzt9u7ZQzupbkT37WFhV
	mgEsWUeGSzIj/19gb+Tq8BosxVfyi4TFbwa3Kmjo2kuM+uE7HxnX7idMvi9PAvs7Wiw+OR
	Jl3h0x9NzvUaJ7inKLTNk1kZu+isqj/tgMXHTzscOm2flBtD/RFBursuZs9FuQ==
Date: Thu, 22 Jan 2026 12:41:14 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Rob Herring
 <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Kalle Niemi <kaleposti@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Andi
 Shyti <andi.shyti@kernel.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, Arnd
 Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Charles
 Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, Linus
 Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Wolfram Sang <wsa@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan
 <saravanak@kernel.org>
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT
 overlays"
Message-ID: <20260122124114.44812cc7@bootlin.com>
In-Reply-To: <CAMuHMdWGk5ig3v9tGy1cMOg1LmKu3KrxQq2HO1vcQeZPuRxWBQ@mail.gmail.com>
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
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
	<1b9fa77b-d74a-4fa7-b2e7-8b389d59a5a0@gmail.com>
	<20251211161902.11ef4248@bootlin.com>
	<CAMuHMdWGk5ig3v9tGy1cMOg1LmKu3KrxQq2HO1vcQeZPuRxWBQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linaro.org,lists.infradead.org,lunn.ch,linuxfoundation.org,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,google.com,opensource.cirrus.com,cirrus.com,linux.intel.com,stgolabs.net,huawei.com,intel.com,vger.kernel.org,lists.linux.dev,microchip.com,bootlin.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20540-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: C8CFC66ACA
X-Rspamd-Action: no action

Hi Geert,

On Wed, 21 Jan 2026 13:59:26 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hervé,
> 
> Revisiting his old thread (sorry for the delay)...
> 
> On Thu, 11 Dec 2025 at 16:19, Herve Codina <herve.codina@bootlin.com> wrote:
> > On Thu, 11 Dec 2025 15:52:28 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:  
> > > On 11/12/2025 14:20, Herve Codina wrote:  
> > > > On Thu, 11 Dec 2025 10:34:46 +0200
> > > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > > > Do you see the same trace with:
> > > > - "pinctrl-0 = <&i2c1_pins>;" in your overlay
> > > > - fragment0 removed from the overlay (i2c1_pins definition removed from
> > > >    the overlay.
> > > > - i2c1_pins node defined in your base DT.  
> > >
> > > Just tested. The i2c1 appears and the test-overlay probe gets called,
> > > when the i2c1_pins is in the base-dt and not in the overlay.  
> >
> > Geert, do you expirement same results?  
> 
> Yes, after moving the pin control subnode from the overlay[1] to the
> base DTS, the SPI bus and FLASH work after loading the overlay for
> the first time.

Ok. What I said for Matti's use-case is also valid for your use-case.

> 
> > > > In other word, is the issues related to adding a pinctrl sub-node (pinctrl
> > > > pins definition) in the overlay or is it something else?  
> > >
> > > Seems to be related to the pinctrl.  
> >
> > I don't think that the issue is related to pinctrl itself.
> >
> > IMHO, I think the issue is related to overlays and fw_devlink.
> > The distinction between "a new node is going to lead to a device" vs "a new
> > node is just data and will never been attached to a new device" when an
> > overlay is applied is broken.
> >
> > This is broken with the upstream "treewide: Fix probing of devices in DT
> > overlays" commit I've tried to revert. Indeed, on the LAN966x PCI device
> > use case devlinks created are not correct with this commit applied.
> >
> > I am not sure also that devlinks created with a more complex overlay will be
> > correct. For instance, Matti, with your overlay not sure that a phandle from
> > the oscillator node referencing the pmic node will lead to a correct
> > provider/consumer devlink between the pmic device and the oscillator device.
> >
> > On the other hand, this is broken with "of: dynamic: Fix overlayed devices
> > not probing because of fw_devlink" works for the LAN966x PCI device use case
> > an lead to correct devlinks but breaks your use cases.  
> 
> Loading my overlay[1] causes the following changes under
> /sys/class/devlink/:
> 
>     + genpd_provider:ca53-cpu0--platform:e6e90000.spi ->
> ../../devices/virtual/devlink/genpd_provider:ca53-cpu0--platform:e6e90000.spi
>     + platform:e6055000.gpio--platform:e6e90000.spi ->
> ../../devices/virtual/devlink/platform:e6055000.gpio--platform:e6e90000.spi
>     + platform:e6060000.pinctrl--platform:e6e90000.spi ->
> ../../devices/virtual/devlink/platform:e6060000.pinctrl--platform:e6e90000.spi
>     - platform:e6060000.pinctrl--platform:keys ->
> ../../devices/virtual/devlink/platform:e6060000.pinctrl--platform:keys
>     + platform:e6150000.clock-controller--platform:e6e90000.spi ->
> ../../devices/virtual/devlink/platform:e6150000.clock-controller--platform:e6e90000.spi
>     + platform:soc--platform:e6e90000.spi ->
> ../../devices/virtual/devlink/platform:soc--platform:e6e90000.spi
> 
> Note that these changes are exactly the same in the working and the
> non-working case.
> 
> Removing the overlay again removes all added links, but does not
> restore the keys link:

I think you should have the exact same behavior with and without my
modification.

Can you confirm?

Best regards,
Hervé

