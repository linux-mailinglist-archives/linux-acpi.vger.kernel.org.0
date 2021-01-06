Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8C82EB778
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jan 2021 02:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbhAFBNQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 20:13:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10391 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbhAFBNQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 20:13:16 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D9WXq1gxBz7Qwl;
        Wed,  6 Jan 2021 09:11:39 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Wed, 6 Jan 2021
 09:11:25 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] =?UTF-8?q?ACPI:=20PM:=20s2idle:=20Remove=20useless=20vari?= =?UTF-8?q?able=20=E2=80=98obj=5Fnew=E2=80=99=20in=20lpi=5Fdevice=5Fget=5F?= =?UTF-8?q?constraints=5Famd?=
Date:   Wed, 6 Jan 2021 09:23:01 +0800
Message-ID: <20210106012301.71260-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix warning:
drivers/acpi/x86/s2idle.c:138:25: warning: variable ‘obj_new’ set but
not used [-Wunused-but-set-variable]
      union acpi_object *obj_new;
                               ^~~~~~~
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/acpi/x86/s2idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 25fea34b544c..e5fb17fd1020 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -135,12 +135,10 @@ static void lpi_device_get_constraints_amd(void)
 
 				for (k = 0; k < info_obj->package.count; ++k) {
 					union acpi_object *obj = &info_obj->package.elements[k];
-					union acpi_object *obj_new;
 
 					list = &lpi_constraints_table[lpi_constraints_table_size];
 					list->min_dstate = -1;
 
-					obj_new = &obj[k];
 					switch (k) {
 					case 0:
 						dev_info.enabled = obj->integer.value;
-- 
2.16.2.dirty

