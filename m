Return-Path: <linux-acpi+bounces-11790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BFEA4E5A5
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 17:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01473880ED3
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDFC2C2CC6;
	Tue,  4 Mar 2025 15:50:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E02C2CBC
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103415; cv=pass; b=gzwdB3zYoLZw7IPtuLXoaH08pPrEKwPQ0uZu7ci5ZPhTV4zW9dDRKVEzzWF6UdgPdlq/wb1RPB0YkjjH7dt0DLlTC48EnmC8bKJcl3CeQuZ8HTGkmzfBfaiHyKzgUOLCTCt0t3Y1YlGkuJh3oVPQ7+f3opjBU1VAt3CcWtSZrx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103415; c=relaxed/simple;
	bh=UbmacZHuc0rkrUhM8NEGGe2sjhxY+p2kFyDwy7F6O9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMikM0mIB297aglcFpUmkF4BzsRYa/PiXhoKcMRocz1BM0pM2uwGfzsabHA6OPtrLRYrZKI18ezjOj8t1ECU51wIKMjebJIU06ASxC4YOhI+K1s3eppH80F0ROE4J7jaX7wNUVj+4dZIW7aTyR/S4Rg4PxFPDT2bmBoxtI9ap0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 57681408B656
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 18:50:12 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g8j45r6zG1YB
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 18:49:09 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id DA6224272B; Tue,  4 Mar 2025 18:48:56 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541445-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 95E1941A7B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:55:38 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id DC73C3063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:55:37 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD177AA657
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B291F5849;
	Mon,  3 Mar 2025 10:53:35 +0000 (UTC)
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
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g8j45r6zG1YB
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708150.61581@tkhR7cRzEva8rvsHbsdmag
X-ITU-MailScanner-SpamCheck: not spam

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



