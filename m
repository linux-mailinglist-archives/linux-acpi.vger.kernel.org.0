Return-Path: <linux-acpi+bounces-14555-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35606AE68B9
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 16:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75F63B90A6
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF62D6638;
	Tue, 24 Jun 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="mr4EqkD0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4328ECE2;
	Tue, 24 Jun 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774911; cv=none; b=cipFIrvF0zB0/doUGFMCchrPQol50gEF3ykzBYM0Mbzehs8Cxql0ASOEyWcyrnvGzjEz4iLuTxL6q7GLrgrPlYrPEWbsRnIO3KclTl5Jjz/N4jNgry3dMTbjo1IPysNBNccb3kiKzHLQ81pJGV21pvidaYi+6AKYhZ8jhQGo0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774911; c=relaxed/simple;
	bh=QuhArafP5UQWTf6x0cnLMqtBpCyf3kg0+2McZ07EZlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrCW4W5ZMU93hAWQNz6E2ma/kOvvJdgd0znfM7aJv8ZFlb8AIGl6RM6FHYbyA1IhweCqefDXJ7SohauM7l3nGLvU79BLHSViVB5vnVPJpM9Q2TxJvMowW7REmo/grn++d93g9RheJ1UX12L9PgRSISo+eN2dV+g4p0G9eUAPxDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=mr4EqkD0; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bRRw920hMz9sv3;
	Tue, 24 Jun 2025 16:21:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750774905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MgHUoRfXCan2FR4wpwtdY4zXDm5OVuonVtEpuKSoTtU=;
	b=mr4EqkD0koPcUd4uXOgWYfmaMR5Kncf93hieGQj2Fb32SvsVVn3ITcgZDILuMy7sX6+vEU
	NBSOrzAAtYGqY7GfTqGKqctVPawLifvqAURidSrOdW4uwXliDwQ2r26z+pyxl4fO44dpcO
	C0r/OaJIYhaTurwbdwlPU6NYypRYRU97sKvm5XsG9ZjIyTCLX5SQ739wtKNFEUCEl9mGdf
	kTX8vPdZrWH0lq5f+ShcLpS92fDZVM4zs9aUbhZSkc6+8hVpA7jFEzbbYJV1veb/SO1ZZQ
	ilKb5Cvz9YJMnGJ+odA/dFppLbLgNm05Ahg8Uv87tiAW/UXjNoMnS2cnvJxcbA==
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	lv.zheng@intel.com,
	kees@kernel.org,
	rui.zhang@intel.com,
	len.brown@intel.com
Subject: [PATCH] ACPI / sysfs: Replace deprecated strcpy() with sysfs_emit
Date: Tue, 24 Jun 2025 19:51:34 +0530
Message-ID: <20250624142134.11317-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bRRw920hMz9sv3

strcpy() is deprecated; use sysfs_emit() instead. No functional changes
intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 drivers/acpi/sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a48ebbf768f9..7ce90998ab97 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -181,10 +181,9 @@ static int param_set_trace_method_name(const char *val,
 
 	/* This is a hack.  We can't kmalloc in early boot. */
 	if (is_abs_path)
-		strcpy(trace_method_name, val);
+		sysfs_emit(trace_method_name, "%s", val);
 	else {
-		trace_method_name[0] = '\\';
-		strcpy(trace_method_name+1, val);
+		sysfs_emit(trace_method_name, "\%s", val);
 	}
 
 	/* Restore the original tracer state */
-- 
2.50.0


