Return-Path: <linux-acpi+bounces-2946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F775832E11
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 18:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A29B23E4A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13455C39;
	Fri, 19 Jan 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gY7k3TeM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8DF54BEE;
	Fri, 19 Jan 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685014; cv=none; b=iZC5F4GfVVbadsZhgrdaF5bzYBGertImnLrU7GWCg4MfTeyy3hZ292ansW3VpGe/GPMloeXkPBOc986Ov7WW99e7l0vKOJ//TNyGSNh/QE7LpRnnlxcbuk1qUCZiCYTnSPAQpbI8mIOSNQAn1dCoRvCUtaGC/1OnDNWntxie2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685014; c=relaxed/simple;
	bh=2ib7jsfMdFbHGpgSI+1hplU7d9cLjkAxO61RlQoVxhU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/4p3WsRYWo/f6bvptRz+zDHPOYc12XV1HT+Hed19ZYpk6elYEidCxSFZALCHCZoGn+nggKqFctcu+qSzADtQvrGTpuOlEvTR1eGLBEiFmqHXDUkkLjQHYb4OUcmpsDdwY2CAjmcs9xmUSFpIF+B0o9RtONQBZy7h+meKUXngx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gY7k3TeM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705685012; x=1737221012;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ib7jsfMdFbHGpgSI+1hplU7d9cLjkAxO61RlQoVxhU=;
  b=gY7k3TeMpHh8Pb6mlscRlnPN1JbH3j0oVwBMS/i3AiZ1ZLimfZdVOI8r
   NyrJCaT88AqXZ2nFmlneBEsoHJafatJoKpbw3ic38cGrAao55kuFYB1MB
   eDWNXpqaWr2JyfMlOSisDorNa7uBB9jUNLPlaYASEzfqBHaR46Eq/MADl
   diTLjUzwYQxwAc3hXZCk0DazrOOhYsXUHIBN1RnoUnDc4ZZIMc82Ul7Xf
   CAWb9BWGhEGoOEtCDJ5/qnr2tIM2c2uddeIBit7pA0yutFi697oGKCBag
   Q9XOHRjCTEHR0iKtALXxrtI9XqLmwtnD9rBsK4Zu65RnAJZqUdgFdcQVf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="7487398"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7487398"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="1032001684"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="1032001684"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.22])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:28 -0800
Subject: [PATCH v4 04/11] ACPI: HMAT / cxl: Add retrieval of generic port
 coordinates for both access classes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, brice.goglin@gmail.com,
 nifan.cxl@gmail.com, rafael@kernel.org, gregkh@linuxfoundation.org
Date: Fri, 19 Jan 2024 10:23:28 -0700
Message-ID: <170568500862.1008395.4154683379461229187.stgit@djiang5-mobl3>
In-Reply-To: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
References: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Update acpi_get_genport_coordinates() to allow retrieval of both access
classes of the 'struct access_coordinate' for a generic target. The update
will allow CXL code to compute access coordinates for both access class.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |    8 ++++++--
 drivers/cxl/acpi.c       |    8 +++++---
 drivers/cxl/core/port.c  |    2 +-
 drivers/cxl/cxl.h        |    2 +-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 8dbb0e366059..5be79896bd08 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -126,7 +126,8 @@ static struct memory_target *acpi_find_genport_target(u32 uid)
 /**
  * acpi_get_genport_coordinates - Retrieve the access coordinates for a generic port
  * @uid: ACPI unique id
- * @coord: The access coordinates written back out for the generic port
+ * @coord: The access coordinates written back out for the generic port.
+ *	   Expect 2 levels array.
  *
  * Return: 0 on success. Errno on failure.
  *
@@ -142,7 +143,10 @@ int acpi_get_genport_coordinates(u32 uid,
 	if (!target)
 		return -ENOENT;
 
-	*coord = target->coord[NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL];
+	coord[ACCESS_COORDINATE_LOCAL] =
+		target->coord[NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL];
+	coord[ACCESS_COORDINATE_CPU] =
+		target->coord[NODE_ACCESS_CLASS_GENPORT_SINK_CPU];
 
 	return 0;
 }
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index afc712264d1c..7834fc208229 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -522,13 +522,15 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
 	if (kstrtou32(acpi_device_uid(hb), 0, &uid))
 		return -EINVAL;
 
-	rc = acpi_get_genport_coordinates(uid, &dport->hb_coord);
+	rc = acpi_get_genport_coordinates(uid, dport->hb_coord);
 	if (rc < 0)
 		return rc;
 
 	/* Adjust back to picoseconds from nanoseconds */
-	dport->hb_coord.read_latency *= 1000;
-	dport->hb_coord.write_latency *= 1000;
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		dport->hb_coord[i].read_latency *= 1000;
+		dport->hb_coord[i].write_latency *= 1000;
+	}
 
 	return 0;
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8c00fd6be730..7a5eff45e1e2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2151,7 +2151,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	}
 
 	/* Augment with the generic port (host bridge) perf data */
-	combine_coordinates(&c, &dport->hb_coord);
+	combine_coordinates(&c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
 
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 492dbf63935f..0fc06455233d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -673,7 +673,7 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct cxl_regs regs;
 	struct access_coordinate sw_coord;
-	struct access_coordinate hb_coord;
+	struct access_coordinate hb_coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
 };
 



