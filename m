Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F2E239EB0
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Aug 2020 07:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgHCFSn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Aug 2020 01:18:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:41133 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgHCFSn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Aug 2020 01:18:43 -0400
IronPort-SDR: /wHOw2KZdhJA6k2q+U5TwGqX68qUfgcBe3ijJLu2xdtVftfInE0JHk8XkIlEfIBaxke5IxIYTz
 iIXDJgOW79pQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="213579971"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="213579971"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:18:42 -0700
IronPort-SDR: tm9LkYDyqhV6V4pL1WKMtw3wf8v+Is6yDzCmQMUlL5Qqvl/+x6Q9qb44wsebsqk1ZT8GgKO45l
 P1v5Vq1qFkWg==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="395938115"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:18:41 -0700
Subject: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved
 ranges
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jeff Moyer <jmoyer@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, vishal.l.verma@intel.com,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        joao.m.martins@oracle.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Sun, 02 Aug 2020 22:02:23 -0700
Message-ID: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes since v3 [1]:
- Update x86 boot options documentation for 'nohmat' (Randy)

- Fixup a handful of kbuild robot reports, the most significant being
  moving usage of PUD_SIZE and PMD_SIZE under
  #ifdef CONFIG_TRANSPARENT_HUGEPAGE protection.

[1]: http://lore.kernel.org/r/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com

---
Merge notes:

Well, no v5.8-rc8 to line this up for v5.9, so next best is early
integration into -mm before other collisions develop.

Chatted with Justin offline and it currently appears that the missing
numa information is the fault of the platform firmware to populate all
the necessary NUMA data in the NFIT.

---
Cover:

The device-dax facility allows an address range to be directly mapped
through a chardev, or optionally hotplugged to the core kernel page
allocator as System-RAM. It is the mechanism for converting persistent
memory (pmem) to be used as another volatile memory pool i.e. the
current Memory Tiering hot topic on linux-mm.

In the case of pmem the nvdimm-namespace-label mechanism can sub-divide
it, but that labeling mechanism is not available / applicable to
soft-reserved ("EFI specific purpose") memory [3]. This series provides
a sysfs-mechanism for the daxctl utility to enable provisioning of
volatile-soft-reserved memory ranges.

The motivations for this facility are:

1/ Allow performance differentiated memory ranges to be split between
   kernel-managed and directly-accessed use cases.

2/ Allow physical memory to be provisioned along performance relevant
   address boundaries. For example, divide a memory-side cache [4] along
   cache-color boundaries.

3/ Parcel out soft-reserved memory to VMs using device-dax as a security
   / permissions boundary [5]. Specifically I have seen people (ab)using
   memmap=nn!ss (mark System-RAM as Persistent Memory) just to get the
   device-dax interface on custom address ranges. A follow-on for the VM
   use case is to teach device-dax to dynamically allocate 'struct page' at
   runtime to reduce the duplication of 'struct page' space in both the
   guest and the host kernel for the same physical pages.

[2]: http://lore.kernel.org/r/20200713160837.13774-11-joao.m.martins@oracle.com
[3]: http://lore.kernel.org/r/157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com
[4]: http://lore.kernel.org/r/154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com
[5]: http://lore.kernel.org/r/20200110190313.17144-1-joao.m.martins@oracle.com

---

Dan Williams (19):
      x86/numa: Cleanup configuration dependent command-line options
      x86/numa: Add 'nohmat' option
      efi/fake_mem: Arrange for a resource entry per efi_fake_mem instance
      ACPI: HMAT: Refactor hmat_register_target_device to hmem_register_device
      resource: Report parent to walk_iomem_res_desc() callback
      mm/memory_hotplug: Introduce default phys_to_target_node() implementation
      ACPI: HMAT: Attach a device for each soft-reserved range
      device-dax: Drop the dax_region.pfn_flags attribute
      device-dax: Move instance creation parameters to 'struct dev_dax_data'
      device-dax: Make pgmap optional for instance creation
      device-dax: Kill dax_kmem_res
      device-dax: Add an allocation interface for device-dax instances
      device-dax: Introduce 'seed' devices
      drivers/base: Make device_find_child_by_name() compatible with sysfs inputs
      device-dax: Add resize support
      mm/memremap_pages: Convert to 'struct range'
      mm/memremap_pages: Support multiple ranges per invocation
      device-dax: Add dis-contiguous resource support
      device-dax: Introduce 'mapping' devices

Joao Martins (4):
      device-dax: Make align a per-device property
      device-dax: Add an 'align' attribute
      dax/hmem: Introduce dax_hmem.region_idle parameter
      device-dax: Add a range mapping allocation attribute


 Documentation/x86/x86_64/boot-options.rst |    4 
 arch/powerpc/kvm/book3s_hv_uvmem.c        |   14 
 arch/x86/include/asm/numa.h               |    8 
 arch/x86/kernel/e820.c                    |   16 
 arch/x86/mm/numa.c                        |   11 
 arch/x86/mm/numa_emulation.c              |    3 
 arch/x86/xen/enlighten_pv.c               |    2 
 drivers/acpi/numa/hmat.c                  |   76 --
 drivers/acpi/numa/srat.c                  |    9 
 drivers/base/core.c                       |    2 
 drivers/dax/Kconfig                       |    4 
 drivers/dax/Makefile                      |    3 
 drivers/dax/bus.c                         | 1046 +++++++++++++++++++++++++++--
 drivers/dax/bus.h                         |   28 -
 drivers/dax/dax-private.h                 |   60 +-
 drivers/dax/device.c                      |  134 ++--
 drivers/dax/hmem.c                        |   56 --
 drivers/dax/hmem/Makefile                 |    6 
 drivers/dax/hmem/device.c                 |  100 +++
 drivers/dax/hmem/hmem.c                   |   65 ++
 drivers/dax/kmem.c                        |  199 +++---
 drivers/dax/pmem/compat.c                 |    2 
 drivers/dax/pmem/core.c                   |   22 -
 drivers/firmware/efi/x86_fake_mem.c       |   12 
 drivers/gpu/drm/nouveau/nouveau_dmem.c    |   15 
 drivers/nvdimm/badrange.c                 |   26 -
 drivers/nvdimm/claim.c                    |   13 
 drivers/nvdimm/nd.h                       |    3 
 drivers/nvdimm/pfn_devs.c                 |   13 
 drivers/nvdimm/pmem.c                     |   27 -
 drivers/nvdimm/region.c                   |   21 -
 drivers/pci/p2pdma.c                      |   12 
 include/acpi/acpi_numa.h                  |   14 
 include/linux/dax.h                       |    8 
 include/linux/memory_hotplug.h            |    5 
 include/linux/memremap.h                  |   11 
 include/linux/numa.h                      |   11 
 include/linux/range.h                     |    6 
 kernel/resource.c                         |   11 
 lib/test_hmm.c                            |   15 
 mm/memory_hotplug.c                       |   10 
 mm/memremap.c                             |  299 +++++---
 tools/testing/nvdimm/dax-dev.c            |   22 -
 tools/testing/nvdimm/test/iomap.c         |    2 
 44 files changed, 1825 insertions(+), 601 deletions(-)
 delete mode 100644 drivers/dax/hmem.c
 create mode 100644 drivers/dax/hmem/Makefile
 create mode 100644 drivers/dax/hmem/device.c
 create mode 100644 drivers/dax/hmem/hmem.c

base-commit: 01830e6c042e8eb6eb202e05d7df8057135b4c26
