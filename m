Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830E368F9AE
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 22:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjBHV1y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 16:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjBHV1x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 16:27:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0461C7DB;
        Wed,  8 Feb 2023 13:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675891673; x=1707427673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Omzh3EBkFsKkaEjSu30BIFaElbuCTq5BekfLAtiEko=;
  b=k3IitpGLQuuENP62H3hDzsW6Fwpl9/UBG2+el0x3A+wFMNb0Qvn/6cUf
   34UFOMfUOHuW7mehtn628Gb2x54HG+11o86HfKXhG/F8n02nkhY61hoeT
   NrqD5JQH+1dnrmVvKo6tV6RfyUr37g2fOql5pc+AfTYC7AicxJyZ+K7H0
   AKKw4qj4ZxhT1r+U4nBFm/qMOI3QgdNfq+TEQBTXcIrpx400FpOj7F5rr
   mkHalSXzUMKKwKc639JkyFrOzLOm0nbllyu4kH2TLks9GSmvGBy5ZIJbF
   TnkgFVG0Txj9C0m+xaHxkjTUEYgGlsVvxrJK8k77AesKWumQqpAijDfBx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="313566169"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="313566169"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:27:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="756180456"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="756180456"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:27:49 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id B619C122811;
        Wed,  8 Feb 2023 23:27:47 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPryM-00DMZG-Qi; Wed, 08 Feb 2023 23:27:22 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v5 3/8] device property: Add SOFTWARE_NODE() macro for defining software nodes
Date:   Wed,  8 Feb 2023 23:27:07 +0200
Message-Id: <20230208212712.3184953-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
References: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

