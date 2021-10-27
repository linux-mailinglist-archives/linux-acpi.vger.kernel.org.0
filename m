Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3172643C4B5
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhJ0INL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 04:13:11 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55690 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240780AbhJ0INL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Oct 2021 04:13:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Uts4e-Z_1635322242;
Received: from localhost.localdomain(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0Uts4e-Z_1635322242)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Oct 2021 16:10:43 +0800
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
To:     helgaas@kernel.org
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuesong.chen@linux.alibaba.com
Subject: [PATCH v4 0/4] PCI MCFG consolidation and APEI resource filtering
Date:   Wed, 27 Oct 2021 16:10:35 +0800
Message-Id: <20211027081035.53370-1-xuesong.chen@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <YW5OTMz+x8zrsqkF@Dennis-MBP.local>
References: <YW5OTMz+x8zrsqkF@Dennis-MBP.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The issue of commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
level") on x86 is also happened on our own ARM64 platform. We sent a patch[1]
trying to fix this issue in an arch-specific way as x86 does at first, but
according to the suggestion from Lorenzo Pieralisi and Catalin Marinas, we can
consolidate the PCI MCFG part then fix it in a more common way, that's why this
patch series comes.

[1] https://marc.info/?l=linux-arm-kernel&m=163108478627166&w=2

---
Change from v3 to v4:
  - Add a new patch (patch #3) to address the quirk ECAM access issue. Because
    the normal ECAM config space can be accessed in a lockless way, so we don't
    need the mutual exclusion with the EINJ action. But those quirks maybe break
    this rule and corrupt the configuration access, reserve its MCFG address
    regions in this case to avoid that happens. 
  
  - Add another patch (patch #4) to log the PCI MCFG entry parse message per
    the suggestion from Bjorn Helgaas. The output on ARM64 as:
    ACPI: MCFG entry for domain 0000 [bus 00-0f] at [mem 0x50000000-0x50ffffff] (base 0x50000000)
  
  - Commit message updated with more details of patch #2

Change from v2 to v3:
  - Address the comments of Lorenzo Pieralisi about the CONFIG_PCI
    dependence issue in APEI module (patch #2)

Change from v1 to v2:
  - Fix the "undefined reference to `pci_mmcfg_list'" build error in case
    of PCI_CONFIG=n, reported by the kernel test robot

Xuesong Chen (4):
  PCI: MCFG: Consolidate the separate PCI MCFG table entry list
  ACPI: APEI: Filter the PCI MCFG address with an arch-agnostic method
  ACPI: APEI: Reserve the MCFG address for quirk ECAM implementation
  PCI: MCFG: Add the MCFG entry parse log message

 arch/x86/include/asm/pci_x86.h | 17 +----------
 arch/x86/pci/mmconfig-shared.c | 30 -------------------
 drivers/acpi/apei/apei-base.c  | 68 ++++++++++++++++++++++++++++++++----------
 drivers/acpi/pci_mcfg.c        | 46 +++++++++++++++-------------
 drivers/pci/pci.c              |  2 ++
 drivers/pci/quirks.c           |  2 ++
 include/linux/pci.h            | 18 +++++++++++
 7 files changed, 101 insertions(+), 82 deletions(-)

-- 
1.8.3.1

