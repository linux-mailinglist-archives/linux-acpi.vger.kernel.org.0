Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB8C66DD63
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 13:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbjAQMWS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 07:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjAQMWR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 07:22:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7992B607;
        Tue, 17 Jan 2023 04:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673958136; x=1705494136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TNAz2cqgFaXqjlPxK8X9IkOdWzQkM2gF5KFYWTN+1o4=;
  b=LxN+2YhuatoYA4+qmvMnJKZnIfAurhPZij7jv3nSCJ8P1Kzee6JbHdc7
   PGhCgMBVX2l0Pkf5PxCaF0fXEorn1G75MLz8YGbzMgJPceiVMtUA25Gyu
   BQh4mk8SGDcRTKbvTd8hejEiXO8SGOORiz9ZW1rrJiE7DrnKufRvzg8Sx
   WTU13FIaDVT2s6PCBjz6qrJZHQenXK5JLlUkyFvpv4um0LR67HMtHOhQ6
   J6gCQm0rNI+WtoN1DXzbfyrTZok3Tcreod1ikZnfKTVaIezxUayMEHQat
   D9EEav9Rd1HjZqhLsMbOyyc+HWy/uEE/+K+jfh0gux9vdml6oI8heXJmB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410920100"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="410920100"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="727772032"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="727772032"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:14 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id D3973205E4;
        Tue, 17 Jan 2023 14:22:11 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pHkzE-00AgVC-Kr; Tue, 17 Jan 2023 14:22:44 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH 3/8] device property: Add SOFTWARE_NODE() macro for defining software nodes
Date:   Tue, 17 Jan 2023 14:22:39 +0200
Message-Id: <20230117122244.2546597-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
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

