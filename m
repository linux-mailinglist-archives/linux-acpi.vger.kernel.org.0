Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65059677CEB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjAWNrW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 08:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjAWNrG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 08:47:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6A2265A0;
        Mon, 23 Jan 2023 05:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674481603; x=1706017603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XzvtTpMJq0uXaTsKcQQzDEecD2kIN/gAK1rgKNIfjUc=;
  b=fqU4t6FRm3rLt/Vlx6WWDSMK7TwNEMzVnqIJzps0wVLC4dpVH29nRizU
   zI7pJSZSV3+1P4xYegAITQAmYYrsHXEjjeE/tgEwfqOtUVy8dZ6MuhvZW
   QhQW5alWJTV9LDbrRdZihDYDvMEda8nnTCLm9GKd0wLqGr8dj5yszDcgO
   uN+sJstOcCSrptT6AFRzsV6CUkz+/aY16z7I0yi69KzNxInrjX2LACKRy
   0oqWHRr8LlRnyZ00PenjH4/s3ckCBLEcLtfxrN4PmsEKGgNN3/7u/icSJ
   HzHpwUIYS8D6rkazYLrlZqTqOG7Vpq8j2XvP7VbwfwhG43I0Yio/1elCg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="390542160"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="390542160"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 05:46:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="785601922"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="785601922"
Received: from turnipsi.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 05:46:36 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id B5E3520CB0;
        Mon, 23 Jan 2023 15:46:33 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pJx9Y-00173P-20; Mon, 23 Jan 2023 15:46:28 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v2 3/8] device property: Add SOFTWARE_NODE() macro for defining software nodes
Date:   Mon, 23 Jan 2023 15:46:12 +0200
Message-Id: <20230123134617.265382-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
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

