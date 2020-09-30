Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D341327E8C6
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 14:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgI3MrH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Sep 2020 08:47:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbgI3MrH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 08:47:07 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8488828AD1ADABFA29E5;
        Wed, 30 Sep 2020 13:47:04 +0100 (IST)
Received: from J00310691.china.huawei.com (10.47.4.201) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 30 Sep 2020 13:47:03 +0100
From:   John Garry <john.garry@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] drivers/acpi: Make acpi_evaluate_dsm() prototype consistent
Date:   Wed, 30 Sep 2020 13:43:50 +0100
Message-ID: <20200930124350.1176-1-john.garry@huawei.com>
X-Mailer: git-send-email 2.25.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.4.201]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When compiling a driver which includes both include/linux/acpi.h and
include/acpi/acpi_bus.h for when CONFIG_ACPI=n for i386, I get this:

/include/acpi/acpi_bus.h:53:20: error: conflicting types for ‘acpi_evaluate_dsm’
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
                    ^~~~~~~~~~~~~~~~~
In file included from drivers/scsi/hisi_sas/hisi_sas.h:10:0,
                 from drivers/scsi/hisi_sas/hisi_sas_main.c:7:
./include/linux/acpi.h:866:34: note: previous definition of ‘acpi_evaluate_dsm’ was here
 static inline union acpi_object *acpi_evaluate_dsm(acpi_handle handle,
                                  ^~~~~~~~~~~~~~~~~
Fix by making prototype in include/linux/acpi.h consistent.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3eb4cb88e8a6..72a696ceba8d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -866,7 +866,7 @@ static inline bool acpi_driver_match_device(struct device *dev,
 
 static inline union acpi_object *acpi_evaluate_dsm(acpi_handle handle,
 						   const guid_t *guid,
-						   int rev, int func,
+						   u64 rev, u64 func,
 						   union acpi_object *argv4)
 {
 	return NULL;
-- 
2.26.2


