Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0746C34D36A
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhC2PMS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 11:12:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:52885 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhC2PMH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Mar 2021 11:12:07 -0400
IronPort-SDR: csefPtpgNUM378g9UQojPKN/XRU7IEFdkyUhiNXdeia0TBN2X0sr9F3FL5Tndbtyfh7MLIV+cm
 /aw+T8n0+6YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191596399"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="191596399"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 08:12:06 -0700
IronPort-SDR: gFHeFxm344grZ9YU/23ywBO4rF8CqrYy8p5+xWVazmE9/3EFQR7Rv6rFGkzrjLVJGtuwhovocW
 jBA5y4xp4A+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="376460764"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2021 08:12:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B817CDD; Mon, 29 Mar 2021 18:12:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 6/6] media: ipu3-cio2: Switch to use SOFTWARE_NODE_REFERENCE()
Date:   Mon, 29 Mar 2021 18:12:07 +0300
Message-Id: <20210329151207.36619-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is useful to assign software node reference with arguments
in a common way. Switch to use SOFTWARE_NODE_REFERENCE() here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index c2199042d3db..e8511787c1e4 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -79,8 +79,8 @@ static void cio2_bridge_create_fwnode_properties(
 {
 	sensor->prop_names = prop_names;
 
-	sensor->local_ref[0].node = &sensor->swnodes[SWNODE_CIO2_ENDPOINT];
-	sensor->remote_ref[0].node = &sensor->swnodes[SWNODE_SENSOR_ENDPOINT];
+	sensor->local_ref[0] = SOFTWARE_NODE_REFERENCE(&sensor->swnodes[SWNODE_CIO2_ENDPOINT]);
+	sensor->remote_ref[0] = SOFTWARE_NODE_REFERENCE(&sensor->swnodes[SWNODE_SENSOR_ENDPOINT]);
 
 	sensor->dev_properties[0] = PROPERTY_ENTRY_U32(
 					sensor->prop_names.clock_frequency,
-- 
2.30.2

