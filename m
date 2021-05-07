Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C6F376130
	for <lists+linux-acpi@lfdr.de>; Fri,  7 May 2021 09:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhEGHey (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 May 2021 03:34:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:54866 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235147AbhEGHeu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 May 2021 03:34:50 -0400
IronPort-SDR: reJpF6bJ/FcGIeR0oMVhvlCsY8ZE6tN9gb5SHHZjACM4Ni8BSLnGu9pf3moEeGSltKwSs6XHW2
 KyaNZehGt6MQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="178235222"
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="178235222"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 00:33:50 -0700
IronPort-SDR: m5C36Ec0x+duB6JPI7kJ5dUlT3jsn2I+KnojciCs80pCrvDZF4rlkrnxz01gHElv3dy2k2oz29
 KUyHKkUN7F5A==
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="434792851"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 00:33:50 -0700
Subject: [PATCH] ACPI: NFIT: Fix support for variable 'SPA' structure size
From:   Dan Williams <dan.j.williams@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Yi Zhang <yi.zhang@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
        nvdimm@lists.linux.dev, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 07 May 2021 00:33:50 -0700
Message-ID: <162037273007.1195827.10907249070709169329.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 6.4 introduced the "SpaLocationCookie" to the NFIT "System Physical
Address (SPA) Range Structure". The presence of that new field is
indicated by the ACPI_NFIT_LOCATION_COOKIE_VALID flag. Pre-ACPI-6.4
firmware implementations omit the flag and maintain the original size of
the structure.

Update the implementation to check that flag to determine the size
rather than the ACPI 6.4 compliant definition of 'struct
acpi_nfit_system_address' from the Linux ACPICA definitions.

Update the test infrastructure for the new expectations as well, i.e.
continue to emulate the ACPI 6.3 definition of that structure.

Without this fix the kernel fails to validate 'SPA' structures and this
leads to a crash in nfit_get_smbios_id() since that routine assumes that
SPAs are valid if it finds valid SMBIOS tables.

    BUG: unable to handle page fault for address: ffffffffffffffa8
    [..]
    Call Trace:
     skx_get_nvdimm_info+0x56/0x130 [skx_edac]
     skx_get_dimm_config+0x1f5/0x213 [skx_edac]
     skx_register_mci+0x132/0x1c0 [skx_edac]

Cc: Bob Moore <robert.moore@intel.com>
Cc: Erik Kaneda <erik.kaneda@intel.com>
Fixes: cf16b05c607b ("ACPICA: ACPI 6.4: NFIT: add Location Cookie field")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

Rafael, I can take this through nvdimm.git after -rc1, but if you are
sending any fixes to Linus based on your merge baseline between now and
Monday, please pick up this one.

 drivers/acpi/nfit/core.c         |   15 ++++++++++----
 tools/testing/nvdimm/test/nfit.c |   42 +++++++++++++++++++++++---------------
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 958aaac869e8..23d9a09d7060 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -686,6 +686,13 @@ int nfit_spa_type(struct acpi_nfit_system_address *spa)
 	return -1;
 }
 
+static size_t sizeof_spa(struct acpi_nfit_system_address *spa)
+{
+	if (spa->flags & ACPI_NFIT_LOCATION_COOKIE_VALID)
+		return sizeof(*spa);
+	return sizeof(*spa) - 8;
+}
+
 static bool add_spa(struct acpi_nfit_desc *acpi_desc,
 		struct nfit_table_prev *prev,
 		struct acpi_nfit_system_address *spa)
@@ -693,22 +700,22 @@ static bool add_spa(struct acpi_nfit_desc *acpi_desc,
 	struct device *dev = acpi_desc->dev;
 	struct nfit_spa *nfit_spa;
 
-	if (spa->header.length != sizeof(*spa))
+	if (spa->header.length != sizeof_spa(spa))
 		return false;
 
 	list_for_each_entry(nfit_spa, &prev->spas, list) {
-		if (memcmp(nfit_spa->spa, spa, sizeof(*spa)) == 0) {
+		if (memcmp(nfit_spa->spa, spa, sizeof_spa(spa)) == 0) {
 			list_move_tail(&nfit_spa->list, &acpi_desc->spas);
 			return true;
 		}
 	}
 
-	nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa) + sizeof(*spa),
+	nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa) + sizeof_spa(spa),
 			GFP_KERNEL);
 	if (!nfit_spa)
 		return false;
 	INIT_LIST_HEAD(&nfit_spa->list);
-	memcpy(nfit_spa->spa, spa, sizeof(*spa));
+	memcpy(nfit_spa->spa, spa, sizeof_spa(spa));
 	list_add_tail(&nfit_spa->list, &acpi_desc->spas);
 	dev_dbg(dev, "spa index: %d type: %s\n",
 			spa->range_index,
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 9b185bf82da8..54f367cbadae 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1871,9 +1871,16 @@ static void smart_init(struct nfit_test *t)
 	}
 }
 
