Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CFF9E4CE
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2019 11:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfH0JuB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Aug 2019 05:50:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56163 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfH0JuA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Aug 2019 05:50:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so2360115wmf.5;
        Tue, 27 Aug 2019 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YznYRBNIZJsjf15mCv/UO/Z7efUC4feYMf4UUEtTBug=;
        b=HNTSkVB4YhrW41vd9iFfMcgo54sJx3gm878TXSk5zFVuAuRXAHNWlkLEo4WXaTWJwl
         Nbh1t3Fv0DMnDsIFVJW412TlTEZ7Ep1hOQ0HkCRIQK6l5CE8l9kDc0tKfy33khRHb1bi
         z6RuQ6Sc4UehmZTRlPpRni6YqcSRyO5FPVcXYyCRE7NtIgBuXwfEtC9FD1/SMSljjZE8
         pz5hKirqXNoD96PlX6puthuLvwPFhWMUeRGAQZaTZ8L5zV1pvbrOiKvyHzfVCfurHWPx
         2HoUJvEnX0kPf83H2+ASYkf2Cuh0dMWob/+EoVkTvW37z1ho4jvp2E8D0Ebzqvh7xmey
         24uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YznYRBNIZJsjf15mCv/UO/Z7efUC4feYMf4UUEtTBug=;
        b=tJ9712hEkdqV6wdhTpTU32xS2dOzt24IPnQq7Hl5JPwG+MsAnq1QWUCUKmKT1HkSha
         LOosJ1/9pmt9plkxuU1T+9Qz55/BJkEpET3FN25Y46BJR9Ie9RKs0qGb/6gNqiCODmn9
         hk164J2cR75XMY/921+PzvspaxATSv0z1NaFHyCcEscMOdj8U93orz8A1xA5uhlRDVhW
         DZqy4ThBAwtw3ftlxms5ZSXL8lwAjtOeaefcJ8WT4+zLFlZxy0ztI+GglwR0bg6tUBnC
         X5s2C2qYRRhi7b2x1cF5tEu1rStf6wVR6jHaVqow6NRrVFmBcZrL1j8SzCJTo6h21PqY
         JwUg==
X-Gm-Message-State: APjAAAWp3NtQYoc5QzaiM/99IwZKysSNjmV6N5zZeYXyOMOuexLhKJlD
        29SJcYNrNNkVFH/fwGLjfMU=
X-Google-Smtp-Source: APXvYqxI3QBVzZ01siDbt8ryi+l+xNHUWOlDCTvWaYd5/wsnEMgofPLlYRFyzhuEFXqm30gPp5Zsgw==
X-Received: by 2002:a1c:790d:: with SMTP id l13mr26245330wme.49.1566899395547;
        Tue, 27 Aug 2019 02:49:55 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id p10sm2450087wma.8.2019.08.27.02.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:49:54 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI/ACPI: Move ACPI-specific Hot Plug programming functions to pci-acpi.c
Date:   Tue, 27 Aug 2019 11:49:50 +0200
Message-Id: <20190827094951.10613-3-kw@linux.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190827094951.10613-1-kw@linux.com>
References: <20190827094951.10613-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Move functions program_hpx_type0(), program_hpx_type1(), etc.,
from drivers/pci/probe.c to drivers/pci/pci-acpi.c, and enums
hpx_type3_dev_type, hpx_type3_fn_type and hpx_type3_cfg_loc to
drivers/pci/pci-acpi.c as these functions and enums are
ACPI-specific.

Then move structs hpx_type0, hpx_type1, hpx_type2 and hpx_type3 to
drivers/pci/pci.h as these are shared between drivers/pci/pci-acpi.c
and drivers/pci/probe.c.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/pci-acpi.c      | 296 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h           |  79 ++++++++++
 drivers/pci/probe.c         | 269 --------------------------------
 include/linux/pci_hotplug.h | 100 ------------
 4 files changed, 375 insertions(+), 369 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 02addc47edae..0bfabb3f9931 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -118,6 +118,47 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 	return (phys_addr_t)mcfg_addr;
 }
 
