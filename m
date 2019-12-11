Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1370C11A7F8
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2019 10:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfLKJqC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Dec 2019 04:46:02 -0500
Received: from mx-out.tlen.pl ([193.222.135.158]:26728 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfLKJqB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Dec 2019 04:46:01 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2019 04:46:01 EST
Received: (wp-smtpd smtp.tlen.pl 7699 invoked from network); 11 Dec 2019 10:39:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1576057160; bh=vO+bFE2Ilhfw7pmQtVHnoPeP/BVjkJ2aq5R4+CZNkiI=;
          h=From:To:Cc:Subject;
          b=wOfHrhlWCOvP5NKyeOLTv7du/ngSUfQUzuyhsHAtC5MkoHZp3roukg84w8KUBmTol
           iHVKbAWBmN8lAQENzJP/NYDeS2KaacxwvOdfy66kaJ97mRC0Pskfv9uw2/MpRYKz7p
           TUl1Qx3CE1Ik0vNuWYSMEoVHoH4gErkXzcdaEWIE=
Received: from public-gprs362173.centertel.pl (HELO localhost.localdomain) (cosiekvfj@o2.pl@[37.47.45.254])
          (envelope-sender <cosiekvfj@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rui.zhang@intel.com>; 11 Dec 2019 10:39:20 +0100
From:   =?UTF-8?q?Kacper=20Piwi=C5=84ski?= <cosiekvfj@o2.pl>
To:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Kacper=20Piwi=C5=84ski?= <cosiekvfj@o2.pl>
Subject: [PATCH] ACPI: acpi_video: fix typo in comment
Date:   Wed, 11 Dec 2019 10:37:28 +0100
Message-Id: <20191211093728.4163-1-cosiekvfj@o2.pl>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: o2.pl)                                      
X-WP-MailID: 4604a5f9e9c53ca3898b3ce9680c96fe
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [sdIR]                               
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: Kacper Piwiński <cosiekvfj@o2.pl>
---
 drivers/acpi/acpi_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 4f325e47519f..9b4da4167a2b 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2183,7 +2183,7 @@ int acpi_video_register(void)
 	if (register_count) {
 		/*
 		 * if the function of acpi_video_register is already called,
-		 * don't register the acpi_vide_bus again and return no error.
+		 * don't register the acpi_video_bus again and return no error.
 		 */
 		goto leave;
 	}
-- 
2.24.0

