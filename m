Return-Path: <linux-acpi+bounces-12201-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC94A5F9DB
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9697A6ECE
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0582690E3;
	Thu, 13 Mar 2025 15:29:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D8E269808;
	Thu, 13 Mar 2025 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879759; cv=none; b=Qi7mzKfLl9kVpHtBlXJXK4QewWAGGFQY7aqm1NuU+r9xeUpURKCXwUqZ8MVpLTW3b71nRuXnMApq59nZtni50/QVZhfKsektclVv2AaBHBIcEQ2af2sC3GQkbvA+K7sAYTFmR/yyxx33TvyrIv/yOt5s+t4m6U1QAe4AwlTu/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879759; c=relaxed/simple;
	bh=UCfoq5iv8gZQgWR9g+UiHw55YgFlpcDqEVY1HoIkIzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTbV4gPFcINTshxFpZAt1+av3Gk0XGIeYYbqIcErG94ZbWfO8Xzf8DUzeuCnpCYvADIVzIHaE/0NM0Gi2kc3Z10YcHg+Wm6/2GP5jkdmNqtktY1wTXeiaNPNXwB6y5IwpfAZJRl5CPa2e5Ca0vx2888kzU17PAFqryvFT56vCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C29E201B;
	Thu, 13 Mar 2025 08:29:26 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAC1F3F694;
	Thu, 13 Mar 2025 08:29:14 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:49 +0000
Subject: [PATCH v3 03/13] mailbox: pcc: Drop unnecessary endianness
 conversion of pcc_hdr.flags
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-3-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2141; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=UCfoq5iv8gZQgWR9g+UiHw55YgFlpcDqEVY1HoIkIzs=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnESUxQx6rqi4Q0YSvDGMvX2KJJ+P4dmoQm4
 knxotCnrqOJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5xAAKCRAAQbq8MX7i
 mFcNEACxVrjtPjXpBrEX4HVnmPkyaozacS2YdnDAtATsCmJJH2+5LDQNqHnMecgrqJEANJwRme0
 hLu1ZsDgYlr/KJWA2Y/sG76wuOesNLtAFdj+5lVgtHjed0VlNlcSP0utcVQFKVyB/svHm8E4FXV
 lf8xoD72n9kgSiGXOupWk0dH/MvcX5l2DXMCz8WiUbpuljps5T7OPmxWDGZS9Oqgq77KL418COI
 TIZNwZ+DU+8vAYpGRPi1wR2vwc1ZFpRaxBtwaW8zojjOwtXs5qLpGcX6IE2NFDOwdxvem44+ask
 R17UOwRmP56W/S/8T1fG8se/XdkYr7AyZkUKFbuJBs4nghj+dANbAmhUsimWp/3cHIr2duqwzK9
 FFHYrt9peo82QB4+g4wSflJ7QZbX/lFB5F1FzJXN3BSA6i5/1OF9pxCLK0wXOAJrhqu0datP06+
 WUQe2JVMGHZ4Sd1Vd6RnHyQ/LDKuBlwCaBw98Op53Ai1xovRz1hjYrnzKzpJLb8lEfH4v1hiOEj
 +dUE2atz0HcH8+w1PmEQ8OxB+j/HUwzwO4tw3o2Pjo/QxiA+GB/HoNLy2Epq/DChudtsN6YdfGU
 B6H1yvDq1fIPJyycStOuGZQs0f/IammcpqIbzMLXh6LJ9knE0c4bzpYRhUNtiHvfAOm1ZvrMnnk
 eMgt3Deld7vGQKA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The Sparse static checker flags a type mismatch warning related to
endianness conversion:

  |  warning: incorrect type in argument 1 (different base types)
  |     expected restricted __le32 const [usertype] *p
  |     got unsigned int *

This is because an explicit endianness conversion (le32_to_cpu()) was
applied unnecessarily to a pcc_hdr.flags field that is already in
little-endian format.

The PCC driver is only enabled on little-endian kernels due to its
dependency on ACPI and EFI, making the explicit conversion unnecessary.

The redundant conversion occurs in pcc_chan_check_and_ack() for the
pcc_hdr.flags field. Drop this unnecessary endianness conversion of
pcc_hdr.flags.

Also drop the redundant PCC_ACK_FLAG_MASK definition and use the
more appropriate and already defined PCC_CMD_COMPLETION_NOTIFY.

Acked-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 2 +-
 include/acpi/pcc.h    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f8215a8f656a460b38806d4c002470c3fe1e3c9c..9cf0ca772c1adb73ceb91d25a2abd1d12c678d90 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -292,7 +292,7 @@ static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
 	 *
 	 * The PCC master subspace channel clears chan_in_use to free channel.
 	 */
-	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
+	if (pcc_hdr.flags & PCC_CMD_COMPLETION_NOTIFY)
 		pcc_send_data(chan, NULL);
 	else
 		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 699c1a37b8e7846362bae35477eb5736be15d79e..d1e506f041c5a80857d4a025fa3c1803746ba4b9 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -32,7 +32,6 @@ struct pcc_mbox_chan {
 #define PCC_CMD_COMPLETION_NOTIFY	BIT(0)
 
 #define MAX_PCC_SUBSPACES	256
-#define PCC_ACK_FLAG_MASK	0x1
 
 #ifdef CONFIG_PCC
 extern struct pcc_mbox_chan *

-- 
2.34.1


