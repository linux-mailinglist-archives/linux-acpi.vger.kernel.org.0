Return-Path: <linux-acpi+bounces-10892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E38FA27641
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 16:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B20497A1F14
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629EF213E90;
	Tue,  4 Feb 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BtJAX/3c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA432144B0
	for <linux-acpi@vger.kernel.org>; Tue,  4 Feb 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683752; cv=none; b=Wuo9vzQAGCZKmbwQVWRXk7hq4CIYeWAXbx9AhxO1QZxq26ZvJorPmRcoJOWi7nJE2hKbjBPM09SwgOvEuQa8zxRTkboWAGk0daXXOAm48MocWKgJTcmk6fmAJ2DwpIJpUv+2mzuMhrhLtghQ7otlv6unWuWOh8PAlukoLbk32xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683752; c=relaxed/simple;
	bh=PKhgCI0Zy0bjDtG6fmMXd/y+VHyTFHTVxbURGIl+GJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RK9P5HAaa2QKXDzx8wKMMCK7Qbt5nRltu4vj5bXERabmmTSMYLxCDwJKu+pBzKfJq0xX0aHoaamXlRZHELua3eBjCVmcuHIAc2YxWb8qqSaL6ZwdEYQHYkjlaBiv1scJEkNn64KXKDBbbR9+S7HOdBjKDhFKVDZ1aME2aZZOx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BtJAX/3c; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738683743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rjgh0NHIE24t3tM5YBjaxn3uiX5S8lp37xeGpZmhvUY=;
	b=BtJAX/3cIq3u+BCDiQXj3NtfkwBHxtwf+VEg+cij6VVtjPSaaCh22p2LgTAVCBXYGJks0L
	eoPTTp7d1w3ThlX4LffgJSFdzz59wIN/uUMu5rZiS6CHe30pTysd2wCDjpQufqLxDJx5Bh
	9yTgrNl4t1y3l4oUNtv/00KscAUZYow=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: video: Use str_yes_no() helper in acpi_video_bus_add()
Date: Tue,  4 Feb 2025 16:42:00 +0100
Message-ID: <20250204154159.3980-2-thorsten.blum@linux.dev>
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


