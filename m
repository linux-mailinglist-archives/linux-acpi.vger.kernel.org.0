Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BFC355E61
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhDFWFT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:54928 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238704AbhDFWFS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:18 -0400
IronPort-SDR: BW6DEGHHXYRB6ijb6WsKYeAyhKgzAhWi9XledNuU8OlH0UG5bjsayS1atlcmSYzW/PjiErbnkx
 j0VaJGjGZw2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640455"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640455"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:08 -0700
IronPort-SDR: lLPQGmszTFNB3XMSZZ5b+OsrW2evpqhY9zsxhbde3eU5pBO9+ltFBq/aqULyqD1hOM22l6fqlF
 +Cit3URZnpvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581716"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 03/22] ACPICA: ACPI 6.4: add USB4 capabilities UUID
Date:   Tue,  6 Apr 2021 14:30:09 -0700
Message-Id: <20210406213028.718796-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 619e6df02edbebe95b2765cdd5159f02607e45fc

This change allows iASL to a list of know UUID's. iASL uses this list
to point out any UUID's that are not publically known.

Link: https://github.com/acpica/acpica/commit/619e6df0
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acuuid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index a5c2ca019a12..bc24388ce94e 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -68,5 +68,6 @@
 #define UUID_DEVICE_GRAPHS              "ab02a46b-74c7-45a2-bd68-f7d344ef2153"
 #define UUID_HIERARCHICAL_DATA_EXTENSION "dbb8e3e6-5886-4ba6-8795-1319f52a966b"
 #define UUID_CORESIGHT_GRAPH            "3ecbc8b6-1d0e-4fb3-8107-e627f805c6cd"
+#define UUID_USB4_CAPABILITIES          "23a0d13a-26ab-486c-9c5f-0ffa525a575a"
 
 #endif				/* __ACUUID_H__ */
-- 
2.29.2

