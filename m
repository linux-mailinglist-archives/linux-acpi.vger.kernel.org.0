Return-Path: <linux-acpi+bounces-2414-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D54812197
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 23:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE9C2821E4
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 22:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440181831;
	Wed, 13 Dec 2023 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4dQyI0SQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28384B7;
	Wed, 13 Dec 2023 14:38:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UghiPeyWmLkJsdfZAm7S9IYbo/02VtEovDwUVnOJbXjac7XdYiMVmEyfVyJ8sn+0TJ8eiFD3KdWDGTqfR4ZP8rkl6OU4CNs4V4GA7tzO3nJL/Y2BaWqiXS9xs2/28O0sveT0lmpmyQY8PtFJlBXmApNgxOP1ilNAio8VrRD2gmO3hXMfF5cZGGyTFdEDtACACVx4UHUglZBaSHOUUyq7VRFN4r6PsAIcJMTDn7V2wSZLEx9Wag+4RY5glW9BcHcBa/yH3sCac10fEBPoiEUWWMLBByxMRBZEeRV4TKYBzRKIY5dDmYNRfUQs+F03tiouribu1yJc65EBkLfW3kL87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRPMSPiu+6rXlJNJFXh4cGcP3rx4Svks1sPSETCLZfA=;
 b=OT4Vh3OMz/T8o1xkgBaX4+L+it3IQ0muHKheYCW0xWV/XQSslYIbk0Pr3aOlAIUVHE9SMreaMG4WgBvUMbdvU3T8NuPfwAJWoVFqPRg/VTu+/qom4bWMvrsbs8+/FGAL1i4JS81Bz/2ud3tO51QBT4qoxlgmh3WN297hDm/fMxaqbr7hwMGdNY33WNxN5vIWc/W31EBub4eK73GfyDXjzkSxvu/pbw4EqRNZ2/1y4YK7b82EgHfDlRCvAGlTHd/wcuEFVKHVbHzs44AgIMPvrZsOAXOCrbvZeuwgvrF7fxWTe2oEvN6H6/yPND/drvlK0HgHVy5PMDdwkHINlGLlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRPMSPiu+6rXlJNJFXh4cGcP3rx4Svks1sPSETCLZfA=;
 b=4dQyI0SQKjs8sBIzZ1NV1NemkkcVeT8sqaFrbEPdWcohD3FGm4OqDVndAyZxJhOOO51z9YPDDxonLo5TdrCxXFVQoAAFVxAr0I0iNdcnKHklwV/Ytd1Uykbok7yF7FWhTJ8yHZSlEd4+YnMBlZJY3885pzc/FG7k/TVtWOL+dzE=
Received: from SA0PR11CA0168.namprd11.prod.outlook.com (2603:10b6:806:1bb::23)
 by CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 22:38:12 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::d1) by SA0PR11CA0168.outlook.office365.com
 (2603:10b6:806:1bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 22:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 22:38:12 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 16:38:10 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v8 4/5] cxl/core, EINJ: Add CXL debugfs files and EINJ functions
