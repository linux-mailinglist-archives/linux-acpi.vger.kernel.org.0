Return-Path: <linux-acpi+bounces-12205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5BEA5F9E3
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA9E3BE6EC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7E269CF2;
	Thu, 13 Mar 2025 15:29:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8617C269895;
	Thu, 13 Mar 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879762; cv=none; b=ih7fesSN0faSK9yZy1WrSEferWadisrnmtHBO1yEu7V1bawGw9RwKcv/c3OEp8bqcFGHe6qh281E7A0kogpmjwYn39TwSUIHbaBvLiFov6G/PQ0QZL1pxwNCmXY/G0vCgS0a4Kc04NtEOwBFQ4efnn3bq0otpovbyifvdb9mUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879762; c=relaxed/simple;
	bh=fuYkPulF6TGzFJB0T+8ug8u78/9jsDIvjelffcznDHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HC+gCgxKRHMtrPEAayImZlcyGq2ZUzZXbfPhFj+b3y8HQgZ405ff06AywgjmtQd8K8sV/rcGBLcDGyRvxUFa8fss+VJ6wY+CNo8p2PNslWRJQIXAtlWR2+R424OmO0iO5K9DX0xkVudXYBjK8JB+V0r/Tq34l0d3BxG8pbGjBR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FF791516;
	Thu, 13 Mar 2025 08:29:30 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A7073F694;
	Thu, 13 Mar 2025 08:29:19 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:52 +0000
Subject: [PATCH v3 06/13] mailbox: pcc: Refactor error handling in irq
 handler into separate function
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-6-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=fuYkPulF6TGzFJB0T+8ug8u78/9jsDIvjelffcznDHQ=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnECxx5+KRKPF2aIc0kHIOiDCPBqrtcU53rb
 Li4K1sPAWuJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5xAAKCRAAQbq8MX7i
 mEJID/99/s5+lKyz42AY7C3m+Ttfzq98W+5o1sDpBc3nbj0dZefZev7shLZKR8/gylzQ19Zfxs0
 FqVz7m6kvuLB4eB/LkEfwIp0fTzJn4oRQ9GftyNnera0FiKZFc/EnLIT+BIvxc03b6MNnliS0Ga
 B6AXzoC+8UPGMRqfp8JUf0bc0atEBGP7j3usLWbNnrG6AZE3HMm10YybJ35yb0k/XrWhIHhCsmc
 5+ElHcCyXdnHv9p0IM5HMMMppQFmI0GrlmGznayXGbmG+mzCHzat7GdLkC4P8mG0WQHXEyHA+4x
 3ifktvox3laOISgGg2z11JR+kWTYuWt0UaiYLviBTfdr5QhLAyD4TiWAT4Nc/0NxxdjwF9lL8fI
 NM/4tIT4srvUxhGOBHFy9g1lB87qqum5Ph7PXJNZ9CPfIAFlt9Sl6e8aHa8iEN0hsy5uWI/DgAC
 qQNFtRmQV+aUu9reIBTjG5OOPWVWd8jCcuiQ2xZZmRYwX64l8PD0H2d8Jsf+9Z8KU+iO9Eag3zG
 rpsbuvIy52dc5MjxwTiKHIERCKCgVVcol+AP5b8JduhWQWz6+ptDGD9pSyr+KTNg4ZT0RHvhrvg
 Gh4voBgKHDWAWKsP2/QzIvfRoTF22JuE/ASZ1e2SOXR4e0mUi/sVu89Lj5SkpR2jujqfui2iUoy
 CvZxfgBQh+V4n7g==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The existing error handling logic in pcc_mbox_irq() is intermixed with the
main flow of the function. The command complete check and the complete
complete update/acknowledgment are nicely factored into separate functions.

Moves error detection and clearing logic into a separate function called:
pcc_mbox_error_check_and_clear() by extracting error-handling logic from
pcc_mbox_irq().

This ensures error checking and clearing are handled separately and it
improves maintainability by keeping the IRQ handler focused on processing
events.

Acked-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index fcbf19d7472d05f3c39389d292e6c6646e4b6b24..c9e46e2266a46cad2d482c6a15e2737c47275ffb 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -269,6 +269,25 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 	return !!val;
 }
 
+static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
+{
+	u64 val;
+	int ret;
+
+	ret = pcc_chan_reg_read(&pchan->error, &val);
+	if (ret)
+		return ret;
+
+	val &= pchan->error.status_mask;
+	if (val) {
+		val &= ~pchan->error.status_mask;
+		pcc_chan_reg_write(&pchan->error, val);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
 {
 	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
@@ -309,8 +328,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
-	u64 val;
-	int ret;
 
 	pchan = chan->con_priv;
 
@@ -324,15 +341,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (!pcc_mbox_cmd_complete_check(pchan))
 		return IRQ_NONE;
 
-	ret = pcc_chan_reg_read(&pchan->error, &val);
-	if (ret)
+	if (pcc_mbox_error_check_and_clear(pchan))
 		return IRQ_NONE;
-	val &= pchan->error.status_mask;
-	if (val) {
-		val &= ~pchan->error.status_mask;
-		pcc_chan_reg_write(&pchan->error, val);
-		return IRQ_NONE;
-	}
 
 	/*
 	 * Clear this flag after updating interrupt ack register and just

-- 
2.34.1


