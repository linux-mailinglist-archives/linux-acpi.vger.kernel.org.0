Return-Path: <linux-acpi+bounces-12567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E9EA76BF9
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E2C188CD54
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA3210186;
	Mon, 31 Mar 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DafUMQvW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5262B9A8;
	Mon, 31 Mar 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438755; cv=none; b=enOs4mb+cH8zedZCvPJOODONj+3moio6Lm/VG7LuCExK3jRyeGY5HgF4Q5AMA5toY/6n5TUz/DliJG9DDspqhH+y94k2bTnCFNSeaX+irf37+5FnLL/OIuaOsqCuvDuO8TkwhPWWzOyI9sehxlA3S54YVf6BRJv2djOBA9xRMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438755; c=relaxed/simple;
	bh=ero1559j5wvvXzh1OFTBDSwKuIX3b8+nJBm9al0thkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4ozuZdNe8gvU6YOIePwOld5wxKSMK1yYXpiKmS6JUeF0Z0p9f9JtSx15ujxzXBXc/HZ7NU1rGLlzWcIt9xY5lBix61USb+KRrIHyi31jyp5r98/xGnpKc6iUrGvKlc/N52AY3kJ2GgQULT5bze0ar5SE8R9pdtS73N8/JE4+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DafUMQvW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743438754; x=1774974754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ero1559j5wvvXzh1OFTBDSwKuIX3b8+nJBm9al0thkQ=;
  b=DafUMQvWYl1QKPlGtZCLqahwy5WSPjOhfYsBanC6LMT8hsYUHsg7icrs
   NbHItzcNribPc5Xd0WrkzW33F0+covq0W4n6YSpFATTuWoJyZ+PIwf+Q+
   gdk6AqqsUQBltw36atLEQk9mJ79f1eQostCXdAum4rMY12nBPHigGa66v
   UWmdyaSVkRyaRfVf75C1Vr0aTtxnmRDEqfMeK6habeAW/LD9YUeq472WP
   mu0m7+Jp7lBC0K5ZvxFh+RaGTNdCVCEURIbWVi8gMfND+7icxT+0lb15z
   lDZH+D3skpavGC5/EnfNFwZ9aU85LMlG34+8PmJb9gVUH5r3fqMTcu9xF
   Q==;
X-CSE-ConnectionGUID: LSo4d6RvSJmxAtaiObUM2g==
X-CSE-MsgGUID: yFkvjEYWSySgCICNaZJ3HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="55379824"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="55379824"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 09:32:33 -0700
X-CSE-ConnectionGUID: BrWtMfGGSYyk+qA7F+B5lw==
X-CSE-MsgGUID: /rxz/Ho3SQq0gOgXb9F0lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="125888740"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 31 Mar 2025 09:32:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E890E141; Mon, 31 Mar 2025 19:32:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v1 1/1] device property: Add a note to the fwnode.h
Date: Mon, 31 Mar 2025 19:32:27 +0300
Message-ID: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a note to the fwnode.h that the header should not be used
directly in the leaf drivers, they all should use the higher
level APIs and the respective headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/fwnode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 6fa0a268d538..da537c7c30dc 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -2,6 +2,12 @@
 /*
  * fwnode.h - Firmware device node object handle type definition.
  *
+ * Note, this header is not meant to be used by the leaf drivers.
+ * It provides the low level data types and definitions for the firmware
+ * and device property providers. The respective API headers should
+ * guarantee all the required data types and definitions without including
+ * this header directly.
+ *
  * Copyright (C) 2015, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
-- 
2.47.2