+static struct hpx_type0 pci_default_type0 = {
+	.revision = 1,
+	.cache_line_size = 8,
+	.latency_timer = 0x40,
+	.enable_serr = 0,
+	.enable_perr = 0,
+};
+
+void program_hpx_type0(struct pci_dev *dev, struct hpx_type0 *hpx)
+{
+	u16 pci_cmd, pci_bctl;
+
+	if (!hpx)
+		hpx = &pci_default_type0;
+
+	if (hpx->revision > 1) {
+		pci_warn(dev, "PCI settings rev %d not supported; using defaults\n",
+			 hpx->revision);
+		hpx = &pci_default_type0;
+	}
+
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, hpx->cache_line_size);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, hpx->latency_timer);
+	pci_read_config_word(dev, PCI_COMMAND, &pci_cmd);
+	if (hpx->enable_serr)
+		pci_cmd |= PCI_COMMAND_SERR;
+	if (hpx->enable_perr)
+		pci_cmd |= PCI_COMMAND_PARITY;
+	pci_write_config_word(dev, PCI_COMMAND, pci_cmd);
+
+	/* Program bridge control value */
+	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER,
+				      hpx->latency_timer);
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &pci_bctl);
+		if (hpx->enable_perr)
+			pci_bctl |= PCI_BRIDGE_CTL_PARITY;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, pci_bctl);
+	}
+}
+
 static acpi_status decode_type0_hpx_record(union acpi_object *record,
 					   struct hpx_type0 *hpx0)
 {
@@ -146,6 +187,20 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
+void program_hpx_type1(struct pci_dev *dev, struct hpx_type1 *hpx)
+{
+	int pos;
+
+	if (!hpx)
+		return;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (!pos)
+		return;
+
+	pci_warn(dev, "PCI-X settings not supported\n");
+}
+
 static acpi_status decode_type1_hpx_record(union acpi_object *record,
 					   struct hpx_type1 *hpx1)
 {
@@ -173,6 +228,107 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
+static bool pcie_root_rcb_set(struct pci_dev *dev)
+{
+	struct pci_dev *rp = pcie_find_root_port(dev);
+	u16 lnkctl;
+
+	if (!rp)
+		return false;
+
+	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
+	if (lnkctl & PCI_EXP_LNKCTL_RCB)
+		return true;
+
+	return false;
+}
+
+void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
+{
+	int pos;
+	u32 reg32;
+
+	if (!hpx)
+		return;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	if (hpx->revision > 1) {
+		pci_warn(dev, "PCIe settings rev %d not supported\n",
+			 hpx->revision);
+		return;
+	}
+
+	/*
+	 * Don't allow _HPX to change MPS or MRRS settings.  We manage
+	 * those to make sure they're consistent with the rest of the
+	 * platform.
+	 */
+	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
+				    PCI_EXP_DEVCTL_READRQ;
+	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
+				    PCI_EXP_DEVCTL_READRQ);
+
+	/* Initialize Device Control Register */
+	pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
+			~hpx->pci_exp_devctl_and, hpx->pci_exp_devctl_or);
+
+	/* Initialize Link Control Register */
+	if (pcie_cap_has_lnkctl(dev)) {
+
+		/*
+		 * If the Root Port supports Read Completion Boundary of
+		 * 128, set RCB to 128.  Otherwise, clear it.
+		 */
+		hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
+		hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
+		if (pcie_root_rcb_set(dev))
+			hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
+
+		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
+			~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
+	}
+
+	/* Find Advanced Error Reporting Enhanced Capability */
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return;
+
+	/* Initialize Uncorrectable Error Mask Register */
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &reg32);
+	reg32 = (reg32 & hpx->unc_err_mask_and) | hpx->unc_err_mask_or;
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, reg32);
+
+	/* Initialize Uncorrectable Error Severity Register */
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &reg32);
+	reg32 = (reg32 & hpx->unc_err_sever_and) | hpx->unc_err_sever_or;
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, reg32);
+
+	/* Initialize Correctable Error Mask Register */
+	pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, &reg32);
+	reg32 = (reg32 & hpx->cor_err_mask_and) | hpx->cor_err_mask_or;
+	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, reg32);
+
+	/* Initialize Advanced Error Capabilities and Control Register */
+	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
+	reg32 = (reg32 & hpx->adv_err_cap_and) | hpx->adv_err_cap_or;
+
+	/* Don't enable ECRC generation or checking if unsupported */
+	if (!(reg32 & PCI_ERR_CAP_ECRC_GENC))
+		reg32 &= ~PCI_ERR_CAP_ECRC_GENE;
+	if (!(reg32 & PCI_ERR_CAP_ECRC_CHKC))
+		reg32 &= ~PCI_ERR_CAP_ECRC_CHKE;
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
+
+	/*
+	 * FIXME: The following two registers are not supported yet.
+	 *
+	 *   o Secondary Uncorrectable Error Severity Register
+	 *   o Secondary Uncorrectable Error Mask Register
+	 */
+}
+
 static acpi_status decode_type2_hpx_record(union acpi_object *record,
 					   struct hpx_type2 *hpx2)
 {
@@ -213,6 +369,146 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
+enum hpx_type3_dev_type {
+	HPX_TYPE_ENDPOINT	= BIT(0),
+	HPX_TYPE_LEG_END	= BIT(1),
+	HPX_TYPE_RC_END		= BIT(2),
+	HPX_TYPE_RC_EC		= BIT(3),
+	HPX_TYPE_ROOT_PORT	= BIT(4),
+	HPX_TYPE_UPSTREAM	= BIT(5),
+	HPX_TYPE_DOWNSTREAM	= BIT(6),
+	HPX_TYPE_PCI_BRIDGE	= BIT(7),
+	HPX_TYPE_PCIE_BRIDGE	= BIT(8),
+};
+
+static u16 hpx3_device_type(struct pci_dev *dev)
+{
+	u16 pcie_type = pci_pcie_type(dev);
+	const int pcie_to_hpx3_type[] = {
+		[PCI_EXP_TYPE_ENDPOINT]    = HPX_TYPE_ENDPOINT,
+		[PCI_EXP_TYPE_LEG_END]     = HPX_TYPE_LEG_END,
+		[PCI_EXP_TYPE_RC_END]      = HPX_TYPE_RC_END,
+		[PCI_EXP_TYPE_RC_EC]       = HPX_TYPE_RC_EC,
+		[PCI_EXP_TYPE_ROOT_PORT]   = HPX_TYPE_ROOT_PORT,
+		[PCI_EXP_TYPE_UPSTREAM]    = HPX_TYPE_UPSTREAM,
+		[PCI_EXP_TYPE_DOWNSTREAM]  = HPX_TYPE_DOWNSTREAM,
+		[PCI_EXP_TYPE_PCI_BRIDGE]  = HPX_TYPE_PCI_BRIDGE,
+		[PCI_EXP_TYPE_PCIE_BRIDGE] = HPX_TYPE_PCIE_BRIDGE,
+	};
+
+	if (pcie_type >= ARRAY_SIZE(pcie_to_hpx3_type))
+		return 0;
+
+	return pcie_to_hpx3_type[pcie_type];
+}
+
+enum hpx_type3_fn_type {
+	HPX_FN_NORMAL		= BIT(0),
+	HPX_FN_SRIOV_PHYS	= BIT(1),
+	HPX_FN_SRIOV_VIRT	= BIT(2),
+};
+
+static u8 hpx3_function_type(struct pci_dev *dev)
+{
+	if (dev->is_virtfn)
+		return HPX_FN_SRIOV_VIRT;
+	else if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV) > 0)
+		return HPX_FN_SRIOV_PHYS;
+	else
+		return HPX_FN_NORMAL;
+}
+
+static bool hpx3_cap_ver_matches(u8 pcie_cap_id, u8 hpx3_cap_id)
+{
+	u8 cap_ver = hpx3_cap_id & 0xf;
+
+	if ((hpx3_cap_id & BIT(4)) && cap_ver >= pcie_cap_id)
+		return true;
+	else if (cap_ver == pcie_cap_id)
+		return true;
+
+	return false;
+}
+
+enum hpx_type3_cfg_loc {
+	HPX_CFG_PCICFG		= 0,
+	HPX_CFG_PCIE_CAP	= 1,
+	HPX_CFG_PCIE_CAP_EXT	= 2,
+	HPX_CFG_VEND_CAP	= 3,
+	HPX_CFG_DVSEC		= 4,
+	HPX_CFG_MAX,
+};
+
+static void program_hpx_type3_register(struct pci_dev *dev,
+				       const struct hpx_type3 *reg)
+{
+	u32 match_reg, write_reg, header, orig_value;
+	u16 pos;
+
+	if (!(hpx3_device_type(dev) & reg->device_type))
+		return;
+
+	if (!(hpx3_function_type(dev) & reg->function_type))
+		return;
+
+	switch (reg->config_space_location) {
+	case HPX_CFG_PCICFG:
+		pos = 0;
+		break;
+	case HPX_CFG_PCIE_CAP:
+		pos = pci_find_capability(dev, reg->pci_exp_cap_id);
+		if (pos == 0)
+			return;
+
+		break;
+	case HPX_CFG_PCIE_CAP_EXT:
+		pos = pci_find_ext_capability(dev, reg->pci_exp_cap_id);
+		if (pos == 0)
+			return;
+
+		pci_read_config_dword(dev, pos, &header);
+		if (!hpx3_cap_ver_matches(PCI_EXT_CAP_VER(header),
+					  reg->pci_exp_cap_ver))
+			return;
+
+		break;
+	case HPX_CFG_VEND_CAP:	/* Fall through */
+	case HPX_CFG_DVSEC:	/* Fall through */
+	default:
+		pci_warn(dev, "Encountered _HPX type 3 with unsupported config space location");
+		return;
+	}
+
+	pci_read_config_dword(dev, pos + reg->match_offset, &match_reg);
+
+	if ((match_reg & reg->match_mask_and) != reg->match_value)
+		return;
+
+	pci_read_config_dword(dev, pos + reg->reg_offset, &write_reg);
+	orig_value = write_reg;
+	write_reg &= reg->reg_mask_and;
+	write_reg |= reg->reg_mask_or;
+
+	if (orig_value == write_reg)
+		return;
+
+	pci_write_config_dword(dev, pos + reg->reg_offset, write_reg);
+
+	pci_dbg(dev, "Applied _HPX3 at [0x%x]: 0x%08x -> 0x%08x",
+		pos, orig_value, write_reg);
+}
+
+void program_hpx_type3(struct pci_dev *dev, struct hpx_type3 *hpx)
+{
+	if (!hpx)
+		return;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	program_hpx_type3_register(dev, hpx);
+}
+
 static void parse_hpx3_register(struct hpx_type3 *hpx3_reg,
 				union acpi_object *reg_fields)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -649,4 +649,83 @@ static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
 #endif
 
