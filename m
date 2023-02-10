Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98FD691AC0
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjBJJGQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjBJJFv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:05:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E845FF4;
        Fri, 10 Feb 2023 01:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019924; x=1707555924;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aAOYbYjD+N5rIbj4yLf5cWdsbDyvwj1VTim/NDqe4VU=;
  b=N9M1/N0syUZ/ijR4s/xbctWiKVwo+n7kdFCbOnpUjIBF/4w56a8JTSWm
   DAEJStqukpqmNgtYP0sEavrb8qfNhN6KgvKdq+XbWoW24BaI3ZM7Fxuc8
   0JMjlcKjK3R7ip/jXub3mmbVHaRFXv9FZi3P36Eb83coLLAipn9RNupqp
   POHJ9ymBAUkdLpnXn7ZUa4qpLuAtDG8+ul1NdY4zAzRHlkomeqc7pS86T
   NplHb2P+8FAvVPL93lmuQMmPXHKbcixE+9ivk44kr2gT4jmOQCe1L5TzK
   qcGgPa355SH4ACyzngLr7WPVfJCpycDGXRIQjynqFtBdVZHcwkNVdREKN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="314018672"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="314018672"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="736669673"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="736669673"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:22 -0800
Subject: [PATCH v2 00/20] CXL RAM and the 'Soft Reserved' => 'System RAM'
 default
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Gregory Price <gregory.price@memverge.com>,
        Fan Ni <fan.ni@samsung.com>, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:05:21 -0800
Message-ID: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes since v1: [1]
- Add a fix for memdev removal racing port removal (found by unit tests)
- Add a fix to unwind region target list updates on error in
  cxl_region_attach() (Jonathan)
- Move the passthrough decoder fix for submission for v6.2-final (Greg)
- Fix wrong initcall for cxl_core (Gregory and Davidlohr)
- Add an endpoint decoder state (CXL_DECODER_STATE_AUTO) to replace
  the flag CXL_DECODER_F_AUTO (Jonathan)
- Reflow cmp_decode_pos() to reduce levels of indentation (Jonathan)
- Fix a leaked reference count in cxl_add_to_region() (Jonathan)
- Make cxl_add_to_region() return an error (Jonathan)
- Fix several spurious whitespace changes (Jonathan)
- Cleanup some spurious changes from the tools/testing/cxl update
  (Jonathan)
- Test for == CXL_CONFIG_COMMIT rather than >= CXL_CONFIG_COMMIT
  (Jonathan)
- Add comment to clarify device_attach() return code expectation in
  cxl_add_to_region() (Jonathan)
- Add a patch to split cxl_port_probe() into switch and endpoint port
  probe calls (Jonathan)
- Collect reviewed-by and tested-by tags

[1]: http://lore.kernel.org/r/167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com

---
Cover letter same as v1

Summary:
--------

CXL RAM support allows for the dynamic provisioning of new CXL RAM
regions, and more routinely, assembling a region from an existing
configuration established by platform-firmware. The latter is motivated
by CXL memory RAS (Reliability, Availability and Serviceability)
support, that requires associating device events with System Physical
Address ranges and vice versa.

The 'Soft Reserved' policy rework arranges for performance
differentiated memory like CXL attached DRAM, or high-bandwidth memory,
to be designated for 'System RAM' by default, rather than the device-dax
dedicated access mode. That current device-dax default is confusing and
surprising for the Pareto of users that do not expect memory to be
quarantined for dedicated access by default. Most users expect all
'System RAM'-capable memory to show up in FREE(1).


Details:
--------

Recall that the Linux 'Soft Reserved' designation for memory is a
reaction to platform-firmware, like EFI EDK2, delineating memory with
the EFI Specific Purpose Memory attribute (EFI_MEMORY_SP). An
alternative way to think of that attribute is that it specifies the
*not* general-purpose memory pool. It is memory that may be too precious
for general usage or not performant enough for some hot data structures.
However, in the absence of explicit policy it should just be 'System
RAM' by default.

