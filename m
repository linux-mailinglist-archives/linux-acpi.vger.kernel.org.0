Return-Path: <linux-acpi+bounces-12976-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB131A85BB1
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 13:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A7F16D5E8
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4C822129F;
	Fri, 11 Apr 2025 11:31:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD9278E60;
	Fri, 11 Apr 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371113; cv=none; b=RViGS/qmoub96bakKuOQLraU0ROYI5vPT3awZMfA5VBoBO2srqcKPt/fe8A6TAPhlagbAUvdxpFC+xYrh8OVh3dHXMG44Ro5umXw8ccinA0GIghIKrajbhkePvIvgHx4N4Nc5qQWjGa1/O5AGZK0yqtNFQyfX2ZBBWcc63lSixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371113; c=relaxed/simple;
	bh=YU2wQBwNLXuHiinu6YIwWknnJ/JQO7XKsCNlLqHyvT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+ubVpz0NWJ1dLiCQjkVQO4Apb+araYf9CBK+QbrxlyqS2A2EK4dFYoLCZQxSdBNENuKjZG2zQTNQ+atBbJCDuo2UN8w/dFBIOfgYwU7yRoIYhUm45Ns6SVW3sGx+4SZ32NEO441lzJrVtpv+m2HTpgXGtjXxtq9OHn1rols6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4479106F;
	Fri, 11 Apr 2025 04:31:50 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E22463F694;
	Fri, 11 Apr 2025 04:31:49 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: [PATCH 1/2] ACPI: PCC: Simplify PCC shared memory region handling
Date: Fri, 11 Apr 2025 12:31:43 +0100
Message-Id: <20250411113144.1151094-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/acpi_pcc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

Hi Rafael,

This is just resend of the couple of patches that was part of a series [1][2].
Only core PCC mailbox changes were merged during v6.15 merge window.
So dropping all the maintainer acks and reposting it so that it can
be picked up for v6.16 via maintainers tree.

Regards,
Sudeep

[1] https://lore.kernel.org/all/20250313-pcc_fixes_updates-v3-12-019a4aa74d0f@arm.com/
[2] https://lore.kernel.org/all/20250313-pcc_fixes_updates-v3-13-019a4aa74d0f@arm.com/

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 07a034a53aca..97064e943768 100644
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


