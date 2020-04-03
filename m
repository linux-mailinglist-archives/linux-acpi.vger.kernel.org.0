Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5C19D06E
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Apr 2020 08:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbgDCGst (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Apr 2020 02:48:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387962AbgDCGst (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Apr 2020 02:48:49 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4440CC138E76024DC4F0;
        Fri,  3 Apr 2020 14:48:44 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Apr 2020
 14:48:36 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <robert.moore@intel.com>, <erik.kaneda@intel.com>,
        <rafael.j.wysocki@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <devel@acpica.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ACPICA: make acpi_gbl_next_cmd_num static
Date:   Fri, 3 Apr 2020 14:47:12 +0800
Message-ID: <20200403064712.26746-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix the following sparse warning:

drivers/acpi/acpica/dbhistry.c:30:5: warning: symbol
'acpi_gbl_next_cmd_num' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/acpi/acpica/dbhistry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index bb9600b867ee..801b35a08174 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -27,7 +27,7 @@ static HISTORY_INFO acpi_gbl_history_buffer[HISTORY_SIZE];
 static u16 acpi_gbl_lo_history = 0;
 static u16 acpi_gbl_num_history = 0;
 static u16 acpi_gbl_next_history_index = 0;
-u32 acpi_gbl_next_cmd_num = 1;
+static u32 acpi_gbl_next_cmd_num = 1;
 
 /*******************************************************************************
  *
-- 
2.17.2

