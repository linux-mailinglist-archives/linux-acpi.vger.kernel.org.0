Return-Path: <linux-acpi+bounces-18272-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C83C132D0
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 07:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B6F1A27430
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 06:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C33429C35A;
	Tue, 28 Oct 2025 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="aErX//JP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97029B8E5;
	Tue, 28 Oct 2025 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633110; cv=none; b=oPYvfiVUbe81PIEmBxHQ4CU8pIA92Rrtmr9p/jjX3AVoqyB9xR8ZImkZ9o1KwV/I4i8n00yAjpX0ZVhZHoBA5MDDK/jCWEXGEVA+bfEpvJLaSLnIHOHWHTnSxi3j91oQQcwX0wybkgN/A+0ror0+q+8kIyJ8aQFCr3hbHG+vO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633110; c=relaxed/simple;
	bh=kRRUofgeos3ZtqWPJdn9BGVMz9ruxa9wz+KdE97I8AM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=K4HmTkiThScLvdBAQO/RGOmcYzg7aYtIg/PRKHLKtxh1D8hWXjY3KA7gp2um6MpJh39BxVkHqgjtBQDPDec2r0FvtUluv4uOU0hJQ/Wy+G24U44AZpVuwleW8MxOHJdMMWzLDAZBKQvy/5n4q7WZLferdZ/JAyhJvR5Z/SITA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=aErX//JP; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1761632799;
	bh=pi1zXcr5RpNJ+LWrYVRPR8sqQuBNG7+Xw9qcszIoFM4=;
	h=From:To:Cc:Subject:Date;
	b=aErX//JPDEPZGG8rmiRIdO0sFYckDF+Oa7ZRtO0278rzCOlG7Is+ZLDcynWPlSYLQ
	 cIyb8hjh/A+DhlG3aGjCZA+JxHgEpMxvD0m/xgPWS3fGayffKxh2q48XfmFuZfJ3EZ
	 B+LQug4IUVs7Zb2jr7DpV1Jzd117xs4LH3iYsKTw=
Received: from dcitdc.dci.com ([61.220.30.51])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 5189CEA7; Tue, 28 Oct 2025 14:20:24 +0800
X-QQ-mid: xmsmtpt1761632424ti6wb9lir
Message-ID: <tencent_EA7267F6C936BBDE7977C3076819C9BA8D08@qq.com>
X-QQ-XMAILINFO: NAuAIaytDrXp1QDAZDTmKMpfa75ZonkIdJUkMhBt1OUgMrQzXFl9JXtmDRFzvX
	 aDLhNZEqZ2jrlJ20GkyBgreWHhn/pSI9rQ3/ZWKWvxX6MmLIFAAU8lBNsrIxytAdkkgC3e2QksDl
	 fDMgIofmu7Yho3eE0WVMxO/sdLeTAfjnkyf49hC8tSr/wBhdIhDHRKDvvMqfBiYG7A3vIWl0eieH
	 f0Rpwvsq1y7H0iChqsjXKtXP1ZpeANgw7H2dHIL3VNs2pUPdomXWP5IZDVWYyFoqmsHm+Qh/POU/
	 4UQvtpCq4jAp1zIw1yZFSkO1hg6K3QGRaR3G+0gfv+bowztobV9Ak2fzZ9UdG93WA8UVZQj7gjq6
	 rzrRHJuicr4Bsg3NlN9ofuAf9Bxagcui9ksX1z31bhAQucyNZd/nYCkk8uO5wZfLFEMvvjeYR+f8
	 P/0jZhs8y3J7WTev4HwpEfRNIcnN5obxcPnm/UfxO5AkDO77bvCCFo/Djwt0o2fc0tqN5ail53vY
	 z7/tg16OR1Hr/Ml/WX/XZBPZr3LkJqew9ZS+rYFje4HLpyt/l0RQuylaJdj/u6QUKkdt8eyBNVJo
	 uYEe8IN95QwdYhpSg4F21XhooSzCr4ecN5QH/ONL0opMR21OWwzsv1G68CRxGBxJUfBxz3LNRb6H
	 Mwv1RNLQrQ8TrWbcWcMGhTMcyHs9pRfOe+xT66al7C2hYUmii0C5ino8OXOOGgit6GD6S66dsjtm
	 Epi7dps797rlkpLddkhJACRZuw3la3hdiHP7AUTn7VoGTQrXhtqEb8B+rPe20C0Br9Zbs3kTVMQd
	 CejNihFBw2MTGW39fstBXe6RwQ//LNdkpuRnsDCdl3yk55KjByKHIRds7KPJCg9oaramsLM+937T
	 bl11CutpI+D3ZCWtQ9ajA70gmTJ3pTLlEFlE+CZ7LHD387r9FAZWz7mpDQf1JgcJEyPL33X9VrtD
	 pxlaE10+iv8n26g2uPyRxL3XPNwJkTKUpuwVhQPhDzMrviR0ucSjcZxKJUzEWT
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: "Shang song (Lenovo)" <shangsong2@foxmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shangsong2@lenovo.com,
	"Shang song (Lenovo)" <shangsong2@foxmail.com>
Subject: [PATCH v2 1/1] ACPI: PRM: Skip the initialization when boot from legacy BIOS
Date: Tue, 28 Oct 2025 02:20:13 -0400
X-OQ-MSGID: <20251028062014.3090136-1-shangsong2@foxmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To address the confusion caused by the misleading "Failed to find VA for GUID..."
message during legacy BIOS boot, making 'EFI_RUNTIME_SERVICES's earlier judgment
can prevent this false alert.

Signed-off-by: Shang song (Lenovo) <shangsong2@foxmail.com>
---

Changes in v2:
  - Add comment for the code update.

 drivers/acpi/prmt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 6792d4385eee..4457ff17f878 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -392,6 +392,14 @@ void __init init_prmt(void)
 	if (ACPI_FAILURE(status))
 		return;
 
+	/*
+	 * Return immediately if EFI_RUNTIME_SERVICES is not enabled.
+	 */
+	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
+		pr_err("PRM: EFI runtime services unavailable\n");
+		return;
+	}
+
 	mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
 					  sizeof (struct acpi_table_prmt_header),
 					  0, acpi_parse_prmt, 0);
@@ -404,11 +412,6 @@ void __init init_prmt(void)
 
 	pr_info("PRM: found %u modules\n", mc);
 
-	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
-		pr_err("PRM: EFI runtime services unavailable\n");
-		return;
-	}
-
 	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
 						    ACPI_ADR_SPACE_PLATFORM_RT,
 						    &acpi_platformrt_space_handler,
-- 
2.43.7


