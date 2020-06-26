Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60B220B579
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFZP6p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jun 2020 11:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFZP6p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jun 2020 11:58:45 -0400
Received: from dogfood.home (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9D82080C;
        Fri, 26 Jun 2020 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593187125;
        bh=MI1bCIGMLcKccd2dmrayi3mwq6PLyLqFmsxPhzVVj+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pMTRSoP0LXtmeOSgiI76477HiCGpazaJWj4NOXf4jg37wdu7QJRO+hgH7/lbWlegp
         YbMVEvycZyfYFIw7lvXVRybyHe8zWKkHfI1tp0NnY6Ii7+0F1yeppV9UA9SqboJnmG
         d43IUvvLg9Bbk9CBd3EtE1y9ClPj/ONI/O8B3hsw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, kernel-hardening@lists.openwall.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 2/2] arm64/acpi: disallow writeable AML opregion mapping for EFI code regions
Date:   Fri, 26 Jun 2020 17:58:32 +0200
Message-Id: <20200626155832.2323789-3-ardb@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626155832.2323789-1-ardb@kernel.org>
References: <20200626155832.2323789-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Given that the contents of EFI runtime code and data regions are
provided by the firmware, as well as the DSDT, it is not unimaginable
that AML code exists today that accesses EFI runtime code regions using
a SystemMemory OpRegion. There is nothing fundamentally wrong with that,
but since we take great care to ensure that executable code is never
mapped writeable and executable at the same time, we should not permit
AML to create writable mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/acpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 01b861e225b0..455966401102 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -301,6 +301,15 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 			pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
 			return NULL;
 
+		case EFI_RUNTIME_SERVICES_CODE:
+			/*
+			 * This would be unusual, but not problematic per se,
+			 * as long as we take care not to create a writable
+			 * mapping for executable code.
+			 */
+			prot = PAGE_KERNEL_RO;
+			break;
+
 		case EFI_ACPI_RECLAIM_MEMORY:
 			/*
 			 * ACPI reclaim memory is used to pass firmware tables
-- 
2.27.0

