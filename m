Return-Path: <linux-acpi+bounces-3265-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F7084C00D
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 23:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C911F26106
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18941BF54;
	Tue,  6 Feb 2024 22:30:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A11BDED;
	Tue,  6 Feb 2024 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258618; cv=none; b=IylExbytFLnrudpKn6UtXbVN4hMMmwq0QOLYDqnG+3geYFUl+vNSs03AJUD8i2qEVu6lBYwaFhEFI42TdfwQ+jRphB3Pfh9KGlsDCtfmS/TWcXwoRrm+zlDbeSVXQbhZ/ub0Am851zOGnkHAJf9RCRqYuozd/Em9/I5zN376OTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258618; c=relaxed/simple;
	bh=JNUml2i+yaLHc3RQIrkNjeM7tvdF3wgWSmI0HzbHPzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDRZc6gUI3n4aylKoVJd7rJvowHhVpqxXEDkRqqPCyOdzStDStfFSPCoDQ5dkY11hg/Zz/CyI6XES/tkl/LspREnrpzURQz8zl+J8wlq7B8kUePQ07IbC5a5+EqbM/TZVU12oidSaxAPbkEqT3xDvy6VqHhN9SXEFGuWjVOxHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C88BC43390;
	Tue,  6 Feb 2024 22:30:18 +0000 (UTC)
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
	gregkh@linuxfoundation.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v5 07/12] cxl: Move QoS class to be calculated from the nearest CPU
Date: Tue,  6 Feb 2024 15:28:35 -0700
Message-ID: <20240206222951.1833098-8-dave.jiang@intel.com>
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

Retrieve the qos_class (QTG ID) using the access coordinates from the
nearest CPU rather than the nearst initiator that may not be a CPU.
This may be the more appropriate number that applications care about.

Link: https://lore.kernel.org/linux-cxl/20240112113023.00006c50@Huawei.com/
Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 79844874a34b..bd0ff3cebb8c 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -198,12 +198,12 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 		 * coordinates in order to allow calculation of access class
 		 * 0 and 1 for region later.
 		 */
-		cxl_coordinates_combine(&coord[ACCESS_COORDINATE_LOCAL],
-					&coord[ACCESS_COORDINATE_LOCAL],
+		cxl_coordinates_combine(&coord[ACCESS_COORDINATE_CPU],
+					&coord[ACCESS_COORDINATE_CPU],
 					&dent->coord);
 		dent->entries = 1;
 		rc = cxl_root->ops->qos_class(cxl_root,
-					      &coord[ACCESS_COORDINATE_LOCAL],
+					      &coord[ACCESS_COORDINATE_CPU],
 					      1, &qos_class);
 		if (rc != 1)
 			continue;
-- 
2.43.0


