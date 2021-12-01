Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E821F464E4D
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 13:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349436AbhLANCB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 08:02:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:2470 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244869AbhLANB7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Dec 2021 08:01:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="297252705"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="297252705"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:37 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="596320511"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:36 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 74DE3206DC;
        Wed,  1 Dec 2021 14:58:34 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1msPCw-003vl2-Ow; Wed, 01 Dec 2021 14:59:34 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        rafael@kernel.org
Subject: [PATCH v2 0/7] Small device property fixes and improvements
Date:   Wed,  1 Dec 2021 14:59:28 +0200
Message-Id: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello everyone,

Here's a few small fixes and improvements for device properties.

since v1:

- Use labelled references.

- Avoid using continue in fwnode_graph_get_endpoint_count().

- Rewrap lines in data node reference example.

Sakari Ailus (7):
  device property: Fix fwnode_graph_devcon_match() fwnode leak
  device property: Fix documentation for FWNODE_GRAPH_DEVICE_DISABLED
  Documentation: ACPI: Fix data node reference documentation
  Documentation: ACPI: Update references
  device property: Implement fwnode_graph_get_endpoint_count()
  device property: Use fwnode_graph_for_each_endpoint() macro
  device property: Drop fwnode_graph_get_remote_node()

 .../acpi/dsd/data-node-references.rst         | 28 +++---
 .../firmware-guide/acpi/dsd/graph.rst         | 40 ++++-----
 .../firmware-guide/acpi/dsd/leds.rst          | 40 ++++-----
 Documentation/firmware-guide/acpi/dsd/phy.rst | 28 +++---
 drivers/base/property.c                       | 89 +++++++++----------
 drivers/staging/media/tegra-video/vi.c        | 12 ++-
 include/linux/property.h                      |  8 +-
 7 files changed, 119 insertions(+), 126 deletions(-)

-- 
2.30.2

