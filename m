Return-Path: <linux-acpi+bounces-21296-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOKjDDSBpWl1CgYAu9opvQ
	(envelope-from <linux-acpi+bounces-21296-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 13:23:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB97D1D83C7
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 13:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15845304953C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2026 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B027136C9CF;
	Mon,  2 Mar 2026 12:21:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22557175A85;
	Mon,  2 Mar 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454109; cv=none; b=fSYEIBWbOM9kvRzQ7C8pXjKui+Y5Fxpw+D9OmAHbmPg7t0wxQFdloEtshM9zmKa+jiiZp+xT0fKpujZIfIZHAJaloavzQgaQfz/NraQi8WGe4pWPykEHrGpcVDzsCShSLEkviAT3lDvuloMiQVoPdHGxmyultIAfnFM4rqK/6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454109; c=relaxed/simple;
	bh=hY4/1V4CPkbzOM46xddbLCRjIns1Rne2oR81yNkRkMQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zs4I+AmdVZGEnrx256SEazhMrm2xjZTnZ7Qlty/7b7bWlrXt4b6GHsRRB/3Z4wA+27U7p3yuwrb0qUdxhvJAniS4/hAeYLnMSeNlXAX0ft3vdu/4sffPPrqxPdP2BtOB4mB72fTGd/OzFNy3ySDjeqauPHGpiCfGslzsVigw97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fPdLq4LTKzHnGhl;
	Mon,  2 Mar 2026 20:20:51 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 53AA54056B;
	Mon,  2 Mar 2026 20:21:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Mar
 2026 12:21:41 +0000
Date: Mon, 2 Mar 2026 12:21:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>, Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, "Sascha Hauer"
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "Michael Turquette"
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Andi Shyti"
	<andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>, "Arnd Bergmann" <arnd@arndb.de>, Saravana
 Kannan <saravanak@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, Charles
 Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald
	<rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, "Linus
 Walleij" <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Mark
 Brown" <broonie@kernel.org>, Len Brown <lenb@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, "Shawn Guo" <shawnguo@kernel.org>,
	Wolfram Sang <wsa@kernel.org>, <linux-kernel@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<patches@opensource.cirrus.com>, <linux-gpio@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Allan Nielsen
	<allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli
	<luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 10/28] cxl/test: Use device_set_node()
Message-ID: <20260302122139.00000041@huawei.com>
In-Reply-To: <20260227135428.783983-11-herve.codina@bootlin.com>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
	<20260227135428.783983-11-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,intel.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21296-lists,linux-acpi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,bootlin.com:email,huawei.com:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB97D1D83C7
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 14:54:07 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> The code set directly dev->fwnode.
> 
> Use the dedicated helper to perform this operation.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  tools/testing/cxl/test/cxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 81e2aef3627a..3d9107b2661c 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1136,7 +1136,7 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
>  {
>  	device_initialize(&adev->dev);
>  	fwnode_init(&adev->fwnode, NULL);
> -	dev->fwnode = &adev->fwnode;
> +	device_set_node(dev, &adev->fwnode);
>  	adev->fwnode.dev = dev;
>  }
>  


