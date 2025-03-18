Return-Path: <linux-acpi+bounces-12324-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F7A678BD
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 17:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046C4177460
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B25020CCF1;
	Tue, 18 Mar 2025 16:09:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DBF1E8334;
	Tue, 18 Mar 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314171; cv=none; b=poDOpKs6eWLGDEoiMk9kcxaAr4AsUl8k4U9dSqNTKVzQh8CerUFeUDeFSzl9uuStMSJwzISu3WfECbjczHHId0wvo04hKZMnCpiB/Sl8JDQnJCh2drnc2GewLyRwu99j6heN8mzsgNptK7OZL/WjzTQn8ALsiEuMbRGlpGa4hRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314171; c=relaxed/simple;
	bh=xyy1nidpm2NckiLYGWHxIMTkjl1fascaNCIbAZgR9NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BukvHcSqTOG6gSKSnbA+DpcKfB2v48KqefB+3aKK7ILKtMFYRrKYil1WGadDychX30WyA/vDTVH3bkgqWgK5inMMGFOUGjmo6FYqHMbuGoKHNCDRzKYh1Aqlvc58BTZM27d2V75pG94pBI1Q/I12s19c6lSY0254FBokJDdvTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.molgen.mpg.de (g43.guest.molgen.mpg.de [141.14.220.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 55D0A61CCD8A3;
	Tue, 18 Mar 2025 17:09:13 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Anton Shyndin <mrcold.il@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	All applicable <stable@vger.kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: resource: Skip IRQ override on ASUS Vivobook 14 X1404VAP
Date: Tue, 18 Mar 2025 17:09:02 +0100
Message-ID: <20250318160903.77107-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Like the ASUS Vivobook X1504VAP and Vivobook X1704VAP, the ASUS Vivobook 14
X1404VAP has its keyboard IRQ (1) described as ActiveLow in the DSDT, which
the kernel overrides to EdgeHigh breaking the keyboard.

    $ sudo dmidecode
    […]
    System Information
            Manufacturer: ASUSTeK COMPUTER INC.
            Product Name: ASUS Vivobook 14 X1404VAP_X1404VA
    […]
    $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
                 IRQ (Level, ActiveLow, Exclusive, )
                     {1}

Add the X1404VAP to the irq1_level_low_skip_override[] quirk table to fix
this.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219224
Cc: Anton Shyndin <mrcold.il@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b4cd14e7fa76..14c7bac4100b 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		/* Asus Vivobook X1404VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1404VAP"),
+		},
+	},
 	{
 		/* Asus Vivobook X1504VAP */
 		.matches = {
-- 
2.49.0


