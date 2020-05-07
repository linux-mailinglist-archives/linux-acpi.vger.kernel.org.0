Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756081C8301
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 09:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgEGHDn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 03:03:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3833 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbgEGHDn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 03:03:43 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A4620EA74AE585F0F2A2;
        Thu,  7 May 2020 15:03:41 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 15:03:33 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhengzengkai@huawei.com>
Subject: [PATCH -next] ACPI: debug: Make two functions static
Date:   Thu, 7 May 2020 15:07:36 +0800
Message-ID: <20200507070736.25418-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix sparse warnings:

drivers/acpi/acpi_dbg.c:748:12: warning:
 symbol 'acpi_aml_init' was not declared. Should it be static?
drivers/acpi/acpi_dbg.c:774:13: warning:
 symbol 'acpi_aml_exit' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 drivers/acpi/acpi_dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index 7a265c2171c0..6041974c7627 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -745,7 +745,7 @@ static const struct acpi_debugger_ops acpi_aml_debugger = {
 	.notify_command_complete = acpi_aml_notify_command_complete,
 };
 
-int __init acpi_aml_init(void)
+static int __init acpi_aml_init(void)
 {
 	int ret;
 
@@ -771,7 +771,7 @@ int __init acpi_aml_init(void)
 	return 0;
 }
 
-void __exit acpi_aml_exit(void)
+static void __exit acpi_aml_exit(void)
 {
 	if (acpi_aml_initialized) {
 		acpi_unregister_debugger(&acpi_aml_debugger);
-- 
2.20.1

