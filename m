Return-Path: <linux-acpi+bounces-11806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E27CAA4E9CD
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 18:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674F6423F8E
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475A727EC77;
	Tue,  4 Mar 2025 17:19:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089E27EC69
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108792; cv=pass; b=nd0drf9hGWcP3DwmlbdE5zT49O0sdM3OVEXyde+XvOGsCQBmNHH7q0x5FPDHHMnrM8ZaV7iuenGtIVYy+o2DAv6mFDlt9eu+bmz3GiUI0TJgUv/cMM14GcnfE+GzP02rpxkd5mpWCO5ttlE6GcsihS0i2UEoODwNu0JLsCs8E4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108792; c=relaxed/simple;
	bh=qKYQ/RpHnPPi0xz+U1dihMeF/+HcwhhzvfPtYWgkvCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kg5UWJlHPvWqD4iy15/wDKSm6y2McH5BlGz21zlY8zTs6qvu95iP6fHQdvbufME8bCrsK1LP7F7h+5mprFj+SCtzuFcH/mIgxr6MYhYZCd1EBKUxdZ4QWXX11FLs2HPdjiq/vbibVWEyngg1jzrEvICjjKLHYgHnEw7PClXe4JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 2A9B240D572A
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 20:19:48 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fj61WngzG0T0
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 18:28:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id E9A054272E; Tue,  4 Mar 2025 18:28:31 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541454-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 7526B41F10
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:57:45 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 26FA4305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:57:45 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C676172641
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9371F9F64;
	Mon,  3 Mar 2025 10:53:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80FC1F8AE2;
	Mon,  3 Mar 2025 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999223; cv=none; b=AChXIWWbSGvoKjtkDj36sZe1V6IVHEXjDCU06bRvarqzxI7jMptQvjk6RkpOUPX/PUIJLp/XVYqU+vDQf2mWm/Fg5OTo5YPYzbxTURBlVDZUSJzSQ+17sIRE93zfRAQvIHf659gbBk9P6cWftLdGlvtBcV6gilgJql8bh7BCoF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999223; c=relaxed/simple;
	bh=qKYQ/RpHnPPi0xz+U1dihMeF/+HcwhhzvfPtYWgkvCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+ivxV4DBbdDdINjB7PqEYgBjbfdqKGRJdq6+Ok/g2ok+c28Sv+aNk6wy2/ZOtFwIuHj0YaCjZKOa9VeT7Nmj7VGFtGEZ5ZxIIa82LHMTm+gdEChnYAu5ObPCYDM1aO+O95wtT1vO1W+qqA2LwIJHYz7HqeIRYNI9bO+EPzaqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6B6C113E;
	Mon,  3 Mar 2025 02:53:55 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FC6A3F673;
	Mon,  3 Mar 2025 02:53:40 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:47 +0000
Subject: [PATCH 12/14] hwmon: (xgene-hwmon) Simplify PCC shared memory
 region handling
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-12-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 linux-hwmon@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3678; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=qKYQ/RpHnPPi0xz+U1dihMeF/+HcwhhzvfPtYWgkvCg=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYoiJfyJ15B7dZMCKbfDh7KWMxlk1zX1nXbFZ
 DSDENvulASJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIgAKCRAAQbq8MX7i
 mOOJEACk8HwhoV/kf4yQTtXA0+Bt6TAgAQcmvhIbnJbmQo6uNeuyvNtO6AJ4hp2bBhQshaQw/O5
 EJ/zNcpbsEojllwwlLTXEySe3nChK24CyD5Hz/DbGKOrZNTE6ZPI2nN7d7ids2MfY3gnpJRe+EY
 JSuME2353lxcPdMkxQD0SU5auKiZJzQJXZNsmwCII+ibzjmokrbjDIdDnmi5gG9SZ/3Z3MYOAb+
 UjqklBafICGSMLwE+zmaIYwtt1v0RZ7swQHGkNMHAc/Q6HyQCR9tM8DMeGq9ezKkV7S7cU3eApR
 bVJmjqNa7Tz2U9z59MMvtfCS5uYcSY5hNk5s0asxqgQA/sW32EdUvI1AUj9jo6jEzjqBYzSLTm7
 UbnG/UCJYSDSZqThECQuw3zhvwCdiSwC4593JGU4SIDWuZ3KxGAybmi2T4YsBgKg7FoI5YuDs7F
 0x5PH5nD26+wtjhRIfYcvHDjZzFQJrUFcee3epOIiPYflGlKgS6Gdx8ymxUhcfIc+LXV0e0fjrv
 iFrgf7J3PAs2slBNxdLJ+VCtUxx6s147rt9O1XarZ4TDmRDTh751OhsGFsqJeF5cEK6H3Yqs7br
 PrEnT+KfL563qBk10DtcNPuQ9fTiK9gLXm1SrbF6MDC9ZdpbqwFGVtUVNzlPm0iYt1S4wgdnR0j
 Wb96Xqm4w4wZD3g==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fj61WngzG0T0
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713482.02606@PfxkhUeipqY9ALq0Bng1wg
X-ITU-MailScanner-SpamCheck: not spam

