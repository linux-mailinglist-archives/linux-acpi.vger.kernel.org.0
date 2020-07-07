Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E252163C1
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 04:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGGCPG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 22:15:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:29711 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgGGCPG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Jul 2020 22:15:06 -0400
IronPort-SDR: N5M48f91kcc+BMkjOBAlSo04gYsjXM4zxznkmITrrOqI1D1zA0Znw2BThbLXhyCIRIfhCRP91y
 4YpCPIiKCVGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212500744"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="212500744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:05 -0700
IronPort-SDR: rlFPFpCSFbdwWJWn8Dg68/6tSpDz5iD/BGbMxmqiqyfMjH+q1BfYVazXmEX8NbowN1PUHm/0tG
 a6oPyPEYGtNw==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="283231091"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:05 -0700
Subject: [PATCH v2 03/12] ACPI: NFIT: Define runtime firmware activation
 commands
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Jul 2020 18:58:49 -0700
Message-ID: <159408712989.2385045.3306664726566037392.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Platform reboots are expensive. Towards reducing downtime to apply
firmware updates the Intel NVDIMM command definition is growing support
for applying live firmware updates that only require temporarily
suspending memory traffic instead of a full reboot.

Follow-on commits add support for triggering firmware activation, this
patch only defines the commands, adds probe support, and validates that
they are blocked via the ioctl path. The ioctl-path block ensures that
the OS is in charge since these commands have side effects only the OS
can handle. Specifically firmware activation may cause the memory
controller to be quiesced on the order of 100s of milliseconds. In that
case Linux ensure the activation only takes place while the OS is in a
suspend state.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Link: https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c   |   86 ++++++++++++++++++++++++++++++--------------
 drivers/acpi/nfit/intel.h  |   53 +++++++++++++++++++++++++++
 drivers/acpi/nfit/nfit.h   |   25 ++++++++++++-
 include/uapi/linux/ndctl.h |    3 +-
 4 files changed, 137 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 9fdd655bdf0e..78cc9e2d2aa3 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -73,6 +73,18 @@ const guid_t *to_nfit_uuid(enum nfit_uuids id)
 }
 EXPORT_SYMBOL(to_nfit_uuid);
 
+static const guid_t *to_nfit_bus_uuid(int family)
+{
+	if (WARN_ONCE(family == NVDIMM_BUS_FAMILY_NFIT,
+			"only secondary bus families can be translated\n"))
+		return NULL;
+	/*
+	 * The index of bus UUIDs starts immediately following the last
+	 * NVDIMM/leaf family.
+	 */
+	return to_nfit_uuid(family + NVDIMM_FAMILY_MAX);
+}
+
 static struct acpi_device *to_acpi_dev(struct acpi_nfit_desc *acpi_desc)
 {
 	struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
@@ -362,24 +374,8 @@ static u8 nfit_dsm_revid(unsigned family, unsigned func)
 {
 	static const u8 revid_table[NVDIMM_FAMILY_MAX+1][NVDIMM_CMD_MAX+1] = {
 		[NVDIMM_FAMILY_INTEL] = {
-			[NVDIMM_INTEL_GET_MODES] = 2,
-			[NVDIMM_INTEL_GET_FWINFO] = 2,
-			[NVDIMM_INTEL_START_FWUPDATE] = 2,
-			[NVDIMM_INTEL_SEND_FWUPDATE] = 2,
-			[NVDIMM_INTEL_FINISH_FWUPDATE] = 2,
-			[NVDIMM_INTEL_QUERY_FWUPDATE] = 2,
-			[NVDIMM_INTEL_SET_THRESHOLD] = 2,
-			[NVDIMM_INTEL_INJECT_ERROR] = 2,
-			[NVDIMM_INTEL_GET_SECURITY_STATE] = 2,
-			[NVDIMM_INTEL_SET_PASSPHRASE] = 2,
-			[NVDIMM_INTEL_DISABLE_PASSPHRASE] = 2,
-			[NVDIMM_INTEL_UNLOCK_UNIT] = 2,
-			[NVDIMM_INTEL_FREEZE_LOCK] = 2,
-			[NVDIMM_INTEL_SECURE_ERASE] = 2,
-			[NVDIMM_INTEL_OVERWRITE] = 2,
-			[NVDIMM_INTEL_QUERY_OVERWRITE] = 2,
-			[NVDIMM_INTEL_SET_MASTER_PASSPHRASE] = 2,
-			[NVDIMM_INTEL_MASTER_SECURE_ERASE] = 2,
+			[NVDIMM_INTEL_GET_MODES ...
+				NVDIMM_INTEL_FW_ACTIVATE_ARM] = 2,
 		},
 	};
 	u8 id;
@@ -406,7 +402,7 @@ static bool payload_dumpable(struct nvdimm *nvdimm, unsigned int func)
 }
 
 static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
-		struct nd_cmd_pkg *call_pkg)
+		struct nd_cmd_pkg *call_pkg, int *family)
 {
 	if (call_pkg) {
 		int i;
@@ -417,6 +413,7 @@ static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
 		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
 			if (call_pkg->nd_reserved2[i])
 				return -EINVAL;
+		*family = call_pkg->nd_family;
 		return call_pkg->nd_command;
 	}
 
@@ -450,13 +447,14 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	acpi_handle handle;
 	const guid_t *guid;
 	int func, rc, i;
+	int family = 0;
 
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
 
 	if (cmd == ND_CMD_CALL)
 		call_pkg = buf;
-	func = cmd_to_func(nfit_mem, cmd, call_pkg);
+	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
 	if (func < 0)
 		return func;
 
@@ -478,9 +476,17 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 
 		cmd_name = nvdimm_bus_cmd_name(cmd);
 		cmd_mask = nd_desc->cmd_mask;
-		dsm_mask = acpi_desc->bus_dsm_mask;
+		if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
+			family = call_pkg->nd_family;
+			if (!test_bit(family, &nd_desc->bus_family_mask))
+				return -EINVAL;
+			dsm_mask = acpi_desc->family_dsm_mask[family];
+			guid = to_nfit_bus_uuid(family);
+		} else {
+			dsm_mask = acpi_desc->bus_dsm_mask;
+			guid = to_nfit_uuid(NFIT_DEV_BUS);
+		}
 		desc = nd_cmd_bus_desc(cmd);
