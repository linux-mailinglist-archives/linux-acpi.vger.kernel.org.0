Return-Path: <linux-acpi+bounces-11845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF8A50551
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B51169889
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662EC253B43;
	Wed,  5 Mar 2025 16:39:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E313225332F;
	Wed,  5 Mar 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192747; cv=none; b=a6sNIYleBHgQRBiuvtDkuCR8DLZEM2vCskaZcCNnnVzd8W9pOeW19nDfZ99amwfQmbFMVRHPz+BxRWIFfkfW8hIWvWT4wwMW0Inap1mfF4EMYfX+K1nhMM/qIf9yh5Ji5ySiKBkKmVSAYds8VsAe75xIBgTPKBjf2+xe+Cqjnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192747; c=relaxed/simple;
	bh=9BkIGgfS0RG6AgwZYwfBR/H6S0S8n79d9GcPGd/VSic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mo5JhpRo+8AAXl0DmpvQbySO0ivhje50686g+vqoEAnjrfbR6EURCOUgTmvMCFVViwZ0eEdd/Y6W5AEtcikxRiNO/8bbHUOkkCbMG3202ud9HHfBpL5SjwdnbeqKVOGL4885QukClR39V6FZGPt7jm2jgezX/cM/wnC2ZO3L4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071561FCD;
	Wed,  5 Mar 2025 08:39:19 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93B253F5A1;
	Wed,  5 Mar 2025 08:39:04 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:09 +0000
Subject: [PATCH v2 05/13] mailbox: pcc: Use acpi_os_ioremap() instead of
 ioremap()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-5-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=9BkIGgfS0RG6AgwZYwfBR/H6S0S8n79d9GcPGd/VSic=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4fdgv5QsAezQ1z9+Y/UIgvXihIakDP3PBkG
 aQ54yp0LPmJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HwAKCRAAQbq8MX7i
 mNjiD/9n5QdcY5P5URbCWoCuIspKXYgjIPDgULuV396obVfUUwZ2yEgG6gZGocPnt4a1F5jVitE
 q67L4yKR07ux6FMMccGGGoSICec4E7VpOXstbA4bqh3RU08BEx/W9vGffT90h0K5b1YfyizjC1q
 XSDUlSx4/x6wclBJvAIt1H+VcOu9apAJChg6scCjkLAc4riPOb0xb7bVssxy9MDi/7Y0ZU2hLKN
 nyCswu7zmIdm3t/m53tnmnaRa8kmVCHtuoUmAeQm7Ml9mmbooc+rrcBFGvlw98nwvkjdyeykdjG
 yyX4SAbWLEcolYShuown4clTzTnZJ1VtuOfmH9ubYuK+sAYg6E5vyh8276KkPgvds7oPo+7tT0b
 yaRBuy7Gz8pcdj2BCzTihktMUY0VqinX7IaO03zmVUyQ6PVSsuvn5OaNjU1icYOMaNlUJ36k7CK
 39wA+Ab4UaAh0JDEt1GOZXf7QZwWdrf/URwOych4le3BbCW/FNfps//lDgRocZTmfdTYHsI3sGd
 Smp+euoONXFR6DSP6HQSm8715Tnw99o38hYZBuiFIdoT7uHug8WJI2Wfw2jEeVqSKSnOrp6OqVQ
 emKvEQqjTZxXPRagfwhXY8gSmBLDo0aUQzIpIapojLY9tfml4vWVT0SOjumZ0ryoi/QUVb1SQlV
 NH9SNjZO8LcXk2A==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The Platform Communication Channel (PCC) mailbox driver currently uses
ioremap() to map channel shared memory regions. However it is preferred
to use acpi_os_ioremap(), which is mapping function specific to EFI/ACPI
defined memory regions. It ensures that the correct memory attributes
are applied when mapping ACPI-provided regions.

While at it, also add checks for handling any errors with the mapping.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 5a9ae67f5c50a3e43d30aa368c31c80b81db01f7..b1b8223b5da7002fc522523dbc82f6124215439a 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -418,8 +418,12 @@ int pcc_mbox_ioremap(struct mbox_chan *chan)
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


