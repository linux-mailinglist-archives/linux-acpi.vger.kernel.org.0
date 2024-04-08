Return-Path: <linux-acpi+bounces-4725-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7F289BD27
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB9E1F22B1D
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E33353E13;
	Mon,  8 Apr 2024 10:29:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183A535C8;
	Mon,  8 Apr 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572198; cv=none; b=tLyOOXWsz8KZNYaMtsb9JrddKCTLx3rMb2iGtmkkxJre8reGcDi6J+u6HBf6ULZFI+poCIuOVqXskAfVh3jiXwMdZuWLeWAua9SojiR8mU3a5SFURUEkUYXwfn1JxZJDsPW61rqBg4lJhEysdqA6o88pHIBCpX97yWwIjJ9TWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572198; c=relaxed/simple;
	bh=m9BJlA3v26UaNJxmSCbA61ukI2y0NQsanGsLp9fpqec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTYrIct3Ue+1m+wR1G/FShq2Y8xf+/BTCnHpGJcSk03o2jRG0w1MDBVhH2pVlq6SHkW9u9D6f8OvvY1tBHG4d+hob3jBguvAeo2wMVWS1O/hNpVgu+U4hEmIKUAoKR4ME+5+MjFRIEErvwIwj0KQYxl4HspHC4hFZPEn9qD/0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 3872F2F20246; Mon,  8 Apr 2024 10:29:55 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 9D04D2F20249;
	Mon,  8 Apr 2024 10:29:43 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.6.y 5/7] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CVA
Date: Mon,  8 Apr 2024 13:29:38 +0300
Message-Id: <20240408102940.197282-6-kovalev@altlinux.org>
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


