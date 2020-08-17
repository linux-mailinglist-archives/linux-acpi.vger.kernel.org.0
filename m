Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1292465EB
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 14:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgHQMEj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Aug 2020 08:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgHQMEh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Aug 2020 08:04:37 -0400
Received: from e123331-lin.nice.arm.com (ip-213-127-60-218.ip.prioritytelecom.net [213.127.60.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AC092067C;
        Mon, 17 Aug 2020 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597665876;
        bh=6QoCSlJv7HkuQ6x9iDtVGVAgbwxMfnO85vY9IKlv7LI=;
        h=From:To:Cc:Subject:Date:From;
        b=ggQScV1FjM1jxgw6fyAsXJtf35cyuhpfAB4Y7TT1PQUmChV+KFXsW6znBVRUICla3
         UIAMMZL1vAh2dLNKJZ3os4V0YBTePI4HcyL73K75OAdpCS4FJ3Yrh4DU6nCmbrHgfE
         2lQpU6Bd6tIirkxZWxNM/KBL1ozgFFGQVSyKwjEM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] ACPI: ioremap: avoid redundant rounding to OS page size
Date:   Mon, 17 Aug 2020 14:04:31 +0200
Message-Id: <20200817120431.32233-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The arm64 implementation of acpi_os_ioremap() was recently updated to
tighten the checks around which parts of memory are permitted to be
mapped by ACPI code, which generally only needs access to memory regions
that are statically described by firmware, and any attempts to access
memory that is in active use by the OS is generally a bug or a hacking
attempt. This tightening is based on the EFI memory map, which describes
all memory in the system.

The AArch64 architecture permits page sizes of 16k and 64k in addition
to the EFI default, which is 4k, which means that the EFI memory map may
describe regions that cannot be mapped seamlessly if the OS page size is
greater than 4k. This is usually not a problem, given that the EFI spec
does not permit memory regions requiring different memory attributes to
share a 64k page frame, and so the usual rounding to page size performed
by ioremap() is sufficient to deal with this. However, this rounding does
complicate our EFI memory map permission check, due to the loss of
information that occurs when several small regions share a single 64k
page frame (where rounding each of them will result in the same 64k
single page region).

However, due to the fact that the region check occurs *before* the call
to ioremap() where the necessary rounding is performed, we can deal
with this issue simply by removing the redundant rounding performed by
acpi_os_map_iomem(), as it appears to be the only place where the
arguments to a call to acpi_os_ioremap() are rounded up. So omit the
rounding in the call, and instead, apply the necessary offset to the
result of kmap().

Fixes: 1583052d111f ("arm64/acpi: disallow AML memory opregions to access kernel memory")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/osl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 6ad8cb05f672..55dbdbbae3be 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -289,7 +289,8 @@ static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz)
 	if (should_use_kmap(pfn)) {
 		if (pg_sz > PAGE_SIZE)
 			return NULL;
-		return (void __iomem __force *)kmap(pfn_to_page(pfn));
+		pg_off &= ~PAGE_MASK;
+		return (void __iomem __force *)(kmap(pfn_to_page(pfn)) + pg_off);
 	} else
 		return acpi_os_ioremap(pg_off, pg_sz);
 }
@@ -350,7 +351,7 @@ void __iomem __ref
 
 	pg_off = round_down(phys, PAGE_SIZE);
 	pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
-	virt = acpi_map(pg_off, pg_sz);
+	virt = acpi_map(phys, size);
 	if (!virt) {
 		mutex_unlock(&acpi_ioremap_lock);
 		kfree(map);
@@ -358,7 +359,7 @@ void __iomem __ref
 	}
 
 	INIT_LIST_HEAD(&map->list);
-	map->virt = virt;
+	map->virt = (void *)((unsigned long)virt & PAGE_MASK);
 	map->phys = pg_off;
 	map->size = pg_sz;
 	map->track.refcount = 1;
@@ -367,7 +368,7 @@ void __iomem __ref
 
 out:
 	mutex_unlock(&acpi_ioremap_lock);
-	return map->virt + (phys - map->phys);
+	return virt;
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_iomem);
 
-- 
2.17.1

