Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D998A3165A9
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 12:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBJLvW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 06:51:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:24123 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhBJLtB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 06:49:01 -0500
IronPort-SDR: QUd48rqjBXst2QXEx5j2x77Aq/JLO9/ONQ+zw+Q6S6Mcl9RVqgfsQ6m9JaxpigZjLY10hjE/jA
 9+H/HLykmswA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="246122909"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="246122909"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 03:43:34 -0800
IronPort-SDR: fmT3ddd9slATGK1BkhnsvO+nHZRfHFKqO2xUDALiZdOuFbK0gsZ+3lhpZD5IGXTFyoRI9uF3rY
 qynayBIBqBgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="396674874"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 10 Feb 2021 03:43:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4EF4A2BE; Wed, 10 Feb 2021 13:43:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/7] ACPI: property: Satisfy kernel doc validator (part 1)
Date:   Wed, 10 Feb 2021 13:43:16 +0200
Message-Id: <20210210114320.3478-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
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
index 9304c88ce446..a6b096575fc8 100644
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

