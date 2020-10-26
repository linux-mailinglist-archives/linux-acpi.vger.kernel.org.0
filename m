Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81EB299F98
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 01:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410358AbgJZXyN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Oct 2020 19:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410156AbgJZXyM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Oct 2020 19:54:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8770B21655;
        Mon, 26 Oct 2020 23:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756451;
        bh=VZVHPvdGvoauXFvYUP0vUslj5DObR0FlXbYEGzh0Xo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZeQl8IFPTIJNrobOTY5uJCoIOByecVfbvXeRgIcepUPoE5UIiFgkxxUYl+1cntlie
         8UxwoG0vTwTrpqhJC4ud2Eq/xQOQPpwwTS+bCVEqydq1Iw7Im0O4gBEE1/uBaS2atX
         VTMA7AYJvS4Y1Wf6f1iQUBELyQUcZSsONGn9seLk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 102/132] PCI/ACPI: Add Ampere Altra SOC MCFG quirk
Date:   Mon, 26 Oct 2020 19:51:34 -0400
Message-Id: <20201026235205.1023962-102-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235205.1023962-1-sashal@kernel.org>
References: <20201026235205.1023962-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Tuan Phan <tuanphan@os.amperecomputing.com>

[ Upstream commit 877c1a5f79c6984bbe3f2924234c08e2f4f1acd5 ]

Ampere Altra SOC supports only 32-bit ECAM reads.  Add an MCFG quirk for
the platform.

Link: https://lore.kernel.org/r/1596751055-12316-1-git-send-email-tuanphan@os.amperecomputing.com
Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/pci_mcfg.c  | 20 ++++++++++++++++++++
 drivers/pci/ecam.c       | 10 ++++++++++
 include/linux/pci-ecam.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 54b36b7ad47d9..e526571e0ebdb 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -142,6 +142,26 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	XGENE_V2_ECAM_MCFG(4, 0),
 	XGENE_V2_ECAM_MCFG(4, 1),
 	XGENE_V2_ECAM_MCFG(4, 2),
+
+#define ALTRA_ECAM_QUIRK(rev, seg) \
+	{ "Ampere", "Altra   ", rev, seg, MCFG_BUS_ANY, &pci_32b_read_ops }
+
+	ALTRA_ECAM_QUIRK(1, 0),
+	ALTRA_ECAM_QUIRK(1, 1),
+	ALTRA_ECAM_QUIRK(1, 2),
+	ALTRA_ECAM_QUIRK(1, 3),
+	ALTRA_ECAM_QUIRK(1, 4),
+	ALTRA_ECAM_QUIRK(1, 5),
+	ALTRA_ECAM_QUIRK(1, 6),
+	ALTRA_ECAM_QUIRK(1, 7),
+	ALTRA_ECAM_QUIRK(1, 8),
+	ALTRA_ECAM_QUIRK(1, 9),
+	ALTRA_ECAM_QUIRK(1, 10),
+	ALTRA_ECAM_QUIRK(1, 11),
+	ALTRA_ECAM_QUIRK(1, 12),
+	ALTRA_ECAM_QUIRK(1, 13),
+	ALTRA_ECAM_QUIRK(1, 14),
+	ALTRA_ECAM_QUIRK(1, 15),
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 8f065a42fc1a2..b54d32a316693 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -168,4 +168,14 @@ const struct pci_ecam_ops pci_32b_ops = {
 		.write		= pci_generic_config_write32,
 	}
 };
+
+/* ECAM ops for 32-bit read only (non-compliant) */
+const struct pci_ecam_ops pci_32b_read_ops = {
+	.bus_shift	= 20,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read32,
+		.write		= pci_generic_config_write,
+	}
+};
 #endif
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 1af5cb02ef7f9..033ce74f02e81 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -51,6 +51,7 @@ extern const struct pci_ecam_ops pci_generic_ecam_ops;
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
+extern const struct pci_ecam_ops pci_32b_read_ops; /* 32-bit read only */
 extern const struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
 extern const struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 1.x & 2.x */
 extern const struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
-- 
2.25.1

