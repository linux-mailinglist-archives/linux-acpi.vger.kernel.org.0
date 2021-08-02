Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25CA3DDC52
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Aug 2021 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhHBPY0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Aug 2021 11:24:26 -0400
Received: from foss.arm.com ([217.140.110.172]:37490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235089AbhHBPYY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Aug 2021 11:24:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3F8811FB;
        Mon,  2 Aug 2021 08:24:13 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62CB43F66F;
        Mon,  2 Aug 2021 08:24:11 -0700 (PDT)
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
Subject: [PATCH v2 1/3] ACPI: osl: Add __force attribute in acpi_os_map_iomem() cast
Date:   Mon,  2 Aug 2021 16:23:57 +0100
Message-Id: <20210802152359.12623-2-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a __force attribute to the void* cast in acpi_os_map_iomem()
to prevent sparse warnings.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 45c5c0e45e33..8f67bf0f090b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -376,7 +376,7 @@ EXPORT_SYMBOL_GPL(acpi_os_map_iomem);
 
 void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 {
-	return (void *)acpi_os_map_iomem(phys, size);
+	return (__force void *)acpi_os_map_iomem(phys, size);
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
-- 
2.31.0

