Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0037A72D
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhEKM4T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 08:56:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:3548 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhEKM4S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 May 2021 08:56:18 -0400
IronPort-SDR: g3Z521J314bxV6/6Se9fUAju4VTFn3Vq1nw4BJX8z0XVnDVPySGdBiLEL1d/FTc/JyXvhjKeGK
 ahn3j2hrE2TQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199497662"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199497662"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:55:12 -0700
IronPort-SDR: paY5nt11JMPLo/R7PxT8KvmylfGEyj0erqLxvznsoYF093hI/T9ubgbtSGaOMftunmZj3R3IP5
 3P2B52UGscBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="537014258"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2021 05:55:07 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI/IORT: Handle device properties with software node API
Date:   Tue, 11 May 2021 15:55:28 +0300
Message-Id: <20210511125528.18525-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The older device property API is going to be removed.
Replacing the device_add_properties() call with software
node API equivalent device_create_managed_software_node().

Fixes: 434b73e61cc6 ("iommu/arm-smmu-v3: Use device properties for pasid-num-bits")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3912a1f6058e5..e34937e11186a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -976,7 +976,7 @@ static void iort_named_component_init(struct device *dev,
 				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
 						nc->node_flags));
 
-	if (device_add_properties(dev, props))
+	if (device_create_managed_software_node(dev, props, NULL))
 		dev_warn(dev, "Could not add device properties\n");
 }
 
-- 
2.30.2

