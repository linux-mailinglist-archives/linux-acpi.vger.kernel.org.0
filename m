Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141865D03C
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2019 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfGBNKc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Jul 2019 09:10:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51481 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfGBNKc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jul 2019 09:10:32 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hiIYH-0003QF-Iz; Tue, 02 Jul 2019 13:10:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: APD: remove redundant assignment to pointer clk
Date:   Tue,  2 Jul 2019 14:10:29 +0100
Message-Id: <20190702131029.9621-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer clk is being initialized with a value that is never
read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/acpi_apd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index ff47317d8ef1..7cd0c9ac71ea 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -57,7 +57,7 @@ struct apd_private_data {
 static int acpi_apd_setup(struct apd_private_data *pdata)
 {
 	const struct apd_device_desc *dev_desc = pdata->dev_desc;
-	struct clk *clk = ERR_PTR(-ENODEV);
+	struct clk *clk;
 
 	if (dev_desc->fixed_clk_rate) {
 		clk = clk_register_fixed_rate(&pdata->adev->dev,
-- 
2.20.1

