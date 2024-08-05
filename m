Return-Path: <linux-acpi+bounces-7297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD685947D2D
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11FD1C20F5F
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292115B54E;
	Mon,  5 Aug 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA2z+YSK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20BB15B104;
	Mon,  5 Aug 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869419; cv=none; b=hhd/MeRV4OoJU/lLf/OuZLDWoqbLgn3W2r9VfFXdJkQysQOL/NcLr8ofrmKVX3hmDPsgMgX1OL7edKlCH1r5tDh6Ewqyb9efLFMntI8hz8mx8ZFgDag/kXFbaN9oXdse5rSUEJ4qk5FURWNICZv6R8ovu6hsYRAtHRGx2joOCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869419; c=relaxed/simple;
	bh=TXubFA9EPG3koYRbq3Z+pWro6cSdZQFPedoTNgHKsIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBfGW3aPDQWkQCSVpjMIaMOVW0pyqu8E1Kej/leBoNuH/dEvKaeVk10KIFvLLSLN7LhIV+5OYzpoBVaL5EUrmgFHTTj17QDQyP7+92g+TnItYoefXgf9BeuCf5zPVvZaMvmSEJszAkFpFxs9b0R+h54os9GhKF/RHe3MR2A5VOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA2z+YSK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efd530a4eso16375425e87.0;
        Mon, 05 Aug 2024 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722869415; x=1723474215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPSBgbm3jpAmX4JgIT8jji/q0J8YfDHNM8+2dXWfMBo=;
        b=CA2z+YSK4I89eqiCNkzhQfrRuiTWaDixk9wsdftZW6rxwvYK16jauDpclOJa3fY/E+
         S1ujTgLyiPl8jl5yUVn7PK0oH+/gT8z2a1qXZiIp6dJAKYiXwkA1M9Q91lihCsWCmnKn
         KE75xb3E4YqVwvFw6NypkDjjNdKhV0ig5WUwZfYW6AFj9wSkb6rcruTVye02q/WTM8GK
         MKVKxsNoti1bjoet+7CSYLX2dOk22vIKzCYBHDeTGQGuC+HjcDq7VDMGNehBaNe2bBxO
         qfV76KQLX8ikGgmwVdOnIF/OpVlkKZxSCjTG/Us/yMl4uu5BegDrz70yx5CHxbxaDTxO
         E4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722869415; x=1723474215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPSBgbm3jpAmX4JgIT8jji/q0J8YfDHNM8+2dXWfMBo=;
        b=W2IBthzwbG7KryPij5PrWO8rX9fi5EQoX4M7nwK+Sau6bvABu/VHLD1VWsDQCiFf5x
         pVkxRk/sFW5f3NL89O5k+9FBi1juqO4p4tSgWMaoqsIOUGK/14svx8JfL+ZN4Xsd5VT+
         J9DRIAdV+bBNqRik/f2ytrOszNMo+QjWd1S8/pDVMAXHdycpcgapgWQaaX8gbnV75WJR
         kf3iZo7UOrs+sU4CvNfUM2rFCEI5JSltXQJk4RXpS1iOPH52sPySxSxWg9VhqCRPGg5q
         TxH/01pGYouSlCDbQwdM1APEfCXHZQXqCOpUPLCbCXm4B73CyKSOEMNR9mkM4OWyryD0
         vA9A==
X-Forwarded-Encrypted: i=1; AJvYcCVmMRmU+zlq7mKKvJMOsAwE1AP24co36Ly9+/u6cvYETXhK9PoczsSgO2jOusTxU4ZmBjyf/ETpom8999SppVJY92uor3PnJD+uwRI8KXsn6IweVKfMIpDZbhTrC8t6d2w6QHSNb+m1F0Z+O2xMzwYvlGgjatQoeQALajvZsrkBZT7PW6QuTTozNawvPy3iDh3WBOnpAOQBY/8c0DrE
X-Gm-Message-State: AOJu0Yxl7ol6astPjhS47r+ihErpYB2ks2IfH59RIEDd8WZeNXW3FvDv
	bwCv7khvE+BJ2CwKZjKShnP07Q0O9j+0+UU5Sc2cMiO8rn66YZVpNDV8Qfwp
