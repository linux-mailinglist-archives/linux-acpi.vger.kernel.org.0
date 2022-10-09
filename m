Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F05F8EA9
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Oct 2022 23:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiJIVCX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 9 Oct 2022 17:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiJIVBa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Oct 2022 17:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4563F2F66A;
        Sun,  9 Oct 2022 13:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91B0560CBA;
        Sun,  9 Oct 2022 20:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27256C433D6;
        Sun,  9 Oct 2022 20:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665348866;
        bh=cLGKtLbXVqnDb/ajd2omM5QR/yxh49jN/ogXfZjmH1Y=;
        h=From:To:Cc:Subject:Date:From;
        b=g/7cMi5WG8zfLCTE3UE1TWfe+C77Sox3UFY6StuIpaBFhv75XlbozsLeh/Sj7Gcju
         KakiX4k2ZKCS7jLY6fPleCWeWZtY7LkJtzBHmNYGUzWkN0wm+MlyPxLEhbcwyhkV1d
         G1CYUP0s/pwzMKhEc3CKAgLNFBxfVxoxKnIZ0wDGkPktJ8SzSz6kFpcU40EjIrRGle
         dmnQtYzu697vruFtWwgzh9UdMalIaW4WDLPElbwgL0OTms42jYowUKrAf0OH4jVDD/
         sJKxqLeXCuoB6BqqHxyEkoJsofU+ZQ6cT5HDr7AzoxVtJWuCUTKy+fhjOBaBlQ9bON
         jmR7gBR/wzWnw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arvid Norlander <lkml@vorpal.se>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/6] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Date:   Sun,  9 Oct 2022 16:54:17 -0400
Message-Id: <20221009205423.1203538-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
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

From: Arvid Norlander <lkml@vorpal.se>

[ Upstream commit 574160b8548deff8b80b174f03201e94ab8431e2 ]

Toshiba Satellite Z830 needs the quirk video_disable_backlight_sysfs_if
for proper backlight control after suspend/resume cycles.

Toshiba Portege Z830 is simply the same laptop rebranded for certain
markets (I looked through the manual to other language sections to confirm
this) and thus also needs this quirk.

Thanks to Hans de Goede for suggesting this fix.

Link: https://www.spinics.net/lists/platform-driver-x86/msg34394.html
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Arvid Norlander <lkml@vorpal.se>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Arvid Norlander <lkml@vorpal.se>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_video.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 81cd47d29932..bf18efd49a25 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -498,6 +498,22 @@ static const struct dmi_system_id video_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE R830"),
 		},
 	},
+	{
+	 .callback = video_disable_backlight_sysfs_if,
+	 .ident = "Toshiba Satellite Z830",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE Z830"),
+		},
+	},
+	{
+	 .callback = video_disable_backlight_sysfs_if,
+	 .ident = "Toshiba Portege Z830",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE Z830"),
+		},
+	},
 	/*
 	 * Some machine's _DOD IDs don't have bit 31(Device ID Scheme) set
 	 * but the IDs actually follow the Device ID Scheme.
-- 
2.35.1

