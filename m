Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053C968F1FB
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 16:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjBHP2u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 10:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBHP2s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 10:28:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1513772A0;
        Wed,  8 Feb 2023 07:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675870128; x=1707406128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Omzh3EBkFsKkaEjSu30BIFaElbuCTq5BekfLAtiEko=;
  b=JrPPDz3FBzAO1ITAEyOJ6ZN2uVgcBL9xizBHyiYhXfQRz3Pf1vdmPzp2
   uXBU0CNe2A1C5ko+6q3P51FwYKI7NQh7TmRFfR0ouhnL0RYPG8indwCuV
   QL1Pewe/pgEjhpWpcqSE/PoBcJ6YsfT9ZhWGL+qmY3gEiHVDfHofc6Wip
   N90Z6KJoOcI0Wn+zxMR9XnmQpsgmJP4z26wWOJSV3EZDHBrLX4qjt7yAr
   yB63HppP1GfptbNsULjIBKkfzR4jV6RnVsWNhiQXiK6NvvQ4JgTU+9+z6
   t7Fn3r9qe6e7R5nMfH8GAQdHvC1QPSQ0dVNKf0C0TOuFgug80VEESK6Z+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310182268"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310182268"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="617237829"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="617237829"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:44 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 0AC0A121915;
        Wed,  8 Feb 2023 17:28:42 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPmMr-00CrAJ-Gf; Wed, 08 Feb 2023 17:28:17 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v4 3/8] device property: Add SOFTWARE_NODE() macro for defining software nodes
Date:   Wed,  8 Feb 2023 17:28:02 +0200
Message-Id: <20230208152807.3064242-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add SOFTWARE_NODE() macro in order to make defining software nodes look
nicer. This is analogous to different PROPERTY_ENTRY_*() macros for
defining properties.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/property.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 37179e3abad5c..6745a86bc9b97 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -477,6 +477,13 @@ struct software_node {
 	const struct property_entry *properties;
 };
 
+#define SOFTWARE_NODE(_name_, _properties_, _parent_)	\
+	(struct software_node) {			\
+		.name = _name_,				\
+		.properties = _properties_,		\
+		.parent = _parent_,			\
+	}
+
 bool is_software_node(const struct fwnode_handle *fwnode);
 const struct software_node *
 to_software_node(const struct fwnode_handle *fwnode);
-- 
2.30.2

