Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054E221CA49
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Jul 2020 18:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgGLQnV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Jul 2020 12:43:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:25310 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbgGLQnQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Jul 2020 12:43:16 -0400
IronPort-SDR: FugLtLnQdhYYLhrGPUt8GJZLanunBzQsOywZANrtDd/KKrw3czlFXChUXkCHoj4F7hDP8W1yaG
 a+4vUI0Hd4ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="210054602"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="210054602"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:15 -0700
IronPort-SDR: IIjgyPNpskwzeAKvI/juFO2ctoUv5unwPuVTn1wgWZE170cydsmwW59Ps1lMRhWgFL55VPXx1C
 5/zsyHKlW9hA==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="429128404"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:15 -0700
Subject: [PATCH v2 10/22] ACPI: HMAT: Attach a device for each soft-reserved
 range
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jeff Moyer <jmoyer@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
Date:   Sun, 12 Jul 2020 09:26:59 -0700
Message-ID: <159457121992.754248.18124727141742055701.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The hmem enabling in commit 'cf8741ac57ed ("ACPI: NUMA: HMAT: Register
"soft reserved" memory as an "hmem" device")' only registered ranges to
the hmem driver for each soft-reservation that also appeared in the
HMAT. While this is meant to encourage platform firmware to "do the
right thing" and publish an HMAT, the corollary is that platforms that
fail to publish an accurate HMAT will strand memory from Linux usage.
Additionally, the "efi_fake_mem" kernel command line option enabling
will strand memory by default without an HMAT.

Arrange for "soft reserved" memory that goes unclaimed by HMAT entries
to be published as raw resource ranges for the hmem driver to consume.

Include a module parameter to disable either this fallback behavior, or
the hmat enabling from creating hmem devices. The module parameter
requires the hmem device enabling to have unique name in the module
namespace: "device_hmem".

The driver depends on the architecture providing phys_to_target_node()
which is only x86 via numa_meminfo() and arm64 via a generic memblock
implementation.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/Kconfig       |    2 ++
 drivers/dax/hmem/Makefile |    3 ++-
 drivers/dax/hmem/device.c |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index a229f45d34aa..557483ed2e9c 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -50,6 +50,8 @@ config DEV_DAX_HMEM
 
 config DEV_DAX_HMEM_DEVICES
 	depends on DEV_DAX_HMEM
+	# requires phys_to_target_node() support
+	depends on X86_NUMA_KEEP_MEMINFO || MEMBLOCK_NUMA_INFO
 	def_bool y
 
 config DEV_DAX_KMEM
diff --git a/drivers/dax/hmem/Makefile b/drivers/dax/hmem/Makefile
index a9d353d0c9ed..57377b4c3d47 100644
--- a/drivers/dax/hmem/Makefile
+++ b/drivers/dax/hmem/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
-obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device.o
+obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device_hmem.o
 
+device_hmem-y := device.o
 dax_hmem-y := hmem.o
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index b9dd6b27745c..cb6401c9e9a4 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -5,6 +5,9 @@
 #include <linux/dax.h>
 #include <linux/mm.h>
 
+static bool nohmem;
+module_param_named(disable, nohmem, bool, 0444);
+
 void hmem_register_device(int target_nid, struct resource *r)
 {
 	/* define a clean / non-busy resource for the platform device */
@@ -17,6 +20,9 @@ void hmem_register_device(int target_nid, struct resource *r)
 	struct memregion_info info;
 	int rc, id;
 
+	if (nohmem)
+		return;
+
 	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
 			IORES_DESC_SOFT_RESERVED);
 	if (rc != REGION_INTERSECTS)
@@ -63,3 +69,32 @@ void hmem_register_device(int target_nid, struct resource *r)
 out_pdev:
 	memregion_free(id);
 }
+
+static __init int hmem_register_one(struct resource *res, void *data)
+{
+	/*
+	 * If the resource is not a top-level resource it was already
+	 * assigned to a device by the HMAT parsing.
+	 */
+	if (res->parent != &iomem_resource) {
+		pr_info("HMEM: skip %pr, already claimed\n", res);
+		return 0;
+	}
+
+	hmem_register_device(phys_to_target_node(res->start), res);
+
+	return 0;
+}
+
+static __init int hmem_init(void)
+{
+	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
+			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
+	return 0;
+}
+
+/*
+ * As this is a fallback for address ranges unclaimed by the ACPI HMAT
+ * parsing it must be at an initcall level greater than hmat_init().
+ */
+late_initcall(hmem_init);

