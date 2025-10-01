Return-Path: <linux-acpi+bounces-17471-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA753BB00A6
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 12:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7991E1C5A70
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 10:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7AC26B2D7;
	Wed,  1 Oct 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXhdc4Vz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8D2AD3E;
	Wed,  1 Oct 2025 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315408; cv=none; b=ATipNOpVYODUc1ihCkMQztY8w6Igg/FaC+fq4+BC4Z911sawV9elaVeBIr7Yp8rV8laFG3k1wd36TJxmo+o0GhEgCKqWA49rkx0fdNaPXQtGeSyKss+PGZbxnJpHl2+Dcesnez5MylNgchEXNRmCFsnRmcmu/F3OBSEzOxxsi6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315408; c=relaxed/simple;
	bh=6SlDxGv4HiWCjOhy4wCixM3y6TP0m4w6Dp+ZbYc/NiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpNMNrZnFcBcCcYqi1fFoGOiJIAp7OzvRgxVGnge7wAtBP+De/Halqp2fP6edJXk7mH83n/KogRVuqeIDJO0+45K16Jz1a7OzW3OGty2ekzSddgQ4NXPUcYE/sjWduo3TNBpUtkDib/LH757KjXyzgLGtVPvnbNJX0RbKZMKHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXhdc4Vz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759315406; x=1790851406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SlDxGv4HiWCjOhy4wCixM3y6TP0m4w6Dp+ZbYc/NiU=;
  b=lXhdc4Vz+sobazVrH3VJOBEyijqxOOCVpiQpLLNeHGgd/P4iqd3Slony
   o9/PHAF/3B0G6ZZJhQmFVwjOpx9JN0r2UfIrtimivQqTpMNZn68Eb01qW
   qvWSt8pXQgp/N+BG0+PJIpDnHMwoWOKwvPfpMBxoX5fed4I74DRgO+OoQ
   sxRRpFThknk3uMRv0/NC1LMBiS4h/s7oWDAuQuw0XRY7ar+ZbHQVFsBw3
   g3BcQa3QldUC2pmJuYQOucwJZxPeZKFM7nlmp2e0X4EL5tBHOObg28EED
   qzcGM26l9hyn104TqHeTQxYsmZMNn3jZrqNuf5d7fMtKgSJfK8nlJBATC
   A==;
X-CSE-ConnectionGUID: a/pOqgymRKm2cA5GbvZvaw==
X-CSE-MsgGUID: R8uxonJuT9y1suXfe0eohQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61293945"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="61293945"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:43:25 -0700
X-CSE-ConnectionGUID: NI0bO94OTlukE0anZ8dOCg==
X-CSE-MsgGUID: OEbH4oS1TE6HPTVRAp9jrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="178357468"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:43:24 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9882F121EC9;
	Wed, 01 Oct 2025 13:43:20 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v3uIq-00000005L6j-2O6j;
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
Subject: [PATCH 3/3] ACPI: property: Rework acpi_graph_get_next_endpoint()
Date: Wed,  1 Oct 2025 13:43:20 +0300
Message-ID: <20251001104320.1272752-4-sakari.ailus@linux.intel.com>
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

Rework the code obtaining the next endpoint in
acpi_graph_get_next_endpoint(). The resulting code removes unnecessary
contitionals and should be easier to follow.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 200e5d717f16..c07f45929a25 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1421,14 +1421,17 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
 	if (!port)
 		return NULL;
 
-	endpoint = acpi_get_next_subnode(port, prev);
-	while (!endpoint) {
-		port = acpi_get_next_subnode(fwnode, port);
-		if (!port)
+	do {
+		endpoint = acpi_get_next_subnode(port, prev);
+		if (endpoint)
 			break;
-		if (is_acpi_graph_node(port, "port"))
-			endpoint = acpi_get_next_subnode(port, NULL);
-	}
+
+		prev = NULL;
+
+		do {
+			port = acpi_get_next_subnode(fwnode, port);
+		} while (port && !is_acpi_graph_node(port, "port"));
+	} while (port);
 
 	/*
 	 * The names of the endpoint nodes begin with "endpoint@" followed by
-- 
2.47.3


