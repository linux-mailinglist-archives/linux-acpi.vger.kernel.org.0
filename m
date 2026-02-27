Return-Path: <linux-acpi+bounces-21232-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAlOCNyqoWkEvgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21232-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:31:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF391B8FFA
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD4AA30859D0
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35B22C2374;
	Fri, 27 Feb 2026 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WFH06/Qf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473CC265623;
	Fri, 27 Feb 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202196; cv=none; b=dOhKDft5ur3ID5YiXVtbIJd58B3swUC4OmWULn5eWlgRYFgW6JGs000OFJ+0wNvbNAB856ZIyMz4dv3b62zHHR6fbdhOQ9Srf+xiD7v0PCA6Y90xfVDq0y3YLueSAsFy7aVlZMgU8/DSG5k0xip7XR/Z/EZDADieYOK/UG47euI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202196; c=relaxed/simple;
	bh=ZOnoAzi/tWVfolm0QJOYymbD2sqoiY/nc8c+jGVTzlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mySGh7o3ENhjDvW+erf6NU6A4TD65mpT96qOMtDOZEitkLMriF+RhEfInM+qIwC+SyN7fiDW7nXtLxUz/xoo8CRBBbhnVlM7ZlqTZ2YzpBpJBf4jfmhmkJp0AOwPLs0b/fFufxbYyEo8eI/CHMS0HZV/6sx+OX2PnDZQy6aHYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WFH06/Qf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 02B664E41912;
	Fri, 27 Feb 2026 14:23:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC2B55FE74;
	Fri, 27 Feb 2026 14:23:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E8D510369462;
	Fri, 27 Feb 2026 15:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772202189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lqzD5+ZPd8kdWYW4RLHy/8j3RJjJSDBxD1vSEHspz5w=;
	b=WFH06/QfLF52gB4Dx6oioPbPIasxGEk0G1Iq9QmtfWj1x3WwdIwDWACf6H4Uat8FGt8OOV
	plcnvfGV4RPMR3GMrjCmPGd+2KRDTmCa3JfG7TM2JuI7tWrUZJG50rnv/WPLpCASYhu0il
	hI9axC/FGtCYcMt57uc47mhFx9oF1YKxiI9WJaIF2fis+UghfcTHW1lt3WLVeQp+eBRGzR
	0jYxamo2R3d/r1ojZPUXWuk43W5Ywd/vidK0bpFe1dOuF18Y7rO86OzFF6DyW6o99ZXOZ4
	0jaxwwXbqUVUxSCJPUlSS0T9Qsakta6ebrF3+Z+TDVZdktijo3WWvV2BEWHHqw==
Date: Fri, 27 Feb 2026 15:22:49 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Kalle Niemi <kaleposti@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Andi
 Shyti <andi.shyti@kernel.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, Arnd
 Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Charles Keepax
 <ckeepax@opensource.cirrus.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Len
 Brown <lenb@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Shawn Guo <shawnguo@kernel.org>,
 Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 09/28] pinctrl: cs42l43: Use fw_devlink_set_device()
Message-ID: <20260227152249.7c6c40f5@bootlin.com>
In-Reply-To: <CAD++jLmbg1FVGxv_7Lq4rOEbLAGh72YPTppOBcdpcsdLDo8B_A@mail.gmail.com>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
	<20260227135428.783983-10-herve.codina@bootlin.com>
	<CAD++jLmbg1FVGxv_7Lq4rOEbLAGh72YPTppOBcdpcsdLDo8B_A@mail.gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,huawei.com,intel.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com,bootlin.com];
	TAGGED_FROM(0.00)[bounces-21232-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 7BF391B8FFA
X-Rspamd-Action: no action

Hi Linus,

On Fri, 27 Feb 2026 15:11:13 +0100
Linus Walleij <linusw@kernel.org> wrote:

> On Fri, Feb 27, 2026 at 2:57 PM Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > The code set directly fwnode->dev field.
> >
> > Use the dedicated fw_devlink_set_device() helper to perform this
> > operation.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> Acked-by: Linus Walleij <linusw@kernel.org>
> 
> Tell me if I should apply this directly to the pinctrl tree, right
> now I'm under the impression that all patches need to go in
> together?

This patch depends on patch 7.

I think it could make sense to have patches 7 to 12 applied by the same
maintainer.

Best regards,
Hervé

