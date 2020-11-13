Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B122B148A
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 04:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgKMDJS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 22:09:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7226 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKMDJS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 22:09:18 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CXNjB1M6hzkjxD;
        Fri, 13 Nov 2020 11:09:02 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 11:09:05 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/2] ACPI: acpi_drivers.h: Update the kernel doc
Date:   Fri, 13 Nov 2020 11:00:45 +0800
Message-ID: <1605236445-52540-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1605236445-52540-1-git-send-email-guohanjun@huawei.com>
References: <1605236445-52540-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pci_bind.c is not exist anymore, so just remove all the
.c file reference as the c file reference is not useful
and avoid future non-consistency update.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 include/acpi/acpi_drivers.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 634f967..d4f39a2 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -64,14 +64,14 @@
    -------------------------------------------------------------------------- */
 
 
-/* ACPI PCI Interrupt Link (pci_link.c) */
+/* ACPI PCI Interrupt Link */
 
 int acpi_irq_penalty_init(void);
 int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
 			       int *polarity, char **name);
 int acpi_pci_link_free_irq(acpi_handle handle);
 
-/* ACPI PCI Device Binding (pci_bind.c) */
+/* ACPI PCI Device Binding */
 
 struct pci_bus;
 
-- 
1.7.12.4

