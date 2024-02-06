Return-Path: <linux-acpi+bounces-3266-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F4D84C00E
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 23:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7481F23BF3
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7AD1C2AE;
	Tue,  6 Feb 2024 22:30:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9B1C283;
	Tue,  6 Feb 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258620; cv=none; b=RPQGsBl1peIOuOoBRt/1i6rSWC0/6QppornuMGx5iq1FDzHbYmAW74RAsPXc9c2UocentryqDQr00pJtnTGD+HuvIVezmlPjE7/WeG+FIM+bGfAndqWNa0nu02c8ad6QwDRxIU1UcUYiLgp/bKozuIV5l9Hwn3Q7kAMKo0GuvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258620; c=relaxed/simple;
	bh=VaexH3yxKpZg6/OZXdnvDMiwFOX+QkvPIE5yIczuULs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQv1IljqlfvERh2XCCRziL1wMBkwOmLZVxd9zDRdwEFY0iKHAgZAsrz4vrdRvAwG2ezhi3kqm7NlxMdfQVbbPiGYTwmH6U5PmDcXyPE3hr7tZ2VXDfSRNR6Hzk+bpmPWgDBeUoBYWrgX4G/2OmMuoo2kYQkfRoRqv92A+J7erfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7685C433C7;
	Tue,  6 Feb 2024 22:30:19 +0000 (UTC)
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
Subject: [PATCH v5 08/12] cxl: Set cxlmd->endpoint before adding port device
Date: Tue,  6 Feb 2024 15:28:36 -0700
Message-ID: <20240206222951.1833098-9-dave.jiang@intel.com>
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

Move setting of cxlmd->endpoint to before calling add_device() on the port
device. Otherwise when referencing cxlmd->endpoint in region discovery code
that is triggered by the port driver probe function, the endpoint port
pointer is not valid.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e8029170b8c6..2f2b7af9275e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -822,6 +822,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 		 */
 		port->reg_map = cxlds->reg_map;
 		port->reg_map.host = &port->dev;
+		cxlmd->endpoint = port;
 	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
 		if (rc)
@@ -1374,7 +1375,6 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 
 	get_device(host);
 	get_device(&endpoint->dev);
-	cxlmd->endpoint = endpoint;
 	cxlmd->depth = endpoint->depth;
 	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
 }
-- 
2.43.0