+/* _HPX PCI Setting Record (Type 0) */
+struct hpx_type0 {
+	u32 revision; /* Not present in _HPP */
+	u8  cache_line_size; /* Not applicable to PCI Express */
+	u8  latency_timer;   /* Not applicable to PCI Express */
+	u8  enable_serr;
+	u8  enable_perr;
+};
+
+/* _HPX PCI-X Setting Record (Type 1) */
+struct hpx_type1 {
+	u32 revision;
+	u8  max_mem_read;
+	u8  avg_max_split;
+	u16 tot_max_split;
+};
+
+/* _HPX PCI Express Setting Record (Type 2) */
+struct hpx_type2 {
+	u32 revision;
+	u32 unc_err_mask_and;
+	u32 unc_err_mask_or;
+	u32 unc_err_sever_and;
+	u32 unc_err_sever_or;
+	u32 cor_err_mask_and;
+	u32 cor_err_mask_or;
+	u32 adv_err_cap_and;
+	u32 adv_err_cap_or;
+	u16 pci_exp_devctl_and;
+	u16 pci_exp_devctl_or;
+	u16 pci_exp_lnkctl_and;
+	u16 pci_exp_lnkctl_or;
+	u32 sec_unc_err_sever_and;
+	u32 sec_unc_err_sever_or;
+	u32 sec_unc_err_mask_and;
+	u32 sec_unc_err_mask_or;
+};
+
+/* _HPX PCI Express Setting Record (Type 3) */
+struct hpx_type3 {
+	u16 device_type;
+	u16 function_type;
+	u16 config_space_location;
+	u16 pci_exp_cap_id;
+	u16 pci_exp_cap_ver;
+	u16 pci_exp_vendor_id;
+	u16 dvsec_id;
+	u16 dvsec_rev;
+	u16 match_offset;
+	u32 match_mask_and;
+	u32 match_value;
+	u16 reg_offset;
+	u32 reg_mask_and;
+	u32 reg_mask_or;
+};
+
+void program_hpx_type0(struct pci_dev *dev, struct hpx_type0 *hpx);
+void program_hpx_type1(struct pci_dev *dev, struct hpx_type1 *hpx);
+void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx);
+void program_hpx_type3(struct pci_dev *dev, struct hpx_type3 *hpx);
+
+struct hotplug_program_ops {
+	void (*program_type0)(struct pci_dev *dev, struct hpx_type0 *hpx);
+	void (*program_type1)(struct pci_dev *dev, struct hpx_type1 *hpx);
+	void (*program_type2)(struct pci_dev *dev, struct hpx_type2 *hpx);
+	void (*program_type3)(struct pci_dev *dev, struct hpx_type3 *hpx);
+};
+
+#ifdef CONFIG_ACPI
+int pci_acpi_program_hp_params(struct pci_dev *dev,
+			       const struct hotplug_program_ops *hp_ops);
+#else
+static inline int pci_acpi_program_hp_params(struct pci_dev *dev,
+				    const struct hotplug_program_ops *hp_ops)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1915,275 +1915,6 @@ static void pci_configure_mps(struct pci_dev *dev)
 		 p_mps, mps, mpss);
 }
 
