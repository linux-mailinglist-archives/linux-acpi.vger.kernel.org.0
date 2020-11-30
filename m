Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293712C8E65
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 20:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgK3Tsa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 14:48:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:18516 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgK3Tsa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Nov 2020 14:48:30 -0500
IronPort-SDR: KZ/oxSGdfh5OF/l7osVHwEjepXTeXnQkYm/z072eQHXC87X8JSS/27dOigaIYJNOw+DBP8vENZ
 EEilWazL7uRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151954732"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151954732"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:47:49 -0800
IronPort-SDR: RZGJ6XKIOo4T4uaOBma4EwnXA7UglfaiAX3AfgQccRtzCnsHZV8sUqEIJGlyHHI+D7tktO2W2Q
 KCeaRUhp3Cmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="404844846"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2020 11:47:49 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/6] ACPICA version 20201113
Date:   Mon, 30 Nov 2020 11:20:42 -0800
Message-Id: <20201130192048.3093726-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch series contains the linux-ized release of ACPICA version
20201113. For Linux, the most notable change is a fix in a memory
leak that occurs when evaluating _CID as well as handling orphan _REG
methods for GPIO OperationRegions.

Bob Moore (2):
  ACPICA: Add 5 new UUIDs to the known UUID table
  ACPICA: Update version to 20201113

Colin Ian King (1):
  ACPICA: Remove extreaneous "the" in comments

Erik Kaneda (2):
  ACPICA: Add function trace macros to improve debugging
  ACPICA: Interpreter: fix memory leak by using use existing buffer

Hans de Goede (1):
  ACPICA: Also handle "orphan" _REG methods for GPIO OpRegions

 drivers/acpi/acpica/accommon.h  |  2 +-
 drivers/acpi/acpica/evregion.c  | 54 ++++++++++++++++-----------------
 drivers/acpi/acpica/nspredef.c  | 10 +++---
 drivers/acpi/acpica/nsprepkg.c  | 38 ++++++++++++-----------
 drivers/acpi/acpica/nsrepair2.c | 39 +++++++++++-------------
 include/acpi/acpixf.h           |  2 +-
 include/acpi/acuuid.h           |  5 +++
 7 files changed, 77 insertions(+), 73 deletions(-)

-- 
2.25.1

