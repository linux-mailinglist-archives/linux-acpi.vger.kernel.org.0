Return-Path: <linux-acpi+bounces-6999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C693853F
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9176E1C209BD
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F14016C6A8;
	Sun, 21 Jul 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO7JI9dD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020416C440;
	Sun, 21 Jul 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575175; cv=none; b=CnLaCkVd4Dtgf3uXBp9z+L+bOcb4VVb/8rhegIwaZXcqDnOKQg6wkPUAXHRRxpjShKig0gI5zGC1uVtzvcnn30JJEqqf4G0EoNCcvWip6wseptyz+H4+MspNPz5MmTSx4r8k1IkcNpZJ+nTKvz4dm25ESaq8nBKe3MGVhvUBylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575175; c=relaxed/simple;
	bh=7OWJetluoWS/Nf5AUxollSLUqkLBtNYzuJKo21kzZoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/zUGRATrRewvZsMmLFouAhpxuVpwGM8eaNyh43cItGRFr10HLuGHDVVnSu+yl6+aFZmR2+1li6q55lnB+5PbFpFXPoHQeEST4O0QRDYx/q/Oe6woTHq0Q5pQSJs40Oo5MUUV+ag8oA/ATzbXa1SnXGNZ7jq2TMod52EpLnzL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO7JI9dD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so2851008a12.1;
        Sun, 21 Jul 2024 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721575172; x=1722179972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWxQDkg0tjoveNQoAFF0zn3+Cul5K66566bw3Hq4SzU=;
        b=GO7JI9dDutHPHIPdTGjB5AdkL8QSL9z73dWvASktSLLjvYR8F80SYLYSXu4/q/tOqs
         N0w+mi8R6xnm2BqKgavgIiASf04RDNpKrmwllshTg8ldSLXF5KTDbeaDalx0/PwCR/hE
         vMT/fmsqloyLeSfbOc37IFYV129Mj/gE3aRLCYEC0Ggkh8eszlObJwXQCDCIEnXI8++7
         PbOAUNodDwaBX0ZKZUiU6fn2JC6EtZAEcHA3wk1975pKucj9eL90OG73A22fOweFHq8N
         rDqp3UrWW8JzC62MYXI0wUB/mJp9y84yt7as9L2AAfcf/m6ONOSYLJgaHaTbclix8pmU
         BqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721575172; x=1722179972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWxQDkg0tjoveNQoAFF0zn3+Cul5K66566bw3Hq4SzU=;
        b=iki50d1tqffTpVvMjwVVNVcXv76DjI9HKgouZPnZlpNXgp60M6nqgC6L3Aw9LbN82U
         1/vAa9KzI6tnQorDd9MQZxZKc3kNXA18e1qsXBO4Qdm5CsvXkH03+f2yaFTKTsiXw5ed
         VoPo5FfALrPWACE6Ppua1vG189mO1+cei0WPyJzKjdgmZtroXGGlkjQD4ZQeoACRzJyv
         ivIEoil9rJ+yp4WxCnyJNFQJUkuBNtmhG43XIVK6j7N3GqaOijr8XagBSqpksSFaQPsj
         jJItAWBXkhfmasK1noMpVZ0Bpt0asd4P8xgEgnnDWh6e7OMW7OD/J+p6jEMrfeQSxW7r
         lOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgmr5rqgSGz/TtL4+f1Epeo2ipMm4jUL1rOKAlQeWBwIxvcTUikwN3IrKoE6vSTaWHZkLTtK9bPBZbrNCg7a+hyy2XE11ISRWIdAK8o/YgJBGYF6NB7lIvLWsMJ/bj0/mWx8FzJwvCoMMXOcimnr0UY0gIE8nGott6X/r5qEdLiWfJyrR2LR/i639CVQGudz9mzQT0FoLhOpXD3YC9
X-Gm-Message-State: AOJu0YzahdMFJdjD+C8nF4D8Xl+7J4J8qCctqrW+IQ5BUVxjuRO4v6DZ
	DZBMllgk1s62GYEU7p54+hgR1Ec3iPqMp1WjO/T2aZ77uziRqxMc
