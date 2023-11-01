Return-Path: <linux-acpi+bounces-1129-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B197DDF6D
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 11:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02FAB20995
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BBF7462
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fug97fgu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C96FDF
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 09:07:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A59E121
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698829667; x=1730365667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lf2DeuIuVeem6mH16UyF2feA5lfIQF4u4qmvUR3qUw4=;
  b=fug97fguwY3DhIV0JznMgabCHbek3XPlWTH8Ln0fVK+D9xTVBkU0a7ce
   SRwBBK3etZID509qVCYuuPizjNch4tZJEPX0WWRF7ZvPEdGo8YHmnIqde
   gCVJdZltR4B/Vt0/cz8BwSKHcgi8sMdZKxhm4hcJMOsU5/08u3t7Ycooh
   2+2IB2QaTbi8ZwqtzKvwkT9YiBsL1o+ccPA4hGi/5su7B8ZteQ23ZA5Sy
   FlY6XoZoBPuvANriLTXjAXJPVsvnJajshA+KBWGqD2rsRf7YdZw6t948c
   XSVOhKRslnxm39eEGz917CEyqWiRAgPziU5uuICbONaztAMpGYc1oo9JX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="7088617"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="7088617"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="884500010"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="884500010"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:07:44 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 800F1120BDC;
	Wed,  1 Nov 2023 11:07:40 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/3] device property: fwnode_property_get_reference allows NULL args now
Date: Wed,  1 Nov 2023 11:07:37 +0200
Message-Id: <20231101090737.1148303-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
References: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All three fwnode_property_get_reference() now allow args argument to be
NULL. Document this.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 89a6e0833356..b39d3ae04877 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -508,6 +508,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
  * @nargs:	Number of arguments. Ignored if @nargs_prop is non-NULL.
  * @index:	Index of the reference, from zero onwards.
  * @args:	Result structure with reference and integer arguments.
+ *		May be NULL.
  *
  * Obtain a reference based on a named property in an fwnode, with
  * integer arguments.
-- 
2.39.2


