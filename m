Return-Path: <linux-acpi+bounces-1175-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2117E018F
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 11:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04DAB212CC
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815A154A3
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIe/8oeE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D06FB5
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 08:36:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39900D44
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699000596; x=1730536596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q1rFDdn055YhUM6w8twK1/O3m+2EDsWdczT++7HzALY=;
  b=AIe/8oeEe9sF93RTx9r2SLvx/YhnABA82/Me+s3WGgRaDWehBPJUWWew
   xYQOk6+cK0t68UFYmyXjV+Xw4PqCmw69c76ltiIbSMhvNlRseT+6HsOVt
   4yCtfcJehD9LsPpofhLznbaC/hZsIWDGJcDO4z6R5nU7lg9advP/6/24R
   JAse+ChFEnVnV9b1jZWizFtK9+o1KewCn8IisIaS+SLfxzX3eN8u9/jfM
   ObSwYszCELwjOP84gkFybIQyz1GVjIwLZAuSHatjzULxn/61Zu5Egpo6a
   GFtndjHoVvHNOTJv5cvmOE+4aYzODVR9TISJC131sUYzd0tDr9/wsimI1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373943774"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="373943774"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878574868"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="878574868"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:36:32 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 3A573120FB1;
	Fri,  3 Nov 2023 10:36:29 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 3/3] device property: fwnode_property_get_reference_args allows NULL args now
Date: Fri,  3 Nov 2023 10:36:25 +0200
Message-Id: <20231103083625.1229008-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103083625.1229008-1-sakari.ailus@linux.intel.com>
References: <20231103083625.1229008-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All three fwnode_property_get_reference_args() implemantations now allow
args argument to be NULL. Document this.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8c40abed7852..8667b13639d2 100644
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


