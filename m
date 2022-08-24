Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7685A01AD
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 21:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiHXTAb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiHXTAS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 15:00:18 -0400
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 12:00:15 PDT
Received: from vorpal.se (vorpal.se [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B4A6470
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2022 12:00:11 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id F21F0147F2;
        Wed, 24 Aug 2022 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1661367016; bh=d7p594l2s14DNotZ9mJcvOga6IDcnwfMw0BXWHwDueQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlvFmN8AEllj0m4mn6JAi+nHYTra+zrJF3gc0LYxaeuuJ9isj00fW/tm+/+shYKIS
         xvYymH20Q59U2PbIOylx3sjNwK827NozlycwB3TBzimDlyjZ/rUrCDkzxqurttH8hE
         MuShHe4IRAd2rREPAbYFrvgiMyByCvcGYc2iA+U6iKggT7SQ/gxybpNb50Be+aric7
         TufsHIRXslogvCi1UFCOv+gIn3Mj8MuwH+dNzlknVGckcRUkglgjZcw7IM+cCti9kP
         e1vivTW+W+Xg8QVbJDJkoSzdidMT4AHbuFYA4X/OMvfrQL2gJFLqAzAioVDaVRc1Qy
         GSWKxqrn5GqYQ==
From:   Arvid Norlander <lkml@vorpal.se>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>, Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH 1/1] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Date:   Wed, 24 Aug 2022 20:49:50 +0200
Message-Id: <20220824184950.631520-2-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824184950.631520-1-lkml@vorpal.se>
References: <20220824184950.631520-1-lkml@vorpal.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Toshiba Satellite Z830 needs the quirk video_disable_backlight_sysfs_if
for proper backlight control after suspend/resume cycles.

Toshiba Portege Z830 is simply the same laptop rebranded for certain
markets (I looked through the manual to other language sections to confirm
this) and thus also needs this quirk.

Thanks to Hans de Goede for suggesting this fix.

Link: https://www.spinics.net/lists/platform-driver-x86/msg34394.html
Signed-off-by: Arvid Norlander <lkml@vorpal.se>

---
 drivers/acpi/acpi_video.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 5cbe2196176d..2a4990733cf0 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -496,6 +496,22 @@ static const struct dmi_system_id video_dmi_table[] = {
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
2.37.2

