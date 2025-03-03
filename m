Return-Path: <linux-acpi+bounces-11706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530FDA4BD00
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A772171689
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593E1F5435;
	Mon,  3 Mar 2025 10:53:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A971F4635;
	Mon,  3 Mar 2025 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999213; cv=none; b=M0vFo8qR70DfOR3BY1DwU/z+LFQ6iztcSj7OoYL9FsEDetOXVHpCO317u1JzkqQB15nr+ywZt780Z4MD5WmseK1Fb0BYGNQLRHWt4ZPmVPnc/wxZ61K7HcLQ+WhaeCKPUWT/t6P4amqVnaWAbQoyh/mcvfl2rXCdEvOguCav2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999213; c=relaxed/simple;
	bh=UbmacZHuc0rkrUhM8NEGGe2sjhxY+p2kFyDwy7F6O9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SilJqwpSOgytkAkuKO8hXoJmvwC0PwFHuz8S/D4JXUx2x5E9WeaZ3lfI07etQGzHDjpfTqzMOhCsgvV4/24NN9j7MEd8ggpm2MZQ7JxB6EYNpbQk82/G9mZGb2k8Mh7vGqz043GCHUz74Xbr74ExnDfKCRYgsnZ+SEh9k1sM37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C16C31FC7;
	Mon,  3 Mar 2025 02:53:45 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A57CF3F673;
	Mon,  3 Mar 2025 02:53:30 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:40 +0000
Subject: [PATCH 05/14] mailbox: pcc: Use acpi_os_ioremap() instead of
 ioremap()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-5-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=UbmacZHuc0rkrUhM8NEGGe2sjhxY+p2kFyDwy7F6O9g=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYohDnfLle7CFfvs0cbGHG+605WgQHE8GV+YO
 iXyfhUuk1+JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIQAKCRAAQbq8MX7i
 mCJTD/9tHPMsmYiCLgOELz0+VsOIsbtVXK06UOdVm5UAe+fTPWEd0bNLOlxhr2w6NdQ+bbuM3QW
 UE7/33ijae/yOzWqWRFTi2MIKj0BOtOg+Msox9oGXEkPz7o6P3WVs/s+PHWiKFaJ/O85kqnKtAX
 puwQeVseE+8P0h0J4h/4i8QlSi+Gi+Za7z7UhMwZPsGmWqoTu6jg42wvPCVyMmU+PSOlAeA+9Uo
 Lad0W1JTpz33WArz/7ZtnTkr4XdgqgyMJkIB1lZHNEnMDiqWF/6o5BcFdRS2c+ysBAF/rxRYIdr
 E0/vAzokYXFxB6cHYhgB3bqB1R6P0E/fUuIFwqg7vOHUuVX21AyO/STjH+kJ7ilvVnL28mr4yMQ
 A4iNv+XhT0x68wYCZteEVJiaz/CT1AlqbguP8RuhPVFUu+v8arjs/nKf0YzTX2sWVQv9YTjGIPz
 oSV+YtbVoHgO5Mm34oO6Lm95SLIuEB8JcUlAyyPrB+qwqHTb5Q5WG8lfe7q5nJuGFbn91lE6M+X
 1Pf3ermNqu6zTi6TKvKb+gRM22CkScIHt/5kYUo/OKeND2zdDRlzUTZFfpd9hX+y9/mJMy8gvuR
 bDdh8u7b8wzj9P92LEq9j4eyWgnNexvj4i89DUepJgsMM3EX/6ah71HHNaVfme2b1YSsANyx2JQ
 fioy0b8vkC72yaQ==
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
index 98c99f0e24c4a654a8f4835063f5a479a433c9a0..a0fdafc3ef71d20c73ff58ef065201e6dc911396 100644
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


