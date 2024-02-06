Return-Path: <linux-acpi+bounces-3262-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BDD84C00A
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 23:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA5D2859D3
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8025B1C282;
	Tue,  6 Feb 2024 22:30:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECF1BF20;
	Tue,  6 Feb 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258613; cv=none; b=u4+BxfJosGB5afC6PwE7tQnwAknn6SUG7OcOixm+iIlG/JpOfoTc6PTSDQpli7Elgsc/I31WMkllkkL2mr4aQL97Fksj0iKTjp2a4TTwK/tXRaII/Dhs6yMQOPafxRhGMK2P9/rUlmbSjSFdaqbaVFnWdEcBlEhX/nbSplHBDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258613; c=relaxed/simple;
	bh=ClVCK76BQzHiFDNMyqXKcwEPWfcURKCmfEvO/UrKXH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0okcFr0cRsCMoJxqdRhF+yzPiePnSbsjnkrME7TW3016kQycTPLmhoiUA5iUBa5z5F+z6p/pHssoiD17Ifbj/yZy8NXsnLZva79QZ6W5XEcIFCpFI/iSDhDPqVglse4bKEou2kCKA/IeKjkgid3pQ9F+XuUqnyANmJllSkUZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CBDC433F1;
	Tue,  6 Feb 2024 22:30:12 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	rafael@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v5 04/12] ACPI: HMAT / cxl: Add retrieval of generic port coordinates for both access classes
Date: Tue,  6 Feb 2024 15:28:32 -0700
Message-ID: <20240206222951.1833098-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206222951.1833098-1-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update acpi_get_genport_coordinates() to allow retrieval of both access
classes of the 'struct access_coordinate' for a generic target. The update
will allow CXL code to compute access coordinates for both access class.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c | 8 ++++++--
 drivers/cxl/acpi.c       | 8 +++++---
 drivers/cxl/core/port.c  | 2 +-
 drivers/cxl/cxl.h        | 2 +-
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
index dcf2b39e1048..2bf543221c6f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -520,13 +520,15 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
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
index e59d9d37aa65..612bf7e1e847 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2152,7 +2152,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	}
 
 	/* Augment with the generic port (host bridge) perf data */
-	combine_coordinates(&c, &dport->hb_coord);
+	combine_coordinates(&c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
 
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 003feebab79b..fe7448f2745e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -671,7 +671,7 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct cxl_regs regs;
 	struct access_coordinate sw_coord;
-	struct access_coordinate hb_coord;
+	struct access_coordinate hb_coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
 };
 
-- 
2.43.0


