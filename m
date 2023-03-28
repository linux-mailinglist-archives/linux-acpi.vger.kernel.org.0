Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285106CBC40
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 12:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjC1KOG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 06:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjC1KN4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 06:13:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DD172AA;
        Tue, 28 Mar 2023 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679998418; x=1711534418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r323+DQEI8BsS8jV9Pe4FLB/ceIhXeIT8ZS/n2SUNiA=;
  b=Z2WGs8CsN4H6/Cppdi2TWIMJ1MjVMKOFTP8Do1JhRb2MyhF1RTNxkQex
   LgErbtFXTKpYV/xFSrm70a3iqBZpfBGSfcscuGVd+fvjWFVJ/Dj6tiU89
   Tb6FsctVHZ5NvzcmlVg71BKj84HpuPeefXW2ohf/5OhcFh2I6/o8m3V37
   Ih7RNxaRvmbjdK4aB7MmM6O0H8Kgpjoi2HN2wITzhtj3kKAOLzQqDAYSO
   Lb1GZOVt+u1QCPcpTrT4JcNssrWMfm10WZlNzjfxVZ1Mw1CLzWJ4dPT0P
   hWr7mieCxf9IyggNCNz5uGJxMMmzhne7+Lj/ci8vlN/k1dDEybi5rv5GP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328985340"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="328985340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827432692"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827432692"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:12 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 39C41122499;
        Tue, 28 Mar 2023 13:13:09 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v7 04/10] device property: Add SOFTWARE_NODE() macro for defining software nodes
Date:   Tue, 28 Mar 2023 13:12:57 +0300
Message-Id: <20230328101303.1458570-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 0a29db15ff34..b2562f512c49 100644
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

