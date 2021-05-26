Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091B539199B
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 16:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhEZOO0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 10:14:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59533 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhEZOO0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 10:14:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lluHE-0007MV-Vt; Wed, 26 May 2021 14:12:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] acpi: power: remove redundant initialization of variable result
Date:   Wed, 26 May 2021 15:12:52 +0100
Message-Id: <20210526141252.3750231-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable result is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 97c9a94a1a30..d86865c04f64 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -919,7 +919,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	union acpi_object acpi_object;
 	struct acpi_buffer buffer = { sizeof(acpi_object), &acpi_object };
 	acpi_status status;
-	int state, result = -ENODEV;
+	int state, result;
 
 	acpi_bus_get_device(handle, &device);
 	if (device)
-- 
2.31.1

