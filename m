Return-Path: <linux-acpi+bounces-13472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AADAA9F1D
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 00:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D9A1A81E52
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 22:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DCF27E7E5;
	Mon,  5 May 2025 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq8fg8x6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705027E7D6;
	Mon,  5 May 2025 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483297; cv=none; b=kPrlobQB4WyoVCBnhrI0Xn9buC/IqxXqqzEoUJZrnyXVHdixyclIQu4WZ9OB/vuVNUyd5dHxlpnTHu20eQVKaQNQRXoIb8t/j4fBXel7zmrbUB0s5svI/oK/vvpynRTaofRqYvAZlEkAgDbYMK/svjL6jAka8nlbO+oWAt++VRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483297; c=relaxed/simple;
	bh=eEUI680ypmPuZ5QWILhPpSBV4+NzpYcdAqCvbVpWpUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=euYztweYBZK/MpSA86zs9Wv1yCRXQYmk6hRvMySBWlJvklELQWpYEKH1RJgXcKJr6YiXBxbIKVnCYfqIwEcCenx/7QySoKVf0+ejDDSNJKnXbM6dnHmr7uDaesFm8F4PqbItZ2hDq1Z0XPmnZ4b0kPhVE7sfVvbgL+F4uz/OwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq8fg8x6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249F0C4CEF1;
	Mon,  5 May 2025 22:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483297;
	bh=eEUI680ypmPuZ5QWILhPpSBV4+NzpYcdAqCvbVpWpUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zq8fg8x6Nf5pE90+VuZ2j5Lo2ni3JF1CzQvdXmZAhn1mVrrqeXkO6j1qbpnCJ/lKD
	 o3fT3iqR5tffo1eXmZ7q/ZyEFJ10j2+5b3QbFhe99qcwXpGG9IsepxRsRFaAMTZSTE
	 4kbhlgTmFeUA7OVz1E62olD+wiIqkNDXvdI1k0cNb/VYTzaQhgPKRwFV1+REJtB+ID
	 AfvbvJVf5eR7lGSEFWm3cMdcf4z4lDvyG5pjnF2ASqLjhrWaQV/uMqUhBA618LL6EP
	 AthNWBV8OlyhBtgyHQQ+lrlSnvvwDz2n2wE4igOLDD3DgRiyG6+jcZtg7VcDVsdeSf
	 s0kYdfGLepI+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Huisong Li <lihuisong@huawei.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 021/642] mailbox: pcc: Use acpi_os_ioremap() instead of ioremap()
Date: Mon,  5 May 2025 18:03:57 -0400
Message-Id: <20250505221419.2672473-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


