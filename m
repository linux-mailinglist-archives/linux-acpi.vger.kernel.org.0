Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430022EA71D
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 10:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbhAEJNf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 04:13:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:50270 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbhAEJNe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Jan 2021 04:13:34 -0500
IronPort-SDR: 0UPKj7s3m7zymyBdS34bu8tvu8o6ytEKJOAtlOWkBgvA5rEZpvlCtCzIKuBzN/i6pUl8xSfazk
 +Ltt8XYlbV5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156862072"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="156862072"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:11:49 -0800
IronPort-SDR: rd5cUvd4ZnqdyMmHos4rkmJ1zUzJYRrc9eAo6Y2alNpRklkOWV6NInOt9mn3BeaG1XdzylEciZ
 yasHxqpMCU+g==
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="378794963"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:11:47 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
        heikki.krogerus@linux.intel.com, rafael@kernel.org
Cc:     bard.liao@intel.com
Subject: [PATCH 1/2] Revert "device property: Keep secondary firmware node secondary by type"
Date:   Tue,  5 Jan 2021 17:11:45 +0800
Message-Id: <20210105091146.25422-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105091146.25422-1-yung-chuan.liao@linux.intel.com>
References: <20210105091146.25422-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While the commit d5dcce0c414f ("device property: Keep secondary firmware
node secondary by type")
describes everything correct in its commit message the change it made does
the opposite and original commit c15e1bdda436 ("device property: Fix the
secondary firmware node handling in set_primary_fwnode()") was fully
correct. Thus, revert the former one here and improve documentation in
the next patch.

Fixes: d5dcce0c414f ("device property: Keep secondary firmware node secondary by type")
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 25e08e5f40bd..51b9545a050b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4433,7 +4433,7 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 		if (fwnode_is_primary(fn)) {
 			dev->fwnode = fn->secondary;
 			if (!(parent && fn == parent->fwnode))
-				fn->secondary = ERR_PTR(-ENODEV);
+				fn->secondary = NULL;
 		} else {
 			dev->fwnode = NULL;
 		}
-- 
2.17.1

