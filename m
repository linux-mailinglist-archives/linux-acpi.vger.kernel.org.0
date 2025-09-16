Return-Path: <linux-acpi+bounces-17032-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C71FB59CCF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180F21C04688
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BF7374278;
	Tue, 16 Sep 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faP/HNJx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9B34AAE5
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038502; cv=none; b=Sr/fl06/CvM8qJlwaeR/ozNohcLpeeSghp5uRPb2LLo4gZs4CzhsQBv9fldPW/oE+JDnYURWk3eWVZBteFc3tbMQax1oQpuNlRZD94BFgnLw+OFF/xvFOjU9uOtt5mctUy5n5xAXm+0P7A4goas9I6mswExzadjzEjZmxJC0RCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038502; c=relaxed/simple;
	bh=SOIIxPHN0pMKXry68YzKaQyiVojN7g77KKyrfmEqRek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J17L4g7HK5nqsbbIuK0pjd0nBl7fCOzTuMbxaQGXvQLSNDa3RPnEjOzDawZ6YEWxQTsQkGVAHo5tjvyT6HLez7+DaLjuRWj5dIS/nxAtZ1fTEarDHhYRIQSkA2K+zLW7iSX+KcR12zADZVe7zMP5Pt49lZJPqDSaKyXZktfOe0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faP/HNJx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038501; x=1789574501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOIIxPHN0pMKXry68YzKaQyiVojN7g77KKyrfmEqRek=;
  b=faP/HNJxHsObOsYzZi3TYtMoh0anHUL/1dKPyP4xEpwL6IxYyZADrZoY
   5fVoxZzuCi5pOoStXdnrvPWiJkLHLIpIo6ORjMKyja9gMUhBmwY2DzpdC
   wow0HyTJnqdwL4cH1tWRrJijrs9FaQoZ+gCvJ8eu2AG0dZWigfD/NzC9I
   6QG05dmH/kseQRWUlWRV5GGUbfMyHe2MfTgieGFbN4Kk9n4mtpFRpOmDn
   g/azlClMduzDf6RSuxxn9ovn/8T3B538VE4x6Dy4mOLQpW8ZtjvRmD0f/
   e8VgVhcy4zaEJj3ASI0CjZtmNdJ/Cufe2ZzSiv/Az0GtjTGoqbgZzCPk6
   w==;
X-CSE-ConnectionGUID: 7M5Dl4XyRAuzBaoDkZ6ojg==
X-CSE-MsgGUID: JaXdoH22TZiBGZGtMJLqzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422960"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422960"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:40 -0700
X-CSE-ConnectionGUID: 1QA+oLrzT7yBayAxJ+uH5A==
X-CSE-MsgGUID: 64yBp8WoQU+J6r0fADnfpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091535"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:38 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7F163121F0A;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gb0L-20cE;
	Tue, 16 Sep 2025 19:01:30 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 10/14] media: thp7312: Use fwnode_for_each_child_node() instead
Date: Tue, 16 Sep 2025 19:01:25 +0300
Message-ID: <20250916160129.3955410-11-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_for_each_child_node() is now the same as
fwnode_for_each_available_child_node() on all backends (OF, ACPI and
swnode). In order to remove the available variants, switch the uses to
non-available variants.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/thp7312.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/thp7312.c b/drivers/media/i2c/thp7312.c
index 775cfba188d8..86208a47f472 100644
--- a/drivers/media/i2c/thp7312.c
+++ b/drivers/media/i2c/thp7312.c
@@ -2064,7 +2064,7 @@ static int thp7312_parse_dt(struct thp7312_device *thp7312)
 		return -EINVAL;
 	}
 
-	fwnode_for_each_available_child_node(sensors, node) {
+	fwnode_for_each_child_node(sensors, node) {
 		if (fwnode_name_eq(node, "sensor")) {
 			if (!thp7312_sensor_parse_dt(thp7312, node))
 				num_sensors++;
-- 
2.47.3


