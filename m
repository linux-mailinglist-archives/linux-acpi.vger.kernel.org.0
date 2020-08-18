Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56B5248196
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Aug 2020 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHRJOK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Aug 2020 05:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgHRJOJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Aug 2020 05:14:09 -0400
Received: from e123331-lin.nice.arm.com (127.163.185.81.rev.sfr.net [81.185.163.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBAF4206B5;
        Tue, 18 Aug 2020 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597742049;
        bh=LtsJ167RX159KXYa+wkLLrnd5wFDCnQKro4DmZ8k9U8=;
        h=From:To:Cc:Subject:Date:From;
        b=u2FIXIfzTte6eDi02KQX97wMhw26lOpmp51nBwIYTQ+aU4QlLymg3wZD843lXnrnX
         jh8eT8xvcg6xdw66USJSGPZO6QT8KEwBGYfxDgOAizoiASE/SLcTnkBcjDnkGWTpkp
         vL6xJG1oJm43D1w+99DVsArhXWJHOLKyUb2ZTJ5o=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, hch@infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2] ACPI: ioremap: avoid redundant rounding to OS page size
Date:   Tue, 18 Aug 2020 11:13:53 +0200
Message-Id: <20200818091353.20097-1-ardb@kernel.org>
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
rounding in the call, and instead, apply the necessary masking when
assigning the map->virt member.

Fixes: 1583052d111f ("arm64/acpi: disallow AML memory opregions to access kernel memory")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: return the correct virtual address for hits in the cached mappings array

 drivers/acpi/osl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 6ad8cb05f672..acf6abc693a0 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -350,7 +350,7 @@ void __iomem __ref
 
 	pg_off = round_down(phys, PAGE_SIZE);
 	pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
-	virt = acpi_map(pg_off, pg_sz);
+	virt = acpi_map(phys, size);
 	if (!virt) {
 		mutex_unlock(&acpi_ioremap_lock);
 		kfree(map);
@@ -358,7 +358,7 @@ void __iomem __ref
 	}
 
 	INIT_LIST_HEAD(&map->list);
-	map->virt = virt;
+	map->virt = (void __iomem __force *)((unsigned long)virt & PAGE_MASK);
 	map->phys = pg_off;
 	map->size = pg_sz;
 	map->track.refcount = 1;
-- 
2.17.1

