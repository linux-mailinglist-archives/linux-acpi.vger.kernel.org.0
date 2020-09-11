Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B21C2675BD
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Sep 2020 00:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgIKWOk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Sep 2020 18:14:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56345 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgIKWOj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2020 18:14:39 -0400
Received: from 2.general.alexhung.us.vpn ([10.172.65.255] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1kGrJT-0002ET-LN; Fri, 11 Sep 2020 22:14:36 +0000
From:   Alex Hung <alex.hung@canonical.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        alex.hung@canonical.com
Cc:     All applicable <stable@vger.kernel.org>
Subject: [PATCH] ACPI: video: use ACPI backlight for HP 635 Notebook
Date:   Fri, 11 Sep 2020 16:14:20 -0600
Message-Id: <20200911221420.21692-1-alex.hung@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Default backlight interface is AMD's radeon_bl0 which does not work on
this system. As a result, let's for ACPI backlight interface for this
system.

BugLink: https://bugs.launchpad.net/bugs/1894667

Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 2499d7e..05047a3 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -282,6 +282,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "530U4E/540U4E"),
 		},
 	},
+	/* https://bugs.launchpad.net/bugs/1894667 */
+	{
+	 .callback = video_detect_force_video,
+	 .ident = "HP 635 Notebook",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP 635 Notebook PC"),
+		},
+	},
 
 	/* Non win8 machines which need native backlight nevertheless */
 	{
-- 
2.7.4

