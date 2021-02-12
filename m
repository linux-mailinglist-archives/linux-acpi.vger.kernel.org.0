Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8946F31A07A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 15:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhBLORY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 09:17:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:44070 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232045AbhBLORE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 09:17:04 -0500
IronPort-SDR: GvgyzfJQMryv3XuImxt8wLR3v9fzFDTmzQ2ftS6KwToIjy5u8aRA5LnQ9cKSEZyDa8ohINUBJl
 n1gNHYS9uQ/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="246483867"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="246483867"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 06:11:37 -0800
IronPort-SDR: cM62hL94wrmVdz258pXNXcsB5XhwZiA5XBxPQ7Vcz/aoiNLBjYID0O5hQ2DFOs9RrJ+9itcJQU
 +OkFaM8cjPUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="360386123"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 12 Feb 2021 06:11:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9E47935A; Fri, 12 Feb 2021 16:11:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 3/5] ACPI: property: Satisfy kernel doc validator (part 1)
Date:   Fri, 12 Feb 2021 16:11:19 +0200
Message-Id: <20210212141121.62115-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
References: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CHECK   drivers/acpi/property.c
 warning: Function parameter or member 'data' not described in 'acpi_data_get_property_array'
 warning: Excess function parameter 'adev' description in 'acpi_data_get_property_array'

Fixes: 3a7a2ab839ad ("ACPI / property: Extend fwnode_property_* to data-only subnodes")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 2b65ad9b4c0d..ab4d7c734b0d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -564,7 +564,7 @@ int acpi_node_prop_get(const struct fwnode_handle *fwnode,
 
 /**
  * acpi_data_get_property_array - return an ACPI array property with given name
- * @adev: ACPI data object to get the property from
+ * @data: ACPI data object to get the property from
  * @name: Name of the property
  * @type: Expected type of array elements
  * @obj: Location to store a pointer to the property value (if not NULL)
-- 
2.30.0

