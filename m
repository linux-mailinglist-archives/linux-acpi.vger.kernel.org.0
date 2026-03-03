Return-Path: <linux-acpi+bounces-21309-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAgZHlPxpmmSagAAu9opvQ
	(envelope-from <linux-acpi+bounces-21309-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 15:33:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4B81F18B7
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 15:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 344093072DB5
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D907E4279E9;
	Tue,  3 Mar 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d/O+JXo5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F09426D17;
	Tue,  3 Mar 2026 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548119; cv=none; b=OC75F4bHbkC4PMXmeePNa+WG4ngzcyFbL5mDYSpXyB3pHGvANnO2NfdQiYWsXlrL5eUhTnEw3Ms8qeFZLYy6z74gu1dgItl8P6yiN40oPqM5REs2iODP0VC13CRgE+lp2Jbqr8hfdZa/9/+VNkp3VIbPIl6GAsGL5tixOdwqAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548119; c=relaxed/simple;
	bh=sFdspMKJumEMO4fDQc2+117471ZtpGFHB8cFzHcqV9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8n8KdcANGeo5HgRhp7ATof0t1m3PSlrlvObMxNog3FLmh4gnm3KfYUejjZ27p1Y1F/lB9gi/D1MrzkeqCAC4bqrdUsKMmzBPHU8QKX7NF0mwW4DGqwh4wQvbPfRIX1W8WAZu2L6HKKwkuq54fmm/cu2pdv+TrItM7KtuC0j05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d/O+JXo5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 03C62C40FAC;
	Tue,  3 Mar 2026 14:28:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3AFBB5FF87;
	Tue,  3 Mar 2026 14:28:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2BC881036864C;
	Tue,  3 Mar 2026 15:28:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772548112; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GWUy5XUp50lxxjU1GZxGSJIelBHwpc1HiL3azJ0BLV4=;
	b=d/O+JXo543vedMVvGLT5gKQytZfFXK8awsVgYA6R2ojxBslqYDSqG0VaRPH7bRUxFJlQN8
	1vkegNiRGY41CrTbPRA1NgXIqSpHHXeFNACKcalOr4bzHngc7EbH0CSSUuvUxXHy5MVFSy
	vEESymOX/4StaUul4BCuzjnEikImvMMtImKAjJiVJGCmUvbpNeHT+w2j0OOFIPwqXLeYpl
	cStsMnmcoZTIpyS3EgJxQykjVvH8H5XHlQadKad7TsG6qk3H2sE9QULsdlhxCLsvdS6N3P
	Oejd8rD6YiajdGxXjpbhWcTxEQM/3Nco4XUAiT9M4D/MHRwg24QTsSLti/Lp2w==
Date: Tue, 3 Mar 2026 15:28:12 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>, Kalle Niemi <kaleposti@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "Michael
 Turquette" <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Andi Shyti" <andi.shyti@kernel.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, "Arnd
 Bergmann" <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Charles Keepax
 <ckeepax@opensource.cirrus.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, "Linus
 Walleij" <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Mark
 Brown" <broonie@kernel.org>, Len Brown <lenb@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 "Shawn Guo" <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-clk@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
 <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 11/28] cxl/test: Use fw_devlink_set_device()
Message-ID: <20260303152812.5d699701@bootlin.com>
In-Reply-To: <20260302122449.00006c77@huawei.com>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
	<20260227135428.783983-12-herve.codina@bootlin.com>
	<20260302122449.00006c77@huawei.com>
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
X-Rspamd-Queue-Id: 5B4B81F18B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,intel.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com,bootlin.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21309-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[62];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

Hi Jonathan,

On Mon, 2 Mar 2026 12:24:49 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Fri, 27 Feb 2026 14:54:08 +0100
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > The code set directly fwnode.dev field.
> > 
> > Use the dedicated fw_devlink_set_device() helper to perform this
> > operation.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>  
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> From practical point of view, what path do you expect this to take?
> Is there urgency to make the change, or does it make more sense to
> add the helper this cycle and cleanup up the various places it can be
> used next?

I hoped to have patches 7 to 12 applied by one maintainer on his/her trees.

As it is related to fw_devlink, I expect to have them applied by a driver
core maintainer.

Any other plan can work as well.

Best regards,
Hervé


