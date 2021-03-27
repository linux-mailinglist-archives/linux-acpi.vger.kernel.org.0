Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F70A34B9DB
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Mar 2021 23:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhC0WUn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Mar 2021 18:20:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:3289 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231197AbhC0WUV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Mar 2021 18:20:21 -0400
IronPort-SDR: gPvA/MrXRu/6HY7200wvHED6r8hEkLfdZVo1ntczuLZ4PYOXHUhSrvyvnQ5/Gq9EY/0qiqiJul
 UDLh3oV202aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9936"; a="252690862"
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="252690862"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 15:20:20 -0700
IronPort-SDR: 12VvtQS48zmeJGUefaQrhNWO/GGZlYVIEZisJRhrGrEMfhfrYy+H4IjnxTJFnJ0hBI9Mt0W15O
 dmu4GKxNHsrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,284,1610438400"; 
   d="scan'208";a="454002272"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2021 15:20:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1D59710D1; Sun, 28 Mar 2021 00:20:28 +0200 (EET)
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
Subject: [PATCH v1 8/8] media: ipu3-cio2: Switch to use SOFTWARE_NODE_REFERENCE()
Date:   Sun, 28 Mar 2021 00:20:12 +0200
Message-Id: <20210327222012.54103-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is useful to assign software node reference with arguments
in a common way. Switch to use SOFTWARE_NODE_REFERENCE() here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

