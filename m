Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE421CB2BA
	for <lists+linux-acpi@lfdr.de>; Fri,  8 May 2020 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEHPXL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 May 2020 11:23:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbgEHPXL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 May 2020 11:23:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1960F3345A7098F8FCCE;
        Fri,  8 May 2020 23:23:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 23:22:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] arm64: gtdt: Fix section mismatch in next_platform_timer()
Date:   Fri, 8 May 2020 23:26:53 +0800
Message-ID: <20200508152653.157663-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Drop the __initdata for acpi_gtdt_desc variable to fix the section mismatch,

WARNING: modpost: vmlinux.o(.text.unlikely+0x95ac): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
The function next_platform_timer() references
the variable __initdata acpi_gtdt_desc.
This is often because next_platform_timer lacks a __initdata
annotation or the annotation of acpi_gtdt_desc is wrong.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/arm64/gtdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 01962c63a711..6a327616a299 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -34,7 +34,7 @@ struct acpi_gtdt_descriptor {
 	void *platform_timer;
 };
 
-static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
+static struct acpi_gtdt_descriptor acpi_gtdt_desc;
 
 static inline void *next_platform_timer(void *platform_timer)
 {
-- 
2.26.2

