Return-Path: <linux-acpi+bounces-11708-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8675A4BD05
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9223170BE1
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B41F6694;
	Mon,  3 Mar 2025 10:53:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F9A1F5831;
	Mon,  3 Mar 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999216; cv=none; b=Z1WYI3qIJXLz0BuD+CBvdnULX7dNM3cliSAc9HMlCx/cqWf6C6sNzM8193QdMWPn2mO2r56cNVi2UII/peLiNNRHo8uZpke2HCVdkcX3HvSnKD9K1VFdS7GliULwsu9qUJKxq3Go03gm7M4JPqGJMTt3/9qdpldwT/6XqBV96Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999216; c=relaxed/simple;
	bh=u3wVE/ZfoE0JWVqpIaNDPrdp1FRUoL1ftJi5ZNONaTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4Y39QhYXFQ31Q7GPbpOTDaGIoxiFakklpUC75e5zAlRsNRiO1QTeQ/x5FzIQXC5xh7DO0wXxgKEHjMYQ1eH3K3KSbTUL/ra7cZE6uGz3XCLwGQT+QWeMYAELf5WU6qK/b/5VW16n/j+CUkg4TADTDPjuO2pdfAcZmHm2urWGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6976E204C;
	Mon,  3 Mar 2025 02:53:48 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C27D3F673;
	Mon,  3 Mar 2025 02:53:33 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:42 +0000
Subject: [PATCH 07/14] mailbox: pcc: Move pcc_mbox_ioremap() before
 pcc_mbox_request_channel()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-7-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2094; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=u3wVE/ZfoE0JWVqpIaNDPrdp1FRUoL1ftJi5ZNONaTk=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYoh25UXY+l7xb9TXLNxAznPkKfBn4zemN8E8
 acTboQdllaJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIQAKCRAAQbq8MX7i
 mJgnD/95AZ0+SFqGInKhDg71UUdviLxFz0go4EkfWDZ+L0XOJfU+TvLZPpWZoQ4Sz2ThyRudlSW
 o+3taV1QdQ9wHd+bs2ILbELpm/ybpxaPlVB5hbirgQgmx4njkhJNbhNyiec8Z+HnjXewVwmbZan
 KKIU/cjuEdj3sreZecwlGdW9jW5njnfSqMzWu5G2GHOlIf3jtYL+VuxPI8Sg/SjsvJNv7a/cJVN
 ABQAkGgbUWmB7gF7PJJrDoXGHLWAcAizzVJlWXPtXRG6Q3Gig8lgjqpbg5nRW5OVL+obP0Zlhbi
 uu4RsCLimRGfyCxAaohkg0h3E+Zdf2NXwIRO0BtwntdGWzgdX/Jwt651xQFhyEwaIDmC0iAPiD9
 YX357Qyko3JaNk3VuvgFiHpkZQaZ88taDkBYrSzEahFKsAZos23fBsRvQ07vU+KMowIeUag/QYB
 pPIXt7jghmRThAp7Fadcm+xZaKyVo+gI5URS/BDYaGKE47z0Fo7Earu4rtAU9im91zXII7PAcsM
 7k2SLQGhZQdxZYh0Cx8/IM+NFRoJm3eWHBStUA1r04H49kU9oUG0OpsdV2KnrOo/+dlgSgpmIAi
 qUTC/bk7Q1g5SCyw8ikgRJ9rCNEpWBWS9QgerEeYolAyLnLrdPwrGu45dh2y/tzZ2QRmMTTHTsA
 XA2tPhwdrJeFSlw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

In order to add support of mapping the generic communication shared
memory region in the PCC mailbox driver when the PCC channel is requested,
we need to move pcc_mbox_ioremap() before pcc_mbox_request_channel().

No functional change.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index e693675ce1fbd8d01d0640b3053a5c1882bdbce7..f230e512c29b79fc03e429145180ff049a250d2d 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -357,6 +357,25 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+int pcc_mbox_ioremap(struct mbox_chan *chan)
+{
+	struct pcc_chan_info *pchan_info;
+	struct pcc_mbox_chan *pcc_mbox_chan;
+
+	if (!chan || !chan->cl)
+		return -1;
+	pchan_info = chan->con_priv;
+	pcc_mbox_chan = &pchan_info->chan;
+
+	pcc_mbox_chan->shmem = acpi_os_ioremap(pcc_mbox_chan->shmem_base_addr,
+					       pcc_mbox_chan->shmem_size);
+	if (!pcc_mbox_chan->shmem)
+		return -ENXIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
+
 /**
  * pcc_mbox_request_channel - PCC clients call this function to
  *		request a pointer to their PCC subspace, from which they
@@ -419,25 +438,6 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
-int pcc_mbox_ioremap(struct mbox_chan *chan)
-{
-	struct pcc_chan_info *pchan_info;
-	struct pcc_mbox_chan *pcc_mbox_chan;
-
-	if (!chan || !chan->cl)
-		return -1;
-	pchan_info = chan->con_priv;
-	pcc_mbox_chan = &pchan_info->chan;
-
-	pcc_mbox_chan->shmem = acpi_os_ioremap(pcc_mbox_chan->shmem_base_addr,
-					       pcc_mbox_chan->shmem_size);
-	if (!pcc_mbox_chan->shmem)
-		return -ENXIO;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
-
 /**
  * pcc_send_data - Called from Mailbox Controller code. Used
  *		here only to ring the channel doorbell. The PCC client

-- 
2.34.1