-		guid = to_nfit_uuid(NFIT_DEV_BUS);
 		handle = adev->handle;
 		dimm_name = "bus";
 	}
@@ -516,8 +522,8 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		in_buf.buffer.length = call_pkg->nd_size_in;
 	}
 
-	dev_dbg(dev, "%s cmd: %d: func: %d input length: %d\n",
-		dimm_name, cmd, func, in_buf.buffer.length);
+	dev_dbg(dev, "%s cmd: %d: family: %d func: %d input length: %d\n",
+		dimm_name, cmd, family, func, in_buf.buffer.length);
 	if (payload_dumpable(nvdimm, func))
 		print_hex_dump_debug("nvdimm in  ", DUMP_PREFIX_OFFSET, 4, 4,
 				in_buf.buffer.pointer,
@@ -2153,14 +2159,21 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
 {
 	struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
 	const guid_t *guid = to_nfit_uuid(NFIT_DEV_BUS);
+	unsigned long dsm_mask, *mask;
 	struct acpi_device *adev;
-	unsigned long dsm_mask;
 	int i;
 
-	nd_desc->cmd_mask = acpi_desc->bus_cmd_force_en;
 	set_bit(ND_CMD_CALL, &nd_desc->cmd_mask);
 	set_bit(NVDIMM_BUS_FAMILY_NFIT, &nd_desc->bus_family_mask);
 
+	/* enable nfit_test to inject bus command emulation */
+	if (acpi_desc->bus_cmd_force_en) {
+		nd_desc->cmd_mask = acpi_desc->bus_cmd_force_en;
+		mask = &nd_desc->bus_family_mask;
+		if (acpi_desc->family_dsm_mask[NVDIMM_BUS_FAMILY_INTEL])
+			set_bit(NVDIMM_BUS_FAMILY_INTEL, mask);
+	}
+
 	adev = to_acpi_dev(acpi_desc);
 	if (!adev)
 		return;
@@ -2181,6 +2194,14 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
 	for_each_set_bit(i, &dsm_mask, BITS_PER_LONG)
 		if (acpi_check_dsm(adev->handle, guid, 1, 1ULL << i))
 			set_bit(i, &acpi_desc->bus_dsm_mask);
+
+	/* Enumerate allowed NVDIMM_BUS_FAMILY_INTEL commands */
+	dsm_mask = NVDIMM_BUS_INTEL_FW_ACTIVATE_CMDMASK;
+	guid = to_nfit_bus_uuid(NVDIMM_BUS_FAMILY_INTEL);
+	mask = &acpi_desc->family_dsm_mask[NVDIMM_BUS_FAMILY_INTEL];
+	for_each_set_bit(i, &dsm_mask, BITS_PER_LONG)
+		if (acpi_check_dsm(adev->handle, guid, 1, 1ULL << i))
+			set_bit(i, mask);
 }
 
 static ssize_t range_index_show(struct device *dev,
@@ -3492,7 +3513,10 @@ static int __acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
 	return 0;
 }
 
-/* prevent security commands from being issued via ioctl */
+/*
+ * Prevent security and firmware activate commands from being issued via
+ * ioctl.
+ */
 static int acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
 		struct nvdimm *nvdimm, unsigned int cmd, void *buf)
 {
@@ -3503,10 +3527,15 @@ static int acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
 			call_pkg->nd_family == NVDIMM_FAMILY_INTEL) {
 		func = call_pkg->nd_command;
 		if (func > NVDIMM_CMD_MAX ||
-		    (1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
+		    (1 << func) & NVDIMM_INTEL_DENY_CMDMASK)
 			return -EOPNOTSUPP;
 	}
 
+	/* block all non-nfit bus commands */
+	if (!nvdimm && cmd == ND_CMD_CALL &&
+			call_pkg->nd_family != NVDIMM_BUS_FAMILY_NFIT)
+		return -EOPNOTSUPP;
+
 	return __acpi_nfit_clear_to_send(nd_desc, nvdimm, cmd);
 }
 
