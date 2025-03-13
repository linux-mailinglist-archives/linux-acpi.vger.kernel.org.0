Return-Path: <linux-acpi+bounces-12204-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF5A5F9E2
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6734C7ADD1B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39186269AED;
	Thu, 13 Mar 2025 15:29:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80366269816;
	Thu, 13 Mar 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879761; cv=none; b=DeiSC1TchKpQkNZsYpCjQ2JlXGH/h/lPhTM16jc/omB1D1WblZGSkV3znmh3wH9roBimHZsSbt0bPGm4LzcHYNey2doFqwgky3FgediGvYYs0V0GTrBsLdpg5F0jb1oeigaSI3jq4O4nE1peC+08miEF5/Xx2dLGPUohPW5FGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879761; c=relaxed/simple;
	bh=VPUGFmtI1iuXgQ1aLwLZD3h5ALRy8oTBEohdtSGq27w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPpgmzEKIWDdmDmG99kBK2MVUFuYCMC+VY3mHKnneUDXJPp6LjoDeQZIzch65u0eR+wimS4SQA4ZOXkWIQJCDTPSDQA3wPrLqLN/QHkjOEBgBNMownkP2Xzvtc9ZT/o4ZrFPOcJ7+0E1nSCVRW7AGFTdOhnV4GBWO7BuYm+CRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34F2728C7;
	Thu, 13 Mar 2025 08:29:29 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC0113F694;
	Thu, 13 Mar 2025 08:29:17 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:51 +0000
Subject: [PATCH v3 05/13] mailbox: pcc: Use acpi_os_ioremap() instead of
 ioremap()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-5-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=VPUGFmtI1iuXgQ1aLwLZD3h5ALRy8oTBEohdtSGq27w=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnE/gW7t89bPt+5P7OubJum2RN+xBVtn0084
 +vQJXkWqquJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5xAAKCRAAQbq8MX7i
 mHrUEACE/ZPAxlV6/kkgqOfvdAFCaHif65+JA3vHEm0Ax0Td9qXsDubDCTNnA2TzjTnTvjGhZcB
 9Y7s9kxXkdyxXhuLytF8IAdzbZWmL4bRHETzKSFWPa3POC7tNPOtxUz2Jyr0OaMHUe1VdnmEeWt
 rIwOQP0ScEyzSY7v5VRHv88QSt25/hDbkvQAxPg1Otj2u3ZVneps3qhFgaYqzitsIlLBZWdbXzL
 e2Q1Z8dNAf2nT9pAjpThsmP30sgsRoLRImROnHor0pCxisIrieguyjB2yWRG4FYFW40cbHxknEA
 Wute2eTu6lfV8XCU9xjRP5PowuZ1V/vAn7RiiQVOlWLUjG4KwivdugZt+aF8E9rgcFWjOKfreqL
 ea64SL29i+GPQnnCDlCnd5aQdTTt0qdwoOwjeaE1BoUJAmRBDQIxl83e5n1qBPUWILJfwXHj8jb
 VHoKfoi/crqPekcPmN2ILRwDpy9SIa43+qLO0Q8FWnVzhVfZIEdcp+rAHFhb3FEPSchGbST0pXm
 bhRSRf16LDhH8SMHPaBOaguDvUD2Y6cApVkdwGcyaUJcFFZ0+1w216LZOZVdDmvoMKfU0tFni6q
 jh/GsFziPJZB6H1k9knNjN1axVAo/avdKpAOqSLkMRAX49SYw48S8sWTaYKswWahHpn/IoVtQGR
 rKG6Z0FAmaNay2A==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The Platform Communication Channel (PCC) mailbox driver currently uses
ioremap() to map channel shared memory regions. However it is preferred
to use acpi_os_ioremap(), which is mapping function specific to EFI/ACPI
defined memory regions. It ensures that the correct memory attributes
are applied when mapping ACPI-provided regions.

While at it, also add checks for handling any errors with the mapping.

Acked-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 7105dd6bc2fc6b8d36cb62f7ecd1b578361f89b6..fcbf19d7472d05f3c39389d292e6c6646e4b6b24 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -419,8 +419,12 @@ int pcc_mbox_ioremap(struct mbox_chan *chan)
 		return -1;
 	pchan_info = chan->con_priv;
 	pcc_mbox_chan = &pchan_info->chan;
-	pcc_mbox_chan->shmem = ioremap(pcc_mbox_chan->shmem_base_addr,
-				       pcc_mbox_chan->shmem_size);
+
+	pcc_mbox_chan->shmem = acpi_os_ioremap(pcc_mbox_chan->shmem_base_addr,
+					       pcc_mbox_chan->shmem_size);
+	if (!pcc_mbox_chan->shmem)
+		return -ENXIO;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);

-- 
2.34.1


