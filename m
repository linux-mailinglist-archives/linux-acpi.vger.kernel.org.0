Return-Path: <linux-acpi+bounces-12211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC39A5FA02
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A55A19C3997
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13C26B081;
	Thu, 13 Mar 2025 15:29:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928D26A0C7;
	Thu, 13 Mar 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879772; cv=none; b=UJU/JyYPaxNdwbxaoY00UIzQs1Y6r+jzW/gp6s9AIEw1az71luJmxD+ftSteeYu0aUDsLPv04ewPmekypGGCLCKGIiQkPygppExj8ym/g9Cg/GO+W8tRsyQBIlSt78rBhTLdeZ0zMhRzbGmRSkfop9fPqW+8dYxrCr2n0srXRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879772; c=relaxed/simple;
	bh=tFkBXBO/atiCQgL+I5PaOZGXAVe1jBN5O3xNDo6yR1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbTSKUfsgrjXDbXb+Cz57vH+MG0uLl6rqXGvg7wzojduSV588uicuYDcpYCSJ+MeRZERylnYxms94BLs32L6Xq2JDacCyAbQ9w6jhWaW7EPnsbFYjn7iN9l6pV1Qti5qYET0r0zwUltTkQpgzUcr+/DiPKnlSpvz6efrV+1EBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5675B1F91;
	Thu, 13 Mar 2025 08:29:40 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0E8C3F694;
	Thu, 13 Mar 2025 08:29:28 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:58 +0000
Subject: [PATCH v3 12/13] ACPI: PCC: Simplify PCC shared memory region
 handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-12-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=tFkBXBO/atiCQgL+I5PaOZGXAVe1jBN5O3xNDo6yR1U=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnFSHJPryKt07vGcR36CZ3Tqoh24jxtYMB9V
 LxA15/K79yJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5xQAKCRAAQbq8MX7i
 mHKRD/9NVdNYHghHeULoS8iAYKizbx6vIkwD75/H/+NAGPhtqEPDMpU/610A5bbuHziCX0OCTJ3
 8x5l4X2wqefQXo3RkB/O0whfjEcT5dLo0K9SVQxIiOmpkxhe5HPv6eIcjLWhPHwE03MwNcTAAaj
 7IJPtBUJ3duIuaLOdyL1oQEFGWsw40E+bGKgd7GXYybZAo5FJ+KxkIbIbETjP+FYbKSHOrm1Ayg
 AYEaWp+W87XQAdaXmY5U/BJpzEjkMv2U/kfw9ODFDD38vg+ZrgXJwpaz0AkNz86umLsrCoBOqN1
 m3s7m/bfwgRnz6bLaml7VxP3NBpTKzIyKwrYOOcveMKaHdPwyHbGh1teTbgzD9Ji3LCKRBhlXKO
 UH7jFatj3v/9s5+eQZim0FIFYBU2+d3U7cCsD9QIUOLoyqE/HkJ3/iw0ufA0PyAtQnYa0rP06pS
 HxEGqZhxh66XoNcEVJ3M/Xp7S83UgFSHtYBxB12ES4pNI5K72bMkSKDxeJSNI6x3/TD7ussZeqN
 3T/inRnrub/90eWeI6AyuAo5u8s0DwSCxri3lAB8jaMvl7PYqL4rEWh3e6TU4WHe0/+EH1YptBS
 azWez6IsZcTHfqKgZiKpTbPKRsvPhhqIph1twEwOZfejmvOMfMeLesd8nJ/l+qPzUC8J5wUNk8j
 IsACwertPVL3xnw==
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


