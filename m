Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D45743E275
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Oct 2021 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1NrT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 09:47:19 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52]:38936 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhJ1NrT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Oct 2021 09:47:19 -0400
X-QQ-mid: bizesmtp44t1635428676twqsn36p
Received: from debian.zl-kernel-compile.com (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 28 Oct 2021 21:44:35 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000B00A0000000
X-QQ-FEAT: F3yR32iATbhvqpadPrnq4hbpoGxlomGnAMWWm+0bxqWIL1kNSS4bS7qp28Vxn
        Sd1YHY5Fl5BGV9MPzgpiHvnuSVVgvJZQAbPpYnMwJ6IVSyf7ZvLi4BYZZykQUAKd4m543r6
        U3Qyx71EvSnV/aKFNY8IFWSw9XOSa+a04yQqGzY35K+W6617hqMuPRBwFzGqM2GMNC6ufR3
        fQgGynWib/Wf6IB4k3D5stwaxNtkQOz5zPGWQK4/1CR1DA0Cxm6GMd/VyI12hmsqMzsIPTt
        66riasCgN2nQ1/MPrQB1b5iWq0fO0Wpm7GHGUWh7Dvcznl7mmogx9Qwgl6nqWbemFJXvY1N
        lgri4GIie1DrfGhkXOlBXNuLelBQpE7FBB2aye5
X-QQ-GoodBg: 2
From:   zhoubinbin@uniontech.com
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc:     zhoubb.aaron@gmail.com, Binbin Zhou <zhoubinbin@uniontech.com>
Subject: [PATCH] ACPI / EC: Use ec_no_wakeup on HP ZHAN 66 Pro
Date:   Thu, 28 Oct 2021 21:44:32 +0800
Message-Id: <20211028134432.31719-1-zhoubinbin@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Binbin Zhou <zhoubinbin@uniontech.com>

EC interrupts constantly wake up system from s2idle.
So make ec_no_wakeup be true as default to keep system in s2idle mode
and reduce power consumption.

Signed-off-by: Binbin Zhou <zhoubinbin@uniontech.com>
---
 drivers/acpi/ec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e629e891d1bb..7c32da8f51ed 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2152,6 +2152,13 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
 		},
 	},
+	{
+		.ident = "HP ZHAN 66 Pro",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
+		},
+	},
 	{ },
 };
 
-- 
2.20.1



