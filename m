Return-Path: <linux-acpi+bounces-3751-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C4F85CBDA
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 00:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DFF2843D8
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87744154BE0;
	Tue, 20 Feb 2024 23:14:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9E135416;
	Tue, 20 Feb 2024 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470869; cv=none; b=PnMligSHN54hK1/0lwnlhyv2VK2Z4P/EOLR0Zo8l8fWYidEUi4bzXYFp+9uWw0AxMPS4B39q+u3vdxktgG17GjDyb2mY78FxwVrzIXZjO/ZOQtm7TlaW8EYowb3X0TSNxm6/zIESGa8q5kaw3GD2tLLTQs+up/Obco/djrH5lSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470869; c=relaxed/simple;
	bh=gi5yqYimXSfZxATp5y0wzz1yM/nJtUHCFzzTqFE+j7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5dPZ3Lx/vjclIXMgve+7T6Dqlf+mWPFgpfyN64BYyxbtT4vU2Xh/VzkEHYw/sKhrIEhqpSO3RsbBXG4pa+KiICFhAMQJwP+yHkeBALKahSyna4g+SQnJOOJ1xUOxLXjUKBulAb3Ly9HeOHwbNpYBv8FHiRFV518YILYRFQOs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C74C433F1;
	Tue, 20 Feb 2024 23:14:28 +0000 (UTC)
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
	Wonjae Lee <wj28.lee@samsung.com>
Subject: [PATCH v6 08/12] cxl: Set cxlmd->endpoint before adding port device
Date: Tue, 20 Feb 2024 16:12:37 -0700
Message-ID: <20240220231402.3156281-9-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220231402.3156281-1-dave.jiang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
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

Current code does not hit this issue yet since cxlmd->endpoint is not being
referenced during region discovery. However follow on code that does
performance calculations will.

Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b2a2f6c34886..9ab542e7af65 100644
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


