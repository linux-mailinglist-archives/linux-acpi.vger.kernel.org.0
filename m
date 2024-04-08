Return-Path: <linux-acpi+bounces-4726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB489BD2A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD13B217A8
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E823E53E26;
	Mon,  8 Apr 2024 10:29:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC21535DC;
	Mon,  8 Apr 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572198; cv=none; b=VZ/N0H0zm+5doUtW2bv7rf2L2eMgJ6U3HKQKLSmUloNDAD8IZctp2C8wTQfVJMtlukUhVG0bPt5DCVxG6oNr+Rw/A3WhesEKO8cXbs7ShLdnqo1XdbabgwKoLu27lCUV8VcnDV/l2TO2b1j5vOcFS/PFJ6Hwflnrfj92WyDL49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572198; c=relaxed/simple;
	bh=EBbPXX1GRVfEnGt9wh3Y1T42heRsa6Z1PnPbI5TzPzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSrEpcYq1CRZpv8dPa0nlGSaNjCBFp8v83KR4u8vpeYhiMRHg9ii82rd2J15oZxosi3BDiqet0adMF2ujISXdatIVj3B6hHKczkG6PG0EVEnxn39mZNDGU4aWHVHYIhljit0ux5aD2K0SPZu98zJuoODIrhVmeXYhwzfPp1r3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 08E502F20248; Mon,  8 Apr 2024 10:29:55 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id C1F9D2F2024B;
	Mon,  8 Apr 2024 10:29:43 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.6.y 7/7] ACPI: resource: Use IRQ override on Maibenben X565
Date: Mon,  8 Apr 2024 13:29:40 +0300
Message-Id: <20240408102940.197282-8-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240408102940.197282-1-kovalev@altlinux.org>
References: <20240408102940.197282-1-kovalev@altlinux.org>
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


