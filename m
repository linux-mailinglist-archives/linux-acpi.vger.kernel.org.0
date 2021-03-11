Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20411336DBB
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Mar 2021 09:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhCKIZN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Mar 2021 03:25:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:49141 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhCKIZK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Mar 2021 03:25:10 -0500
IronPort-SDR: cuXYmVmzo89iPHPWwSEKp41iY1CvDQAM8QlPfvAdfuQj4Py2As37wgm6KzKBjbqiK9SSvjpeHj
 se4WWNJ8J4fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="208452863"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="208452863"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 00:25:10 -0800
IronPort-SDR: AkynqY7WYNcU+yGW8lQOBCIkWqsuOWj2cxHX0Qcnv5cSfLREbVCUSIcNA2eOZJlt4vOvy3yX5I
 jq1duGqnpFLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509954418"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2021 00:25:09 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add entry for the software nodes
Date:   Thu, 11 Mar 2021 11:25:21 +0300
Message-Id: <20210311082521.39342-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Making Andy and myself (Heikki) the designated reviewers of
the thing. The software node mailing list shall be
linux-acpi@vger.kernel.org for now.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f032f45bc9512..a76b6c926004e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16616,6 +16616,13 @@ F:	drivers/firmware/arm_sdei.c
 F:	include/linux/arm_sdei.h
 F:	include/uapi/linux/arm_sdei.h
 
+SOFTWARE NODES
+R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+L:	linux-acpi@vger.kernel.org
+S:	Maintained
+F:	drivers/base/swnode.c
+
 SOFTWARE RAID (Multiple Disks) SUPPORT
 M:	Song Liu <song@kernel.org>
 L:	linux-raid@vger.kernel.org
-- 
2.30.1

