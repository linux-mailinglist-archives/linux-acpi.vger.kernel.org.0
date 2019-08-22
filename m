Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0125A9972F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2019 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbfHVOoW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Aug 2019 10:44:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730203AbfHVOoW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Aug 2019 10:44:22 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 14C18F8D37B23162DF40;
        Thu, 22 Aug 2019 22:44:17 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:44:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ACPI: SBS: remove unused variable 'SMBUS_PEC'
Date:   Thu, 22 Aug 2019 22:43:46 +0800
Message-ID: <20190822144346.12028-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

drivers/acpi/sbshc.h:18:17: warning:
 SMBUS_PEC defined but not used [-Wunused-const-variable=]

SMBUS_PEC is never used since introduction in
commit 91087dfa51a2 ("ACPI: SBS: Split host
controller (ACPI0001) from SBS driver (ACPI0002)"),
so just remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/acpi/sbshc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/sbshc.h b/drivers/acpi/sbshc.h
index 06372a3..c3522bb 100644
--- a/drivers/acpi/sbshc.h
+++ b/drivers/acpi/sbshc.h
@@ -15,8 +15,6 @@ enum acpi_smb_protocol {
 	SMBUS_BLOCK_PROCESS_CALL = 0xd,
 };
 
-static const u8 SMBUS_PEC = 0x80;
-
 enum acpi_sbs_device_addr {
 	ACPI_SBS_CHARGER = 0x9,
 	ACPI_SBS_MANAGER = 0xa,
-- 
2.7.4


