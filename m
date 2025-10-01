Return-Path: <linux-acpi+bounces-17474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1F4BB00BE
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 12:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176C64A1E8C
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 10:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B5D2BE7DD;
	Wed,  1 Oct 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kj/ilOQr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A992C08A2;
	Wed,  1 Oct 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315413; cv=none; b=JcjicIWzIjzFQ9+suIZ8ODeGmv58NKem422RDxYLJ+XNDun2ygMxwWwc2o4Z0hRpU2GVCtXDqBnIjImpYDKy2UwMG5/cqcP9wEpqu23A0uiGuFDiDgzCUMyFNOp47MMEIggKyRtIn3NNhXyqNgWnZWomH3I9sDUl9fGTB8Ewt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315413; c=relaxed/simple;
	bh=OM/ifuRIPjEtb46dSEU0Ivsp1/jrjS24GvVgOeQ2Te0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UH5wL9dVV4QF6jp5h/2zvcGyyQfaen7ZdlBbJGHXXi1PTOIRPqkO+AkfznojJGQXeVUfUOCFYCT8YuvQDQ4/TRFFxcZp8PHb8kYM6AaUJCB6nxDbbp1MYRpbNRxuKVkTeqmw5MlMY5hG4CsHFYrq9r02RtSf7pc6fLkCLIbV8R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kj/ilOQr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759315411; x=1790851411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OM/ifuRIPjEtb46dSEU0Ivsp1/jrjS24GvVgOeQ2Te0=;
  b=Kj/ilOQrwowF+rFhDVjshA3S9ITtWMIIXbOstc12pVaSKMMxgvkQJNhL
   1ymo0sE+unE4WXV47mklT/KHmUxX4oWA01fQ5tlOiBxhEC5DiDhA5E4FF
   LMJQstTS5aUgteTOh/iDUtVTbCPh5GcffhGyvNK0+3xjyHZDHYlvyY73h
   AobB77MLm05k6STWksTbf9Yz+PhxOXfsIPePry6TqOgLvEw1D8TWJifFg
   zPIi/Z4/uAuFUGmVu6FrSswi0+fPX7vhyPXZKJXzWlposG+qQXFWWSAEy
   6Id/J/pgdDeUqp0c8GA+5f0KoQ7G11VSBMLkTE1icNYe14lG9UiL95qwd
   A==;
X-CSE-ConnectionGUID: ebwzBLyYR62vfUfROrtsCA==
X-CSE-MsgGUID: iQKE4kAaRumkLAjcC3I2WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61293950"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="61293950"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:43:25 -0700
X-CSE-ConnectionGUID: CAne+d/RQGOuKeK6hCTErA==
X-CSE-MsgGUID: 6envKmqaSkmjU9wJVcBFYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="178357469"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:43:24 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 93385120DA3;
	Wed, 01 Oct 2025 13:43:20 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v3uIq-00000005L6b-2HLa;
	Wed, 01 Oct 2025 13:43:20 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/3] ACPI: property: Make acpi_get_next_subnode() static
Date: Wed,  1 Oct 2025 13:43:18 +0300
Message-ID: <20251001104320.1272752-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001104320.1272752-1-sakari.ailus@linux.intel.com>
References: <20251001104320.1272752-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_get_next_subnode() is only used in drivers/acpi/property.c. Remove
its prototype from include/linux/acpi.h and make it static.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/acpi/property.c |  7 ++++---
 include/linux/acpi.h    | 10 ----------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 10bab30300f3..59ed2d9f1007 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1259,13 +1259,14 @@ static int stop_on_next(struct acpi_device *adev, void *data)
 	return 0;
 }
 
-/**
+/*
  * acpi_get_next_subnode - Return the next child node handle for a fwnode
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
  */
-struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
-					    struct fwnode_handle *child)
+static struct fwnode_handle *
+acpi_get_next_subnode(const struct fwnode_handle *fwnode,
+		      struct fwnode_handle *child)
 {
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5ff5d99f6ead..703323b9fe0c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1349,9 +1349,6 @@ acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
 int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
 		       void **valptr);
 
-struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
-					    struct fwnode_handle *child);
-
 struct acpi_probe_entry;
 typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
 						 struct acpi_probe_entry *);
@@ -1450,13 +1447,6 @@ static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
 	return -ENXIO;
 }
 
-static inline struct fwnode_handle *
-acpi_get_next_subnode(const struct fwnode_handle *fwnode,
-		      struct fwnode_handle *child)
-{
-	return NULL;
-}
-
 static inline struct fwnode_handle *
 acpi_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			     struct fwnode_handle *prev)
-- 
2.47.3


