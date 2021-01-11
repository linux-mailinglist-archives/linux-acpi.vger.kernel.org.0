Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C932F23D8
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 01:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbhALA0C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 19:26:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:57931 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403774AbhAKXDY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 18:03:24 -0500
IronPort-SDR: aHUeHg2TXdVIvu+6hsztscIPFRvP8KZJErZe1QsEc3oaxIORG9Upf8f0bH472mjZrsCLwVH4jD
 0zzui0ahys8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="196564991"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="196564991"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:01:34 -0800
IronPort-SDR: ufzfRJUJ+TdpidumJldS4pvqx/OJZOAWeK7WGRJEQLg56GcR8vDWYLRVpbERSBLhX2gy+rwCJ0
 JftDuSBbgb6g==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="381181349"
Received: from yyang31-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.142.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:01:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Mailbox Transport; Mon, 11 Jan 2021 14:51:47 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Jan 2021 14:51:46 -0800
Received: from fmsmga008.fm.intel.com (10.253.24.58) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Jan 2021 14:51:46 -0800
IronPort-SDR: VdJ05s1NChzHk7duOIerNMDumd6j1VR5FhcSlVVNOvy50xDDnztFRh35l+lpp5z3CnuayyejMB
 7y40Iq17FxrQ==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352778061"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:45 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>
Subject: [RFC PATCH v3 16/16] MAINTAINERS: Add maintainers of the CXL driver
Date:   Mon, 11 Jan 2021 14:51:21 -0800
Message-ID: <20210111225121.820014-18-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
Content-Transfer-Encoding: 7BIT
X-MS-Exchange-Organization-Network-Message-Id: eca87aa2-6e18-45ad-ea96-08d8b683795e
Content-Type:   text/plain; charset=US-ASCII
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-SCL: -1
X-MS-Exchange-Organization-AuthSource: fmsmsx609.amr.corp.intel.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Transport-EndToEndLatency: 00:00:00.5476929
X-MS-Exchange-Processed-By-BccFoldering: 15.01.1713.001
MIME-Version: 1.0
X-TUID: i407kUBA2Pj9
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..70c7ec4b2921 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4459,6 +4459,16 @@ F:	fs/configfs/
 F:	include/linux/configfs.h
 F:	samples/configfs/
 
+COMPUTE EXPRESS LINK (CXL)
+M:	Vishal Verma <vishal.l.verma@intel.com>
+M:	Ira Weiny <ira.weiny@intel.com>
+M:	Ben Widawsky <ben.widawsky@intel.com>
+M:	Dan Williams <dan.j.williams@intel.com>
+L:	linux-cxl@vger.kernel.org
+S:	Maintained
+F:	drivers/cxl/
+F:	include/uapi/linux/cxl_mem.h
+
 CONSOLE SUBSYSTEM
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 S:	Supported
-- 
2.30.0

