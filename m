Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51775F8E72
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Oct 2022 22:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiJIU6W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 9 Oct 2022 16:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJIU4r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Oct 2022 16:56:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188FC2FFFA;
        Sun,  9 Oct 2022 13:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA627B80DC5;
        Sun,  9 Oct 2022 20:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E67C4314D;
        Sun,  9 Oct 2022 20:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665348823;
        bh=EvJC7ybRO4I0b2bkGMWAtdvSSua1BQZEEPWytH/fjio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmFa2Y77/6MWDfbsUVNoUWS7/MS5SzdUNf+3wGyG8AMaHLqoAjm2BCxBjxh+Y1A0H
         19bOMDknSEJ+3RUgVzfKeQ7OymzOuMyIVCH+MKllzO8uzyZ2Fi9JlgeZpuLikMEzqk
         4xEYhORMifXyda72zzEiKuQHw0FRRnp2oLG2YEl16Ketfb9Efegnm+db8uIO9TMQET
         6AllkkNIyyQG+QZRJ9lmao2xLLh8uQoKp3Dk9ioKAMNysjdP5pUXWxvQKJQFN4OD5d
         q31238zQqBmThPqC35sOVHgCnG27TtviaL2+CzV5o0ob8RN3xJ5fk2NAg3KDA6dtBg
         UX+O3Z9M4mong==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Luya Tshimbalanga <luya@fedoraproject.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 12/15] ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1 for StorageD3Enable
Date:   Sun,  9 Oct 2022 16:53:05 -0400
Message-Id: <20221009205308.1202627-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009205308.1202627-1-sashal@kernel.org>
References: <20221009205308.1202627-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 018d6711c26e4bd26e20a819fcc7f8ab902608f3 ]

Dell Inspiron 14 2-in-1 has two ACPI nodes under GPP1 both with _ADR of
0, both without _HID.  It's ambiguous which the kernel should take, but
it seems to take "DEV0".  Unfortunately "DEV0" is missing the device
property `StorageD3Enable` which is present on "NVME".

To avoid this causing problems for suspend, add a quirk for this system
to behave like `StorageD3Enable` property was found.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216440
Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index b3fb428461c6..3a3f09b6cbfc 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -198,7 +198,24 @@ static const struct x86_cpu_id storage_d3_cpu_ids[] = {
 	{}
 };
 
+static const struct dmi_system_id force_storage_d3_dmi[] = {
+	{
+		/*
+		 * _ADR is ambiguous between GPP1.DEV0 and GPP1.NVME
+		 * but .NVME is needed to get StorageD3Enable node
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216440
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
+		}
+	},
+	{}
+};
+
 bool force_storage_d3(void)
 {
-	return x86_match_cpu(storage_d3_cpu_ids);
+	const struct dmi_system_id *dmi_id = dmi_first_match(force_storage_d3_dmi);
+
+	return dmi_id || x86_match_cpu(storage_d3_cpu_ids);
 }
-- 
2.35.1

