Return-Path: <linux-acpi+bounces-12843-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2215A7FA8B
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 11:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38313A6474
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF639269CF1;
	Tue,  8 Apr 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PM5ZDLwC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEE264FAC;
	Tue,  8 Apr 2025 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105960; cv=none; b=kTja1/wmyL4Vl0aNzZOCk2G332XFzICpcOiAgCZyqJhOauQ1wc9LjrRR+JAHHIFUvK9Llv60xhLQ3Cja1t4EjBt1Ys3lj3JqJSk+l0eVh/8gSwX6ZswxwI8GTvfXqvPmsxcaFxbg9DyemO0HyLlj0ypfNCAiE6wSBlXaQP7767Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105960; c=relaxed/simple;
	bh=8klGH551jaB3tR6fN/1f6j2RISg5+ef6RCdN0l72FOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGeOg6shHpQhXRatLJGNNHG5czGvdR9VLJWs4/KQ9B61GlV04TSaykdaedd5F0iOWHO2s4jYeEhdcfapRNcz3eX5tuj5xPUEnL0+gXSzczdXr28cjZxjJ0Y/iBYiXL3RBLe5E1Uy/wmVKBl1Glz8Lwd3+zNgb7Q9nDNkWkDZw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PM5ZDLwC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744105959; x=1775641959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8klGH551jaB3tR6fN/1f6j2RISg5+ef6RCdN0l72FOU=;
  b=PM5ZDLwCu33qoW+tqFGAsERaZtk9jMpBGnE/rQVPj5XhWW5hRybeV93F
   /NSt3rf8uqz0Nj2RX+5S9qVF05ZukEG9mYYv5sZ/7VIubuqTXDiiYN1S6
   0OGAe7sQ7AdJoVnUrZiBbkCin1tCSHu7GxoBuiQsBFBmtezLnGQJ95t9k
   hb2vP1EpqIw2c1qgL/lj8WvO30ROLeKPKuywqS+2GMey2Az21f44N7LpA
   KLSkePTokpPV35mnhrfF3S5epALXGEYZD+XDqSN38XvV0LuGEd184ObTS
   BSW0HcTSS1nV5oNaWPck5qXg9tZTZT9x1i8nzgZ24xP4ZOOTAR2HydnIC
   Q==;
X-CSE-ConnectionGUID: JZhPW3M4Qk+meLumRWHigA==
X-CSE-MsgGUID: 30X7NmExQT66qiRXr0blZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56167273"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="56167273"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 02:52:37 -0700
X-CSE-ConnectionGUID: YjTNhO6aQjis35bACrFRdw==
X-CSE-MsgGUID: WLWzMleMTGuC5iMEaHCjLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="129173611"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 08 Apr 2025 02:52:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6ABE1398; Tue, 08 Apr 2025 12:52:32 +0300 (EEST)
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
Subject: [PATCH v3 1/1] device property: Add a note to the fwnode.h
Date: Tue,  8 Apr 2025 12:48:55 +0300
Message-ID: <20250408095229.1298005-1-andriy.shevchenko@linux.intel.com>
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

The purpose of this note is to give guidance to driver writers
to avoid repeating a common mistake.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3: reworded the note, added problem statement into commit message (Rafael)
v2: added "...into the driver" piece at the end to remove ambiguity

 include/linux/fwnode.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 87b183595ba1..900ecd8f45a1 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -2,6 +2,11 @@
 /*
  * fwnode.h - Firmware device node object handle type definition.
  *
+ * This header file provides low-level data types and definitions for firmware
+ * and device property providers. The respective API header files supplied by
+ * them should contain all of the requisite data types and definitions for end
+ * users, so including it directly should not be necessary.
+ *
  * Copyright (C) 2015, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
-- 
2.47.2


