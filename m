Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B447C2F23D2
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 01:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390900AbhALA0B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 19:26:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:57931 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390903AbhAKXCp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 18:02:45 -0500
IronPort-SDR: S/M48+TKmN+BdBJOdmFZkGRIrPI+H1Eb8zEFEludaFZKvbeCGbBbTcPnE+ecNDPMieX4emj9l2
 LFgMxOFQQfhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="196564946"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="196564946"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:01:25 -0800
IronPort-SDR: kGubCYlCfSM/8WYR0sgxK/WSFaTh72jgzicklg+hvHwn0UbBxmJCl/v1z/bLr6ovfOGdv2zin3
 nzi64MGvnZGA==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="381181278"
Received: from yyang31-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.142.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:01:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Mailbox Transport; Mon, 11 Jan 2021 14:51:43 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Jan 2021 14:51:42 -0800
Received: from fmsmga008.fm.intel.com (10.253.24.58) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Jan 2021 14:51:42 -0800
IronPort-SDR: kEPmQlJck7soFNnY4OmysN+yLBgksCzipRRYR833FRvRqvLuayPCtT4wcxhZVJmwBZx29pJo7T
 ejSBIM8E7wwQ==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352778034"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:39 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "Jon Masters" <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>
Subject: [RFC PATCH v3 11/16] taint: add taint for direct hardware access
Date:   Mon, 11 Jan 2021 14:51:15 -0800
Message-ID: <20210111225121.820014-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
Content-Transfer-Encoding: 7BIT
X-MS-Exchange-Organization-Network-Message-Id: 17b4e2db-9911-417e-d3c8-08d8b6837716
Content-Type:   text/plain; charset=US-ASCII
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-SCL: -1
X-MS-Exchange-Organization-AuthSource: ORSMSX609.amr.corp.intel.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Transport-EndToEndLatency: 00:00:01.1930372
X-MS-Exchange-Processed-By-BccFoldering: 15.01.1713.001
MIME-Version: 1.0
X-TUID: WLsKeG+bl5Oe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For drivers that moderate access to the underlying hardware it is
sometimes desirable to allow userspace to bypass restrictions. Once
userspace has done this, the driver can no longer guarantee the sanctity
of either the OS or the hardware. When in this state, it is helpful for
kernel developers to be made aware (via this taint flag) of this fact
for subsequent bug reports.

Example usage:
- Hardware xyzzy accepts 2 commands, waldo and fred.
- The xyzzy driver provides an interface for using waldo, but not fred.
- quux is convinced they really need the fred command.
- xyzzy driver allows quux to frob hardware to initiate fred.
  - kernel gets tainted.
- turns out fred command is borked, and scribbles over memory.
- developers laugh while closing quux's subsequent bug report.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/admin-guide/sysctl/kernel.rst   | 1 +
 Documentation/admin-guide/tainted-kernels.rst | 6 +++++-
 include/linux/kernel.h                        | 3 ++-
 kernel/panic.c                                | 1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1d56a6b73a4e..3e1eada53504 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1352,6 +1352,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
  32768  `(K)`  kernel has been live patched
  65536  `(X)`  Auxiliary taint, defined and used by for distros
 131072  `(T)`  The kernel was built with the struct randomization plugin
+262144  `(H)`  The kernel has allowed vendor shenanigans
 ======  =====  ==============================================================
 
 See :doc:`/admin-guide/tainted-kernels` for more information.
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index ceeed7b0798d..ee2913316344 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to the aforementioned
 script, but if you need something quick you can use this shell command to check
 which bits are set::
 
-	$ for i in $(seq 18); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
+	$ for i in $(seq 19); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
 
 Table for decoding tainted state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  15  _/K   32768  kernel has been live patched
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
+ 18  _/H  262144  kernel has allowed vendor shenanigans
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
@@ -175,3 +176,6 @@ More detailed explanation for tainting
      produce extremely unusual kernel structure layouts (even performance
      pathological ones), which is important to know when debugging. Set at
      build time.
+
+ 18) ``H`` Kernel has allowed direct access to hardware and can no longer make
+     any guarantees about the stability of the device or driver.
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f7902d8c1048..bc95486f817e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -443,7 +443,8 @@ extern enum system_states {
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_RAW_PASSTHROUGH		18
+#define TAINT_FLAGS_COUNT		19
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index 332736a72a58..dff22bd80eaf 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -386,6 +386,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_RAW_PASSTHROUGH ]	= { 'H', ' ', true },
 };
 
 /**
-- 
2.30.0

