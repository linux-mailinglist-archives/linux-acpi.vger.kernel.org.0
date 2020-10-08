Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6613A286D1F
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 05:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgJHDWD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 23:22:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:29857 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgJHDWC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Oct 2020 23:22:02 -0400
IronPort-SDR: hjWMYFk3WS2MZsjGA/zUjrWiyh9KxeB0FVVyamw/34cni44l0KzI7lb602by6qPaZPVCZTBPdr
 mbGEIgzGYrJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162613645"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="162613645"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 20:22:01 -0700
IronPort-SDR: 9CsDmXHpwhbYGo/seVvjMlT5AtQB8ewSFORmH0Sa0QdApLsPMNwoPtxtvsHmUYk7WpuVjWwcDg
 82sGkv9M0Dwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355229343"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 20:22:01 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 5/9] ACPICA: acpi_help: Update UUID list
Date:   Wed,  7 Oct 2020 19:53:59 -0700
Message-Id: <20201008025403.2401736-6-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008025403.2401736-1-erik.kaneda@intel.com>
References: <20201008025403.2401736-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Added the following UUID's

Memory Device
Generic Buttons Device
NVDIMM Root Device
Control Method Battery
Device Graphs for _DSD method
Hierarchical Data Extension
ARM core_sight Graph UUID

This commit squashes the following ACPICA commits:
93e9aa864a7c5e10db876a9af3f2086e50cc6cf5
759aaf73942af4a1a0d13715ce5e6b054af351fa
24751ce4cf3089a7c1709e4986bc82dfb5cca7bc

Link: https://github.com/acpica/acpica/commit/93e9aa86
Link: https://github.com/acpica/acpica/commit/759aaf73
Link: https://github.com/acpica/acpica/commit/24751ce4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acuuid.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 9e1367b19069..10e30a5030ee 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -27,6 +27,10 @@
 #define UUID_PCI_HOST_BRIDGE            "33db4d5b-1ff7-401c-9657-7441c03dd766"
 #define UUID_I2C_DEVICE                 "3cdff6f7-4267-4555-ad05-b30a3d8938de"
 #define UUID_POWER_BUTTON               "dfbcf3c5-e7a5-44e6-9c1f-29c76f6e059c"
+#define UUID_MEMORY_DEVICE              "03b19910-f473-11dd-87af-0800200c9a66"
+#define UUID_GENERIC_BUTTONS_DEVICE     "fa6bd625-9ce8-470d-a2c7-b3ca36c4282e"
+#define UUID_NVDIMM_ROOT_DEVICE         "2f10e7a4-9e91-11e4-89d3-123b93f75cba"
+#define UUID_CONTROL_METHOD_BATTERY     "f18fc78b-0f15-4978-b793-53f833a1d35b"
 
 /* Interfaces */
 
@@ -56,5 +60,8 @@
 #define UUID_BATTERY_THERMAL_LIMIT      "4c2067e3-887d-475c-9720-4af1d3ed602e"
 #define UUID_THERMAL_EXTENSIONS         "14d399cd-7a27-4b18-8fb4-7cb7b9f4e500"
 #define UUID_DEVICE_PROPERTIES          "daffd814-6eba-4d8c-8a91-bc9bbf4aa301"
+#define UUID_DEVICE_GRAPHS              "ab02a46b-74c7-45a2-bd68-f7d344ef2153"
+#define UUID_HIERARCHICAL_DATA_EXTENSION "dbb8e3e6-5886-4ba6-8795-1319f52a966b"
+#define UUID_CORESIGHT_GRAPH            "3ecbc8b6-1d0e-4fb3-8107-e627f805c6cd"
 
 #endif				/* __ACUUID_H__ */
-- 
2.25.1