X-Google-Smtp-Source: AGHT+IHGH9JX2RR9KngT55yV5101rsh+ddZ2QIAfLNa3pkQMsbItoMIF1Z9NpTiCFZd1aGc4XVB13w==
X-Received: by 2002:a05:6512:3da8:b0:52f:413:7e8c with SMTP id 2adb3069b0e04-530bb373e93mr8499417e87.14.1722869414972;
        Mon, 05 Aug 2024 07:50:14 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b82f308sm5004088a12.63.2024.08.05.07.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:50:14 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 05 Aug 2024 16:49:46 +0200
Subject: [PATCH v3 3/4] net: mvpp2: use port_count to remove ports
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-device_for_each_child_node-available-v3-3-48243a4aa5c0@gmail.com>
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
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722869407; l=2455;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=TXubFA9EPG3koYRbq3Z+pWro6cSdZQFPedoTNgHKsIQ=;
 b=c3q9MLjk2l9gK8uPqdN47FDouKz245XtE1QkVU7bUIc10J/nfciAxZqoXVodF6xXJEOSjulxq
 xtZ/XGFpzl+DGZXFlKVUC6pT7IDt5SrTEbcYqoZjzPieWoKRY9wluuG
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

As discussed in [1], there is no need to iterate over child nodes to
remove the list of ports. Instead, a loop up to `port_count` ports can
be used, and is in fact more reliable in case the child node
availability changes.

The suggested approach removes the need for the `fwnode` and
`port_fwnode` variables in mvpp2_remove() as well.

Link: https://lore.kernel.org/all/ZqdRgDkK1PzoI2Pf@shell.armlinux.org.uk/ [1]
Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0d62a33afa80..0b5b2425de12 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7655,12 +7655,8 @@ static int mvpp2_probe(struct platform_device *pdev)
 err_port_probe:
 	fwnode_handle_put(port_fwnode);
 
-	i = 0;
-	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
-		if (priv->port_list[i])
-			mvpp2_port_remove(priv->port_list[i]);
-		i++;
-	}
+	for (i = 0; i < priv->port_count; i++)
+		mvpp2_port_remove(priv->port_list[i]);
 err_axi_clk:
 	clk_disable_unprepare(priv->axi_clk);
 err_mg_core_clk:
@@ -7677,18 +7673,13 @@ static int mvpp2_probe(struct platform_device *pdev)
 static void mvpp2_remove(struct platform_device *pdev)
 {
 	struct mvpp2 *priv = platform_get_drvdata(pdev);
-	struct fwnode_handle *fwnode = pdev->dev.fwnode;
-	int i = 0, poolnum = MVPP2_BM_POOLS_NUM;
-	struct fwnode_handle *port_fwnode;
+	int i, poolnum = MVPP2_BM_POOLS_NUM;
 
 	mvpp2_dbgfs_cleanup(priv);
 
-	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
-		if (priv->port_list[i]) {
-			mutex_destroy(&priv->port_list[i]->gather_stats_lock);
-			mvpp2_port_remove(priv->port_list[i]);
-		}
-		i++;
+	for (i = 0; i < priv->port_count; i++) {
+		mutex_destroy(&priv->port_list[i]->gather_stats_lock);
+		mvpp2_port_remove(priv->port_list[i]);
 	}
 
 	destroy_workqueue(priv->stats_queue);
@@ -7711,7 +7702,7 @@ static void mvpp2_remove(struct platform_device *pdev)
 				  aggr_txq->descs_dma);
 	}
 
-	if (is_acpi_node(port_fwnode))
+	if (!dev_of_node(&pdev->dev))
 		return;
 
 	clk_disable_unprepare(priv->axi_clk);

-- 
2.43.0


