Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20E33A780A
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jun 2021 09:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOHgX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 03:36:23 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6371 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhFOHgX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jun 2021 03:36:23 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G40Mv29qwz63Yv;
        Tue, 15 Jun 2021 15:30:19 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 15:34:17 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 15:34:16 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next v2] acpi/nvs: fix doc warnings in nvs.c
Date:   Tue, 15 Jun 2021 15:43:17 +0800
Message-ID: <20210615074317.3103832-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/acpi/nvs.c:94: warning: Function parameter or
  member 'start' not described in 'suspend_nvs_register'
 drivers/acpi/nvs.c:94: warning: Function parameter or
  member 'size' not described in 'suspend_nvs_register'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Fix the formatting of this kerneldoc comment

 drivers/acpi/nvs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 7f02e399047c..a2b11069e792 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -84,13 +84,13 @@ struct nvs_page {
 static LIST_HEAD(nvs_list);
 
 /**
- *	suspend_nvs_register - register platform NVS memory region to save
- *	@start - physical address of the region
- *	@size - size of the region
+ * suspend_nvs_register - register platform NVS memory region to save
+ * @start: Physical address of the region.
+ * @size: Size of the region.
  *
- *	The NVS region need not be page-aligned (both ends) and we arrange
- *	things so that the data from page-aligned addresses in this region will
- *	be copied into separate RAM pages.
+ * The NVS region need not be page-aligned (both ends) and we arrange
+ * things so that the data from page-aligned addresses in this region will
+ * be copied into separate RAM pages.
  */
 static int suspend_nvs_register(unsigned long start, unsigned long size)
 {
@@ -125,7 +125,7 @@ static int suspend_nvs_register(unsigned long start, unsigned long size)
 }
 
 /**
- *	suspend_nvs_free - free data pages allocated for saving NVS regions
+ * suspend_nvs_free - free data pages allocated for saving NVS regions
  */
 void suspend_nvs_free(void)
 {
@@ -149,7 +149,7 @@ void suspend_nvs_free(void)
 }
 
 /**
- *	suspend_nvs_alloc - allocate memory necessary for saving NVS regions
+ * suspend_nvs_alloc - allocate memory necessary for saving NVS regions
  */
 int suspend_nvs_alloc(void)
 {
@@ -166,7 +166,7 @@ int suspend_nvs_alloc(void)
 }
 
 /**
- *	suspend_nvs_save - save NVS memory regions
+ * suspend_nvs_save - save NVS memory regions
  */
 int suspend_nvs_save(void)
 {
@@ -195,10 +195,10 @@ int suspend_nvs_save(void)
 }
 
 /**
- *	suspend_nvs_restore - restore NVS memory regions
+ * suspend_nvs_restore - restore NVS memory regions
  *
- *	This function is going to be called with interrupts disabled, so it
- *	cannot iounmap the virtual addresses used to access the NVS region.
+ * This function is going to be called with interrupts disabled, so it
+ * cannot iounmap the virtual addresses used to access the NVS region.
  */
 void suspend_nvs_restore(void)
 {
-- 
2.31.1

