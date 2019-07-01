Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4647351A98
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 20:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFXSdo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 14:33:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:13366 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfFXSdo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jun 2019 14:33:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 11:33:43 -0700
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="360098149"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 11:33:42 -0700
Subject: [PATCH v4 00/10] EFI Specific Purpose Memory Support
From:   Dan Williams <dan.j.williams@intel.com>
To:     x86@kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Darren Hart <dvhart@infradead.org>, tglx@linutronix.de,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 11:19:25 -0700
Message-ID: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes since v3 [1]:
- Clarify in the changelog that the policy decision of how to treat
  specific-purpose memory is x86 only until other archs grow a
  translation to IORES_DESC_APPLICATION_RESERVED. The EFI spec does not
  mandate a behavior for the EFI_MEMORY_SP attribute so the decision is
  kept out of the core EFI implementation. (prompted by Ard)

- Merge the memregion ida into kernel/resource.c and provide a static
  inline wrappers around an exported  'struct ida memregion_ids'
  instance. (Willy)

- Fix a set of compile errors in the CONFIG_EFI_FAKE_MEMMAP=n case.
  (0day)

- Collect Dave's reviewed-by on the series.

[1]: https://lore.kernel.org/lkml/155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com/

---

Merge logistics: These patches touch core-efi, acpi, device-dax, and
x86. Given the regression risk is highest for the x86 changes it seems
tip.git is the best tree to host the series.

---

The EFI 2.8 Specification [2] introduces the EFI_MEMORY_SP ("specific
purpose") memory attribute. This attribute bit replaces the deprecated
ACPI HMAT "reservation hint" that was introduced in ACPI 6.2 and removed
in ACPI 6.3.

Given the increasing diversity of memory types that might be advertised
to the operating system, there is a need for platform firmware to hint
which memory ranges are free for the OS to use as general purpose memory
and which ranges are intended for application specific usage. For
example, an application with prior knowledge of the platform may expect
to be able to exclusively allocate a precious / limited pool of high
bandwidth memory. Alternatively, for the general purpose case, the
operating system may want to make the memory available on a best effort
basis as a unique numa-node with performance properties by the new
CONFIG_HMEM_REPORTING [3] facility.

In support of optionally allowing either application-exclusive and
core-kernel-mm managed access to differentiated memory, claim
EFI_MEMORY_SP ranges for exposure as device-dax instances by default.
Such instances can be directly owned / mapped by a
platform-topology-aware application. Alternatively, with the new kmem
facility [4], the administrator has the option to instead designate that
those memory ranges be hot-added to the core-kernel-mm as a unique
memory numa-node. In short, allow for the decision about what software
agent manages specific-purpose memory to be made at runtime.

The patches build on the new HMAT+HMEM_REPORTING facilities merged
for v5.2-rc1. The implementation is tested with qemu emulation of HMAT
[5] plus the efi_fake_mem facility for applying the EFI_MEMORY_SP
attribute.

[2]: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1cf33aafb84
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308f
[5]: http://patchwork.ozlabs.org/cover/1096737/

---

Dan Williams (10):
      acpi/numa: Establish a new drivers/acpi/numa/ directory
      acpi/numa/hmat: Skip publishing target info for nodes with no online memory
      efi: Enumerate EFI_MEMORY_SP
      x86, efi: Push EFI_MEMMAP check into leaf routines
      x86, efi: Reserve UEFI 2.8 Specific Purpose Memory for dax
      x86, efi: Add efi_fake_mem support for EFI_MEMORY_SP
      resource: Uplevel the pmem "region" ida to a global allocator
      device-dax: Add a driver for "hmem" devices
      acpi/numa/hmat: Register HMAT at device_initcall level
      acpi/numa/hmat: Register "specific purpose" memory as an "hmem" device


 arch/x86/Kconfig                    |   23 +++++
 arch/x86/boot/compressed/eboot.c    |    5 +
 arch/x86/boot/compressed/kaslr.c    |    3 -
 arch/x86/include/asm/e820/types.h   |    9 ++
 arch/x86/include/asm/efi.h          |   34 ++++++++
 arch/x86/kernel/e820.c              |   12 ++-
 arch/x86/kernel/setup.c             |   21 +++--
 arch/x86/platform/efi/efi.c         |   40 +++++++++
 arch/x86/platform/efi/quirks.c      |    3 +
 drivers/acpi/Kconfig                |    9 --
 drivers/acpi/Makefile               |    3 -
 drivers/acpi/hmat/Makefile          |    2 
 drivers/acpi/numa/Kconfig           |    8 ++
 drivers/acpi/numa/Makefile          |    3 +
 drivers/acpi/numa/hmat.c            |  148 +++++++++++++++++++++++++++++++----
 drivers/acpi/numa/srat.c            |    0 
 drivers/dax/Kconfig                 |   27 +++++-
 drivers/dax/Makefile                |    2 
 drivers/dax/hmem.c                  |   57 +++++++++++++
 drivers/firmware/efi/Makefile       |    5 +
 drivers/firmware/efi/efi.c          |    5 +
 drivers/firmware/efi/esrt.c         |    3 +
 drivers/firmware/efi/fake_mem.c     |   26 +++---
 drivers/firmware/efi/fake_mem.h     |   10 ++
 drivers/firmware/efi/x86-fake_mem.c |   69 ++++++++++++++++
 drivers/nvdimm/Kconfig              |    1 
 drivers/nvdimm/core.c               |    1 
 drivers/nvdimm/nd-core.h            |    1 
 drivers/nvdimm/region_devs.c        |   12 +--
 include/linux/efi.h                 |    3 -
 include/linux/ioport.h              |   32 ++++++++
 kernel/resource.c                   |    6 +
 lib/Kconfig                         |    3 +
 33 files changed, 504 insertions(+), 82 deletions(-)
 delete mode 100644 drivers/acpi/hmat/Makefile
 rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (70%)
 create mode 100644 drivers/acpi/numa/Makefile
 rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (81%)
 rename drivers/acpi/{numa.c => numa/srat.c} (100%)
 create mode 100644 drivers/dax/hmem.c
 create mode 100644 drivers/firmware/efi/fake_mem.h
 create mode 100644 drivers/firmware/efi/x86-fake_mem.c
