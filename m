Return-Path: <linux-acpi+bounces-11851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2507FA50564
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF8F16CE33
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4E254B19;
	Wed,  5 Mar 2025 16:39:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D00B24F5A6;
	Wed,  5 Mar 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192759; cv=none; b=XHiz0TqYVu/FJIM4FEEyMoJmaM4wHbLlQgPqPuzjoA4s5nJC73TMzuKLDv0QjBILc2xZYqRj8oNEFE79kwOIMYd9PlaQRzc25i6TK4Quo+gEJzfV3rVu8qfj31pXzz5NB0NxZ8i9j+XB0SuBLWbXz3OPRP/2nriWrHu86pwXcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192759; c=relaxed/simple;
	bh=tFkBXBO/atiCQgL+I5PaOZGXAVe1jBN5O3xNDo6yR1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ByJPRs8PGFWtWq6eXh0uK571ANsnlRq40UHOho/5p1tTJ5kHv1IkYrqDH5JH/BNl4ByH3LL1XFJ0L5hOPFOge5bJlLh4AFA/NDbz3sVhSbpB0Oe73l3OT8y9Gpe+1EqgVOthDGJV47JYggtw1XHqtLeyEN4rSoz0MevuZFr+auc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D00E1007;
	Wed,  5 Mar 2025 08:39:30 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95BC23F5A1;
	Wed,  5 Mar 2025 08:39:15 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:16 +0000
Subject: [PATCH v2 12/13] ACPI: PCC: Simplify PCC shared memory region
 handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-12-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=tFkBXBO/atiCQgL+I5PaOZGXAVe1jBN5O3xNDo6yR1U=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4fBs6KUn9ck2ci3zzCHWjTUV5jpju76ILak
 Mj7PGqwh6OJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HwAKCRAAQbq8MX7i
 mGH2EACASilhQ00UNq1paOOrLBKFTnZALt72kTxJlFX/+vRI4ihGJsufAbyKpAB3bdUMfhlhUhq
 rOwTvRomIYPPAU+ysqHN2KeH5EZpKkr2k2Bk2u1iz7Ic8hhY7cn2B+WzHXkvEpeAZiEy2MPsmJr
 1yp58cNVXxldEYc7MHbgBY1ztBDkkrdQs1mwCYD0JTYMxSvWgp11Om6CcdeOedqpBfdVBDxP1yJ
 uTrB6spoy1CXDvwiE8nTWeDkegyX2ifHzDsM10F+Eg2GDvBfvjBTb5DMJgfir0vXKoLaI/bhQWA
 YiQBAYOlnVepdmnYSxPG7Z4Z1FyNvei0mRxfruf6EScKbJzDet3NjuVz7GkxtYxYhqpgwAXjgOA
 4OjISuYixUN/8ikNKw7UP9EsETVUIAFHAEcoiz4tQ1PynusQo1QaHyAHNtQXZidc+YRSSi7dJZJ
 s8RLG3eHfAF5NS54xvpZvwCLJt9mgCluoRCDuEqzIsFacfAj3n4pse13vfWdcl3ZtPxjjqDiFzB
 Y9NJ5oOZ6boSgOV9qAdtAY7rZeFqJ8Dbq4PfJzkOH34qhg4GAsyPzDpxxWpmXN2U/JhE496DQcr
 YgBxMmo40FRtQ3QB2E71v0BDnlc0Hajo1LDdXSecO1HNmV9spgnlaCODFHSAeqmN8qt+HXxKi5O
 F+nTyEf6UDZZUYg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The PCC driver now handles mapping and unmapping of shared memory
areas as part of pcc_mbox_{request,free}_channel(). Without these before,
this ACPI PCC opregion driver did handling of those mappings like several
other PCC mailbox client drivers.

There were redundant operations, leading to unnecessary code. Maintaining
the consistency across these driver was harder due to scattered handling
of shmem.

Just use the mapped shmem and remove all redundant operations from this
driver.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/acpi_pcc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 07a034a53acac1e8307265bcc5572054d34d971f..97064e943768ad9f1704effa13dddbc0876a9452 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -31,7 +31,6 @@
 
 struct pcc_data {
 	struct pcc_mbox_chan *pcc_chan;
-	void __iomem *pcc_comm_addr;
 	struct completion done;
 	struct mbox_client cl;
 	struct acpi_pcc_info ctx;
@@ -81,14 +80,6 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 		ret = AE_SUPPORT;
 		goto err_free_channel;
 	}
-	data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
-					      pcc_chan->shmem_size);
-	if (!data->pcc_comm_addr) {
-		pr_err("Failed to ioremap PCC comm region mem for %d\n",
-		       ctx->subspace_id);
-		ret = AE_NO_MEMORY;
-		goto err_free_channel;
-	}
 
 	*region_context = data;
 	return AE_OK;
@@ -113,7 +104,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 	reinit_completion(&data->done);
 
 	/* Write to Shared Memory */
-	memcpy_toio(data->pcc_comm_addr, (void *)value, data->ctx.length);
+	memcpy_toio(data->pcc_chan->shmem, (void *)value, data->ctx.length);
 
 	ret = mbox_send_message(data->pcc_chan->mchan, NULL);
 	if (ret < 0)
@@ -134,7 +125,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 
 	mbox_chan_txdone(data->pcc_chan->mchan, ret);
 
-	memcpy_fromio(value, data->pcc_comm_addr, data->ctx.length);
+	memcpy_fromio(value, data->pcc_chan->shmem, data->ctx.length);
 
 	return AE_OK;
 }

-- 
2.34.1