@@ -3798,6 +3827,7 @@ static __init int nfit_init(void)
 	guid_parse(UUID_NFIT_DIMM_N_HPE2, &nfit_uuid[NFIT_DEV_DIMM_N_HPE2]);
 	guid_parse(UUID_NFIT_DIMM_N_MSFT, &nfit_uuid[NFIT_DEV_DIMM_N_MSFT]);
 	guid_parse(UUID_NFIT_DIMM_N_HYPERV, &nfit_uuid[NFIT_DEV_DIMM_N_HYPERV]);
+	guid_parse(UUID_INTEL_BUS, &nfit_uuid[NFIT_BUS_INTEL]);
 
 	nfit_wq = create_singlethread_workqueue("nfit");
 	if (!nfit_wq)
diff --git a/drivers/acpi/nfit/intel.h b/drivers/acpi/nfit/intel.h
index 0aca682ab9d7..868d073731cc 100644
--- a/drivers/acpi/nfit/intel.h
+++ b/drivers/acpi/nfit/intel.h
@@ -111,4 +111,57 @@ struct nd_intel_master_secure_erase {
 	u8 passphrase[ND_INTEL_PASSPHRASE_SIZE];
 	u32 status;
 } __packed;
+
+#define ND_INTEL_FWA_IDLE 0
+#define ND_INTEL_FWA_ARMED 1
+#define ND_INTEL_FWA_BUSY 2
+
+#define ND_INTEL_DIMM_FWA_NONE 0
+#define ND_INTEL_DIMM_FWA_NOTSTAGED 1
+#define ND_INTEL_DIMM_FWA_SUCCESS 2
+#define ND_INTEL_DIMM_FWA_NEEDRESET 3
+#define ND_INTEL_DIMM_FWA_MEDIAFAILED 4
+#define ND_INTEL_DIMM_FWA_ABORT 5
+#define ND_INTEL_DIMM_FWA_NOTSUPP 6
+#define ND_INTEL_DIMM_FWA_ERROR 7
+
+struct nd_intel_fw_activate_dimminfo {
+	u32 status;
+	u16 result;
+	u8 state;
+	u8 reserved[7];
+} __packed;
+
+struct nd_intel_fw_activate_arm {
+	u8 activate_arm;
+	u32 status;
+} __packed;
+
+/* Root device command payloads */
+#define ND_INTEL_BUS_FWA_CAP_FWQUIESCE (1 << 0)
+#define ND_INTEL_BUS_FWA_CAP_OSQUIESCE (1 << 1)
+#define ND_INTEL_BUS_FWA_CAP_RESET     (1 << 2)
+
+struct nd_intel_bus_fw_activate_businfo {
+	u32 status;
+	u16 reserved;
+	u8 state;
+	u8 capability;
+	u64 activate_tmo;
+	u64 cpu_quiesce_tmo;
+	u64 io_quiesce_tmo;
+	u64 max_quiesce_tmo;
+} __packed;
+
+#define ND_INTEL_BUS_FWA_STATUS_NOARM  (6 | 1 << 16)
+#define ND_INTEL_BUS_FWA_STATUS_BUSY   (6 | 2 << 16)
+#define ND_INTEL_BUS_FWA_STATUS_NOFW   (6 | 3 << 16)
+#define ND_INTEL_BUS_FWA_STATUS_TMO    (6 | 4 << 16)
+#define ND_INTEL_BUS_FWA_STATUS_NOIDLE (6 | 5 << 16)
+#define ND_INTEL_BUS_FWA_STATUS_ABORT  (6 | 6 << 16)
+
+struct nd_intel_bus_fw_activate {
+	u8 iodev_state;
+	u32 status;
+} __packed;
 #endif
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index da097149d94d..97c122628975 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -18,6 +18,7 @@
 
 /* http://pmem.io/documents/NVDIMM_DSM_Interface-V1.6.pdf */
 #define UUID_NFIT_DIMM "4309ac30-0d11-11e4-9191-0800200c9a66"
