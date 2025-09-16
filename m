Return-Path: <linux-acpi+bounces-17035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A097B59CD1
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D94B1C04848
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC02857EA;
	Tue, 16 Sep 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaQM6c6y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CA374273
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038505; cv=none; b=Cz13JdjYkcPK9bW3S/pFdqLvPFiJ3ptDt9YVihHEL3WcloOzt6mZqGUuL+leIdnOmzCM7sRr8ODjWi1w5tlpc1TV4RZMAvqnb4zLWhT9pUTowReLFZ+hZtF2TY3kLgnrZzo/kvErMofD4d49dfGMS0t8tbY0t6Vj+bTn+HSiRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038505; c=relaxed/simple;
	bh=jCyeJsf2r0hmAqCSjDUfebbgI9PEHOizoRXrfnF8aSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdA9Tc3Sgpqlbg5l+cXu3tBwzjKGuy9W4S72cUou/G4OlHvXN5Z+i3TufQeTC8nTANSGSJc/wc8a+wGleODpvXBuMvWSaYeRSZ8wqi7a/ML5fiYw46vyCSlDq7oQA6lWryiMicodniJe3Q14UjZmwzUqW56KW3KFn5x71zDam5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaQM6c6y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038503; x=1789574503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jCyeJsf2r0hmAqCSjDUfebbgI9PEHOizoRXrfnF8aSA=;
  b=SaQM6c6yEMqME150Af+y2DY2ES04s21JqGhan7m8avMSEw5DNoYEzr5w
   vhEhXbSVG+yNbxiY7Ycv1OiUvdyC8/pfcAk1RIB0jH/QtUf7VTcndyeLK
   /isoY9qj9dkAI9/DDj/uxC9dg3If0iQsKzCYpH2cTpfjhxZAKZ2mEWbKT
   m1CGQ/HOXsH/D/ls+xefvqk3aKWk49gGDGnCuQM3bj3J6aHEiOMEGukJW
   4aCGYLDs6bZ3ysaNH9pP3TUyznoBStJKaHxUxgY0qZA3q3EvmRF81xkrf
   aDip1ICB1e+3tBtH9lcBJKGchG0LOCfNncYFCtH4z1fCYc+rm9riadJ6r
   g==;
X-CSE-ConnectionGUID: di9mh4fIS2+Wt6bI3jyXrA==
X-CSE-MsgGUID: aGzCfY/0SemAD+X4M4oVJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422967"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422967"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:41 -0700
X-CSE-ConnectionGUID: EH7XhDoESDusMsSdzM/H5A==
X-CSE-MsgGUID: C+smrkOZTD+zN2O04ErA8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091537"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:38 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7CDE7121F09;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gb0G-1xHp;
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
Subject: [PATCH 09/14] Input: touch-overlay - Use fwnode_for_each_child_node() instead
Date: Tue, 16 Sep 2025 19:01:24 +0300
Message-ID: <20250916160129.3955410-10-sakari.ailus@linux.intel.com>
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
 drivers/input/touch-overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
index b9fd82c4829d..7eaaaef1bd82 100644
--- a/drivers/input/touch-overlay.c
+++ b/drivers/input/touch-overlay.c
@@ -82,7 +82,7 @@ int touch_overlay_map(struct list_head *list, struct input_dev *input)
 	if (!overlay)
 		return 0;
 
-	fwnode_for_each_available_child_node(overlay, fw_segment) {
+	fwnode_for_each_child_node(overlay, fw_segment) {
 		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
 		if (!segment) {
 			fwnode_handle_put(fw_segment);
-- 
2.47.3


