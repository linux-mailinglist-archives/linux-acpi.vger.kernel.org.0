Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EFD21CA27
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Jul 2020 18:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgGLQmX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Jul 2020 12:42:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:25234 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbgGLQmX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Jul 2020 12:42:23 -0400
IronPort-SDR: Z69v/ORhMbLG0E5kePfctdqTImwG7ZFvZF+tZqDFkRwyfFtPNWJvuxGyvBFTysGlJtixmt/1Yf
 Qdv4Kcw8ussw==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="210054562"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="210054562"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:42:22 -0700
IronPort-SDR: w09DlxdoREi5sngYNiZBKWJOVTLl+CDIvtzZ/uaA4MupcVijS0R+Mlb2tQyBlcFZBMiu8NVopd
 tnqyNHuv32/A==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="317142928"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:42:21 -0700
Subject: [PATCH v2 00/22] device-dax: Support sub-dividing soft-reserved
 ranges
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
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
        Andrew Morton <akpm@linux-foundation.org>,
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
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        hch@lst.de, joao.m.martins@oracle.com
Date:   Sun, 12 Jul 2020 09:26:05 -0700
Message-ID: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes since v1 [1]:

- Combine this series with "Manual definition of Soft Reserved memory
  devices" [2] as the pre-requisites are required to test the device-dax
  facility, the device-dax changes are part of the justification for the
  numa-info reworks.

- Provide a generic version of numa data retrieval based on memblock for
  arm64 rather than adding a new / empty phys_to_target_node() stub
  alongside memory_add_physaddr_to_nid(). (Will)

- Fix several corner case allocation bugs and pass the unit test written
  by Joao.

- Lift the restriction that a 'seed' device must be activated before a
  new seed can be created. This minor sanity check was to prevent userspace
  spamming devices, but it gets in the way of some of allocation
  scenarios like allocating a memory-range that is guaranteed to never be
  evicted due to memory-side-cache conflicts. (Iqbal)

- Add debug prints for space allocation decisions (Joao)

- Rebased on v5.8-rc2 which included resolving conflicts in the kmem
  driver and memremap_pages().

[1]: http://lore.kernel.org/r/158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com
[2]: http://lore.kernel.org/r/158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com/

---

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

Given the intersections of arm64, x86, and core memremap_pages() changes
I'd like to explore taking this through the libnvdimm tree, but that is
step 2. Any concerns with the proposed infrastructure changes
(memblock-numainfo and multi-range-memremap-pages)?

[3]: http://lore.kernel.org/r/157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com
[4]: http://lore.kernel.org/r/154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com
[5]: http://lore.kernel.org/r/20200110190313.17144-1-joao.m.martins@oracle.com

---

Dan Williams (22):
      x86/numa: Cleanup configuration dependent command-line options
      x86/numa: Add 'nohmat' option
      efi/fake_mem: Arrange for a resource entry per efi_fake_mem instance
      ACPI: HMAT: Refactor hmat_register_target_device to hmem_register_device
      resource: Report parent to walk_iomem_res_desc() callback
      x86: Move NUMA_KEEP_MEMINFO and related definition to x86-internals
      numa: Introduce a generic memory_add_physaddr_to_nid()
      memblock: Introduce a generic phys_addr_to_target_node()
      arm64: Convert to generic memblock for numa-info
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

 arch/arm64/Kconfig                     |    1 
 arch/arm64/mm/numa.c                   |   10 
 arch/powerpc/kvm/book3s_hv_uvmem.c     |   14 
 arch/x86/Kconfig                       |    7 
 arch/x86/include/asm/numa.h            |    8 
 arch/x86/kernel/e820.c                 |   16 +
 arch/x86/mm/numa.c                     |   12 
 arch/x86/mm/numa_emulation.c           |    3 
 arch/x86/mm/numa_internal.h            |    7 
 arch/x86/xen/enlighten_pv.c            |    2 
 drivers/acpi/numa/hmat.c               |   76 ---
 drivers/acpi/numa/srat.c               |    9 
 drivers/base/core.c                    |    2 
 drivers/dax/Kconfig                    |    6 
 drivers/dax/Makefile                   |    3 
 drivers/dax/bus.c                      |  902 ++++++++++++++++++++++++++++++--
 drivers/dax/bus.h                      |   28 +
 drivers/dax/dax-private.h              |   39 +
 drivers/dax/device.c                   |   97 ++-
 drivers/dax/hmem/Makefile              |    6 
 drivers/dax/hmem/device.c              |  100 ++++
 drivers/dax/hmem/hmem.c                |   20 -
 drivers/dax/kmem.c                     |  199 ++++---
 drivers/dax/pmem/compat.c              |    2 
 drivers/dax/pmem/core.c                |   22 +
 drivers/firmware/efi/x86_fake_mem.c    |   12 
 drivers/gpu/drm/nouveau/nouveau_dmem.c |    4 
 drivers/nvdimm/badrange.c              |   26 -
 drivers/nvdimm/claim.c                 |   13 
 drivers/nvdimm/nd.h                    |    3 
 drivers/nvdimm/pfn_devs.c              |   13 
 drivers/nvdimm/pmem.c                  |   27 +
 drivers/nvdimm/region.c                |   21 -
 drivers/pci/p2pdma.c                   |   12 
 include/acpi/acpi_numa.h               |   14 
 include/linux/dax.h                    |    8 
 include/linux/memblock.h               |    4 
 include/linux/memremap.h               |   11 
 include/linux/mm.h                     |   13 
 include/linux/numa.h                   |    9 
 include/linux/range.h                  |    6 
 kernel/resource.c                      |   11 
 mm/Kconfig                             |    7 
 mm/memblock.c                          |   22 +
 mm/memremap.c                          |  300 ++++++-----
 mm/page_alloc.c                        |   82 +++
 tools/testing/nvdimm/dax-dev.c         |   22 +
 tools/testing/nvdimm/test/iomap.c      |    2 
 48 files changed, 1705 insertions(+), 528 deletions(-)
 create mode 100644 drivers/dax/hmem/Makefile
 create mode 100644 drivers/dax/hmem/device.c
 rename drivers/dax/{hmem.c => hmem/hmem.c} (74%)

base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
