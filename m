Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467942BA957
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Nov 2020 12:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgKTLjk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 06:39:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbgKTLjj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Nov 2020 06:39:39 -0500
Received: from localhost.localdomain (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D418B22253;
        Fri, 20 Nov 2020 11:39:35 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, ardb@kernel.org,
        hch@lst.de
Cc:     Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
        lorenzo.pieralisi@arm.com, linux-mm@kvack.org,
        guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/7] arm64: Default to 32-bit wide ZONE_DMA
Date:   Fri, 20 Nov 2020 11:39:34 +0000
Message-Id: <160587230018.19468.15360551479275381470.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201119175400.9995-1-nsaenzjulienne@suse.de>
References: <20201119175400.9995-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 19 Nov 2020 18:53:52 +0100, Nicolas Saenz Julienne wrote:
> Using two distinct DMA zones turned out to be problematic. Here's an
> attempt go back to a saner default.
> 
> I tested this on both a RPi4 and QEMU.

Applied to arm64 (for-next/zone-dma-default-32-bit), thanks!

[1/7] arm64: mm: Move reserve_crashkernel() into mem_init()
      https://git.kernel.org/arm64/c/0a30c53573b0
[2/7] arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
      https://git.kernel.org/arm64/c/9804f8c69b04
[3/7] of/address: Introduce of_dma_get_max_cpu_address()
      https://git.kernel.org/arm64/c/964db79d6c18
[4/7] of: unittest: Add test for of_dma_get_max_cpu_address()
      https://git.kernel.org/arm64/c/07d13a1d6120
[5/7] arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
      https://git.kernel.org/arm64/c/8424ecdde7df
[6/7] arm64: mm: Set ZONE_DMA size based on early IORT scan
      https://git.kernel.org/arm64/c/2b8652936f0c
[7/7] mm: Remove examples from enum zone_type comment
      https://git.kernel.org/arm64/c/04435217f968

-- 
Catalin