+#define UUID_INTEL_BUS "c7d8acd4-2df8-4b82-9f65-a325335af149"
 
 /* https://github.com/HewlettPackard/hpe-nvm/blob/master/Documentation/ */
 #define UUID_NFIT_DIMM_N_HPE1 "9002c334-acf3-4c0e-9642-a235f0d53bc6"
@@ -65,6 +66,13 @@ enum nvdimm_family_cmds {
 	NVDIMM_INTEL_QUERY_OVERWRITE = 26,
 	NVDIMM_INTEL_SET_MASTER_PASSPHRASE = 27,
 	NVDIMM_INTEL_MASTER_SECURE_ERASE = 28,
+	NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO = 29,
+	NVDIMM_INTEL_FW_ACTIVATE_ARM = 30,
+};
+
+enum nvdimm_bus_family_cmds {
+	NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO = 1,
+	NVDIMM_BUS_INTEL_FW_ACTIVATE = 2,
 };
 
 #define NVDIMM_INTEL_SECURITY_CMDMASK \
@@ -75,13 +83,22 @@ enum nvdimm_family_cmds {
 | 1 << NVDIMM_INTEL_SET_MASTER_PASSPHRASE \
 | 1 << NVDIMM_INTEL_MASTER_SECURE_ERASE)
 
+#define NVDIMM_INTEL_FW_ACTIVATE_CMDMASK \
+(1 << NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO | 1 << NVDIMM_INTEL_FW_ACTIVATE_ARM)
+
+#define NVDIMM_BUS_INTEL_FW_ACTIVATE_CMDMASK \
+(1 << NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO | 1 << NVDIMM_BUS_INTEL_FW_ACTIVATE)
+
 #define NVDIMM_INTEL_CMDMASK \
 (NVDIMM_STANDARD_CMDMASK | 1 << NVDIMM_INTEL_GET_MODES \
  | 1 << NVDIMM_INTEL_GET_FWINFO | 1 << NVDIMM_INTEL_START_FWUPDATE \
  | 1 << NVDIMM_INTEL_SEND_FWUPDATE | 1 << NVDIMM_INTEL_FINISH_FWUPDATE \
  | 1 << NVDIMM_INTEL_QUERY_FWUPDATE | 1 << NVDIMM_INTEL_SET_THRESHOLD \
  | 1 << NVDIMM_INTEL_INJECT_ERROR | 1 << NVDIMM_INTEL_LATCH_SHUTDOWN \
- | NVDIMM_INTEL_SECURITY_CMDMASK)
+ | NVDIMM_INTEL_SECURITY_CMDMASK | NVDIMM_INTEL_FW_ACTIVATE_CMDMASK)
+
+#define NVDIMM_INTEL_DENY_CMDMASK \
+(NVDIMM_INTEL_SECURITY_CMDMASK | NVDIMM_INTEL_FW_ACTIVATE_CMDMASK)
 
 enum nfit_uuids {
 	/* for simplicity alias the uuid index with the family id */
@@ -90,6 +107,11 @@ enum nfit_uuids {
 	NFIT_DEV_DIMM_N_HPE2 = NVDIMM_FAMILY_HPE2,
 	NFIT_DEV_DIMM_N_MSFT = NVDIMM_FAMILY_MSFT,
 	NFIT_DEV_DIMM_N_HYPERV = NVDIMM_FAMILY_HYPERV,
+	/*
+	 * to_nfit_bus_uuid() expects to translate bus uuid family ids
+	 * to a UUID index using NVDIMM_FAMILY_MAX as an offset
+	 */
+	NFIT_BUS_INTEL = NVDIMM_FAMILY_MAX + NVDIMM_BUS_FAMILY_INTEL,
 	NFIT_SPA_VOLATILE,
 	NFIT_SPA_PM,
 	NFIT_SPA_DCR,
@@ -238,6 +260,7 @@ struct acpi_nfit_desc {
 	unsigned long dimm_cmd_force_en;
 	unsigned long bus_cmd_force_en;
 	unsigned long bus_dsm_mask;
+	unsigned long family_dsm_mask[NVDIMM_BUS_FAMILY_MAX + 1];
 	unsigned int platform_cap;
 	unsigned int scrub_tmo;
 	int (*blk_do_io)(struct nd_blk_region *ndbr, resource_size_t dpa,
diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index e9468b9332bd..8cf1e4884fd5 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -248,7 +248,8 @@ struct nd_cmd_pkg {
 #define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_PAPR
 
 #define NVDIMM_BUS_FAMILY_NFIT 0
-#define NVDIMM_BUS_FAMILY_MAX NVDIMM_BUS_FAMILY_NFIT
+#define NVDIMM_BUS_FAMILY_INTEL 1
+#define NVDIMM_BUS_FAMILY_MAX NVDIMM_BUS_FAMILY_INTEL
 
 #define ND_IOCTL_CALL			_IOWR(ND_IOCTL, ND_CMD_CALL,\
 					struct nd_cmd_pkg)

