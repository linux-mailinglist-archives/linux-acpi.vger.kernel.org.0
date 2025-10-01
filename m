Return-Path: <linux-acpi+bounces-17472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E9CBB00AF
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 12:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64411C4089
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142A12C033C;
	Wed,  1 Oct 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDiu2BiS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6126C3A8;
	Wed,  1 Oct 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315411; cv=none; b=WGTv2FUJ0RXpPlMyg5azLLuey2gV91tBCYKUWXvs3diTFxU4wPRagGN1BYpxflGmMFP1ecGWoy6uAdIdkPMJCzwKKVF7Cg0JPE1y3GjudjB6x6Yfw7xv7eBCAD0ufyBPbmLZH/jToIM2luBRRpWm0hL4u/DV/Vx+QF0wC9WsfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315411; c=relaxed/simple;
	bh=Y917bgb8/qH2WXmOJWBWbX1NFwb3igDPb8vLYBttB6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0sAemfZbv+Q0rjZstOVYuCtq2+MkbgPG7H3SDOJ6GlhyHci3QsGkiH0+86TrkFs70O+XcnTuWS6XtwE1BaCs8ydQ/WL5/n8Nq5X8+9A2oM4/0NNu5xjyl3fC3xhBW6L+7O6o/bz4NyXPDG88wBduPOffOmkyDXbudT5GhGtoPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDiu2BiS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759315409; x=1790851409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y917bgb8/qH2WXmOJWBWbX1NFwb3igDPb8vLYBttB6w=;
  b=KDiu2BiShw6/8Lw76Q6PjyORyN78i+W834I/nVu3GfZCJCVlF920M5/A
   dQiGDHbn2keXo4zuMMTRpeUgw+ABcZIXCbDzgAp/spIv+TGe3kKnm/spG
   goHY3X6O4hcN8S9DMBis8/qXXE7IA2ahWa7iD0jLrO5XaQnNrRXWtR4Rg
   k0P/jokfJZh2twj2BScLMV96wdUIPmtVhxRCoDQFfYfFD+2WvuSlCXdX2
   zLgVWxDgY5InAWnDwh55PidJCX8jTJHd8ZI7ndX+pWfVZdlokmDskmdDA
   VDLN690S3DrPQf+/QiDWWI5XorCKhofPsgMpk0fgGiMCSijkta6P1SvDH
   g==;
X-CSE-ConnectionGUID: 3krZezlaSByk8Ncl5p0SBA==
X-CSE-MsgGUID: tlH8en7dQDGfY0yJsIBfNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61293961"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="61293961"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:43:26 -0700
X-CSE-ConnectionGUID: vb7mb/eKQcWDO2uJKZ/9nw==
X-CSE-MsgGUID: xTCnrlCsT3WYlbZUmaCL0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="178357471"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:43:24 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 95936120E3A;
	Wed, 01 Oct 2025 13:43:20 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v3uIq-00000005L6f-2KXA;
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
Subject: [PATCH 2/3] ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint() only
Date: Wed,  1 Oct 2025 13:43:19 +0300
Message-ID: <20251001104320.1272752-3-sakari.ailus@linux.intel.com>
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

Calling fwnode_get_next_child_node() in ACPI implementation of the fwnode
property API is somewhat problematic as the latter is used in the
impelementation of the former. Instead of using
fwnode_get_next_child_node() in acpi_graph_get_next_endpoint(), call
acpi_get_next_subnode() directly instead.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/acpi/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 59ed2d9f1007..200e5d717f16 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1403,7 +1403,7 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
 
 	if (!prev) {
 		do {
-			port = fwnode_get_next_child_node(fwnode, port);
+			port = acpi_get_next_subnode(fwnode, port);
 			/*
 			 * The names of the port nodes begin with "port@"
 			 * followed by the number of the port node and they also
@@ -1421,13 +1421,13 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
 	if (!port)
 		return NULL;
 
-	endpoint = fwnode_get_next_child_node(port, prev);
+	endpoint = acpi_get_next_subnode(port, prev);
 	while (!endpoint) {
-		port = fwnode_get_next_child_node(fwnode, port);
+		port = acpi_get_next_subnode(fwnode, port);
 		if (!port)
 			break;
 		if (is_acpi_graph_node(port, "port"))
-			endpoint = fwnode_get_next_child_node(port, NULL);
+			endpoint = acpi_get_next_subnode(port, NULL);
 	}
 
 	/*
-- 
2.47.3


