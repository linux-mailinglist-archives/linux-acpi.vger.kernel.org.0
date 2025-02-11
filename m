Return-Path: <linux-acpi+bounces-11009-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2213A30905
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 11:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55084161588
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DFA1C3308;
	Tue, 11 Feb 2025 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="frEap/S9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02E194C6A
	for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270755; cv=none; b=JAlEcHD609zry5Slm/yppdzs4f9VpmsuDS05O4nE++dENAy2UIRzGIw9r1BHWkDFOod8N/5FaHAOrO9qKTk0ElKWw7FgU2RCcYe36R5ttYYOOkImXvTJwy9grsD21ZoxUlBwaD12cEBI0Sahw3V0/RAKzARVEnNC+4k8RznmOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270755; c=relaxed/simple;
	bh=PKhgCI0Zy0bjDtG6fmMXd/y+VHyTFHTVxbURGIl+GJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8jn5f783fuZMZNgzRInnYp6J2FXyxNuEQFNsQO8044CD6HcdoiWQ+4UlQPjTEqOSHR7/QZNOWcgiRX9zqvoJSpdR3ktkZQC5DtKCzpgXVuUCS826czHdtKNsiD7RscjIViUJmplfsewECmsOIXr5lKy8vUWvPsf5dLt9pRrGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=frEap/S9; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739270751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rjgh0NHIE24t3tM5YBjaxn3uiX5S8lp37xeGpZmhvUY=;
	b=frEap/S9qKMVVv7cClslXsAh7Itfk/OND9x/ftHtv5rlIB5zt0R1hXYMD5aDcqaaEPS0WR
	hIKw2E/9pAE7K/NzlAz/6s7DfpB8sZ9zc6hNbY4/7mPxb540Q4EpgZEJB8LSNb51EnjfBt
	9vij7ycKiRvSnwyFSMe4X/+JYfxolu8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ACPI: video: Use str_yes_no() helper in acpi_video_bus_add()
Date: Tue, 11 Feb 2025 11:45:32 +0100
Message-ID: <20250211104532.699124-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/acpi/acpi_video.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index a972831dbd66..efdadc74e3f4 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -27,6 +27,7 @@
 #include <linux/acpi.h>
 #include <acpi/video.h>
 #include <linux/uaccess.h>
+#include <linux/string_choices.h>
 
 #define ACPI_VIDEO_BUS_NAME		"Video Bus"
 #define ACPI_VIDEO_DEVICE_NAME		"Video Device"
@@ -2039,9 +2040,9 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 	pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
-	       video->flags.multihead ? "yes" : "no",
-	       video->flags.rom ? "yes" : "no",
-	       video->flags.post ? "yes" : "no");
+	       str_yes_no(video->flags.multihead),
+	       str_yes_no(video->flags.rom),
+	       str_yes_no(video->flags.post));
 	mutex_lock(&video_list_lock);
 	list_add_tail(&video->entry, &video_bus_head);
 	mutex_unlock(&video_list_lock);
-- 
2.48.1


