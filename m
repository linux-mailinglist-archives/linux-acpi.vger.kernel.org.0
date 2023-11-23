Return-Path: <linux-acpi+bounces-1805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D227F6672
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 19:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006131C20E16
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622A14B5CF
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F810DB;
	Thu, 23 Nov 2023 09:44:16 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sblk51lXTz6K5sT;
	Fri, 24 Nov 2023 01:39:57 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 Nov 2023 17:44:13 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 11/11] cxl: scrub: sysfs: Add Documentation for CXL memory device scrub control attributes
Date: Fri, 24 Nov 2023 01:43:54 +0800
Message-ID: <20231123174355.1176-12-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231123174355.1176-1-shiju.jose@huawei.com>
References: <20231123174355.1176-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected

From: Shiju Jose <shiju.jose@huawei.com>

Add sysfs documentation for the CXL memory device scrub control
attributes those are exposed in /sys/class/scrub/ by the scrub
driver. These attributes support user configuring a CXL memory
device scrub.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../testing/sysfs-class-cxl-scrub-configure   | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-cxl-scrub-configure

diff --git a/Documentation/ABI/testing/sysfs-class-cxl-scrub-configure b/Documentation/ABI/testing/sysfs-class-cxl-scrub-configure
new file mode 100644
index 000000000000..57ba63d5390f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-cxl-scrub-configure
@@ -0,0 +1,135 @@
+What:		/sys/class/scrub/
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The scrub/ class subdirectory belongs to the scrub
+		subsystem.
+
+What:		/sys/class/scrub/scrubX/
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The /sys/class/scrub/scrub{0,1,2,3,...} directories
+		correspond to each scrub device.
+
+What:		/sys/class/scrub/scrubX/name
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) name of the memory scrub device
+
+What:		/sys/class/scrub/scrubX/regionY/
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The /sys/class/scrub/scrubX/region{0,1,2,3,...}
+		directories correspond to each scrub region under a scrub device.
+		Scrub region is a physical address range or for example
+		memory media FRU of DDR5 ECS feature for which scrub may be
+		separately controlled.
+
+What:		/sys/class/scrub/scrubX/regionY/enable
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(WO) Start/Stop CXL memory patrol scrub.
+		1 - enable the CXL memory patrol scrub.
+		0 - disable the CXL memory patrol scrub.
+
+What:		/sys/class/scrub/scrubX/regionY/speed
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The scrub cycle to set for the CXL memory
+		patrol scrub and it must be within the supported
+		range. The unit of the scrub cycle is hour.
+
+What:		/sys/class/scrub/scrubX/regionY/speed_available
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Supported range of the scrub cycle by the
+		CXL memory patrol scrub.
+		The unit of the scrub cycle is hour.
+
+What:		/sys/class/scrub/scrubX/regionY/ecs_log_entry_type
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The log entry type of how the DDR5 ECS log is
+		reported.
+		00b - per DRAM.
+		01b - per memory media FRU.
+
+What:		/sys/class/scrub/scrubX/regionY/ecs_log_entry_type_per_dram
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current log entry type of DDR5 ECS
+		region is per DRAM.
+
+What:		/sys/class/scrub/scrubX/regionY/ecs_log_entry_type_per_memory_media
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current log entry type of DDR5 ECS
+		region is per memory media FRU.
+
+What:		/sys/class/scrub/scrubX/regionY/mode
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The mode of how the DDR5 ECS counts the errors.
+		0 - ECS counts rows with errors.
+		1 - ECS counts codewords with errors.
+
+What:		/sys/class/scrub/scrubX/regionY/mode_counts_rows
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current mode of DDR5 ECS region
+		is counts rows with errors.
+
+What:		/sys/class/scrub/scrubX/regionY/mode_counts_codewords
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current mode of DDR5 ECS region
+		is counts codewords with errors.
+
+What:		/sys/class/scrub/scrubX/regionY/reset_counter
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(WO) DDR5 ECS reset ECC counter.
+		0 - normal, ECC counter running actively.
+		1 - reset ECC counter to the default value.
+
+What:		/sys/class/scrub/scrubX/regionY/threshold
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) DDR5 ECS threshold count per GB of memory cells.
+
+What:		/sys/class/scrub/scrubX/regionY/threshold_available
+Date:		November 2023
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Supported list of DDR5 ECS threshold count per GB of
+		memory cells.
-- 
2.34.1