Date: Wed, 13 Dec 2023 16:37:01 -0600
Message-ID: <20231213223702.543419-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH0PR12MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: d02f6c4e-446d-4233-2581-08dbfc2c3075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sAWMcsTdiSuY1PRv6YzwkMzTD/8Y71aze/28Yx7DRdrUaZ4dizDQzghLIXJPFLxlI5qA43HLQDJlfw3Nk+bm+L5rMvuCa9sddMBDPDR0X8Pl8SMq9vwLVi0oj+d8jzBdw06vnIhNu2V1VJi4dEw5JzDKHCs7drJZENx2e315ZpbnNApEKc9ZtKparOHjU4om/jRP855f/MNfoagA0OLyS7zYGDWyuWeVLx1c5Dd19JzYZLWkwkF9lVcBLgqPY94V4geeCiLvGLTYxK/V4C+HTFWRlf1Q+4IG22V7sVI5rTWEi7qaIMKMteWrQvX9GKodiNOdU97EacvWiNgXwyjXmxoM872OGCm6LRDUV9Ey1Q6ZKfdZs30U78BdSlSu46EsmOjnWsPL/loXMb/Oh8YfN+zsUl/tNHZdCDAoedMOKib8LuCJuAGVfsKR988n+2ssA+KanuSEQd75idfKqU7l6o05NKXWu8WvT/DuiduDIpNt6/Efgr6REvqLleSsNAEmKAaSEbfk1u4rpu691tfXW5L/gcURQpNAnyo2vMrDM6o9MV2WKFhb0AxVzpKHC/QAJhMYguO9PkfC/u1TiALFIU1W2ibueTUGP45LKVrA7LgPFuQ428Vh7v6qUo2FROm7JwWvxnAsoj7dBOI9HNGr9hYKFbZaLGPzdrGF/AfNxSA4zlyQhPxtlTwWsQ1R+SzmnqQg7nUJOwt2h3A3hVzomXLOFUw2g1T4SWvZ9Hxuhft62pJAIFZp0uOjxFCZmqilyRkHDllpmMJrvTwovCRH/WB2jWkzIOeQyRo/8/dyT4Y=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(336012)(26005)(16526019)(426003)(83380400001)(2616005)(7696005)(1076003)(47076005)(36860700001)(8676002)(8936002)(5660300002)(4326008)(41300700001)(7416002)(30864003)(2906002)(6666004)(478600001)(316002)(54906003)(70206006)(70586007)(110136005)(36756003)(86362001)(356005)(81166007)(82740400003)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:38:12.4176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02f6c4e-446d-4233-2581-08dbfc2c3075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057

Implement CXL helper functions in the EINJ module for getting the
available CXL protocol error types and injecting CXL errors and export
them to sysfs under kernel/debug/cxl.

The kernel/debug/cxl/einj_types file will print the available CXL
protocol errors in the same format as the available_error_types
file provided by the EINJ module. The
kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
error_type and error_inject files provided by the EINJ module, i.e.:
writing an error type into $dport_dev/einj_inject will inject said error
type into the CXL dport represented by $dport_dev.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/debugfs-cxl |  23 ++++
 drivers/acpi/apei/einj.c              | 144 ++++++++++++++++++++++++--
 drivers/cxl/core/port.c               |  33 ++++++
 drivers/cxl/einj.h                    |  58 +++++++++++
 4 files changed, 248 insertions(+), 10 deletions(-)
 create mode 100644 drivers/cxl/einj.h

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index fe61d372e3fa..97a8684bad84 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -33,3 +33,26 @@ Description:
 		device cannot clear poison from the address, -ENXIO is returned.
 		The clear_poison attribute is only visible for devices
 		supporting the capability.
+
+What:		/sys/kernel/debug/cxl/einj_types
+Date:		November, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Prints the CXL protocol error types made available by
+		the platform in the format "0x<error number>	<error type>".
+		The <error number> can be written to einj_inject to inject
+		<error type> into a chosen dport. This file is only visible if
+		CONFIG_CXL_EINJ is enabled.
+
+What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
+Date:		November, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Writing an integer to this file injects the corresponding
+		CXL protocol error into $dport_dev (integer to type mapping is
+		available by reading from einj_types). If the dport was
+		enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
+		a CXL 2.0 error is injected. This file is only visible if
+		CONFIG_CXL_EINJ is enabled.
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 26a887d2a5cd..1a2195779b52 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -24,6 +24,7 @@
 #include <asm/unaligned.h>
 
 #include "apei-internal.h"
+#include "../../cxl/einj.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) "EINJ: " fmt
@@ -36,6 +37,12 @@
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
 				ACPI_EINJ_MEMORY_FATAL)
+#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_FATAL | \
+				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_FATAL)
 
 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
