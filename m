Return-Path: <linux-acpi+bounces-1154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4CB7DF019
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 11:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7718F2818B9
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD3914A94
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uj/B+wZA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F812B92
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 10:13:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A64133
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698920008; x=1730456008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q1rFDdn055YhUM6w8twK1/O3m+2EDsWdczT++7HzALY=;
  b=Uj/B+wZAY4A5aK3Qj8KKDaqEfi8/JTA9cosxMbYjSroh+IpnIwZs0fSQ
   HlQh1wsS3Xdws/4a7zPSaPxWguvosvFrepqvq0bH+Mx6mqnZ8wE3izi54
   MSsdQrMmT5CSqXl7151IVIVFJWAZM166lrWr6/jSDq9lCDh9u8kMJo0YK
   MRy4NAStlf+vFEdUsUeGlWcy26RtwAA9RhDomsr1J49pjfQ3bL3YS58Yv
   h3/Y/ixg/h4mI2ISJQ5MJ7eunIiYd+0mJxniZBOz6Q8JbD+4SQngAaNaZ
   dQttXJQMxig5hAq02q7dxgBfOmbSzsHM9kffRzOh9GTzljV3PoXEWED7r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7318646"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="7318646"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="904969784"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="904969784"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:13:23 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 3534812098A;
	Thu,  2 Nov 2023 12:13:20 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 3/3] device property: fwnode_property_get_reference_args allows NULL args now
Date: Thu,  2 Nov 2023 12:13:16 +0200
Message-Id: <20231102101316.1186215-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102101316.1186215-1-sakari.ailus@linux.intel.com>
References: <20231102101316.1186215-1-sakari.ailus@linux.intel.com>
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


