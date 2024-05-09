Return-Path: <linux-acpi+bounces-5700-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57C8C17AA
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 22:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FE92826BF
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3FF7CF16;
	Thu,  9 May 2024 20:37:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58BC2C6;
	Thu,  9 May 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287066; cv=none; b=eelgS0gD+O39ol9FAPLvaGHXJ5Xea8f7m1I1bsanZ2wpP+L9gGp2JhN9GLYrezsLgxJkzDP1VLzyS5JTX1TfeD718bRNtq/LXx61KdZgWi0V9SW7zCUEhxpZi/ba+87eL6iNpxOyC6tfZ2FXdUpOPrBcFipR1T5YhPfyGavtQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287066; c=relaxed/simple;
	bh=Nu8yKBaS56CMBP5odvTg9R8vfM1PHiuEmDmPEvzkkxw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OCG+MLHz1hJc81kaPeKn6V5Vir9oGXsL87vr03qDYm8gcixIap5g3wRVyUiIUIWjdw6ZCuIHp85FPO/RqhC3Db4nGtmlcrLqpjOA/4yFry6RbMHtvVMwyD2eidl1CAbSyrm5/Yam9Tcy3vmozACQmRCV/a7mbxhyfKtODX5YpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449J48x4022119;
	Thu, 9 May 2024 13:37:24 -0700
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y0qpbvcp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 13:37:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 May 2024 13:37:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 May 2024 13:37:23 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id D1D0D3F703F;
	Thu,  9 May 2024 13:37:22 -0700 (PDT)
From: Vasyl Gomonovych <gomonovych@gmail.com>
To: <lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
        <rafael@kernel.org>, <lenb@kernel.org>
CC: Vasyl Gomonovych <gomonovych@gmail.com>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: AGDI: Add missing newline to log
Date: Thu, 9 May 2024 13:36:15 -0700
Message-ID: <20240509203657.3377168-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kRC2rY97doE9Vlyyg8xOert3WoW0Iopk
X-Proofpoint-ORIG-GUID: kRC2rY97doE9Vlyyg8xOert3WoW0Iopk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_12,2024-05-09_01,2023-05-22_02

It is assumed that log statement print a newline, fix two
missing ones.

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/acpi/arm64/agdi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
index f5f21dd0d277e9612c444c62843b7bece450706f..5d0548f3194a3352ce6b4931c8ea4a445359e21a 100644
--- a/drivers/acpi/arm64/agdi.c
+++ b/drivers/acpi/arm64/agdi.c
@@ -32,7 +32,7 @@ static int agdi_sdei_probe(struct platform_device *pdev,
 
 	err = sdei_event_register(adata->sdei_event, agdi_sdei_handler, pdev);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to register for SDEI event %d",
+		dev_err(&pdev->dev, "Failed to register for SDEI event %d\n",
 			adata->sdei_event);
 		return err;
 	}
@@ -104,7 +104,7 @@ void __init acpi_agdi_init(void)
 		return;
 
 	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
-		pr_warn("Interrupt signaling is not supported");
+		pr_warn("Interrupt signaling is not supported\n");
 		goto err_put_table;
 	}
 
-- 
2.43.0


