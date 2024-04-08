Return-Path: <linux-acpi+bounces-4735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE86D89BD41
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D06282E87
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006E59B45;
	Mon,  8 Apr 2024 10:32:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F65813F;
	Mon,  8 Apr 2024 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572351; cv=none; b=CSccQoJP7+9B5p7w/nQFeUXe8VztfuIyvLjGixoZKZ62SH41/BRJiNb7OBRqpn16Oq8P+V0r2zeVLxAiRaz97fj4yLnr9I9rNlRzTn8iSxysZlLx2fxRX9UdILI0JfeLMXHzFuo34K3YYJnuOszR4rwDTWOk2VrI2/7EbIuXjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572351; c=relaxed/simple;
	bh=NwtmJOtk7FCAQ3mRWiBh/LpxG8ViaB5l2wms0Oo7kjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=npeJMGbkt7pA1ijhhrxRQHogyTjtqRWrgcX5Sahh28sCRfTK59MCtrx6LPq3d3I4RBE3eBWI/hYl6UV12pjEQTZDd+8noW/7VPUkjF8bD1MGAiY91qgxq5EwXYa3T2kLo31U+14erPGCHi55Hno4fr8Vvz+Z7154qoadKlXlOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id D1BB72F20274; Mon,  8 Apr 2024 10:32:28 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id CC33F2F20256;
	Mon,  8 Apr 2024 10:32:09 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 06/14] ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M
Date: Mon,  8 Apr 2024 13:31:59 +0300
Message-Id: <20240408103207.197423-7-kovalev@altlinux.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit 453b014e2c294abf762d3bce12e91ce4b34055e6 upstream.

It turns out that some PCSpecialist Elimina Pro 16 M models
have "GM6BGEQ" as DMI product-name instead of "Elimina Pro 16 M",
causing the existing DMI quirk to not work on these models.

The DMI board-name is always "GM6BGEQ", so match on that instead.

Fixes: 56fec0051a69 ("ACPI: resource: Add IRQ override quirk for PCSpecialist Elimina Pro 16 M")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394#c36
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index eebfc26c325866..a14a1adaac99a0 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -534,9 +534,13 @@ static const struct dmi_system_id maingear_laptop[] = {
 static const struct dmi_system_id pcspecialist_laptop[] = {
 	{
 		.ident = "PCSpecialist Elimina Pro 16 M",
+		/*
+		 * Some models have product-name "Elimina Pro 16 M",
+		 * others "GM6BGEQ". Match on board-name to match both.
+		 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Elimina Pro 16 M"),
+			DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
 		},
 	},
 	{ }
-- 
2.33.8


