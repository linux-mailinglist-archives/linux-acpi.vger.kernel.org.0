Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F1273862
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Sep 2020 04:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgIVCNq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Sep 2020 22:13:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729477AbgIVCNq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Sep 2020 22:13:46 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5DFE421A43550D47DCCD;
        Tue, 22 Sep 2020 10:13:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 10:13:40 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI / PNP: Fix missing-prototypes in acpi_pnp.c
Date:   Tue, 22 Sep 2020 10:11:14 +0800
Message-ID: <1600740674-43727-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix the following warnings.
drivers/acpi/acpi_pnp.c:382:13: warning: no previous prototype
for ‘acpi_pnp_init’ [-Wmissing-prototypes].

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/acpi/acpi_pnp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index f3039b9..4ed755a 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/ctype.h>
 
+#include "internal.h"
+
 static const struct acpi_device_id acpi_pnp_device_ids[] = {
 	/* pata_isapnp */
 	{"PNP0600"},		/* Generic ESDI/IDE/ATA compatible hard disk controller */
-- 
2.7.4

