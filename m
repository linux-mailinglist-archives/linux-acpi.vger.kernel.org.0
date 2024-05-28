Return-Path: <linux-acpi+bounces-6051-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1598D1898
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 12:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8F9283A58
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 10:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234E716C68D;
	Tue, 28 May 2024 10:27:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2D16B743
	for <linux-acpi@vger.kernel.org>; Tue, 28 May 2024 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892045; cv=none; b=kys2TGM/fHEw+d+d7IDUHrVUL1qHqk9Av4u1K1q6oW4fbjd5U/airj0kZosh/VwUvYhAz8frvB2iAB1KCeWY6ZmUAqRqazNzADqitkh0UN5mxC1FmOX+r55BLz8BC476pRp9j1S7KMAvemmCACnlCpEdQdzRwR/cnfeRnmL5z7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892045; c=relaxed/simple;
	bh=BNnZ7gYxVPG+zhntrXhysWWcp6Wfp3QG2SUsNPXf5hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXEyNNfmlZWAYk1xX8OBCCIP5iQZ2sswcg1IOYOxeOqEV5Fuz58FfSoH5bXiYPtLysWOVpHyV6uSEAELXNPpYioW/FGT0SgK5Rm/CCeXMYwsafZ44nyBR6npgmPKfthQt964/Os7D62iHnzBKRQi1dPd4oz5mddQ7rRMOzCgljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id dd9a6722-1cdc-11ef-aaf4-005056bdd08f;
	Tue, 28 May 2024 13:27:21 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guanbing Huang <albanhuang@outlook.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 2/2] PNP: Hide pnp_bus_type from the non-PNP code
Date: Tue, 28 May 2024 13:25:03 +0300
Message-ID: <20240528102708.1451343-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528102708.1451343-1-andy.shevchenko@gmail.com>
References: <20240528102708.1451343-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pnp_bus_type is defined only when CONFIG_PNP=y, while being
not guarded by ifdeffery in the header. Moreover, it's not used
outside of the PNP code. Move it to the internal header to make
sure no-one will try to (ab)use it.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pnp/base.h  | 1 +
 include/linux/pnp.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index e74a0f6a3157..4e80273dfb1e 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -6,6 +6,7 @@
 
 extern struct mutex pnp_lock;
 extern const struct attribute_group *pnp_dev_groups[];
+extern const struct bus_type pnp_bus_type;
 
 int pnp_register_protocol(struct pnp_protocol *protocol);
 void pnp_unregister_protocol(struct pnp_protocol *protocol);
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index a8def1cea32c..7f2ff95d2deb 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -435,8 +435,6 @@ struct pnp_protocol {
 #define protocol_for_each_dev(protocol, dev)	\
 	list_for_each_entry(dev, &(protocol)->devices, protocol_list)
 
-extern const struct bus_type pnp_bus_type;
-
 #if defined(CONFIG_PNP)
 
 /* device management */
-- 
2.45.1


