Return-Path: <linux-acpi+bounces-4734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206CB89BD3F
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07B8283012
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5244758ADF;
	Mon,  8 Apr 2024 10:32:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521E57335;
	Mon,  8 Apr 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572351; cv=none; b=CPjEsw5RGi6EwkDlIjwXeuXPuPZoO8O67Pbyn2kjer1gHktafFye/rc1xSZR9r1WJ0gR8cRTgPHcu/otB31kb/EBApDBP7SrcxGCSN9VhwNtgsTNEXCP7AvRaKml3Cj5p4TKQJ77lQMpus5ldOJrbd0YXuSYqRagvh2ij2hWFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572351; c=relaxed/simple;
	bh=1+2N9VD8aWYC8y5MqMhMYEILaIevx0gzV/OF6Mwttf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ahDMW6VrKlNy/Sx7N6g7t4JmHhJCDQy+fY+ZktJWMSZzqUqK2n8aZpCZMnrUl2RwvdPIs9ntoNlQobIPOJEiFqbj1PIvAuEiiiyQ569Gm2SXluQF5uP+HNQppAs7/i5Wy3ebWwHM7vOzLWe/5B/PCQr2pRVID3mpDUw8wanx7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 698352F20273; Mon,  8 Apr 2024 10:32:28 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 5F4FE2F2025F;
	Mon,  8 Apr 2024 10:32:10 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 13/14] ACPI: resource: Add IRQ override quirk for ASUS ExpertBook B2502FBA
Date: Mon,  8 Apr 2024 13:32:06 +0300
Message-Id: <20240408103207.197423-14-kovalev@altlinux.org>
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

From: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>

commit 0793e511c4c66c38dd26add86f7236bcdc70c3b5 upstream.

In order to fix the keyboard on ASUS ExpertBook B2502FBA, add an IRQ
override quirk for it in analogy with how it was done for other members
of this machine family.

Link: https://lore.kernel.org/linux-acpi/20230411183144.6932-1-pmenzel@molgen.mpg.de
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217323
Signed-off-by: Sviatoslav Harasymchuk <sviatoslav.harasymchuk@gmail.com>
[ rjw: Subject and changelog rewrite, fix broken white space ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index a4f245669d24a5..42b594f5127e4a 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -496,6 +496,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B2502FBA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
+		},
+	},
 	{
 		/* Asus Vivobook E1504GA */
 		.matches = {
-- 
2.33.8


