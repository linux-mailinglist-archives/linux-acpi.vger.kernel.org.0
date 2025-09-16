Return-Path: <linux-acpi+bounces-17034-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3211B59CD9
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD6487AA1
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737BB374294;
	Tue, 16 Sep 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvIn6YOB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBE37427A
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038504; cv=none; b=c19mjR4O4Afkiwr+1tBkUBg7LRC3bwwqz9jMoVXj3G70U0Du87ymYWkNl0XyZsPiV7kx2qNrcNsAMRFdgMEMMLeu6ONmJlrmuxl0diZQx/AGy5P91UI0d/6gVxE0hsz1BuQOnJF2VF4pL57cfqRGMtKW0y/PaG7kYQcOU3Pijh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038504; c=relaxed/simple;
	bh=/eCProyFWYCYOJOTfw4H2B0E1zLjy8me1P2s2AigyG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/6hU0OIkMa18uOYkpGe/ARIh0Fs8qDIkcXZNHOtAW5YI+SZ4ygg2gI4anpxfMalEer5kKTo3vdIY8thVLT8Uo+vn36mt+i6roQrXV+itVTFCiX3ScOLSn4ULu8ZWr+z33edftWSL+CCYVe4fm1iIzeqnW0n3GBT6/iouWC2qq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvIn6YOB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038503; x=1789574503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/eCProyFWYCYOJOTfw4H2B0E1zLjy8me1P2s2AigyG4=;
  b=bvIn6YOBTXDomhDxKTP7mguGWef5oei3bipUQDkRF6tRnMbwQC2vS+5Z
   tt0CGwj+QIiwKCgFvc3oUvCnjLLhgoK/u5yuBdf4VhqigicEeX/RnEZBg
   fs4PsUlaN2sN3UYZLjaveTQ7kumyHAa8jE0rfYzrlDnlkWBdGDoKoEijr
   uqgWm23ZeMwmTCB+LmsB8wA52fs1RPv1aPF7HDw5AiRmrOXjzN8yOX5wJ
   4lYyarx2gPW1jMak0N7we+VnwryL3IKPwBcVFut1HvXHKzFU8oyNanuKl
   Bn82UwNSMUM50g1dYaA4yWs6DKddqzCNmM8+HytAAum8zm3wX0qfwJTeV
   w==;
X-CSE-ConnectionGUID: uTErA43+S3GF7OxyHGRjyg==
X-CSE-MsgGUID: 1u9EsRDbS2+YLE85KoKh+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422974"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422974"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:41 -0700
X-CSE-ConnectionGUID: W8vcNUk9RTO4fJmws8Vt0w==
X-CSE-MsgGUID: NyAsh8h+RzGEfiecdYuZRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091539"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:38 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 6E2F9121F04;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gazt-1i1f;
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
Subject: [PATCH 05/14] property: Drop DEVICE_DISABLED flag in fwnode_graph_get_endpoint_count()
Date: Tue, 16 Sep 2025 19:01:20 +0300
Message-ID: <20250916160129.3955410-6-sakari.ailus@linux.intel.com>
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

FWNODE_GRAPH_DEVICE_DISABLED flag isn't used anywhere, drop the flag and
support for it in fwnode_graph_get_endpoint_count().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 10 ++--------
 include/linux/property.h |  8 +-------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index b48ef81ae43e..2e0ff0232b27 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1291,21 +1291,15 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_by_id);
 /**
  * fwnode_graph_get_endpoint_count - Count endpoints on a device node
  * @fwnode: The node related to a device
- * @flags: fwnode lookup flags
  * Count endpoints in a device node.
- *
- * If FWNODE_GRAPH_DEVICE_DISABLED flag is specified, also unconnected endpoints
- * and endpoints connected to disabled devices are counted.
  */
-unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
-					     unsigned long flags)
+unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *ep;
 	unsigned int count = 0;
 
 	fwnode_graph_for_each_endpoint(fwnode, ep) {
-		if (flags & FWNODE_GRAPH_DEVICE_DISABLED ||
-		    fwnode_graph_remote_available(ep))
+		if (fwnode_graph_remote_available(ep))
 			count++;
 	}
 
diff --git a/include/linux/property.h b/include/linux/property.h
index d1e80b3c9918..8b8bbbe6b5b7 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -503,19 +503,13 @@ static inline bool fwnode_graph_is_endpoint(const struct fwnode_handle *fwnode)
  * @FWNODE_GRAPH_ENDPOINT_NEXT: In the case of no exact match, look for the
  *				closest endpoint ID greater than the specified
  *				one.
- * @FWNODE_GRAPH_DEVICE_DISABLED: That the device to which the remote
- *				  endpoint of the given endpoint belongs to,
- *				  may be disabled, or that the endpoint is not
- *				  connected.
  */
 #define FWNODE_GRAPH_ENDPOINT_NEXT	BIT(0)
-#define FWNODE_GRAPH_DEVICE_DISABLED	BIT(1)
 
 struct fwnode_handle *
 fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 				u32 port, u32 endpoint, unsigned long flags);
-unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
-					     unsigned long flags);
+unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode);
 
 #define fwnode_graph_for_each_endpoint(fwnode, child)				\
 	for (child = fwnode_graph_get_next_endpoint(fwnode, NULL); child;	\
-- 
2.47.3


