Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9A17676D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 23:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCBWgF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 17:36:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:35175 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgCBWgF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Mar 2020 17:36:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 14:36:03 -0800
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400"; 
   d="scan'208";a="273921114"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 14:36:02 -0800
Subject: [PATCH 0/5] Manual definition of Soft Reserved memory devices
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 Mar 2020 14:19:57 -0800
Message-ID: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Given the current dearth of systems that supply an ACPI HMAT table, and
the utility of being able to manually define device-dax "hmem" instances
via the efi_fake_mem= option, relax the requirements for creating these
devices. Specifically, add an option (numa=nohmat) to optionally disable
consideration of the HMAT and update efi_fake_mem= to behave like
memmap=nn!ss in terms of delimiting device boundaries.

All review welcome of course, but the E820 changes want an x86
maintainer ack, the efi_fake_mem update needs Ard, and Rafael has
previously shepherded the HMAT changes. For the changes to
kernel/resource.c, where there is no clear maintainer, I just copied the
last few people to make thoughtful changes in that area. I am happy to
take these through the nvdimm tree along with these prerequisites
already in -next:

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

Dan Williams (5):
      ACPI: NUMA: Add 'nohmat' option
      efi/fake_mem: Arrange for a resource entry per efi_fake_mem instance
      ACPI: HMAT: Refactor hmat_register_target_device to hmem_register_device
      resource: Report parent to walk_iomem_res_desc() callback
      ACPI: HMAT: Attach a device for each soft-reserved range


 arch/x86/kernel/e820.c              |   16 +++++-
 arch/x86/mm/numa.c                  |    4 +
 drivers/acpi/numa/hmat.c            |   71 +++-----------------------
 drivers/dax/Kconfig                 |    5 ++
 drivers/dax/Makefile                |    3 -
 drivers/dax/hmem/Makefile           |    6 ++
 drivers/dax/hmem/device.c           |   97 +++++++++++++++++++++++++++++++++++
 drivers/dax/hmem/hmem.c             |    2 -
 drivers/firmware/efi/x86_fake_mem.c |   12 +++-
 include/acpi/acpi_numa.h            |    1 
 include/linux/dax.h                 |    8 +++
 kernel/resource.c                   |    1 
 12 files changed, 156 insertions(+), 70 deletions(-)
 create mode 100644 drivers/dax/hmem/Makefile
 create mode 100644 drivers/dax/hmem/device.c
 rename drivers/dax/{hmem.c => hmem/hmem.c} (98%)

base-commit: 7b27a8622f802761d5c6abd6c37b22312a35343c
