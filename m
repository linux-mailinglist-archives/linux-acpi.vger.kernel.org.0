Return-Path: <linux-acpi+bounces-5649-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF818BEC4A
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 21:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB8F286946
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E1A16EC04;
	Tue,  7 May 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJN/ED4a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E216EBE0;
	Tue,  7 May 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108866; cv=none; b=fwM35R0elwrJGAOFIumRcF/gMon+MP2NVKlwPBCjeO8ReGoqaWjESI9leVMuQhKbHgV9sm527EGkXxR34ngn52U124JJ067IpgSiSENbfr9X3qdhJnZW678CMg1fAqPz14ao38Jj+QKEBmFpWketZ8opEzvJUOwqMRVmGDBXVSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108866; c=relaxed/simple;
	bh=PQ/gSxurBgyu06eRHs/rJNYqfbmMMka7kznfXnJ8i80=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4AK7kbckTEsF+Q7grQ8OuOqVA3YsfqQKHI+j2KXCxXCGGB3rTQi3hvfvz24+Y2WgtSd1DXYpzN58a4svLF81ymmmz90zl6AuXgYiIcsc8EEZAM5mcWLjkabeP3pFy8ghRpwi3+okR+5q43yQ7AecGji9cMLD4wgjOfn+k5ephM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJN/ED4a; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715108865; x=1746644865;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PQ/gSxurBgyu06eRHs/rJNYqfbmMMka7kznfXnJ8i80=;
  b=SJN/ED4a577o39Xt2qHF6QbwW5QPVan/+8pGRkkj7bCL2cHENNfzjn1T
   iUPzLm1N3VjsrqKkWlCQltovOwXaKw7+Mf3scVxBEK7CR/oB5q/TMNxxc
   5f/I8gqk15ajSKNsZOMUGGb3hi9+O/ligirDjF1ax1lxlB6ibkuWspDvl
   BxeRE/XxN0LP8N2ufaRPEGnslyrJRLpeQF04NQnmh2u9kBM2IoLCYUOi/
   ozERqImsOsORTqDGTGxcEY89cSr7SrpednzubAaTonejm3E95ppt+ThFI
   gCq9MzznE6GbREa6ARdxvG2M+6DKYiz0GrxpPw7DWYOzZL2KvBSE4R0m4
   A==;
X-CSE-ConnectionGUID: 1uynUcSCRZG6O6dfrEfBdw==
X-CSE-MsgGUID: NpFiuvuIS4O6fKit5thhOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11087464"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11087464"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:07:45 -0700
X-CSE-ConnectionGUID: 3ABlObkuTMqhTFca2u6xbg==
X-CSE-MsgGUID: 6TaLySOVS5iY1Li6/VfYng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28682096"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.246.52])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:07:43 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [RFC PATCH 2/3] ACPI: extlog: Trace PCI Express Error Section
Date: Tue,  7 May 2024 21:02:21 +0200
Message-ID: <20240507190724.323269-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507190724.323269-1-fabio.m.de.francesco@linux.intel.com>
References: <20240507190724.323269-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, extlog_print() (ELOG) only reports CPER PCIe section (UEFI
v2.10, Appendix N.2.7) to the kernel log via print_extlog_rcd(). Instead,
the similar ghes_do_proc() (GHES) prints to kernel log and calls
pci_print_aer() to report via the ftrace infrastructure.

Add support to report the CPER PCIe Error section also via the ftrace
infrastructure by calling pci_print_aer() to make ELOG act consistently
with GHES.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 4e62d7235d33..c167e391ba43 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -131,6 +131,32 @@ static int print_extlog_rcd(const char *pfx,
 	return 1;
 }
 
+static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
+			      int aer_severity)
+{
+	struct aer_capability_regs *aer;
+	struct pci_dev *pdev;
+	unsigned int devfn;
+	unsigned int bus;
+	int domain;
+
+	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
+		aer = (struct aer_capability_regs *)pcie_err->aer_info;
+		domain = pcie_err->device_id.segment;
+		bus = pcie_err->device_id.bus;
+		devfn = PCI_DEVFN(pcie_err->device_id.device,
+				  pcie_err->device_id.function);
+		pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
+		if (!pdev) {
+			pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
+			       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+			return;
+		}
+		pci_print_aer(pdev, aer_severity, aer);
+	}
+}
+
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -182,6 +208,11 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
 						       (u8)gdata->error_severity);
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
+			int aer_severity = cper_severity_to_aer(gdata->error_severity);
+
+			extlog_print_pcie(pcie_err, aer_severity);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
@@ -331,3 +362,4 @@ module_exit(extlog_exit);
 MODULE_AUTHOR("Chen, Gong <gong.chen@intel.com>");
 MODULE_DESCRIPTION("Extended MCA Error Log Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(CXL);
-- 
2.45.0


