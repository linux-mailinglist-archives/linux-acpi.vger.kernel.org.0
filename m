Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA8B39EC10
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 04:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFHCaS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 22:30:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4389 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhFHCaR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 22:30:17 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzYwK2hjZz6vSx;
        Tue,  8 Jun 2021 10:24:33 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:28:23 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 10:28:23 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] acpi/bus: fix doc warnings in bus.c
Date:   Tue, 8 Jun 2021 10:37:33 +0800
Message-ID: <20210608023733.2745553-1-libaokun1@huawei.com>
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

 drivers/acpi/bus.c:437: warning: Function parameter or
  member 'handle' not described in 'acpi_bus_notify'
 drivers/acpi/bus.c:437: warning: Function parameter or
  member 'type' not described in 'acpi_bus_notify'
 drivers/acpi/bus.c:437: warning: Function parameter or
  member 'data' not described in 'acpi_bus_notify'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/acpi/bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index be7da23fad76..021b85ff990a 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -430,6 +430,9 @@ static void acpi_bus_osc_negotiate_usb_control(void)
 
 /**
  * acpi_bus_notify
+ * @handle: Handle to acpi device.
+ * @type: ACPI device event type.
+ * @data: ACPI device data.
  * ---------------
  * Callback for all 'system-level' device notifications (values 0x00-0x7F).
  */
-- 
2.31.1

