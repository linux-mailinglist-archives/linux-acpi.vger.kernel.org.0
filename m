Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDAA3DDC53
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Aug 2021 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhHBPY2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Aug 2021 11:24:28 -0400
Received: from foss.arm.com ([217.140.110.172]:37504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234852AbhHBPY1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Aug 2021 11:24:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F02B12FC;
        Mon,  2 Aug 2021 08:24:17 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AD013F66F;
        Mon,  2 Aug 2021 08:24:14 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 2/3] ACPI: osl: Reorder acpi_os_map_iomem() __ref annotation
Date:   Mon,  2 Aug 2021 16:23:58 +0100
Message-Id: <20210802152359.12623-3-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The __ref annotation has nothing to do with the acpi_os_map_iomem()
return value type.

Redefine the acpi_os_map_iomem() function prototype to avoid mixing the
__ref annotation with the return type declaration.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/osl.c     | 4 ++--
 include/acpi/acpi_io.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 8f67bf0f090b..fdee0c6f4f7f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -321,8 +321,8 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
  * During early init (when acpi_permanent_mmap has not been set yet) this
  * routine simply calls __acpi_map_table() to get the job done.
  */
-void __iomem __ref
-*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
+void __iomem *__ref
+acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map;
 	void __iomem *virt;
diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
index 027faa8883aa..a0094420303f 100644
--- a/include/acpi/acpi_io.h
+++ b/include/acpi/acpi_io.h
@@ -16,8 +16,8 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 
 extern bool acpi_permanent_mmap;
 
-void __iomem __ref
-*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
+void __iomem *__ref
+acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
 void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size);
 void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size);
 
-- 
2.31.0

