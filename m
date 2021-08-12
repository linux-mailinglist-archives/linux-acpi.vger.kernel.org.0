Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677573E9F0B
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 08:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhHLG7q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 02:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhHLG7p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 02:59:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F24AA601FD;
        Thu, 12 Aug 2021 06:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628751560;
        bh=YFMZTccB6r2mQUHMX3e0DwUnA6yRsuYhah5UQoES2qE=;
        h=From:To:Cc:Subject:Date:From;
        b=gqDKL6oFAWPfl+qrvP4ICkIiJuTj0zB5TnIo9v2jyftPMcesd9mebeUTOENH/WF4R
         PBfqCrnjEHgRHt0O1dyCISfhSxmredSB9XxmW1Ns603miZy037IV2h2edGI81ldDzY
         NqgDtvGktsfZul6wLbLg1Tgj9dX32EjsY3bdIRoj49WsQpGFdC5ZMg6zFcqteaJDkt
         0uruPXpJRVzqwUCwDkAf6p3Y7H3f580IbJRG6NdyUWhatq3Gxbuq0XxYssVS/sjhOA
         hChRFrKVbGxFTcFqXajSbSnyBDOxjDPh7zY8Sk+z4WzAiR3GMcSU98BQ+MjV7C6G/L
         np4VR2Z/7QAFw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Len Brown <lenb@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v4 0/2] memblock: make memblock_find_in_range method private
Date:   Thu, 12 Aug 2021 09:59:05 +0300
Message-Id: <20210812065907.20046-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is v4 of "memblock: make memblock_find_in_range method private" patch
that essentially replaces memblock_find_in_range() + memblock_reserve()
calls with equivalent calls to memblock_phys_alloc() and prevents usage of
memblock_find_in_range() outside memblock itself.

The patch uncovered an issue with top down memory mapping on x86 and this
version has a preparation patch that addresses this issue.

Guenter, I didn't add your Tested-by because the patch that addresses the
crashes differs from the one you've tested.

v4: 
* Add patch that prevents the crashes reported by Guenter Roeck on x86/i386
  on QEMU with 256M or 512M of memory and EFI boot enabled.
* Add Acked-by and Reviewed-by, thanks everybidy!

v3: https://lore.kernel.org/lkml/20210803064218.6611-1-rppt@kernel.org
* simplify check for exact crash kerenl allocation on arm, per Rob
* make crash_max unsigned long long on arm64, per Rob

v2: https://lore.kernel.org/lkml/20210802063737.22733-1-rppt@kernel.org
* don't change error message in arm::reserve_crashkernel(), per Russell

v1: https://lore.kernel.org/lkml/20210730104039.7047-1-rppt@kernel.org

Mike Rapoport (2):
  x86/mm: memory_map_top_down: remove spurious reservation of upper 2M
  memblock: make memblock_find_in_range method private

 arch/arm/kernel/setup.c           | 20 +++++---------
 arch/arm64/kvm/hyp/reserved_mem.c |  9 +++----
 arch/arm64/mm/init.c              | 36 ++++++++-----------------
 arch/mips/kernel/setup.c          | 14 +++++-----
 arch/riscv/mm/init.c              | 44 ++++++++++---------------------
 arch/s390/kernel/setup.c          | 10 ++++---
 arch/x86/kernel/aperture_64.c     |  5 ++--
 arch/x86/mm/init.c                | 27 +++++++------------
 arch/x86/mm/numa.c                |  5 ++--
 arch/x86/mm/numa_emulation.c      |  5 ++--
 arch/x86/realmode/init.c          |  2 +-
 drivers/acpi/tables.c             |  5 ++--
 drivers/base/arch_numa.c          |  5 +---
 drivers/of/of_reserved_mem.c      | 12 ++++++---
 include/linux/memblock.h          |  2 --
 mm/memblock.c                     |  2 +-
 16 files changed, 76 insertions(+), 127 deletions(-)


base-commit: ff1176468d368232b684f75e82563369208bc371
-- 
2.28.0

