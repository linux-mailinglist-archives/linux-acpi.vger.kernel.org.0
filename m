Return-Path: <linux-acpi+bounces-4740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E132A89BD4B
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB241C21733
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9BF59B6A;
	Mon,  8 Apr 2024 10:32:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20025A11C;
	Mon,  8 Apr 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572354; cv=none; b=sb7k1uKCzXyx2yzUl2xaFa9yvIUu1G0sWFFQVPsK0zlXxyB/hsXEsK12w9cFJZRdYIRFNSSSdJUSvTqPI88ZVse86VIWk69SWaTlO3gocpQ2JGmE8epgkHS6h51C2QkUvE2/B09tsM0X9V8RTsRjxNcpqIFi9U6xqAZx6jhZv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572354; c=relaxed/simple;
	bh=m9BJlA3v26UaNJxmSCbA61ukI2y0NQsanGsLp9fpqec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I9lbZSYHh5HhsST5QEWUbS1pPOXlYCzAz56A9l4mKVxHSeD3SHc6PwLfTBSzooOvswq6yBDX4Zkc8blrb8txOKmjxK/ydV+Dw9QZQFQrzc8O2dtpbfuQV2OlExjTFAUyJGO570SzFPujqRJyxuYPhdlk9gPvggLP5BAb5wuObWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 6596A2F20255; Mon,  8 Apr 2024 10:32:31 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 4CF232F2025C;
	Mon,  8 Apr 2024 10:32:10 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 12/14] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CVA
Date: Mon,  8 Apr 2024 13:32:05 +0300
Message-Id: <20240408103207.197423-13-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240408103207.197423-1-kovalev@altlinux.org>
References: <20240408103207.197423-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Haye <nicolas.haye@proton.me>

commit ca3afc2806046f626a1518f160a564b90f141f95 upstream.

Like many b1502 models,
the b1502CVA keyboard doesn't work because of an ACPI DSDT table that
describes IRQ 1 as ActiveLow while the kernel overrides it to Edge_High.

Signed-off-by: Nicolas Haye <nicolas.haye@proton.me>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 5697ccf902184e..a4f245669d24a5 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -468,6 +468,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B1502CVA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1502CVA"),
+		},
+	},
 	{
 		/* Asus ExpertBook B2402CBA */
 		.matches = {
-- 
2.33.8


