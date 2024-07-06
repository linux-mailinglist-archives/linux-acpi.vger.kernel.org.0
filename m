Return-Path: <linux-acpi+bounces-6794-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D187B929489
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 17:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B4CAB21C3E
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B214535B;
	Sat,  6 Jul 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmTPtclV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34E143863;
	Sat,  6 Jul 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279447; cv=none; b=pcVLdQeBNjUQUbD6OJ6nyllE4g1DRI1HcVxTypm1gDAIsX2FwsR7DIzdpC4kDDD0bfQx0wBzk3OEsRptPqC7UmPxknjpYxDqK24ji2SWxBTTmWPmtWuLLx9+eOuMmWZZkeKs3w0gg4neVqEZiH9ARV/OXoWhqxMcyCsYOXMIFDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279447; c=relaxed/simple;
	bh=FqQDDFZRZErZwoVBwncsgkhb9stwS0b2C3AaKUJjEeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nl7SRTjc6x4QIV7n7p1DQdK3OSNVFQtxc6NkIYNwDkDVGLIPotufthjeUtmjHeHcI1f1gFWmbKWUl6pKtTjx5y5XhDz4Zt/CuNkRQbdr4MknJDfIa7U1nw3VtC4TVVHC14jHe/AmK051xQH1A6x9PbwI4kLw86efmpPO7l0AyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmTPtclV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4265921b0f6so8161545e9.2;
        Sat, 06 Jul 2024 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720279444; x=1720884244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Snaqybo2SQ9uek82H01UqwsbwzQvNpsRmSQLWD2DPEc=;
        b=nmTPtclVWbXXf9fVkcsiqzpYV0sSMcryc+3JCFktfHhmbTQLTkZ3vFknMLVrF+RA6m
         wgHSMch4CzE5Qsc8C5O2B3MYWnKQTk78vQnsqgfAjmrmvSp2kU+rTMXPyaUVlmqtWHio
         HNSSEnD12o/DrA4mRHq3xoKt8SfNVaGzZmfTTH3+RN5abJ8Ft45EDFdFCpHDpSF8Kx9d
         6GO2T17GJXXN1ImLepzWRvpC1TQ2sWHJN+YxGXEK342LfQFtwwYfWFvi9vz5CnNDbBw/
         e30Sr0zNk3P4zE9YBeuYfjSn9O8udxj0T3hb80VdOwbFSLJQ3iee5JOe4kOk16stov5u
         TVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720279444; x=1720884244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Snaqybo2SQ9uek82H01UqwsbwzQvNpsRmSQLWD2DPEc=;
        b=bjP6taPJPoolTEtyUscs0aaGC7n8qpavgrUz8A6FcWssktdqvROoSs3D8lxNPk3ezT
         WsybCP7XktSWVRSKx4fB4fH5ND7HC/wLbRJejBLsnlKpdSZMOIi4gnoEABW8FfePS1E6
         HDNk72XFJ6JcBD54eOO+DsQ2mp5fCrrd+2OkRbDwoBq6sUlA3klLA/IHe1/4dC9AtMeh
         Ns0bmcY+zltNzeOBLKbWFs55WLpdSgmY/6ZZh3zWhHEa/7XdpN7Cek/YTRKjebX1FDDZ
         J5i/no1kJfHTWKdz8Xem80S77nGNv9aWV0aXjobkmGHNTjW/LaN0JkK6eHGAgUR4Shm+
         axYw==
X-Forwarded-Encrypted: i=1; AJvYcCXTvpEzeoYa0juJ46lywheiX+bejod5ZI4N+EsrM8uRD1yNd8XcQcX+4bFQ6ur1FBz4XUItt1+b8PnvbKRe0FO8JQ2zhVB4BLGcQnZ7S8FGozvsZ1uU3CtQdyFNxXeKNfO5zBsY7WgO/HUEyMg4SKO8xqKRymntWLOrzI9lTHkO2XjKD6Ps3wvmBLeyd0M7/r+ymnY9L57pB2bUUpPO
X-Gm-Message-State: AOJu0Yybr2Voiy1Y1JT0PhBdNaSLLzrdALwO6Ib9FeGzP4G7+evej3mI
	K1D8lPcJVs1xSAczdOJFTk7v3T9d4yEGCgriFogNLJItF7nmxm+c
X-Google-Smtp-Source: AGHT+IHcEq8Yc3mYNalQX8RlmIf4m62FTVZhE01QeXRyiVYmbmbL9x/FzVMFnqzIuz8+XRLsKWF+iw==
X-Received: by 2002:a05:600c:4fd3:b0:425:672a:766e with SMTP id 5b1f17b1804b1-4264a36eea8mr56784065e9.0.1720279443721;
        Sat, 06 Jul 2024 08:24:03 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d11b-8ec4-ea76-796c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d11b:8ec4:ea76:796c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679ed376cdsm6421593f8f.114.2024.07.06.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:24:03 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 06 Jul 2024 17:23:38 +0200
Subject: [PATCH 6/6] net: mvpp2: use device_for_each_child_node() to access
 device child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240706-device_for_each_child_node-available-v1-6-8a3f7615e41c@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
In-Reply-To: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
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
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720279430; l=3064;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=FqQDDFZRZErZwoVBwncsgkhb9stwS0b2C3AaKUJjEeM=;
 b=iYfjox0buokEbZZKDxP8IjBs7/BLHuTRJspiW0SQNWK4kaEyOHbevnTQUZFZMwWBmoXcBYvtO
 WPOUxSokjULCQwJBFziUXz70jl9I43krYe0vWYwX507MG+hQrbPBtUA
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

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 9adf4301c9b1..97f1faab6f28 100644
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
2.40.1


