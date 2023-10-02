Return-Path: <linux-acpi+bounces-333-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192977B5534
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BD923283142
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 14:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014915EB9
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 14:32:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27A2106
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 14:04:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8424BE1;
	Mon,  2 Oct 2023 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696255491; x=1727791491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nKIji5IZJhMWabHMFqIgraecALuN9dFAb1DqaVopkOo=;
  b=mkBV4JoGpyQS4QO+sXZDM5ofoPdXSEGvVvUf4M6279HpOH2KiO+bFwtd
   QeSEwiaIc5lahvAVpGK31n5fRTPoOUCFGFyZPcAboNrYQg5g1YwppqWhH
   rbZgE26Vq0golsJX3Z4Hk5rfVaBwo7ksqYrz8ghfZ6mNmYIXF0XsbriqF
   740s5DsoXjvOfHRaKHtEog3cyBmyhg08acGY3lGXrTK4Lye9xNvutTm9q
   t1THk5FZbEeMFYvYhcIDk89rJLkFs7jvqAWoBfenhPHLlMj59uGul3TmI
   OPZCHaei1ol15Po4JLFhcLnGqoPNJ58fao6e8ZuUbojifCvrpbgKQbJTR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="468922858"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="468922858"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:04:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="840994379"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="840994379"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Oct 2023 07:04:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3751F1A7; Mon,  2 Oct 2023 16:54:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/1] ACPI: PCI: Switch to use acpi_evaluate_dsm_typed()
Date: Mon,  2 Oct 2023 16:54:24 +0300
Message-Id: <20231002135424.2603191-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/pci_root.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 84030804a763..58b89b8d950e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1055,9 +1055,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	 * exists and returns 0, we must preserve any PCI resource
 	 * assignments made by firmware for this host bridge.
 	 */
-	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
-				DSM_PCI_PRESERVE_BOOT_CONFIG, NULL);
-	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
+	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
+				      DSM_PCI_PRESERVE_BOOT_CONFIG, NULL, ACPI_TYPE_INTEGER);
+	if (obj && obj->integer.value == 0)
 		host_bridge->preserve_config = 1;
 	ACPI_FREE(obj);
 
-- 
2.40.0.1.gaa8946217a0b