+static size_t sizeof_spa(struct acpi_nfit_system_address *spa)
+{
+	/* until spa location cookie support is added... */
+	return sizeof(*spa) - 8;
+}
+
 static int nfit_test0_alloc(struct nfit_test *t)
 {
-	size_t nfit_size = sizeof(struct acpi_nfit_system_address) * NUM_SPA
+	struct acpi_nfit_system_address *spa = NULL;
+	size_t nfit_size = sizeof_spa(spa) * NUM_SPA
 			+ sizeof(struct acpi_nfit_memory_map) * NUM_MEM
 			+ sizeof(struct acpi_nfit_control_region) * NUM_DCR
 			+ offsetof(struct acpi_nfit_control_region,
@@ -1937,7 +1944,8 @@ static int nfit_test0_alloc(struct nfit_test *t)
 
 static int nfit_test1_alloc(struct nfit_test *t)
 {
-	size_t nfit_size = sizeof(struct acpi_nfit_system_address) * 2
+	struct acpi_nfit_system_address *spa = NULL;
+	size_t nfit_size = sizeof_spa(spa) * 2
 		+ sizeof(struct acpi_nfit_memory_map) * 2
 		+ offsetof(struct acpi_nfit_control_region, window_size) * 2;
 	int i;
@@ -2000,7 +2008,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	 */
 	spa = nfit_buf;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_PM), 16);
 	spa->range_index = 0+1;
 	spa->address = t->spa_set_dma[0];
@@ -2014,7 +2022,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	 */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_PM), 16);
 	spa->range_index = 1+1;
 	spa->address = t->spa_set_dma[1];
@@ -2024,7 +2032,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	/* spa2 (dcr0) dimm0 */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
 	spa->range_index = 2+1;
 	spa->address = t->dcr_dma[0];
@@ -2034,7 +2042,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	/* spa3 (dcr1) dimm1 */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
 	spa->range_index = 3+1;
 	spa->address = t->dcr_dma[1];
@@ -2044,7 +2052,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	/* spa4 (dcr2) dimm2 */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
 	spa->range_index = 4+1;
 	spa->address = t->dcr_dma[2];
@@ -2054,7 +2062,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	/* spa5 (dcr3) dimm3 */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
 	spa->range_index = 5+1;
 	spa->address = t->dcr_dma[3];
@@ -2064,7 +2072,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	/* spa6 (bdw for dcr0) dimm0 */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
 	spa->range_index = 6+1;
 	spa->address = t->dimm_dma[0];
@@ -2074,7 +2082,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	/* spa7 (bdw for dcr1) dimm1 */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
 	spa->range_index = 7+1;
 	spa->address = t->dimm_dma[1];
@@ -2084,7 +2092,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	/* spa8 (bdw for dcr2) dimm2 */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
 	spa->range_index = 8+1;
 	spa->address = t->dimm_dma[2];
@@ -2094,7 +2102,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	/* spa9 (bdw for dcr3) dimm3 */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
 	spa->range_index = 9+1;
 	spa->address = t->dimm_dma[3];
@@ -2581,7 +2589,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 		/* spa10 (dcr4) dimm4 */
 		spa = nfit_buf + offset;
 		spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-		spa->header.length = sizeof(*spa);
+		spa->header.length = sizeof_spa(spa);
 		memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
 		spa->range_index = 10+1;
 		spa->address = t->dcr_dma[4];
@@ -2595,7 +2603,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 		 */
 		spa = nfit_buf + offset;
 		spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-		spa->header.length = sizeof(*spa);
+		spa->header.length = sizeof_spa(spa);
 		memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_PM), 16);
 		spa->range_index = 11+1;
 		spa->address = t->spa_set_dma[2];
@@ -2605,7 +2613,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 		/* spa12 (bdw for dcr4) dimm4 */
 		spa = nfit_buf + offset;
 		spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-		spa->header.length = sizeof(*spa);
+		spa->header.length = sizeof_spa(spa);
 		memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
 		spa->range_index = 12+1;
 		spa->address = t->dimm_dma[4];
@@ -2739,7 +2747,7 @@ static void nfit_test1_setup(struct nfit_test *t)
 	/* spa0 (flat range with no bdw aliasing) */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_PM), 16);
 	spa->range_index = 0+1;
 	spa->address = t->spa_set_dma[0];
@@ -2749,7 +2757,7 @@ static void nfit_test1_setup(struct nfit_test *t)
 	/* virtual cd region */
 	spa = nfit_buf + offset;
 	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
-	spa->header.length = sizeof(*spa);
+	spa->header.length = sizeof_spa(spa);
 	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_VCD), 16);
 	spa->range_index = 0;
 	spa->address = t->spa_set_dma[1];

