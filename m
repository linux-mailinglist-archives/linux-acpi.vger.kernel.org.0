Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9422B9A1F
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgKSRyH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 12:54:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:40660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbgKSRyH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Nov 2020 12:54:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 408CFAC22;
        Thu, 19 Nov 2020 17:54:06 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v7 0/7] arm64: Default to 32-bit wide ZONE_DMA
Date:   Thu, 19 Nov 2020 18:53:52 +0100
Message-Id: <20201119175400.9995-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Using two distinct DMA zones turned out to be problematic. Here's an
attempt go back to a saner default.

I tested this on both a RPi4 and QEMU.

---

Changes since v6:
 - Update patch #1 so we reserve crashkernel before request_standard_resources()
 - Tested on top of Catalin's mem_init() patches.

Changes since v5:
 - Unify ACPI/DT functions

Changes since v4:
 - Fix of_dma_get_max_cpu_address() so it returns the last addressable
   addres, not the limit

Changes since v3:
 - Drop patch adding define in dma-mapping
 - Address small review changes
 - Update Ard's patch
 - Add new patch removing examples from mmzone.h

Changes since v2:
 - Introduce Ard's patch
 - Improve OF dma-ranges parsing function
 - Add unit test for OF function
 - Address small changes
 - Move crashkernel reservation later in boot process

Changes since v1:
 - Parse dma-ranges instead of using machine compatible string

Ard Biesheuvel (1):
  arm64: mm: Set ZONE_DMA size based on early IORT scan

Nicolas Saenz Julienne (6):
  arm64: mm: Move reserve_crashkernel() into mem_init()
  arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
  of/address: Introduce of_dma_get_max_cpu_address()
  of: unittest: Add test for of_dma_get_max_cpu_address()
  arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
  mm: Remove examples from enum zone_type comment

 arch/arm64/mm/init.c      | 22 +++++++++-------
 drivers/acpi/arm64/iort.c | 55 +++++++++++++++++++++++++++++++++++++++
 drivers/of/address.c      | 42 ++++++++++++++++++++++++++++++
 drivers/of/unittest.c     | 18 +++++++++++++
 include/linux/acpi_iort.h |  4 +++
 include/linux/mmzone.h    | 20 --------------
 include/linux/of.h        |  7 +++++
 7 files changed, 139 insertions(+), 29 deletions(-)

-- 
2.29.2