@@ -537,8 +544,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (type & ACPI5_VENDOR_BIT) {
 		if (vendor_flags != SETWA_FLAGS_MEM)
 			goto inject;
-	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
+	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
 		goto inject;
+	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
+		goto inject;
+	}
 
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
@@ -590,6 +600,9 @@ static const char * const einj_error_type_string[] = {
 	"0x00000200\tPlatform Correctable\n",
 	"0x00000400\tPlatform Uncorrectable non-fatal\n",
 	"0x00000800\tPlatform Uncorrectable fatal\n",
+};
+
+static const char * const einj_cxl_error_type_string[] = {
 	"0x00001000\tCXL.cache Protocol Correctable\n",
 	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
 	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
@@ -617,29 +630,44 @@ DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
 static bool einj_initialized;
 
-static int error_type_get(void *data, u64 *val)
+int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 {
-	*val = error_type;
+	int cxl_err, rc;
+	u32 available_error_type = 0;
+
+	if (!einj_initialized)
+		return -ENXIO;
+
+	rc = einj_get_available_error_type(&available_error_type);
+	if (rc)
+		return rc;
+
+	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
+		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
+
+		if (available_error_type & cxl_err)
+			seq_puts(m, einj_cxl_error_type_string[pos]);
+	}
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
 
-static int error_type_set(void *data, u64 val)
+static int validate_error_type(u64 type)
 {
+	u32 tval, vendor, available_error_type = 0;
 	int rc;
-	u32 available_error_type = 0;
-	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
-	if (val & GENMASK_ULL(63, 32))
+	if (type & GENMASK_ULL(63, 32))
 		return -EINVAL;
 
 	/*
 	 * Vendor defined types have 0x80000000 bit set, and
 	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
 	 */
-	vendor = val & ACPI5_VENDOR_BIT;
-	tval = val & 0x7fffffff;
+	vendor = type & ACPI5_VENDOR_BIT;
+	tval = type & 0x7fffffff;
 
 	/* Only one error type can be specified */
 	if (tval & (tval - 1))
@@ -648,9 +676,105 @@ static int error_type_set(void *data, u64 val)
 		rc = einj_get_available_error_type(&available_error_type);
 		if (rc)
 			return rc;
-		if (!(val & available_error_type))
+		if (!(type & available_error_type))
 			return -EINVAL;
 	}
+
+	return 0;
+}
+
+static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
+{
+	struct pci_bus *pbus;
+	struct pci_host_bridge *bridge;
+	u64 seg = 0, bus;
+
+	pbus = dport_dev->bus;
+	bridge = pci_find_host_bridge(pbus);
+
+	if (!bridge)
+		return -ENODEV;
+
+	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
+		seg = bridge->domain_nr << 24;
+
+	bus = pbus->number << 16;
+	*sbdf = seg | bus | dport_dev->devfn;
+
+	return 0;
+}
+
+int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
+{
+	u64 param1 = 0, param2 = 0, param4 = 0;
+	u32 flags;
+	int rc;
+
+	if (!einj_initialized)
+		return -ENXIO;
+
+	/* Only CXL error types can be specified */
+	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
+		return -EINVAL;
+
+	rc = validate_error_type(type);
+	if (rc)
+		return rc;
+
+	param1 = (u64) rcrb;
+	param2 = 0xfffffffffffff000;
+	flags = 0x2;
+
+	return einj_error_inject(type, flags, param1, param2, 0, param4);
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
+
+int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
+{
+	u64 param1 = 0, param2 = 0, param4 = 0;
+	u32 flags;
+	int rc;
+
+	if (!einj_initialized)
+		return -ENXIO;
+
+	/* Only CXL error types can be specified */
+	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
+		return -EINVAL;
+
+	rc = validate_error_type(type);
+	if (rc)
+		return rc;
+
+	rc = cxl_dport_get_sbdf(dport, &param4);
+	if (rc)
+		return rc;
+
+	flags = 0x4;
+
+	return einj_error_inject(type, flags, param1, param2, 0, param4);
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
+
+static int error_type_get(void *data, u64 *val)
+{
+	*val = error_type;
+
+	return 0;
+}
+
+static int error_type_set(void *data, u64 val)
+{
+	int rc;
+
+	/* CXL error types have to be injected from cxl debugfs */
+	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
+		return -EINVAL;
+
+	rc = validate_error_type(val);
+	if (rc)
+		return rc;
+
 	error_type = val;
 
 	return 0;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 38441634e4c6..4ed4a24138c3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
+#include <einj.h>
 #include <cxl.h>
 #include "core.h"
 
@@ -783,6 +784,32 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	return rc;
 }
 
+DEFINE_SHOW_ATTRIBUTE(cxl_einj_available_error_type);
+
+static int cxl_einj_inject(void *data, u64 type)
+{
+	struct cxl_dport *dport = data;
+
+	if (dport->rch)
+		return cxl_einj_inject_rch_error(dport->rcrb.base, type);
+
+	if (!dev_is_pci(dport->dport_dev))
+		return -EINVAL;
+
+	return cxl_einj_inject_error(to_pci_dev(dport->dport_dev), type);
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
+
+static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
+{
+	struct dentry *dir;
+
+	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
+
+	debugfs_create_file("einj_inject", 0200, dir, dport,
+			    &cxl_einj_inject_fops);
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
@@ -1136,6 +1163,8 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 	} else {
 		dev_dbg(dport_dev, "dport added to %s\n",
 			dev_name(&port->dev));
+
+		cxl_debugfs_create_dport_dir(dport);
 	}
 
 	return dport;
@@ -1170,6 +1199,8 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 	} else {
 		dev_dbg(dport_dev, "RCH dport added to %s\n",
 			dev_name(&port->dev));
+
+		cxl_debugfs_create_dport_dir(dport);
 	}
 
 	return dport;
@@ -2109,6 +2140,8 @@ static __init int cxl_core_init(void)
 	int rc;
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
+	debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
+			    &cxl_einj_available_error_type_fops);
 
 	cxl_mbox_init();
 
diff --git a/drivers/cxl/einj.h b/drivers/cxl/einj.h
new file mode 100644
index 000000000000..b913763c3238
--- /dev/null
+++ b/drivers/cxl/einj.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CXL protocol Error INJection support.
+ *
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Ben Cheatham <benjamin.cheatham@amd.com>
+ */
+#ifndef CXL_EINJ_H
+#define CXL_EINJ_H
+#include <linux/pci.h>
+
+int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
+int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
+int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
+
+#if IS_ENABLED(CONFIG_CXL_EINJ)
+static inline int cxl_einj_available_error_type_show(struct seq_file *m,
+						     void *v)
+{
+	return einj_cxl_available_error_type_show(m, v);
+}
+
+static inline int cxl_einj_inject_error(struct pci_dev *dport_dev, u64 type)
+{
+	return einj_cxl_inject_error(dport_dev, type);
+}
+
+static inline int cxl_einj_inject_rch_error(u64 rcrb, u64 type)
+{
+	return einj_cxl_inject_rch_error(rcrb, type);
+}
+
+#else
+static inline int cxl_einj_available_error_type_show(struct seq_file *m,
+						     void *v)
+{
+	return -ENXIO;
+}
+
+static inline int cxl_einj_type_show(struct seq_file *m, void *data)
+{
+	return -ENXIO;
+}
+
+static inline int cxl_einj_inject_error(struct pci_dev *dport_dev, u64 type)
+{
+	return -ENXIO;
+}
+
+static inline int cxl_einj_inject_rch_error(u64 rcrb, u64 type)
+{
+	return -ENXIO;
+}
+#endif
+
+#endif
-- 
2.34.1


