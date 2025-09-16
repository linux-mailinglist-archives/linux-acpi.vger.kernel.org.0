Return-Path: <linux-acpi+bounces-17028-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9608B59CDC
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F4171174307
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E2B341AA1;
	Tue, 16 Sep 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rhkfjc8D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A62848A3
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038500; cv=none; b=QP88bT5ibXU2YqnSi39Q64GcVws/hgm+Eee0t5dIzXWJA9aQfiE19gvkIObh+eW/5re+L+H8Zg4jDXh8lkXuYGdScOG5abBepEDaAtjfwCMU8tszsBglNg7V4f2vny9I42KyOqtdKhaqxQfWFQh1RFWvtODVTS849bfUXmspMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038500; c=relaxed/simple;
	bh=8dI9L/kl7dexBvVgWr2ETNmuieG1Iya9plO2id6Lf3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkf3y+/L2Usdsid9zpvPbdmvAqfpLkXRj7XKYOWpuW553M9DH7QKUs7lVkWbXVNXUxFrs8H2n4KFPAUc4sCi3rRIcfq7RLqBTT7bxN8gkIxajd3H+ecHkQlTsGk89RfodnFmmOmIQhgMbolYftW3GEBYQrWTkrfpFoG8hKjZe1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rhkfjc8D; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038499; x=1789574499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8dI9L/kl7dexBvVgWr2ETNmuieG1Iya9plO2id6Lf3o=;
  b=Rhkfjc8DHZX/NzQKB5+slmP5rBCwxl4pZxMjDAjDRNGd7YTkVt9sFnwC
   wJFiiWwiPIVsB5qWdAYKQ2kYTLMvgn+JSDdIBqIpR+Hza7A2I0qCVEFOB
   EZUX8GjD3KPWGLBgQA4neB3LyfS4KKNQMkqa1pHnsmCErGFz20nD8LuId
   edNsXquG9K7T9UgNgyjvL7sUPL9qYXVU7zZwVglI8ok4EMZtT6vIFlOBt
   RSH3L+V8FaQEayTKnvnumJhZZGSElFaz/gB14ZNCugvJt0MI+mPWf6PxV
   iTrUPnsoUJb2/cEndtQe70LeB5tfMJC8nDTB6HOVaFmG01DlzqHLuEGN0
   Q==;
X-CSE-ConnectionGUID: oTHOMIcCRlWmCFHNyg/DKw==
X-CSE-MsgGUID: ryLHhVMYSVyCJx4UzpEUeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422929"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422929"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:36 -0700
X-CSE-ConnectionGUID: /N5rhCi4SE6VBfRFEzyt+g==
X-CSE-MsgGUID: Q6HlcPF4SqawldLbH6e5qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091516"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:33 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 63FF5121EFF;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gazd-1LJ4;
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
Subject: [PATCH 01/14] ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint() only
Date: Tue, 16 Sep 2025 19:01:16 +0300
Message-ID: <20250916160129.3955410-2-sakari.ailus@linux.intel.com>
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

Calling fwnode_get_next_child_node() in ACPI implementation of the fwnode
property API is somewhat problematic as the latter is used in the
impelementation of the former. Instead of using
fwnode_get_next_child_node() in acpi_graph_get_next_endpoint(), call
acpi_get_next_subnode() directly instead.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 436019d96027..8d9a9876748f 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1380,7 +1380,7 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
 
 	if (!prev) {
 		do {
-			port = fwnode_get_next_child_node(fwnode, port);
+			port = acpi_get_next_subnode(fwnode, port);
 			/*
 			 * The names of the port nodes begin with "port@"
 			 * followed by the number of the port node and they also
@@ -1398,13 +1398,13 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
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


