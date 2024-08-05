Return-Path: <linux-acpi+bounces-7298-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DBE947D32
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36E01C21B4E
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142FF15C124;
	Mon,  5 Aug 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4ufaUuX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40D15B153;
	Mon,  5 Aug 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869421; cv=none; b=GMGbLCVaYJ9dukx5HT3nhxVB/l4CLugeNjCiLJ8ZGFr1QAFpUX+RnP680vc+GJm/vQPMAYW4eQPPx76QWC5iTiv1yQHKVKd+G74A6PN9MbZDSOGXanhMNCiWd0Y+nRoSZaHzRtB5E/CAfXnGUPO2Vo5bmGAueVjrHCB1S2ieNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869421; c=relaxed/simple;
	bh=Gs9fUy9yW4JBBaoGjjHZoItLt9sngv838Y8XASfxmd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfPGelbSkakV0eQAzZ1Kz2FWhBfB/dh7stMGqUZ5qnFsqN1Tc63qOHuIybq1imVJaxNz3VqfpihcBDCazay2FC5nqXxXs1w5BONSvIpDoFko2PHJjf2HCV7ZXDSYnzKBT03QvNA3kL1QiG6R9zLzqNe3T3tkEHRiDUI3hTv6nSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4ufaUuX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso3413983a12.1;
        Mon, 05 Aug 2024 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722869417; x=1723474217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ni7itzdtEe2jfSTKg6OGqBXNu0xuqssIDqqXlEDVBsA=;
        b=a4ufaUuX/pM/iqtA6lccvy3jXjNL1tyC/LEcrkqBHJ7Wmi2o4/+N2RP4YoQpSKztHr
         4rigSN0vt89qJyA/MAOrUuI+cvtmsIJlB2Ti2uzZgkWWR5w+fW7LhTSkXK56gMvxbu2U
         OvJ5l/cp/3cgaLeBOEnHywva7aI1tFOfA58K69w4XzETNAg1Hh+hwbfEND6OtvdpTRNu
         QPB+7oAjyR/a/h0NLoDVEEo5AkImvGAiNyReLA5RKIHTnGZeyAAfmsn0TUb6096HuA1k
         +7mkME2bBBjlrTIQmjofayPRAMhVSAkDGXlgPoEWK5tSYqy/XgJXzJ7bUWwyWBnHuf8J
         Nqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722869417; x=1723474217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ni7itzdtEe2jfSTKg6OGqBXNu0xuqssIDqqXlEDVBsA=;
        b=ovNEqOASOtivpjQRbw1ySD9+VtUq2eisJZc1eTS8RXCMlSQalY2atqJUGUWMh6FqSb
         iud9rsXuR+Uf+qH9jaHT4rKpoYuO9lLK6GOWgCRkEKeTURIkoFo5GCBdirtx73VQgVec
         lI2xWklSz4ujB9RgKK2nWJfcAkrQOuH8kMruN/Ng0qbAWRHIbZ1isGbK1kOJ27hvRgrJ
         wejomZzSKwLURYVjsQag97/1OI+6YQ7ykGMvx65ggsSGq9BMNfCYpFGC1jcGnCKUXRvP
         4HAvtOIZqYw3NKAKLcbC20k4DifwyHLYAKnmrBrGZnveSBCCCpNlUIHu8SAAzYpIpDvi
         AFqg==
X-Forwarded-Encrypted: i=1; AJvYcCUfR/wJ/a+0TaD1Zta2qvB/QSnCEKIWThi0lbHFN3D8d7hvoUaOnf+dzNz4jM227xNn5D//3aVjdFEehQ==@vger.kernel.org, AJvYcCVH1jb5DLipSGrUGX1e3wcGJ6Om2M1ffGq7A6SjFHTD2fZFE8FLYoj7mHEM81bnkWkFAl3PoALI@vger.kernel.org, AJvYcCWtsFdWjuI+r5VoHkFMeSxv2kkO8nxPWjzt6E2mO5MWQfhIQZOjMkAZwVhWrmJ/Ue8vy+jey7b0wBl5eQ==@vger.kernel.org, AJvYcCXZCKIcfE9sYNYYpRA269ttkyB68sJcOoAcsGGPkmK/aO6DSmaL3cQJ6qC3KS2GbSLylFhwTnk6ImHFoV3k@vger.kernel.org
X-Gm-Message-State: AOJu0YxhtkiB6rD1e+dR6nYDYar/Q5kzmr5HpnSHcat2rpONPh8LupFj
	fW2GxuD54Cu7R9sjDNmkMK9lBuuNT09Pd1Yz6CREOPvHf/tuWjfa0bGqud/v
X-Google-Smtp-Source: AGHT+IEu7RnD//aEIHLSrf4o/e/BoWMlA3ETDJKKor1UP/ki+rOUQeZH+Has9o+RgFalA/2S8xJoVw==
X-Received: by 2002:a50:ee17:0:b0:5a2:a0d9:c1a6 with SMTP id 4fb4d7f45d1cf-5b7f3cc7429mr8033257a12.11.1722869417114;
        Mon, 05 Aug 2024 07:50:17 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b82f308sm5004088a12.63.2024.08.05.07.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:50:16 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 05 Aug 2024 16:49:47 +0200
Subject: [PATCH v3 4/4] net: mvpp2: use device_for_each_child_node() to
 access device child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-device_for_each_child_node-available-v3-4-48243a4aa5c0@gmail.com>
References: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
In-Reply-To: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722869407; l=2385;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Gs9fUy9yW4JBBaoGjjHZoItLt9sngv838Y8XASfxmd0=;
 b=ihHIaYtp6T390sCfrty1YjNtAYZGThIeMtguLLHG6L01jXTjdSZMRrfQVtNCN4wVYLLhSbRXX
 /RuF4YN2ObTAcdrI40NuECuErDk+DxTOna13wsTN0raOuLMubO8ZQZG
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The iterated nodes are direct children of the device node, and the
`device_for_each_child_node()` macro accounts for child node
availability.

`fwnode_for_each_available_child_node()` is meant to access the child
nodes of an fwnode, and therefore not direct child nodes of the device
node.

The child nodes within mvpp2_probe are not accessed outside the loops,
and the scoped version of the macro can be used to automatically
decrement the refcount on early exits.

Use `device_for_each_child_node()` and its scoped variant to indicate
device's direct child nodes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0b5b2425de12..216cc7b860d6 100644
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
@@ -7653,8 +7651,6 @@ static int mvpp2_probe(struct platform_device *pdev)
 	return 0;
 
 err_port_probe:
-	fwnode_handle_put(port_fwnode);
-
 	for (i = 0; i < priv->port_count; i++)
 		mvpp2_port_remove(priv->port_list[i]);
 err_axi_clk:

-- 
2.43.0


