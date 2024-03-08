Return-Path: <linux-acpi+bounces-4214-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51967876C9E
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 23:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529871C20ABD
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197D65E06C;
	Fri,  8 Mar 2024 22:01:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027E5CDC9;
	Fri,  8 Mar 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935310; cv=none; b=lgGtzXby7z1M0D/SNwWRSfvKvfIpVU0KUOdjOCVci333gI7AEb5nZLAXXSdiADuyzHsdHx1q9KIKel5KxC5pzu4haYtHm5B5siubxgR1v6JPcE/ga193+nYOS2ziaEWkxh0x0gVWfcevg48ul2QsuJfa35SEy7tLk+QWdfkEnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935310; c=relaxed/simple;
	bh=geh/NoNTjRBdF55Ayfusi3WYtHsbepil0b/tcg8sUEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlaEv17gjQHYdfLUqo9gXtQcvI2oeuNRBuHvJKiG1F6CH+CuXZBadjaWh98Tezu4gl+9f7mElSg948cIp4nKlNPAciAENQFA/U3coNJhZJp2lhZghi/CjbvYFiFLLnAwUtFvQ8/qYtjtY5BzblbDzp0L4L//Zzb7D9e4r2641qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010E9C433C7;
	Fri,  8 Mar 2024 22:01:48 +0000 (UTC)
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
Subject: [PATCH v7 07/12] cxl: Move QoS class to be calculated from the nearest CPU
Date: Fri,  8 Mar 2024 14:59:26 -0700
Message-ID: <20240308220055.2172956-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308220055.2172956-1-dave.jiang@intel.com>
References: <20240308220055.2172956-1-dave.jiang@intel.com>
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

For most cases, access0 and access1 have the same values.

Link: https://lore.kernel.org/linux-cxl/20240112113023.00006c50@Huawei.com/
Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 04dfda9d1f1b..02e97a90a43c 100644
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
2.44.0


