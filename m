Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8253128E6ED
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 21:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389070AbgJNTMS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 15:12:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:52058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388775AbgJNTMS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 15:12:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7439B1EA;
        Wed, 14 Oct 2020 19:12:16 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 0/8] arm64: Default to 32-bit wide ZONE_DMA
Date:   Wed, 14 Oct 2020 21:12:02 +0200
Message-Id: <20201014191211.27029-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Using two distinct DMA zones turned out to be problematic. Here's an
attempt go back to a saner default.

I tested this on both a RPi4 and QEMU.

---

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

Nicolas Saenz Julienne (7):
  arm64: mm: Move reserve_crashkernel() into mem_init()
  arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
  of/address: Introduce of_dma_get_max_cpu_address()
  of: unittest: Add test for of_dma_get_max_cpu_address()
  dma-direct: Turn zone_dma_bits default value into a define
  arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
  mm: Update DMA zones description

 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/mm/init.c               | 20 ++++++------
 drivers/acpi/arm64/iort.c          | 51 ++++++++++++++++++++++++++++++
 drivers/of/address.c               | 42 ++++++++++++++++++++++++
 drivers/of/unittest.c              | 20 ++++++++++++
 include/linux/acpi_iort.h          |  4 +++
 include/linux/dma-direct.h         |  3 ++
 include/linux/mmzone.h             |  5 +--
 include/linux/of.h                 |  7 ++++
 kernel/dma/direct.c                |  2 +-
 10 files changed, 143 insertions(+), 12 deletions(-)

-- 
2.28.0

