Return-Path: <linux-acpi+bounces-21307-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJhkMLzspmmQaAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21307-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 15:14:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2B1F1320
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 15:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1371303A3E9
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2483B3C05;
	Tue,  3 Mar 2026 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PKXnJBTJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843043B8936;
	Tue,  3 Mar 2026 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547163; cv=none; b=AdUGQpVlROL+Z14INEJ8seuKhTb5bRHdBQQaW+vzQ4c4ejOEw+rqrx0x0Km9e2uIpBAAy4WtOpd+AzSaq7RU6gu9Ek/d5f9OAUH7828g5InHAfu9YvqS+E4IFcWsRt7f+fugz0ZjMBKraw6ag9RyjdWU8BN5rJbVjVnP4g4qZVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547163; c=relaxed/simple;
	bh=dPGInr9bJSJ4aaTC8V6Vfs27BwEv/iSgsWjWG9xQ8Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgGNSRa/nRW5IUISlBVLbf+ovl5eEyjETSImOEm7ZHdN6xbs09HGwUiqCOD9N5rkwRvh5+5wy0VtvRYM6iNiW8ozPXwpeLp2AzAzmdgZ0XA7900RLSh2scJtePmNbDrAurC4XHdAOjg4ge0m18Xp2EONxBKsdHQmhZQHwKW0PJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PKXnJBTJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F0B891A2358;
	Tue,  3 Mar 2026 14:12:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0FF95FF87;
	Tue,  3 Mar 2026 14:12:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29A51102F19D0;
	Tue,  3 Mar 2026 15:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772547155; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NDntnEFk19MkiUVyHnkpMvjEQ0xuOComNTKHqxzRgtY=;
	b=PKXnJBTJeOSAhEFdsakoatz9eZVQJsYsja7QCQMQzgMh/5rn1PRNYjh0Y43mXfXGOsBQe3
	ylbpcNlkEYOZJgf5w2TjuKlN6BoKRqaUv2T7NSWnft4+R5CB1JRZXmzrvE9foIFtljC0dX
	9lnks0jyXkMRsFdgc/AIne583SVg0IBmmZGSlbX4ZFFiZoIRIMxN3ep1XEp5lG3ykQNMTV
	2MMAGU53bJevHap0Qjn6XIWdND7dFzJBZWAWKL1cGUcMwe1FByNjIm1aDXdWkatlTF4u4d
	eRAAosIijuZ77ayzdkxgCV3s0AjnR8VvyjdUbgJKG2IeDC3gKeA+0ZFLN444JQ==
Date: Tue, 3 Mar 2026 15:12:10 +0100
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
Subject: Re: [PATCH v5 07/28] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Message-ID: <20260303151210.6e8462b8@bootlin.com>
In-Reply-To: <20260302122336.00006bd8@huawei.com>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
	<20260227135428.783983-8-herve.codina@bootlin.com>
	<20260302122336.00006bd8@huawei.com>
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
X-Rspamd-Queue-Id: AFF2B1F1320
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,intel.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com,bootlin.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21307-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[62];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

Hi Jonathan,

On Mon, 2 Mar 2026 12:23:36 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Fri, 27 Feb 2026 14:54:04 +0100
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > Setting fwnode->dev is specific to fw_devlink.
> > 
> > In order to avoid having a direct 'fwnode->dev = dev;' in several
> > place in the kernel, introduce fw_devlink_set_device() helper to perform
> > this operation.
> >   
> I don't mind the helper, but the description could do with a little
> detail on why.  Is it just to avoid visibility of internal details, or
> is there a stronger reason?

I think the idea was to avoid visibility.

It cames from feedback received on my first iteration
  https://lore.kernel.org/all/20250408145139.293c79a2@bootlin.com/

I found the idea relevant and so I did the patch.

Best regards,
Hervé


