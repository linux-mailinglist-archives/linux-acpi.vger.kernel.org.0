Return-Path: <linux-acpi+bounces-11843-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10ADA50558
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75ABB3B1924
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC11EDA2D;
	Wed,  5 Mar 2025 16:39:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8349A1AB531;
	Wed,  5 Mar 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192745; cv=none; b=FLHTiJNFdbqWemBK9n3+yqnjsdGpeVUDeRk/J1PegoaqOlVS+t4LXfSN4QByoVhS/RCcoz4XNBuXUHEHPmop7J2SfcJ5LwalcMAWwtguX7BL62x33TYF3L5ZbPlgNJ6Fcqelal7d/0mrCc7CwmfHAM+TV61KP+rTH2FmEwPSJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192745; c=relaxed/simple;
	bh=12e2e0dB2lXxvdlCmBvDPuISEpM3AnCYciIJsM+VoEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIjhf2KVn2gAXe4FV9HYzFF7ziFWgneuD9KPOMxgMAVxX7UCc5fGf2ps781pGKK3DsSMmEOauxyHy/rGmq3vMuYywouWbHBG3epwEX2JW7xAx/xQl8qpUH47sLm3NHkY/mMXmC55tepb1BLjwKE2Myt5kqxQ+Kmghk9WBqmwq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16DA2175D;
	Wed,  5 Mar 2025 08:39:16 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A354F3F5A1;
	Wed,  5 Mar 2025 08:39:01 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:07 +0000
Subject: [PATCH v2 03/13] mailbox: pcc: Drop unnecessary endianness
 conversion of pcc_hdr.flags
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-3-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2041; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=12e2e0dB2lXxvdlCmBvDPuISEpM3AnCYciIJsM+VoEU=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4ea58zBwAHlZGatJPdQa+A347wiSYI+RQHQ
 eWjnwgAIvCJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HgAKCRAAQbq8MX7i
 mEKDEACiA2EUJ4bgtjGduofUPnjXlg3VIKPwHkTdnv09vKcIqmMN6SlDMhJSw1/15HH9144DcVR
 x+skEt7VLxJ3coBhfq4imjQYSD0FIwDzF7euIFDSxmSUlqVy3fCKlY7ydE2dRl343Eb5QIw/7mK
 6webgEO+d+TtJA87g73X+62/1E/RoUOwL5FCvZYHhYNxrnH6o+6LwbSAR8hwiQhRUMTdhKekOSg
 7nsPUR4DTYRkEH36vqCFkc3SxluGxpS622oWXWzPcH23SNrDMbpyASF3qU1PyoIpWou1Q2hIntX
 gs+akCD5V6MspWEUDzBq9INnNz8vNZn0mA0xx4NOwQrznZ9YOd9u2A3fXzSfWleGkUt8zO6FVsf
 cgrfY73dbNvp5kmPY0l26TyDYaEBtJOVxKGcyuQ6Vhvh8JZJmvs5MePH53f03/7d7DQchoYeoN9
 NCxEYsSJWAOtujBIpLb7PNuslbR82oA1Iutu1MDBGEBvyA/EqXa7+BnR67XUn1FAj08wrgpl5Nq
 rmvoBup5vD3kxajH4V4RE4oq1+HJRujBYTQIK/iUYKk/APAPxxlDxBmu/G5cvH94BwSxXZ4kwqA
 ByDX1dZyrYWNmj02unxi/vPVf2O432VjgjrS8VwiblOd5OvJHhkX0gZkNtPWlBbruuivQnzWJnA
 2+w/WCZAth/mJPA==
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

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 2 +-
 include/acpi/pcc.h    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 4c582fa2b8bf4c9a9368dba8220f567555dba963..42dd405482e407cf90e66917a46fb8e350e0eeaf 100644
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


