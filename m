Return-Path: <linux-acpi+bounces-13476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2D7AAA86E
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 02:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133BF188534F
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 00:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF1234D665;
	Mon,  5 May 2025 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odjJcCPd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369534D65F;
	Mon,  5 May 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484796; cv=none; b=lAklKxtfkLFynvBr3LLB1XXqMaXArDopPBhFKbkHwJvqpICLgHuw4NGXkGmkp2sNo+RCx9Yvb3Qxt1jyjjtw63JNAOZDDBboHbwiRnY5nwmYiK4f+SOEm7UW8Y1xrNim20/W0EiMGE8qJ0i36+CDszftP7dk7/6DlWMVINwuU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484796; c=relaxed/simple;
	bh=eEUI680ypmPuZ5QWILhPpSBV4+NzpYcdAqCvbVpWpUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=padfEphMl3HaAEm45yXBiKT1G3k2wKJWZEdhVvjB5677deBR1IBk574khmqDXJIWWDGFRzt9hT+k8MGtZOMO6JRa5qQVspws3W7E8BohABjzx/p+wLFggLVaI06pQpJcVSjsbxR8MilBRHFCT0A+tpRhoyzmh3nhy1NWeL44Clg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odjJcCPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885BDC4CEED;
	Mon,  5 May 2025 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484795;
	bh=eEUI680ypmPuZ5QWILhPpSBV4+NzpYcdAqCvbVpWpUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odjJcCPdV2qqFeYIqfkQOifHKnm3huwoX7nmMX769j2mKch2phJSCYA/fYlgAnT6g
	 e+k5kXL3YJAAQyX7TnogSqMiyYqjyew7PHxI3+wuFipDjcBBI8D/rfnfcy/WyqDYF2
	 OwdD4qAYpP7scX0Cy3VMTbTn2NJnGoa3xI/j19qSBX0UrelwZ2dn5x37RywBuMVB47
	 +c6tNv7owjVPTI9yuPooHYax+pkKTIYyzrC1StZvkRNysKQV1sWKvklNQEGVtfKhIH
	 QTMMyEs4fiNlSGPtORdktnuke4CT4tt+H7xFT+G8aan6c2emPvUzCP2ARH3mYpXK8i
	 Dmd2CWNj31Y6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Huisong Li <lihuisong@huawei.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 019/486] mailbox: pcc: Use acpi_os_ioremap() instead of ioremap()
Date: Mon,  5 May 2025 18:31:35 -0400
Message-Id: <20250505223922.2682012-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit d181acea5b864e91f38f5771b8961215ce5017ae ]

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
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/pcc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f8215a8f656a4..49254d99a8ad6 100644
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
2.39.5


