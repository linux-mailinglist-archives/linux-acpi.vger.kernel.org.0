Return-Path: <linux-acpi+bounces-4736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2301889BD43
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543751C216C9
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7863B57896;
	Mon,  8 Apr 2024 10:32:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A556461;
	Mon,  8 Apr 2024 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572352; cv=none; b=UEO7E7ZQdIycwXL0nxDWdI5MUsgzW/keffK/fgNQ8rHlk1ZQAVLZlFfff0fm4LEDDqyFofBxENpw0VEaH10PWSwgwAmajJB1j3Gg+0ipCo1LA7ibaniTeVrisaDxIVDx/sFy4VK1l15uQxOxShz0Z4U+U8WeTax7shFi3Uzt8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572352; c=relaxed/simple;
	bh=EBbPXX1GRVfEnGt9wh3Y1T42heRsa6Z1PnPbI5TzPzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5oNRoPgfonmISLMhU11uP4iEibZLDNqJk/w6b/MHLA5Cp4OzJq281VF4Mly3COJHchpDIU05vZ6JKHSzTM5sSNuAUwqHeioOMBH+yycKhEGH2V1bejaM3krctDjmn/KeeeqBZFqnUaPtE+crS3pEIUoifGWljlkmYBqZJHKNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 4B4DB2F20256; Mon,  8 Apr 2024 10:32:29 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 70A732F20260;
	Mon,  8 Apr 2024 10:32:10 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 14/14] ACPI: resource: Use IRQ override on Maibenben X565
Date: Mon,  8 Apr 2024 13:32:07 +0300
Message-Id: <20240408103207.197423-15-kovalev@altlinux.org>
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

From: Sergey Kalinichev <kalinichev.so.0@gmail.com>

commit 00efe7fcf9ceeff0808bca9460afb49e7ada6068 upstream.

Use ACPI IRQ override on Maibenben X565 laptop to make the internal
keyboard work.

Add a new entry to the irq1_edge_low_force_override structure, similar
to the existing ones.

Signed-off-by: Sergey Kalinichev <kalinichev.so.0@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 42b594f5127e4a..e2db4d5883ca40 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -623,6 +623,13 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "X577"),
 		},
 	},
+	{
+		/* Maibenben X565 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MAIBENBEN"),
+			DMI_MATCH(DMI_BOARD_NAME, "X565"),
+		},
+	},
 	{ }
 };
 
-- 
2.33.8


