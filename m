Return-Path: <linux-acpi+bounces-2027-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD217FFCB8
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 21:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B32B20AB6
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E5B4878B
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC14D40;
	Thu, 30 Nov 2023 11:23:28 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh5gp4CmFz6JB3w;
	Fri,  1 Dec 2023 03:23:02 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id BA18114058E;
	Fri,  1 Dec 2023 03:23:25 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 19:23:24 +0000
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
Subject: [PATCH v4 00/11] cxl: Add support for CXL feature commands, CXL device patrol scrub control and DDR5 ECS control features
Date: Fri, 1 Dec 2023 03:23:02 +0800
Message-ID: <20231130192314.1220-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

1. Add support for CXL feature mailbox commands.
2. Add CXL device scrub driver supporting patrol scrub control and DDR5 ECS
control features.
3. Add scrub driver supports configuring memory scrubs in the system.
4. Add scrub attributes for DDR5 ECS control to the memory scrub driver.
5. Register CXL device patrol scrub and ECS with scrub control driver.
6. Add documentation for common attributes in the scrub configure driver.
7. Add documentation for CXL memory device scrub control attributes.

Changes
v3 -> v4:
1. Fixes for the warnings/errors reported by kernel test robot.
2. Add support for reading the 'enable' attribute of CXL patrol scrub.

Changes
v2 -> v3:
1. Changes for comments from Davidlohr, Thanks.
 - Updated cxl scrub kconfig
 - removed usage of the flag is_support_feature from
   the function cxl_mem_get_supported_feature_entry().
 - corrected spelling error.
 - removed unnecessary debug message.
 - removed export feature commands to the userspace.
2. Possible fix for the warnings/errors reported by kernel
   test robot.
3. Add documentation for the common scrub configure atrributes.

v1 -> v2:
1. Changes for comments from Dave Jiang, Thanks.
 - Split patches.
 - reversed xmas tree declarations.
 - declared flags as enums.
 - removed few unnecessary variable initializations.
 - replaced PTR_ERR_OR_ZERO() with IS_ERR() and PTR_ERR().
 - add auto clean declarations.
 - replaced while loop with for loop.
 - Removed allocation from cxl_get_supported_features() and
   cxl_get_feature() and make change to take allocated memory
   pointer from the caller.
 - replaced if/else with switch case.
 - replaced sprintf() with sysfs_emit() in 2 places.
 - replaced goto label with return in few functions.
2. removed unused code for supported attributes from ecs.
3. Included following common patch for scrub configure driver
   to this series.
   "memory: scrub: Add scrub driver supports configuring memory scrubbers
    in the system"

Shiju Jose (11):
  cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
  cxl/mbox: Add GET_FEATURE mailbox command
  cxl/mbox: Add SET_FEATURE mailbox command
  cxl/memscrub: Add CXL device patrol scrub control feature
  cxl/memscrub: Add CXL device DDR5 ECS control feature
  memory: scrub: Add scrub driver supports configuring memory scrubs in
    the system
  cxl/memscrub: Register CXL device patrol scrub with scrub configure
    driver
  memory: scrub: Add scrub control attributes for the DDR5 ECS
  cxl/memscrub: Register CXL device DDR5 ECS with scrub configure driver
  memory: scrub: sysfs: Add Documentation for set of common scrub
    attributes
  cxl: scrub: sysfs: Add Documentation for CXL memory device scrub
    control attributes

 .../testing/sysfs-class-cxl-scrub-configure   |   79 ++
 .../ABI/testing/sysfs-class-scrub-configure   |   82 ++
 drivers/cxl/Kconfig                           |   23 +
 drivers/cxl/core/Makefile                     |    1 +
 drivers/cxl/core/mbox.c                       |   59 +
 drivers/cxl/core/memscrub.c                   | 1002 +++++++++++++++++
 drivers/cxl/cxlmem.h                          |  120 ++
 drivers/cxl/pci.c                             |    6 +
 drivers/memory/Kconfig                        |    1 +
 drivers/memory/Makefile                       |    1 +
 drivers/memory/scrub/Kconfig                  |   11 +
 drivers/memory/scrub/Makefile                 |    6 +
 drivers/memory/scrub/memory-scrub.c           |  481 ++++++++
 include/memory/memory-scrub.h                 |   90 ++
 14 files changed, 1962 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-cxl-scrub-configure
 create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
 create mode 100644 drivers/cxl/core/memscrub.c
 create mode 100644 drivers/memory/scrub/Kconfig
 create mode 100644 drivers/memory/scrub/Makefile
 create mode 100755 drivers/memory/scrub/memory-scrub.c
 create mode 100755 include/memory/memory-scrub.h

-- 
2.34.1


