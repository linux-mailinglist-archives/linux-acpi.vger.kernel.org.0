Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929CD3F5E94
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Aug 2021 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbhHXNDz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Aug 2021 09:03:55 -0400
Received: from mail.huberulrich.de ([81.169.200.209]:35626 "EHLO
        mail.huberulrich.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbhHXNDy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Aug 2021 09:03:54 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 09:03:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=huberulrich.de; s=2017; c=relaxed/relaxed;
 q=dns/txt; h=from:date:to:cc:message-id:subject;
 bh=epadiIZkdAvf+vdKVEQ5nF4EW0KWJMs8g8ZqRjxmupY=;
 b=um8HmFRrK9xR+0zhitmaEERrhyM18HrwU/vqOcpwd1umzOqgNM7bNGXdJ4fG2Vz6jA5jboGN96DpZNqg7/3TXwA9CHboFnzuGwRraZBirEr/DsXwdQihBDJyLwhvjgAnIiPX2/ynMVMyQvqSwO0nLUy+s4/yLvOemPPvw5A1QZ732h6cZdKoZpFdq2ltTEcdkQhW1oXpA5cAIvPN/nZyxRHFJYL9630FgquIMihiPF2wuTuSkQTwgoa5miHRo0sLXhb+xlwiwR7NLWX83BBcipKxbQfUB+HtI1kCLrSkaK2Wj+vrMfFQ5YI8xlMF5RW/BH1Uie6P9MCUKELl8gSGDw==;
DomainKey-Signature: a=rsa-sha1;
 b=SdXKTR2VC+vQS8mOxy8DKoWjQoPxbHP6gY7NoIt2+nWoGwfC8jwXgn0TEwWL5BvMid0Vx4vuKFeNtqoFxXiGa0xVMhrxUpCulNaUaToO+tL9oXlsydwsiIY/0kum+b+Mw4IpDXw94Fsc8uLrjsthgOli+RFg/S6juR+4fYuY3I7y0glG/Ov9pwoj92Q+wpstuz+j7gYk1XC61mbtYiFIYqP7u5NTm/97lZhzxyMSYtTke9IsvDiTib23Y1Y11FY74BrNE2yL3y07/fb/nz5s3DOSOyXVML4eGaKizSqRVjbRVSMHk32PZyeIQOwku7cAiRmrUQUyaB7bAR5AjQh1vQ==;
 c=nofws; q=dns; d=huberulrich.de; s=2017;
 h=from:to:cc:subject:date:message-id;
Received: from lenovo-ulrich.fritz.box
 (2001:16b8:2d34:3e00:b400:f8f7:ccd8:a3aa) by mail.huberulrich.de (Axigen)
 with (ECDHE-RSA-AES128-GCM-SHA256 encrypted) ESMTPSA id 2E0D0E;
 Tue, 24 Aug 2021 12:58:05 +0000
From:   Ulrich Huber <ulrich@huberulrich.de>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Ulrich Huber <ulrich@huberulrich.de>
Subject: [PATCH] ACPI: Add DMI quirk for Lenovo Yoga 9 (14INTL5)
Date:   Tue, 24 Aug 2021 14:57:44 +0200
Message-Id: <20210824125744.11125-1-ulrich@huberulrich.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: 
X-AXIGEN-SPF-Result: Ok
X-AXIGEN-DK-Result: Ok
DomainKey-Status: good
X-AXIGEN-DKIM-Result: Ok
DKIM-Status: good
X-AxigenSpam-Level: 5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Lenovo Yoga 9 (14INTL5)'s ACPI _LID is bugged:

After hibernation the lid is initially reported as closed.
Once closing and then reopening the lid reports the lid as
open again. This leads to the conclusion that the initial
notification of the lid is missing but subsequent
notifications are correct.

In order fo the Linux LID code to handle this device properly
the lid_init_state must be set to ACPI_BUTTON_LID_INIT_OPEN.

Signed-off-by: Ulrich Huber <ulrich@huberulrich.de>
---
 drivers/acpi/button.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index f25bd336113b..1f9b9a4c38c7 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -77,6 +77,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
 	},
+	{
+		/*
+		 * Lenovo Yoga 9 14ITL5, initial notification of the LID device
+		 * never happens.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82BG"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{
 		/*
 		 * Medion Akoya E2215T, notification of the LID device only
-- 
2.33.0