X-Google-Smtp-Source: AGHT+IEVeHfDmq5X+0n82+27QM8fwNYvFlhBRw++xiui7Q80c9Brz+8apBbPFsTFmQPHrqEaUNy4ng==
X-Received: by 2002:a17:907:da1:b0:a77:d0a0:ea6d with SMTP id a640c23a62f3a-a7a4c011d3bmr308158566b.24.1721575171728;
        Sun, 21 Jul 2024 08:19:31 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-859e-243c-21d1-9ff6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:859e:243c:21d1:9ff6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c78603dsm302270366b.8.2024.07.21.08.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 08:19:31 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 21 Jul 2024 17:19:06 +0200
Subject: [PATCH v2 6/6] net: mvpp2: use device_for_each_child_node() to
 access device child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-device_for_each_child_node-available-v2-6-f33748fd8b2d@gmail.com>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
In-Reply-To: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721575158; l=3125;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7OWJetluoWS/Nf5AUxollSLUqkLBtNYzuJKo21kzZoM=;
 b=iNMnJvDJavKxd/cTaIQ/wI2+FJ4kPjgO9E1eheuFfGi79xO65EgIuqoenEmedZS7dH91lzXQt
 cx1BbNkkjcQC1xfO4u/nxdT4RF3p6HMHZwvY1HQLTf43XhDgUcxjsIp
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The iterated nodes are direct children of the device node, and the
`device_for_each_child_node()` macro accounts for child node
availability.

`fwnode_for_each_available_child_node()` is meant to access the child
nodes of an fwnode, and therefore not direct child nodes of the device
node.

The child nodes within mvpp2_probe are not accessed outside the lopps,
and the socped version of the macro can be used to automatically
decrement the refcount on early exits.

Use `device_for_each_child_node()` and its scoped variant to indicate
device's direct child nodes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 8c45ad983abc..f123072b1f87 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7417,8 +7417,6 @@ static int mvpp2_get_sram(struct platform_device *pdev,
 
 static int mvpp2_probe(struct platform_device *pdev)
 {
-	struct fwnode_handle *fwnode = pdev->dev.fwnode;
-	struct fwnode_handle *port_fwnode;
 	struct mvpp2 *priv;
 	struct resource *res;
 	void __iomem *base;
@@ -7591,7 +7589,7 @@ static int mvpp2_probe(struct platform_device *pdev)
 	}
 
 	/* Map DTS-active ports. Should be done before FIFO mvpp2_init */
-	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
+	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
 		if (!fwnode_property_read_u32(port_fwnode, "port-id", &i))
 			priv->port_map |= BIT(i);
 	}
@@ -7614,7 +7612,7 @@ static int mvpp2_probe(struct platform_device *pdev)
 		goto err_axi_clk;
 
 	/* Initialize ports */
-	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
+	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
 		err = mvpp2_port_probe(pdev, port_fwnode, priv);
 		if (err < 0)
 			goto err_port_probe;
@@ -7653,10 +7651,8 @@ static int mvpp2_probe(struct platform_device *pdev)
 	return 0;
 
 err_port_probe:
-	fwnode_handle_put(port_fwnode);
-
 	i = 0;
-	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
+	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
 		if (priv->port_list[i])
 			mvpp2_port_remove(priv->port_list[i]);
 		i++;
@@ -7677,13 +7673,12 @@ static int mvpp2_probe(struct platform_device *pdev)
 static void mvpp2_remove(struct platform_device *pdev)
 {
 	struct mvpp2 *priv = platform_get_drvdata(pdev);
-	struct fwnode_handle *fwnode = pdev->dev.fwnode;
 	int i = 0, poolnum = MVPP2_BM_POOLS_NUM;
 	struct fwnode_handle *port_fwnode;
 
 	mvpp2_dbgfs_cleanup(priv);
 
-	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
+	device_for_each_child_node(&pdev->dev, port_fwnode) {
 		if (priv->port_list[i]) {
 			mutex_destroy(&priv->port_list[i]->gather_stats_lock);
 			mvpp2_port_remove(priv->port_list[i]);

-- 
2.43.0


