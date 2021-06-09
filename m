Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C4B3A1BD9
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 19:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhFIRfK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 13:35:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50150 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhFIRfJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 13:35:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lr24m-00016g-8P; Wed, 09 Jun 2021 17:33:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: scan: ensure ret is initialized to avoid garbage being returned
Date:   Wed,  9 Jun 2021 18:33:12 +0100
Message-Id: <20210609173312.298414-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the unlikely event that there are no callback calls made then ret
will be returned as an uninitialized value. Clean up static analysis
warnings by ensuring ret is initialized.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: a9e10e587304 ("ACPI: scan: Extend acpi_walk_dep_device_list()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c3067e8bfc47..0945d952f0fc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2151,7 +2151,7 @@ int acpi_walk_dep_device_list(acpi_handle handle,
 			      void *data)
 {
 	struct acpi_dep_data *dep, *tmp;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&acpi_dep_list_lock);
 	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
-- 
2.31.1

