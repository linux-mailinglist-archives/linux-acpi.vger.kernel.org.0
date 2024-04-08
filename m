Return-Path: <linux-acpi+bounces-4728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D909B89BD33
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741F91F22C5A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB355C07;
	Mon,  8 Apr 2024 10:32:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210655E44;
	Mon,  8 Apr 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572345; cv=none; b=NQmraYK6Zdl8FZk7v4/D+BuZajk4SC44eihaBQaJHm0bBiyb9aJC9vZbFHeTU8jRU45RgrGW6yloiU7/QKI4dSQ2h2NLWwVjiteVgAtk8vMUv9qW0Unr4VdffsTxlapzcJhdw1adAJzFskbzfBHD3/BgW8bmiA0mcPVNLH+RfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572345; c=relaxed/simple;
	bh=X+hMBt08Tze+49WFvWV70qzbOOi6S4gL6Dreppyl/TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+FIMixRaMDjf2Q5jXOJPymlWDiCVzkHbFPjjmU/oLNLZgIzXVSDWPK81l5EP7R3p7WADh66hiMMPDWLoHgxzR3ae8CRbgs/Y9ZDFOsYIZjbnww+MReR4or+zo/lqk8vcPEax/xYX+k0eIwwkoKSEB3N3P+mxptnsTHJjtuALxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 08B272F20250; Mon,  8 Apr 2024 10:32:22 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 830F12F20252;
	Mon,  8 Apr 2024 10:32:09 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@ucw.cz,
	hdegoede@redhat.com,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 02/14] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CBA
Date: Mon,  8 Apr 2024 13:31:55 +0300
Message-Id: <20240408103207.197423-3-kovalev@altlinux.org>
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

From: Paul Menzel <pmenzel@molgen.mpg.de>

commit 05cda427126f30ce3fc8ffd82fd6f5196398d502 upstream.

Like the ASUS ExpertBook B2502CBA and various ASUS Vivobook laptops, the
ASUS ExpertBook B1502CBA has an ACPI DSDT table that describes IRQ 1 as
ActiveLow while the kernel overrides it to Edge_High.

    $ sudo dmesg | grep DMI
    DMI: ASUSTeK COMPUTER INC. ASUS EXPERTBOOK B1502CBA_B1502CBA/B1502CBA,
    BIOS B1502CBA.300 01/18/2023
    $ grep -A 40 PS2K dsdt.dsl | grep IRQ -A 1
                    IRQ (Level, ActiveLow, Exclusive, )
                        {1}

This prevents the keyboard from working. To fix this issue, add this laptop
to the skip_override_table so that the kernel does not override IRQ 1.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217323
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 2d3ed21c010fb8..548fd63ed26927 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -453,6 +453,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
 		},
 	},
+	{
+		.ident = "Asus ExpertBook B1502CBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
+		},
+	},
 	{
 		.ident = "Asus ExpertBook B2402CBA",
 		.matches = {
-- 
2.33.8


