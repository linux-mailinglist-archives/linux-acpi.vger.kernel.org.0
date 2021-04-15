Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96D1360B2F
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 15:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhDON7S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 09:59:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:60059 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhDON7S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Apr 2021 09:59:18 -0400
IronPort-SDR: CkolhUsRVbRTZ7UKT7r4VIbAwBhMhXg5SromWdjeazFTA+H6yiorYf8mumGVKuMfeqEOpnnctz
 k9rvN4HbosBg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="174961472"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="174961472"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:58:53 -0700
IronPort-SDR: 1Ero4IpCmY7zN/BTHjiLpTX2bZF4Yh00EOPhGr04YRY+PryaHh50jCkmxU7H3tJHVBvXgIoVkE
 ovqkuIFI+rDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="425186820"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 15 Apr 2021 06:58:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7C258BA; Thu, 15 Apr 2021 16:59:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
Date:   Thu, 15 Apr 2021 16:59:01 +0300
Message-Id: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Strictly speaking the comparison between guid_t and raw buffer
is not correct. Import GUID to variable of guid_t type and then
compare.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/nfit/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 958aaac869e8..6d8a1a93636a 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -678,10 +678,12 @@ static const char *spa_type_name(u16 type)
 
 int nfit_spa_type(struct acpi_nfit_system_address *spa)
 {
+	guid_t guid;
 	int i;
 
+	import_guid(&guid, spa->range_guid);
 	for (i = 0; i < NFIT_UUID_MAX; i++)
-		if (guid_equal(to_nfit_uuid(i), (guid_t *)&spa->range_guid))
+		if (guid_equal(to_nfit_uuid(i), &guid))
 			return i;
 	return -1;
 }
-- 
2.30.2

