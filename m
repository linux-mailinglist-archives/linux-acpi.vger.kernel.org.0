Return-Path: <linux-acpi+bounces-13483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C0EAAB6B2
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 07:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB77BABEE
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 05:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B41237A27D;
	Tue,  6 May 2025 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3kmmcqC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4936BA55;
	Mon,  5 May 2025 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485819; cv=none; b=GqqsZc+rSYaMvuMDE/gzoxW8O2IQwzqzRPu2+4MuPfrTmRyvVauK1MvISz2Zb9UdpUrZGxStIORVIFgCiM9yD05sHE31/uKp4ZyVJXIvNEY9sD7HRUQ6fB8VpqSRBzUPZ940I7NMe/FS7K+XQEPxrTRI2+zk7SGW8ROqwMBYyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485819; c=relaxed/simple;
	bh=eEUI680ypmPuZ5QWILhPpSBV4+NzpYcdAqCvbVpWpUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCOb+DO77KP3PmV7jPli1WoN5QV2KKEFKQcJtTvmAqa8fEdk6pk2Jxm1Gz76WOVmDfSxitlI7pXwipRuTkpicwHyDY1OUue1EO583IklZukgndHZW6m3S3KwUx2qDd31RatJEhbVFZ+Ap9jRkXJvlYRjwZOp4doyNHY3EG9VX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3kmmcqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619FFC4CEE4;
	Mon,  5 May 2025 22:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485819;
	bh=eEUI680ypmPuZ5QWILhPpSBV4+NzpYcdAqCvbVpWpUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3kmmcqCk51X5eX2IWgn/GU44EXHnUOJSPWg2heZTdNkQt+JQ4+Wdce3LFh74Ymis
	 tNsBtTiSd+VTspyOaauJAo7MjLVowrudfO3YqJlv9Oy88JZUIN0JLIFOhBK5VnV0sP
	 ExYcARBybYHGg+wHDZHrYIGTfIO/GmII3GSXidt8NiTiqpRPlYII0VbkNW2u7e6+lQ
	 S2ISLEnCok/ZU1pa90cA5XiaS5K91QA9YhrCYCDcQdsV2ZcEjdjkHbgJCWvQclHXop
	 5A9zPaDXXTD8DUuuy+MMyktY8lh+JNFrWnVJAAB+5QzqLPKvYZlzXKGMwiUh0gwYt4
	 O+nIKGsz5E36g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Huisong Li <lihuisong@huawei.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 014/294] mailbox: pcc: Use acpi_os_ioremap() instead of ioremap()
Date: Mon,  5 May 2025 18:51:54 -0400
Message-Id: <20250505225634.2688578-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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


