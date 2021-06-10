Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C023A2A22
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFJL1w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 07:27:52 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5372 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJL1w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 07:27:52 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G11lY3RS1z6vFr;
        Thu, 10 Jun 2021 19:22:01 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:25:54 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 19:25:53 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] ACPI: sysfs: fix doc warnings in device_sysfs.c
Date:   Thu, 10 Jun 2021 19:35:01 +0800
Message-ID: <20210610113501.3439670-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/acpi/device_sysfs.c:278: warning: Function parameter or
  member 'dev' not described in 'acpi_device_uevent_modalias'
 drivers/acpi/device_sysfs.c:278: warning: Function parameter or
  member 'env' not described in 'acpi_device_uevent_modalias'
 drivers/acpi/device_sysfs.c:323: warning: Function parameter or
  member 'dev' not described in 'acpi_device_modalias'
 drivers/acpi/device_sysfs.c:323: warning: Function parameter or
  member 'buf' not described in 'acpi_device_modalias'
 drivers/acpi/device_sysfs.c:323: warning: Function parameter or
  member 'size' not described in 'acpi_device_modalias'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/acpi/device_sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index fa2c1c93072c..3b08efa88ba5 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -268,7 +268,8 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
 
 /**
  * acpi_device_uevent_modalias - uevent modalias for ACPI-enumerated devices.
- *
+ * @dev: Struct device.
+ * @env: Uevent kobject.
  * Create the uevent modalias field for ACPI-enumerated devices.
  *
  * Because other buses do not support ACPI HIDs & CIDs, e.g. for a device with
@@ -313,7 +314,9 @@ static int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
 
 /**
  * acpi_device_modalias - modalias sysfs attribute for ACPI-enumerated devices.
- *
+ * @dev: Struct device.
+ * @buf: The buffer.
+ * @size: Size of the buffer.
  * Create the modalias sysfs attribute for ACPI-enumerated devices.
  *
  * Because other buses do not support ACPI HIDs & CIDs, e.g. for a device with
-- 
2.31.1