Rather than require every distribution to ship a udev policy to assign
dax devices to dax_kmem (the device-memory hotplug driver) just make
that the kernel default. This is similar to the rationale in:

commit 8604d9e534a3 ("memory_hotplug: introduce CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE")

With this change the relatively niche use case of accessing this memory
via mapping a device-dax instance can be achieved by building with
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n, or specifying
memhp_default_state=offline at boot, and then use:

    daxctl reconfigure-device $device -m devdax --force

...to shift the corresponding address range to device-dax access.

The process of assembling a device-dax instance for a given CXL region
device configuration is similar to the process of assembling a
Device-Mapper or MDRAID storage-device array. Specifically, asynchronous
probing by the PCI and driver core enumerates all CXL endpoints and
their decoders. Then, once enough decoders have arrived to a describe a
given region, that region is passed to the device-dax subsystem where it
is subject to the above 'dax_kmem' policy. This assignment and policy
choice is only possible if memory is set aside by the 'Soft Reserved'
designation. Otherwise, CXL that is mapped as 'System RAM' becomes
immutable by CXL driver mechanisms, but is still enumerated for RAS
purposes.

This series is also available via:

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region

...and has gone through some preview testing in various forms.

---

Dan Williams (20):
      cxl/memdev: Fix endpoint port removal
      cxl/Documentation: Update references to attributes added in v6.0
      cxl/region: Add a mode attribute for regions
      cxl/region: Support empty uuids for non-pmem regions
      cxl/region: Validate region mode vs decoder mode
      cxl/region: Add volatile region creation support
      cxl/region: Refactor attach_target() for autodiscovery
      cxl/region: Cleanup target list on attach error
      cxl/region: Move region-position validation to a helper
      kernel/range: Uplevel the cxl subsystem's range_contains() helper
      cxl/region: Enable CONFIG_CXL_REGION to be toggled
      cxl/port: Split endpoint and switch port probe
      cxl/region: Add region autodiscovery
      tools/testing/cxl: Define a fixed volatile configuration to parse
      dax/hmem: Move HMAT and Soft reservation probe initcall level
      dax/hmem: Drop unnecessary dax_hmem_remove()
      dax/hmem: Convey the dax range via memregion_info()
      dax/hmem: Move hmem device registration to dax_hmem.ko
      dax: Assign RAM regions to memory-hotplug by default
      cxl/dax: Create dax devices for CXL RAM regions


 Documentation/ABI/testing/sysfs-bus-cxl |   64 +-
 MAINTAINERS                             |    1 
 drivers/acpi/numa/hmat.c                |    4 
 drivers/cxl/Kconfig                     |   12 
 drivers/cxl/acpi.c                      |    3 
 drivers/cxl/core/core.h                 |    7 
 drivers/cxl/core/hdm.c                  |   25 +
 drivers/cxl/core/memdev.c               |    1 
 drivers/cxl/core/pci.c                  |    5 
 drivers/cxl/core/port.c                 |   92 ++-
 drivers/cxl/core/region.c               |  851 ++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h                       |   57 ++
 drivers/cxl/cxlmem.h                    |    5 
 drivers/cxl/port.c                      |  113 +++-
 drivers/dax/Kconfig                     |   17 +
 drivers/dax/Makefile                    |    2 
 drivers/dax/bus.c                       |   53 +-
 drivers/dax/bus.h                       |   12 
 drivers/dax/cxl.c                       |   53 ++
 drivers/dax/device.c                    |    3 
 drivers/dax/hmem/Makefile               |    3 
 drivers/dax/hmem/device.c               |  102 ++--
 drivers/dax/hmem/hmem.c                 |  148 +++++
 drivers/dax/kmem.c                      |    1 
 include/linux/dax.h                     |    7 
 include/linux/memregion.h               |    2 
 include/linux/range.h                   |    5 
 lib/stackinit_kunit.c                   |    6 
 tools/testing/cxl/test/cxl.c            |  147 +++++
 29 files changed, 1484 insertions(+), 317 deletions(-)
 create mode 100644 drivers/dax/cxl.c

base-commit: 172738bbccdb4ef76bdd72fc72a315c741c39161
