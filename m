Return-Path: <linux-acpi+bounces-4730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE089BD36
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0144282FBB
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304658127;
	Mon,  8 Apr 2024 10:32:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD645810A;
	Mon,  8 Apr 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572346; cv=none; b=ChxZYhSrg/rNd/gS0xNww5CHLDrnJ9eESHbbSdrRr0r99BGt5F1kcbc3qmsN81xtEaUDTGYX7bRusmXVyHNGyZ9RwwocZlVWmK95PhsK16oyCFb6ZqvfHyAxTqaR7YShmU736y8eL2iv9Kt5BCxbGAzJoBsMS9UG7IAikOh791g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572346; c=relaxed/simple;
	bh=leV/hO1lT0ThkwVwzmco7siUwL9jreY0Hyp6cd76cp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BeFIt+v7XKJgBboLYUMHdLsRrQxzOuLCiaZxfv6w6PdRXSvU6Ksa7wkQqEyJQtkIY+Q2wcT2O+vAYDdQKRfSoi95uu4HBYEKQvK3chyHlx1U5+bkYqOG6WlGIGUEnLStj/hVMRU5PdlyA1SG6NgnW+M24dzFbpGROoKGb171GIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id D84BF2F2024E; Mon,  8 Apr 2024 10:32:23 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 732C42F2024C;
	Mon,  8 Apr 2024 10:32:09 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 01/14] ACPI: resource: Skip IRQ override on Asus Expertbook B2402FBA
Date: Mon,  8 Apr 2024 13:31:54 +0300
Message-Id: <20240408103207.197423-2-kovalev@altlinux.org>
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

From: Vojtech Hejsek <hejsekvojtech@gmail.com>

commit 65eb2867f5bf46023ab42ba8347106870d961cf3 upstream.

The Asus Expertbook B2502FBA has IRQ 1 described as Active_Low
in its ACPI table. However, the kernel overrides this and sets it to
Edge_High, which prevents the internal keyboard from working properly.

Adding this laptop model to the override_table fixes the issue.

Signed-off-by: Vojtech Hejsek <hejsekvojtech@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 1c5c1a269fbee4..2d3ed21c010fb8 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -460,6 +460,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
 		},
 	},
+	{
+		.ident = "Asus ExpertBook B2402FBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2402FBA"),
+		},
+	},
 	{
 		.ident = "Asus ExpertBook B2502",
 		.matches = {
-- 
2.33.8


