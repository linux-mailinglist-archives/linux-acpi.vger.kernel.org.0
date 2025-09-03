Return-Path: <linux-acpi+bounces-16345-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4700AB42CF4
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 00:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3F5188A996
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 22:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1B2E2DFA;
	Wed,  3 Sep 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OD9JtDHE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E072D7DE1
	for <linux-acpi@vger.kernel.org>; Wed,  3 Sep 2025 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939792; cv=none; b=fPy+HDQ2gLgVvJQN1UQ5rAezEKRRUM9vZ89II0rWABNae2CxAIy7ikRfJ2swslvrwgxw5RmlIndpxkNUFDnXobg1WVE5cyAWQPZNLUfqFi5612dW6wy+M+c8nFka8RsIATDPYwmbdd0MTX8qJPw2/wywDpuhmBJ9t1KJQhwJ00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939792; c=relaxed/simple;
	bh=5zxZbULTDjBJNqwOYWJcqyxdFdAB7xODm4RLQ8h9b7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oap8rYeH/ePAyNuvkxm6ZGhmD0+Fsr1yneXoUiggP/Mbn4FvC4wRB7wk3UnEqYWwxHHQWFHvzJdwdV6OtLlUvqrSJHJqfMmSAcQkTHDpxCOYZZdJBhCA8PjKixTVf7cVNoj7U9yyA10hG82Tu00i5RpRPAbUQha+YdYuSPSwwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OD9JtDHE; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756939787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v8J4btAAPddn3JaQV4f8n+Z/XZPSOT+Xr10bO/NP8/o=;
	b=OD9JtDHENpogOeIIYgpnD4Q8s4HpIxtkZbL7K5q9riCkemeP5c98YpOkTYFANTE7BnOIcu
	3FhYMSoRIurNI9mNF3f1qh4Tsn1LykHnJsFkggG+hZx5h4DuFTd3i3BAp7e6AvYhq99rzW
	QsrqGCIUEPtS3rGT4aO0+QYUa+VVKIY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: APEI: Remove redundant assignments in erst_dbg_{ioctl|write}()
Date: Thu,  4 Sep 2025 00:49:11 +0200
Message-ID: <20250903224913.242928-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use the result of copy_from_user() directly instead of assigning it to
the local variable 'rc' and then overwriting it in erst_dbg_write() or
immediately returning from erst_dbg_ioctl().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/acpi/apei/erst-dbg.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 246076341e8c..ff0e8bf8e97a 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -60,9 +60,8 @@ static long erst_dbg_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case APEI_ERST_CLEAR_RECORD:
-		rc = copy_from_user(&record_id, (void __user *)arg,
-				    sizeof(record_id));
-		if (rc)
+		if (copy_from_user(&record_id, (void __user *)arg,
+				   sizeof(record_id)))
 			return -EFAULT;
 		return erst_clear(record_id);
 	case APEI_ERST_GET_RECORD_COUNT:
@@ -175,8 +174,7 @@ static ssize_t erst_dbg_write(struct file *filp, const char __user *ubuf,
 		erst_dbg_buf = p;
 		erst_dbg_buf_len = usize;
 	}
-	rc = copy_from_user(erst_dbg_buf, ubuf, usize);
-	if (rc) {
+	if (copy_from_user(erst_dbg_buf, ubuf, usize)) {
 		rc = -EFAULT;
 		goto out;
 	}
-- 
2.51.0


