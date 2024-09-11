Return-Path: <linux-acpi+bounces-8228-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746AC974C5A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 10:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC981F20F5B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11C183CBC;
	Wed, 11 Sep 2024 08:16:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC818308A;
	Wed, 11 Sep 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042606; cv=none; b=Jo6o0Gp7A3fxExeQAd0OthUXKago21smkD4B+k+wu5ZRhPSgTyKIdzGx0Hl04NW9POqB6MpFTU2mGpuDo9XieWKOd/vP205bGK1B05L/a1doR5RDqn3INh5sDB/9FKlJV35X190zT0sPKBUYUfzDpPMCVxVL1RRUaqV1Cko63c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042606; c=relaxed/simple;
	bh=Cn7jZ0lj7XtyPmYrd1E3AGHRAbjiPjARmSyMkGN69Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e7Ze8pAzpyDOu3T7TceVmlQYSWBVXKuPdaQ3Da9lGMcG7S/qDC8Qa+cjdxobY/F5kGi3an0yQxu3P/Ba9OEFJ0X53aehBVVXPxf2O9jdrLIQhmOk6HLhHjf8BYyLiZFyjaBqV0vJZN6zJPFUfh1+y70pW2+Qq/c9J7/mfl2xwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
	by mx.molgen.mpg.de (Postfix) with ESMTP id 9EAEE61E5FE05;
	Wed, 11 Sep 2024 10:16:19 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	bugzilla@lekpreventie.nl,
	Tamim Khan <tamim@fusetak.com>
Subject: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Go E1404GA
Date: Wed, 11 Sep 2024 10:16:12 +0200
Message-Id: <20240911081612.3931-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other Asus Vivobooks, the Asus Vivobook Go E1404GA has a DSDT
describing IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.

    $ sudo dmesg | grep DMI:.*BIOS
    [    0.000000] DMI: ASUSTeK COMPUTER INC. Vivobook Go E1404GA_E1404GA/E1404GA, BIOS E1404GA.302 08/23/2023
    $ sudo cp /sys/firmware/acpi/tables/DSDT dsdt.dat
    $ iasl -d dsdt.dat
    $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
                IRQ (Level, ActiveLow, Exclusive, )
                    {1}

This override prevents the internal keyboard from working.

Fix the problem by adding this laptop to the table that prevents the
kernel from overriding the IRQ.

Reported-by: bugzilla@lekpreventie.nl
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219224
Cc: Tamim Khan <tamim@fusetak.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dd410e67d036d..5324791adfbdf 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -503,6 +503,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
 		},
 	},
+	{
+		/* Asus Vivobook Go E1404GA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "E1404GA"),
+		},
+	},
 	{
 		/* Asus Vivobook Go E1404GAB */
 		.matches = {
-- 
2.40.1


