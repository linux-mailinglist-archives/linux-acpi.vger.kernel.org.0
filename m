Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1260D18EA54
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Mar 2020 17:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCVQ2d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 22 Mar 2020 12:28:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:4086 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVQ2c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Mar 2020 12:28:32 -0400
IronPort-SDR: 6BGa79Zvinhui8/p2u8HeND9AF3xlkxAjFXMCG8mmiXuI4xlAMa4TuuB25Pnd4BDi1NNqSdzHz
 zVvWG25xQ8nQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:31 -0700
IronPort-SDR: ZNYSGDdCKqMndeTUunFztK8jUdJEalFJo9nJ7o9zgaEkHzDyFMea8OAJg+5mWNsNnbHofBnCjx
 OF8kC5fFlnBg==
X-IronPort-AV: E=Sophos;i="5.72,293,1580803200"; 
   d="scan'208";a="419253068"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:30 -0700
Subject: [PATCH v2 0/6] Manual definition of Soft Reserved memory devices
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, joao.m.martins@oracle.com
Date:   Sun, 22 Mar 2020 09:12:23 -0700
Message-ID: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes since v1 [1]:
- Kill the ifdef'ery in arch/x86/mm/numa.c (Rafael)

- Add a dummy phys_to_target_node() for ARM64 (0day-robot)

- Initialize ->child and ->sibling to NULL in the resource returned by
  find_next_iomem_res() (Inspired by Tom's feedback even though it does
  not set them like he suggested)

- Collect Ard's Ack

[1]: http://lore.kernel.org/r/158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com

---

My primary motivation is making the dax_kmem facility useful to
shipping platforms that have performance differentiated memory, but
may not have EFI-defined soft-reservations / HMAT (or
non-EFI-ACPI-platform equivalent). I'm anticipating HMAT enabled
platforms where the platform firmware policy for what is
soft-reserved, or not, is not the policy the system owner would pick.
I'd also highlight Joao's work [2] (see the TODO section) as an
indication of the demand for custom carving memory resources and
applying the device-dax memory management interface.

Given the current dearth of systems that supply an ACPI HMAT table, and
the utility of being able to manually define device-dax "hmem" instances
via the efi_fake_mem= option, relax the requirements for creating these
devices. Specifically, add an option (numa=nohmat) to optionally disable
consideration of the HMAT and update efi_fake_mem= to behave like
memmap=nn!ss in terms of delimiting device boundaries.

[2]: https://lore.kernel.org/lkml/20200110190313.17144-1-joao.m.martins@oracle.com/

With Ard's and Rafael's ack I'd feel ok taking this through the nvdimm
tree, please holler if anything still needs some fixups.

Dependencies:

b2ca916ce392 ACPI: NUMA: Up-level "map to online node" functionality
4fcbe96e4d0b mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
575e23b6e13c powerpc/papr_scm: Switch to numa_map_to_online_node()
1e5d8e1e47af x86/mm: Introduce CONFIG_NUMA_KEEP_MEMINFO
5d30f92e7631 x86/NUMA: Provide a range-to-target_node lookup facility
7b27a8622f80 libnvdimm/e820: Retrieve and populate correct 'target_node' info

Tested with:

        numa=nohmat efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000

...to create to device-dax instances:

	# daxctl list -RDu
	[
	  {
	    "path":"\/platform\/hmem.1",
	    "id":1,
	    "size":"4.00 GiB (4.29 GB)",
	    "align":2097152,
	    "devices":[
	      {
	        "chardev":"dax1.0",
	        "size":"4.00 GiB (4.29 GB)",
	        "target_node":3,
	        "mode":"devdax"
	      }
	    ]
	  },
	  {
	    "path":"\/platform\/hmem.0",
	    "id":0,
	    "size":"4.00 GiB (4.29 GB)",
	    "align":2097152,
	    "devices":[
	      {
	        "chardev":"dax0.0",
	        "size":"4.00 GiB (4.29 GB)",
	        "target_node":2,
	        "mode":"devdax"
	      }
	    ]
	  }
	]


---

Dan Williams (6):
      x86/numa: Cleanup configuration dependent command-line options
      x86/numa: Add 'nohmat' option
      efi/fake_mem: Arrange for a resource entry per efi_fake_mem instance
      ACPI: HMAT: Refactor hmat_register_target_device to hmem_register_device
      resource: Report parent to walk_iomem_res_desc() callback
      ACPI: HMAT: Attach a device for each soft-reserved range

 arch/arm64/mm/numa.c                |   13 +++++
 arch/x86/include/asm/numa.h         |    8 +++
 arch/x86/kernel/e820.c              |   16 +++++-
 arch/x86/mm/numa.c                  |   10 +---
 arch/x86/mm/numa_emulation.c        |    3 +
 arch/x86/xen/enlighten_pv.c         |    2 -
 drivers/acpi/numa/hmat.c            |   76 +++++----------------------
 drivers/acpi/numa/srat.c            |    9 +++
 drivers/dax/Kconfig                 |    5 ++
 drivers/dax/Makefile                |    3 -
 drivers/dax/hmem/Makefile           |    6 ++
 drivers/dax/hmem/device.c           |   97 +++++++++++++++++++++++++++++++++++
 drivers/dax/hmem/hmem.c             |    2 -
 drivers/firmware/efi/x86_fake_mem.c |   12 +++-
 include/acpi/acpi_numa.h            |   14 +++++
 include/linux/dax.h                 |    8 +++
 kernel/resource.c                   |   11 +++-
 17 files changed, 209 insertions(+), 86 deletions(-)
 create mode 100644 drivers/dax/hmem/Makefile
 create mode 100644 drivers/dax/hmem/device.c
 rename drivers/dax/{hmem.c => hmem/hmem.c} (98%)

base-commit: 7b27a8622f802761d5c6abd6c37b22312a35343c
