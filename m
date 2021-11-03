Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01043443CE1
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 06:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhKCFyy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 01:54:54 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52]:35819 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhKCFyx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 01:54:53 -0400
X-QQ-mid: bizesmtp48t1635918689t2dqxqlh
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 03 Nov 2021 13:51:28 +0800 (CST)
X-QQ-SSF: 0140000000200070D000B00A0000000
X-QQ-FEAT: vmnbzJorTWSWh1PNXVj1Ard3xhsTeGeJQOWT2Rcb+YszzQQc3QuapNH4I8N2P
        WA9wBHc7GguslEERSSw79mcOFNHhCAdt+MucGGIsG6XnhX9j7PDT1I+D8DhhfNvVCaD1E4d
        bXZkCiZ++J7jmD4t1n3TAQWkg4zGw/3Pztrb2LXJBYWdvWgNp9aOVvUxUf5jM2T7QuGTK67
        P28ELrJIRYjnkmQs2XGAvaxYDu5BlT7awsijs7geckfCe7Chr6dYqurflijgtZ+T6aNyN2J
        2V4nyc5I/waIM91RsUsXtOUlJRVHlL4SJ6/soWhe/JZ/RilGai5bj8+QSJvw3rz5AtOjU5b
        g54Z6Le62E6jMP08cQ=
X-QQ-GoodBg: 2
From:   wangzhitong <wangzhitong@uniontech.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wangzhitong <wangzhitong@uniontech.com>
Subject: [PATCH] ACPI: EC: fix error "do not initialise statics to false"
Date:   Wed,  3 Nov 2021 13:51:19 +0800
Message-Id: <20211103055119.19312-1-wangzhitong@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

this patch fixes below Errors reported by checkpatch
ERROR: do not initialise statics to false
+static bool ec_freeze_events __read_mostly = false;
ERROR: do not initialise statics to false
+static bool boot_ec_is_ecdt = false;

Signed-off-by: wangzhitong <wangzhitong@uniontech.com>
---
 drivers/acpi/ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 04ce2b96c3da..1255649a4da9 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -133,7 +133,7 @@ static unsigned int ec_storm_threshold  __read_mostly = 8;
 module_param(ec_storm_threshold, uint, 0644);
 MODULE_PARM_DESC(ec_storm_threshold, "Maxim false GPE numbers not considered as GPE storm");
 
-static bool ec_freeze_events __read_mostly = false;
+static bool ec_freeze_events __read_mostly;
 module_param(ec_freeze_events, bool, 0644);
 MODULE_PARM_DESC(ec_freeze_events, "Disabling event handling during suspend/resume");
 
@@ -177,7 +177,7 @@ struct acpi_ec *first_ec;
 EXPORT_SYMBOL(first_ec);
 
 static struct acpi_ec *boot_ec;
-static bool boot_ec_is_ecdt = false;
+static bool boot_ec_is_ecdt;
 static struct workqueue_struct *ec_wq;
 static struct workqueue_struct *ec_query_wq;
 
-- 
2.20.1



