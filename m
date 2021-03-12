Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB257338457
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Mar 2021 04:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhCLDZJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Mar 2021 22:25:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53379 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhCLDYk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Mar 2021 22:24:40 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lKYPk-0004vU-Ub; Fri, 12 Mar 2021 03:24:37 +0000
From:   chris.chiu@canonical.com
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] ACPI: video: Add missing callback back for Sony VPCEH3U1E
Date:   Fri, 12 Mar 2021 11:24:30 +0800
Message-Id: <20210312032430.13664-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

The .callback of the quirk for Sony VPCEH3U1E was unintetionally
removed by the commit 25417185e9b5 ("ACPI: video: Add DMI quirk
for GIGABYTE GB-BXBT-2807"). Add it back to make sure the quirk
for Sony VPCEH3U1E works as expected.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
Reported-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/acpi/video_detect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 811d298637cb..83cd4c95faf0 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -147,6 +147,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 	{
+	.callback = video_detect_force_vendor,
 	.ident = "Sony VPCEH3U1E",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-- 
2.20.1

