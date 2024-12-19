Return-Path: <linux-acpi+bounces-10194-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9D79F7DDE
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 16:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37CE1886E74
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687651FCCF3;
	Thu, 19 Dec 2024 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfiL4Mjw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6F1754B
	for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621716; cv=none; b=lmd39tH9R5JA+X38EncLYF+0KHZ/boh4S17DwxWoYc6Qp6NWUOcH3K2zuMbtt8R0c80KO0NjMA+CWbeBFZ9dew1QxWXhQ9aSqKburlrIUcPOELB1Ac0aIOpD0308yt+S0sjJoK2GVowF1tb/ptWMThyOSOZvDi4xC4TWZlhoBIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621716; c=relaxed/simple;
	bh=6k1H+vC6TVruwoTWb6LJo6tzPj2qKwmpe8u19/NL0X8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzBaN5amuiOOOZZje+uohNEZd2bNYM/IyQOJQuo5A7UhrEpqj5p8bPksBSx7rlc0RLF2N6HmCmSrRkQisZr8W317jkTcmqnxcAGH3gNZLeCrhahquQoIENG5quhbfIfh+TvmmRP1FE5oq60dQ76WIsfrG+A+o7GHQgFwC8YV1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfiL4Mjw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734621715; x=1766157715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6k1H+vC6TVruwoTWb6LJo6tzPj2qKwmpe8u19/NL0X8=;
  b=hfiL4Mjw7dBjnabCz5owt10lDUFGdPemW1aqPnwjcFrdgW2gzvGC4jMS
   BQ538LOu8wAU9MPDAQKPj7nTya8t5R4/GAaSJeAgG/ai2ePgxT1p1AdMK
   WwvtN/p0H2cCmfd3uKiR9fdA7uYvrXt/8rpuVaqbENrf2yxTT7cCv0WUP
   pZncF1a01PpfGPn4t0vhozNAct+GB5oEB/R4T1VxG2J9S4YxixjQLCXW0
   3r0FsJ5uvNYqaIZ+JIk07hT+P1lffHIexoCZ4W9iDYxPpEHYkQlYsq6rt
   /SCWdWkY3fBoyqRmlk5cd6sXEqsYpc0JGipRPJuOV08UYaUhap2iNMPGX
   A==;
X-CSE-ConnectionGUID: yicdfcEBR4uvr0aisLImBA==
X-CSE-MsgGUID: +/GXXbtKT7ax4x8e5X1ehQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46144326"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="46144326"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 07:21:54 -0800
X-CSE-ConnectionGUID: 9g/w5SJqTG+2BebqSO/oiw==
X-CSE-MsgGUID: mNvyRF/BSiaL7iJFPAAYOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98699863"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 07:21:53 -0800
Received: from svinhufvud.intel.com (maa-artisokka.localdomain [192.168.240.50])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B694611FA41;
	Thu, 19 Dec 2024 17:21:48 +0200 (EET)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	andriy.shevchenko@linux.intel.com
Subject: [PATCH v2 1/1] ACPI: property: Consider data nodes as being available
Date: Thu, 19 Dec 2024 17:21:48 +0200
Message-Id: <20241219152148.975622-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New functions making use of the data node availability information, like
fwnode_for_each_available_child_node(), have been added years after
fwnode_device_is_available() was introduced. To enumerate the data nodes
in various ways specific to those functions, the node availability test
needs to pass.

On ACPI, there is no explicit data node availbility information in the
first place and the original fwnode_device_is_available() implementation
simply returns false. This causes new functions that only enumerate
available nodes to never return any nodes on ACPI for leaf devices that
have child data nodes.

However, on the DT side, fwnode_device_is_available() returns true for all
nodes without the "status" property which are analogous to the ACPI data
nodes, so there is a difference in behavior between DT and ACPI in that
respect.

Thus from now on, return true from fwnode_device_is_available() on all
ACPI data nodes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 80a52a4e66dd..1ee81e771ae6 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1492,7 +1492,7 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *__fwnode)
 static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	if (!is_acpi_device_node(fwnode))
-		return false;
+		return true;
 
 	return acpi_device_is_present(to_acpi_device_node(fwnode));
 }

base-commit: e14d5ae28eb28c5edef53bd648037d2bb4fce1b3
-- 
2.39.5


