Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAEF3165A8
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 12:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBJLvS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 06:51:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:64430 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhBJLtB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 06:49:01 -0500
IronPort-SDR: SSi05y+sTmDcrqvLKPVbUwy0FDgO97qkKbu+fLxx+EMnPUfI+8F2xbkBx+eGsWLn5aMMO1G8nq
 eRAKblJNDHgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="169181917"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="169181917"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 03:43:36 -0800
IronPort-SDR: vsAvMH9/oRNgKCElQhKCw64FRSzP8p8ckNi6QPc3GTgVrLW0AKEOMExsh94BJpuvuHS/1LhcvH
 Am/cYDa4ZyYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="488729862"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2021 03:43:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 71064525; Wed, 10 Feb 2021 13:43:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>
Subject: [PATCH v1 7/7] ACPI: property: Allow counting a single value as an array of 1 element
Date:   Wed, 10 Feb 2021 13:43:20 +0200
Message-Id: <20210210114320.3478-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We allow to read the single value as a first element in the array.
Unfortunately the counting doesn't work in this case and we can't
call fwnode_property_count_*() API without getting an error.

Modify acpi_data_prop_read() to always try the single value read
and thus allow counting the single value as an array of 1 element.

Reported-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 236316ee0e25..d6100585fceb 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -913,12 +913,14 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 	const union acpi_object *items;
 	int ret;
 
-	if (val && nval == 1) {
+	/* Try to read as a single value first */
+	if (!val || nval == 1) {
 		ret = acpi_data_prop_read_single(data, propname, proptype, val);
 		if (ret >= 0)
-			return ret;
+			return val ? ret : 1;
 	}
 
+	/* It's not the single value, get an array instead */
 	ret = acpi_data_get_property_array(data, propname, ACPI_TYPE_ANY, &obj);
 	if (ret)
 		return ret;
-- 
2.30.0

