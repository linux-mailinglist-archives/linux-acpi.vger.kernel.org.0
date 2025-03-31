Return-Path: <linux-acpi+bounces-12557-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFAFA765AB
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 14:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285693A9D20
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3331E5B9F;
	Mon, 31 Mar 2025 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBJQX4b0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A51E5702
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423533; cv=none; b=tPmHiVh3RyUr1F0JroitYMoKRGzIjN6CWndjVnOPJP1xZO7qFywrQyxNexQkKMd+wOzJUFQDlUT58kwb2RSstWy5rmnDu6BFh6Z2mKfYAd584TaIYwI8qAtFLQ3CYjVpQIzAMIWGqOdX5FP6d/VxSQOQq+azy17N7RR2Zo/Ai1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423533; c=relaxed/simple;
	bh=QfVsxTqMDWSYaL+pYNY6/00osgXCBOW9SwGfWeTW89Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iUL/nTriCSOS89YDZCBn2lzpthfHQLvFcKXRB0Y1fH8OgQwuCvGnP0k/qsigEV9YtM9rffkVzU+T1DOFLS0veRJG6Og36AA7byTuDaI2zUCPujDoNQUuUmIvu3HJCAFxOekbFDEnm64x2D6OAFZ0mnbPm6QlYENMSGSxU6oVSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBJQX4b0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743423532; x=1774959532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QfVsxTqMDWSYaL+pYNY6/00osgXCBOW9SwGfWeTW89Q=;
  b=MBJQX4b0KYR2A4jGTu88PhK33K1ff/GDNHlk8vm+43VL8PpkksV2HLPs
   qAgpGAHCTbDiU6EsTDuyECL01wdzLWK5a1dhEHWrOr1wg8OEGCNlWWptO
   Ljfus4SeY6hv/Q55pzInwncmrwYzPqLAM3rp667c4slXYnMWdvLVX2Tpj
   izRpNKuo8aLzYJy0RJAwLre3Lnp8+XKwDvIRb/zPTdNtYTgLpcsyw5au1
   OKeI9BE9xA9xfl8pBiGgecMVwcPUky9NtjFUuTQcBS04qVrWElhQ09u/s
   8YAaes9HaUmiLHiDzq4zz+odKp/z8Szz5alAlqqxTY4efINgYBBxKoVUL
   A==;
X-CSE-ConnectionGUID: pDErdkSjQvK+Q7IXOI5ZMw==
X-CSE-MsgGUID: p/tPpZE/Q7yxTccF223F2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44839518"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44839518"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 05:18:51 -0700
X-CSE-ConnectionGUID: 7R0VeSd9Sc6hP1CbuU5RVQ==
X-CSE-MsgGUID: uUcbDtsCT/OShibqo60feg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="130916253"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 05:18:50 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id A88F611FC9E;
	Mon, 31 Mar 2025 15:18:46 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1tzE6I-00ATIh-1s;
	Mon, 31 Mar 2025 15:18:46 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] ACPI: property: Fix REF STR... reference parsing
Date: Mon, 31 Mar 2025 15:18:36 +0300
Message-Id: <20250331121836.2495903-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restore parsing of ACPI data node references consisting of a device node
reference followed by one or more child data node names.

Fixes: 9880702d123f ("ACPI: property: Support using strings in reference properties")
Cc: stable@vger.kernel.org # for 6.8 and later
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Hi Rafael,

It seems that support for REF STR... references got accidentally removed
when pure STR reference were added. The former are documented in
Documentation/firmware-guide/acpi/dsd/graph.rst .

- Sakari

 drivers/acpi/property.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 436019d96027..4e3202a0b305 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -807,10 +807,27 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 static int acpi_get_ref_args(struct fwnode_reference_args *args,
 			     struct fwnode_handle *ref_fwnode,
 			     const union acpi_object **element,
-			     const union acpi_object *end, size_t num_args)
+			     const union acpi_object *end, size_t num_args,
+			     bool follow_strings)
 {
 	u32 nargs = 0, i;
 
+	/*
+	 * Parse REF STR... references by following named child nodes below the
+	 * device node pointed by REF.
+	 */
+	if (follow_strings) {
+		for (; (*element) < end && (*element)->type == ACPI_TYPE_STRING;
+		     (*element)++) {
+			const char *child_name = (*element)->string.pointer;
+
+			ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode,
+								      child_name);
+			if (!ref_fwnode)
+				return -EINVAL;
+		}
+	}
+
 	/*
 	 * Assume the following integer elements are all args. Stop counting on
 	 * the first reference (possibly represented as a string) or end of the
@@ -999,7 +1016,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
 						acpi_fwnode_handle(device),
-						&element, end, num_args);
+						&element, end, num_args, true);
 			if (ret < 0)
 				return ret;
 
@@ -1017,7 +1034,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
 						ref_fwnode, &element, end,
-						num_args);
+						num_args, false);
 			if (ret < 0)
 				return ret;
 
-- 
2.39.5


