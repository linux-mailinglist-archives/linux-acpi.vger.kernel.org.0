Return-Path: <linux-acpi+bounces-11943-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DC5A573F9
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 22:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92ECB16D8E4
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 21:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64651B4254;
	Fri,  7 Mar 2025 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KMB6+/+M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5800B63CF;
	Fri,  7 Mar 2025 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384186; cv=none; b=lHsFDlHxGfffzBKWL+80YDsJmtcv1rBzM++SL2eHATTh1gSQmbYkpv6phCB1ECvJQMXg8Gy3kWZSkkIQxqQT1GenyQef30Lz5W6BlhDSx9zPLq+BjQh0r51ALpE7chSpD3k7Ynn3kiy6L2IiFPTH7gv8vgxB8KnAs/AmWxKziow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384186; c=relaxed/simple;
	bh=GNtu/FYVOPpx1D8ovsMcUOZSryKBm6D3HYLuaMozZZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ec4wz2USxtIeDh17b6ZOp3WCAH2yoB+S8FNSU8+9QWu/xizP0fXfGiwAXQgnTEGjt1+F9hpX8yDWSTTPP6H3Jsc4mRlSmSkdRC8B4YZNPZ0GWTXimzRx9ZXTPN8oyEi0MGrDhzd0zAyQVxje2d9kfl1qLeUQzmZW37NJw2OOYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KMB6+/+M; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kEIoVsmgphcJxiinYI1QXjOtupscvV7ehu3P/xwclBU=; b=KMB6+/+M6LgnpkmU
	P0qg/zKFRiMsrCCdPMewfKO6bzBKvHtfpg/xKovWnqyx0M+7dCe/hbdDTmZ+4pvhZ0N3prId/1/KC
	S1LcCTZeg/zp8ReO5qAo9R2iwRDhu5Qg5025W5CoFHkJSxIdThnzM7sqwF57D+AkgLcpujiyiqw/Q
	Za5iub/ZV7Y2My/byrgeWB7WqA0N0GZJHPOv3XcuydRcUwNTCjkd5QpSTGxMeQEE269RcMnFaTk5f
	4apjQh+BS2wtEsNnzbLoLUK3620f4asvvFB+TJmSHF9CxngBJjDngnCrRi63CnyZAlSt+ql6wiWRE
	EgsWlHZ6QECnLZ/cwQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tqfZZ-003WVM-2v;
	Fri, 07 Mar 2025 21:49:37 +0000
From: linux@treblig.org
To: rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] PNP: Remove prehistoric deadcode
Date: Fri,  7 Mar 2025 21:49:36 +0000
Message-ID: <20250307214936.74504-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

pnp_remove_card() is currently unused, it has been since it was
added in 2003's BKrev: 3e6d3f19XSmESWEZnNEReEJOJW5SOw

pnp_unregister_protocol() is currently unused,  it has been since
it was added in 2002's BKrev: 3df0cf6d4FVUKndhbfxjL7pksw5PGA

Remove them, and pnp_remove_card_device() and __pnp_remove_device()
which are now no longer used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 Documentation/admin-guide/pnp.rst |  3 ---
 drivers/pnp/base.h                |  4 ----
 drivers/pnp/card.c                | 32 -------------------------------
 drivers/pnp/core.c                | 16 ----------------
 4 files changed, 55 deletions(-)

diff --git a/Documentation/admin-guide/pnp.rst b/Documentation/admin-guide/pnp.rst
index 3eda08191d13..24d80e3eb309 100644
--- a/Documentation/admin-guide/pnp.rst
+++ b/Documentation/admin-guide/pnp.rst
@@ -129,9 +129,6 @@ pnp_put_protocol
 pnp_register_protocol
   use this to register a new PnP protocol
 
-pnp_unregister_protocol
-  use this function to remove a PnP protocol from the Plug and Play Layer
-
 pnp_register_driver
   adds a PnP driver to the Plug and Play Layer
 
diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index 4e80273dfb1e..b342570d0236 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -9,7 +9,6 @@ extern const struct attribute_group *pnp_dev_groups[];
 extern const struct bus_type pnp_bus_type;
 
 int pnp_register_protocol(struct pnp_protocol *protocol);
-void pnp_unregister_protocol(struct pnp_protocol *protocol);
 
 #define PNP_EISA_ID_MASK 0x7fffffff
 void pnp_eisa_id_to_string(u32 id, char *str);
@@ -21,9 +20,7 @@ int pnp_add_device(struct pnp_dev *dev);
 struct pnp_id *pnp_add_id(struct pnp_dev *dev, const char *id);
 
 int pnp_add_card(struct pnp_card *card);
-void pnp_remove_card(struct pnp_card *card);
 int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev);
-void pnp_remove_card_device(struct pnp_dev *dev);
 
 struct pnp_port {
 	resource_size_t min;	/* min base number */
@@ -138,7 +135,6 @@ void pnp_init_resources(struct pnp_dev *dev);
 void pnp_fixup_device(struct pnp_dev *dev);
 void pnp_free_options(struct pnp_dev *dev);
 int __pnp_add_device(struct pnp_dev *dev);
-void __pnp_remove_device(struct pnp_dev *dev);
 
 int pnp_check_port(struct pnp_dev *dev, struct resource *res);
 int pnp_check_mem(struct pnp_dev *dev, struct resource *res);
diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index 9610a9f08ff4..c7596dc24fbd 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -269,25 +269,6 @@ int pnp_add_card(struct pnp_card *card)
 	return 0;
 }
 
-/**
- * pnp_remove_card - removes a PnP card from the PnP Layer
- * @card: pointer to the card to remove
- */
-void pnp_remove_card(struct pnp_card *card)
-{
-	struct list_head *pos, *temp;
-
-	device_unregister(&card->dev);
-	mutex_lock(&pnp_lock);
-	list_del(&card->global_list);
-	list_del(&card->protocol_list);
-	mutex_unlock(&pnp_lock);
-	list_for_each_safe(pos, temp, &card->devices) {
-		struct pnp_dev *dev = card_to_pnp_dev(pos);
-		pnp_remove_card_device(dev);
-	}
-}
-
 /**
  * pnp_add_card_device - adds a device to the specified card
  * @card: pointer to the card to add to
@@ -306,19 +287,6 @@ int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev)
 	return 0;
 }
 
-/**
- * pnp_remove_card_device- removes a device from the specified card
- * @dev: pointer to the device to remove
- */
-void pnp_remove_card_device(struct pnp_dev *dev)
-{
-	mutex_lock(&pnp_lock);
-	dev->card = NULL;
-	list_del(&dev->card_list);
-	mutex_unlock(&pnp_lock);
-	__pnp_remove_device(dev);
-}
-
 /**
  * pnp_request_card_device - Searches for a PnP device under the specified card
  * @clink: pointer to the card link, cannot be NULL
diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 6a60c5d83383..ac48db6dcfe3 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -78,16 +78,6 @@ int pnp_register_protocol(struct pnp_protocol *protocol)
 	return ret;
 }
 
-/**
- * pnp_unregister_protocol - removes a pnp protocol from the pnp layer
- * @protocol: pointer to the corresponding pnp_protocol structure
- */
-void pnp_unregister_protocol(struct pnp_protocol *protocol)
-{
-	pnp_remove_protocol(protocol);
-	device_unregister(&protocol->dev);
-}
-
 static void pnp_free_ids(struct pnp_dev *dev)
 {
 	struct pnp_id *id;
@@ -220,12 +210,6 @@ int pnp_add_device(struct pnp_dev *dev)
 	return 0;
 }
 
-void __pnp_remove_device(struct pnp_dev *dev)
-{
-	pnp_delist_device(dev);
-	device_unregister(&dev->dev);
-}
-
 static int __init pnp_init(void)
 {
 	return bus_register(&pnp_bus_type);
-- 
2.48.1