-static struct hpx_type0 pci_default_type0 = {
-	.revision = 1,
-	.cache_line_size = 8,
-	.latency_timer = 0x40,
-	.enable_serr = 0,
-	.enable_perr = 0,
-};
-
-static void program_hpx_type0(struct pci_dev *dev, struct hpx_type0 *hpx)
-{
-	u16 pci_cmd, pci_bctl;
-
-	if (!hpx)
-		hpx = &pci_default_type0;
-
-	if (hpx->revision > 1) {
-		pci_warn(dev, "PCI settings rev %d not supported; using defaults\n",
-			 hpx->revision);
-		hpx = &pci_default_type0;
-	}
-
-	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, hpx->cache_line_size);
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, hpx->latency_timer);
-	pci_read_config_word(dev, PCI_COMMAND, &pci_cmd);
-	if (hpx->enable_serr)
-		pci_cmd |= PCI_COMMAND_SERR;
-	if (hpx->enable_perr)
-		pci_cmd |= PCI_COMMAND_PARITY;
-	pci_write_config_word(dev, PCI_COMMAND, pci_cmd);
-
-	/* Program bridge control value */
-	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
-		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER,
-				      hpx->latency_timer);
-		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &pci_bctl);
-		if (hpx->enable_perr)
-			pci_bctl |= PCI_BRIDGE_CTL_PARITY;
-		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, pci_bctl);
-	}
-}
-
-static void program_hpx_type1(struct pci_dev *dev, struct hpx_type1 *hpx)
-{
-	int pos;
-
-	if (!hpx)
-		return;
-
-	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-	if (!pos)
-		return;
-
-	pci_warn(dev, "PCI-X settings not supported\n");
-}
-
-static bool pcie_root_rcb_set(struct pci_dev *dev)
-{
-	struct pci_dev *rp = pcie_find_root_port(dev);
-	u16 lnkctl;
-
-	if (!rp)
-		return false;
-
-	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
-	if (lnkctl & PCI_EXP_LNKCTL_RCB)
-		return true;
-
-	return false;
-}
-
-static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
-{
-	int pos;
-	u32 reg32;
-
-	if (!hpx)
-		return;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	if (hpx->revision > 1) {
-		pci_warn(dev, "PCIe settings rev %d not supported\n",
-			 hpx->revision);
-		return;
-	}
-
-	/*
-	 * Don't allow _HPX to change MPS or MRRS settings.  We manage
-	 * those to make sure they're consistent with the rest of the
-	 * platform.
-	 */
-	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
-				    PCI_EXP_DEVCTL_READRQ;
-	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
-				    PCI_EXP_DEVCTL_READRQ);
-
-	/* Initialize Device Control Register */
-	pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
-			~hpx->pci_exp_devctl_and, hpx->pci_exp_devctl_or);
-
-	/* Initialize Link Control Register */
-	if (pcie_cap_has_lnkctl(dev)) {
-
-		/*
-		 * If the Root Port supports Read Completion Boundary of
-		 * 128, set RCB to 128.  Otherwise, clear it.
-		 */
-		hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
-		hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
-		if (pcie_root_rcb_set(dev))
-			hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
-
-		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
-			~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
-	}
-
-	/* Find Advanced Error Reporting Enhanced Capability */
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-	if (!pos)
-		return;
-
-	/* Initialize Uncorrectable Error Mask Register */
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &reg32);
-	reg32 = (reg32 & hpx->unc_err_mask_and) | hpx->unc_err_mask_or;
-	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, reg32);
-
-	/* Initialize Uncorrectable Error Severity Register */
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &reg32);
-	reg32 = (reg32 & hpx->unc_err_sever_and) | hpx->unc_err_sever_or;
-	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, reg32);
-
-	/* Initialize Correctable Error Mask Register */
-	pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, &reg32);
-	reg32 = (reg32 & hpx->cor_err_mask_and) | hpx->cor_err_mask_or;
-	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, reg32);
-
-	/* Initialize Advanced Error Capabilities and Control Register */
-	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
-	reg32 = (reg32 & hpx->adv_err_cap_and) | hpx->adv_err_cap_or;
-
-	/* Don't enable ECRC generation or checking if unsupported */
-	if (!(reg32 & PCI_ERR_CAP_ECRC_GENC))
-		reg32 &= ~PCI_ERR_CAP_ECRC_GENE;
-	if (!(reg32 & PCI_ERR_CAP_ECRC_CHKC))
-		reg32 &= ~PCI_ERR_CAP_ECRC_CHKE;
-	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
-
-	/*
-	 * FIXME: The following two registers are not supported yet.
-	 *
-	 *   o Secondary Uncorrectable Error Severity Register
-	 *   o Secondary Uncorrectable Error Mask Register
-	 */
-}
-
-static u16 hpx3_device_type(struct pci_dev *dev)
-{
-	u16 pcie_type = pci_pcie_type(dev);
-	const int pcie_to_hpx3_type[] = {
-		[PCI_EXP_TYPE_ENDPOINT]    = HPX_TYPE_ENDPOINT,
-		[PCI_EXP_TYPE_LEG_END]     = HPX_TYPE_LEG_END,
-		[PCI_EXP_TYPE_RC_END]      = HPX_TYPE_RC_END,
-		[PCI_EXP_TYPE_RC_EC]       = HPX_TYPE_RC_EC,
-		[PCI_EXP_TYPE_ROOT_PORT]   = HPX_TYPE_ROOT_PORT,
-		[PCI_EXP_TYPE_UPSTREAM]    = HPX_TYPE_UPSTREAM,
-		[PCI_EXP_TYPE_DOWNSTREAM]  = HPX_TYPE_DOWNSTREAM,
-		[PCI_EXP_TYPE_PCI_BRIDGE]  = HPX_TYPE_PCI_BRIDGE,
-		[PCI_EXP_TYPE_PCIE_BRIDGE] = HPX_TYPE_PCIE_BRIDGE,
-	};
-
-	if (pcie_type >= ARRAY_SIZE(pcie_to_hpx3_type))
-		return 0;
-
-	return pcie_to_hpx3_type[pcie_type];
-}
-
-static u8 hpx3_function_type(struct pci_dev *dev)
-{
-	if (dev->is_virtfn)
-		return HPX_FN_SRIOV_VIRT;
-	else if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV) > 0)
-		return HPX_FN_SRIOV_PHYS;
-	else
-		return HPX_FN_NORMAL;
-}
-
-static bool hpx3_cap_ver_matches(u8 pcie_cap_id, u8 hpx3_cap_id)
-{
-	u8 cap_ver = hpx3_cap_id & 0xf;
-
-	if ((hpx3_cap_id & BIT(4)) && cap_ver >= pcie_cap_id)
-		return true;
-	else if (cap_ver == pcie_cap_id)
-		return true;
-
-	return false;
-}
-
-static void program_hpx_type3_register(struct pci_dev *dev,
-				       const struct hpx_type3 *reg)
-{
-	u32 match_reg, write_reg, header, orig_value;
-	u16 pos;
-
-	if (!(hpx3_device_type(dev) & reg->device_type))
-		return;
-
-	if (!(hpx3_function_type(dev) & reg->function_type))
-		return;
-
-	switch (reg->config_space_location) {
-	case HPX_CFG_PCICFG:
-		pos = 0;
-		break;
-	case HPX_CFG_PCIE_CAP:
-		pos = pci_find_capability(dev, reg->pci_exp_cap_id);
-		if (pos == 0)
-			return;
-
-		break;
-	case HPX_CFG_PCIE_CAP_EXT:
-		pos = pci_find_ext_capability(dev, reg->pci_exp_cap_id);
-		if (pos == 0)
-			return;
-
-		pci_read_config_dword(dev, pos, &header);
-		if (!hpx3_cap_ver_matches(PCI_EXT_CAP_VER(header),
-					  reg->pci_exp_cap_ver))
-			return;
-
-		break;
-	case HPX_CFG_VEND_CAP:	/* Fall through */
-	case HPX_CFG_DVSEC:	/* Fall through */
-	default:
-		pci_warn(dev, "Encountered _HPX type 3 with unsupported config space location");
-		return;
-	}
-
-	pci_read_config_dword(dev, pos + reg->match_offset, &match_reg);
-
-	if ((match_reg & reg->match_mask_and) != reg->match_value)
-		return;
-
-	pci_read_config_dword(dev, pos + reg->reg_offset, &write_reg);
-	orig_value = write_reg;
-	write_reg &= reg->reg_mask_and;
-	write_reg |= reg->reg_mask_or;
-
-	if (orig_value == write_reg)
-		return;
-
-	pci_write_config_dword(dev, pos + reg->reg_offset, write_reg);
-
-	pci_dbg(dev, "Applied _HPX3 at [0x%x]: 0x%08x -> 0x%08x",
-		pos, orig_value, write_reg);
-}
-
-static void program_hpx_type3(struct pci_dev *dev, struct hpx_type3 *hpx)
-{
-	if (!hpx)
-		return;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	program_hpx_type3_register(dev, hpx);
-}
-
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 {
 	struct pci_host_bridge *host;
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -86,112 +86,14 @@ void pci_hp_deregister(struct hotplug_slot *slot);
 #define pci_hp_initialize(slot, bus, nr, name) \
 	__pci_hp_initialize(slot, bus, nr, name, THIS_MODULE, KBUILD_MODNAME)
 
-/* _HPX PCI Setting Record (Type 0) */
-struct hpx_type0 {
-	u32 revision; /* Not present in _HPP */
-	u8  cache_line_size; /* Not applicable to PCI Express */
-	u8  latency_timer;   /* Not applicable to PCI Express */
-	u8  enable_serr;
-	u8  enable_perr;
-};
-
-/* _HPX PCI-X Setting Record (Type 1) */
-struct hpx_type1 {
-	u32 revision;
-	u8  max_mem_read;
-	u8  avg_max_split;
-	u16 tot_max_split;
-};
-
-/* _HPX PCI Express Setting Record (Type 2) */
-struct hpx_type2 {
-	u32 revision;
-	u32 unc_err_mask_and;
-	u32 unc_err_mask_or;
-	u32 unc_err_sever_and;
-	u32 unc_err_sever_or;
-	u32 cor_err_mask_and;
-	u32 cor_err_mask_or;
-	u32 adv_err_cap_and;
-	u32 adv_err_cap_or;
-	u16 pci_exp_devctl_and;
-	u16 pci_exp_devctl_or;
-	u16 pci_exp_lnkctl_and;
-	u16 pci_exp_lnkctl_or;
-	u32 sec_unc_err_sever_and;
-	u32 sec_unc_err_sever_or;
-	u32 sec_unc_err_mask_and;
-	u32 sec_unc_err_mask_or;
-};
-
-/* _HPX PCI Express Setting Record (Type 3) */
-struct hpx_type3 {
-	u16 device_type;
-	u16 function_type;
-	u16 config_space_location;
-	u16 pci_exp_cap_id;
-	u16 pci_exp_cap_ver;
-	u16 pci_exp_vendor_id;
-	u16 dvsec_id;
-	u16 dvsec_rev;
-	u16 match_offset;
-	u32 match_mask_and;
-	u32 match_value;
-	u16 reg_offset;
-	u32 reg_mask_and;
-	u32 reg_mask_or;
-};
-
-struct hotplug_program_ops {
-	void (*program_type0)(struct pci_dev *dev, struct hpx_type0 *hpx);
-	void (*program_type1)(struct pci_dev *dev, struct hpx_type1 *hpx);
-	void (*program_type2)(struct pci_dev *dev, struct hpx_type2 *hpx);
-	void (*program_type3)(struct pci_dev *dev, struct hpx_type3 *hpx);
-};
-
-enum hpx_type3_dev_type {
-	HPX_TYPE_ENDPOINT	= BIT(0),
-	HPX_TYPE_LEG_END	= BIT(1),
-	HPX_TYPE_RC_END		= BIT(2),
-	HPX_TYPE_RC_EC		= BIT(3),
-	HPX_TYPE_ROOT_PORT	= BIT(4),
-	HPX_TYPE_UPSTREAM	= BIT(5),
-	HPX_TYPE_DOWNSTREAM	= BIT(6),
-	HPX_TYPE_PCI_BRIDGE	= BIT(7),
-	HPX_TYPE_PCIE_BRIDGE	= BIT(8),
-};
-
-enum hpx_type3_fn_type {
-	HPX_FN_NORMAL		= BIT(0),
-	HPX_FN_SRIOV_PHYS	= BIT(1),
-	HPX_FN_SRIOV_VIRT	= BIT(2),
-};
-
-enum hpx_type3_cfg_loc {
-	HPX_CFG_PCICFG		= 0,
-	HPX_CFG_PCIE_CAP	= 1,
-	HPX_CFG_PCIE_CAP_EXT	= 2,
-	HPX_CFG_VEND_CAP	= 3,
-	HPX_CFG_DVSEC		= 4,
-	HPX_CFG_MAX,
-};
-
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
-int pci_acpi_program_hp_params(struct pci_dev *dev,
-			       const struct hotplug_program_ops *hp_ops);
 bool pciehp_is_native(struct pci_dev *bridge);
 int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
 bool shpchp_is_native(struct pci_dev *bridge);
 int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
 int acpi_pci_detect_ejectable(acpi_handle handle);
 #else
-static inline int pci_acpi_program_hp_params(struct pci_dev *dev,
-				    const struct hotplug_program_ops *hp_ops)
-{
-	return -ENODEV;
-}
-
 static inline int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge)
 {
 	return 0;
-- 
2.22.1