The PCC driver now handles mapping and unmapping of shared memory
areas as part of pcc_mbox_{request,free}_channel(). Without these before,
this xgene hwmon driver did handling of those mappings like several
other PCC mailbox client drivers.

There were redundant operations, leading to unnecessary code. Maintaining
the consistency across these driver was harder due to scattered handling
of shmem.

Just use the mapped shmem and remove all redundant operations from this
driver.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwmon/xgene-hwmon.c | 40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 1e3bd129a922d25ff25142d864503377773304a8..ea350d4de902c4e6fc4de1cd54a8b75edfad1119 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -102,9 +102,6 @@ struct xgene_hwmon_dev {
 
 	struct device		*hwmon_dev;
 	bool			temp_critical_alarm;
-
-	phys_addr_t		comm_base_addr;
-	void			*pcc_comm_addr;
 	u64			usecs_lat;
 };
 
@@ -125,7 +122,8 @@ static u16 xgene_word_tst_and_clr(u16 *addr, u16 mask)
 
 static int xgene_hwmon_pcc_rd(struct xgene_hwmon_dev *ctx, u32 *msg)
 {
-	struct acpi_pcct_shared_memory *generic_comm_base = ctx->pcc_comm_addr;
+	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
+							ctx->pcc_chan->shmem;
 	u32 *ptr = (void *)(generic_comm_base + 1);
 	int rc, i;
 	u16 val;
@@ -523,7 +521,8 @@ static void xgene_hwmon_rx_cb(struct mbox_client *cl, void *msg)
 static void xgene_hwmon_pcc_rx_cb(struct mbox_client *cl, void *msg)
 {
 	struct xgene_hwmon_dev *ctx = to_xgene_hwmon_dev(cl);
-	struct acpi_pcct_shared_memory *generic_comm_base = ctx->pcc_comm_addr;
+	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
+							ctx->pcc_chan->shmem;
 	struct slimpro_resp_msg amsg;
 
 	/*
@@ -649,7 +648,6 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 	} else {
 		struct pcc_mbox_chan *pcc_chan;
 		const struct acpi_device_id *acpi_id;
-		int version;
 
 		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
 					    &pdev->dev);
@@ -658,8 +656,6 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 			goto out_mbox_free;
 		}
 
-		version = (int)acpi_id->driver_data;
-
 		if (device_property_read_u32(&pdev->dev, "pcc-channel",
 					     &ctx->mbox_idx)) {
 			dev_err(&pdev->dev, "no pcc-channel property\n");
@@ -685,34 +681,6 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		/*
-		 * This is the shared communication region
-		 * for the OS and Platform to communicate over.
-		 */
-		ctx->comm_base_addr = pcc_chan->shmem_base_addr;
-		if (ctx->comm_base_addr) {
-			if (version == XGENE_HWMON_V2)
-				ctx->pcc_comm_addr = (void __force *)devm_ioremap(&pdev->dev,
-								  ctx->comm_base_addr,
-								  pcc_chan->shmem_size);
-			else
-				ctx->pcc_comm_addr = devm_memremap(&pdev->dev,
-								   ctx->comm_base_addr,
-								   pcc_chan->shmem_size,
-								   MEMREMAP_WB);
-		} else {
-			dev_err(&pdev->dev, "Failed to get PCC comm region\n");
-			rc = -ENODEV;
-			goto out;
-		}
-
-		if (!ctx->pcc_comm_addr) {
-			dev_err(&pdev->dev,
-				"Failed to ioremap PCC comm region\n");
-			rc = -ENOMEM;
-			goto out;
-		}
-
 		/*
 		 * pcc_chan->latency is just a Nominal value. In reality
 		 * the remote processor could be much slower to reply.

-- 
2.34.1



