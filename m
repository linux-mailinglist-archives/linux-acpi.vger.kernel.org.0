Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EB625F5FB
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 11:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgIGJEi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 05:04:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728186AbgIGJEg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 05:04:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8282B88F0C772872483C;
        Mon,  7 Sep 2020 17:04:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 17:04:15 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Ken Xue <Ken.Xue@amd.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 3/5] ACPI / APD: Remove ACPI_MODULE_NAME()
Date:   Mon, 7 Sep 2020 16:56:19 +0800
Message-ID: <1599468981-17301-4-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1599468981-17301-1-git-send-email-guohanjun@huawei.com>
References: <1599468981-17301-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI_MODULE_NAME() is used for ACPI debug output when using
ACPI debug print functions, but ACPI debug print functions are
not used in acpi_apd.c, remove the ACPI_MODULE_NAME().

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_apd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index c4bc4ab..4dbf85b 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -19,7 +19,6 @@
 
 #include "internal.h"
 
-ACPI_MODULE_NAME("acpi_apd");
 struct apd_private_data;
 
 /**
-- 
1.7.12.4

