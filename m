Return-Path: <linux-acpi+bounces-4215-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A524E876C9F
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 23:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461DAB21942
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 22:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2DF5FB99;
	Fri,  8 Mar 2024 22:01:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321B5E06C;
	Fri,  8 Mar 2024 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935316; cv=none; b=B9nKpcGcdZVbm9bWYtx03HRMVgzHOznnhM/xwI7x9PNkdNdTYGYE2eYNGpB66kTd9JySPqSl3XMpQDVHzbVsF1DZd58kGHIvzG3z2wHn6TOLsz45KzmSwbeAfcTpDywFUVNtK8Nf9FlxBYNfa5ygFFqQ3uB9skpUGiXePtDadgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935316; c=relaxed/simple;
	bh=3PIPwvDnkhzQMPyjLryKu08GoMPCcHaZXnHkjw42dqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1DP99TtmkULYRCTYBj4YBK+Mrbd73feBI0N7jfzJANkbR1BTYJG04OaCVKTM6H2zR92y84M5yTBfSCMV2ntF+1CXx3fT3r7Xx/2SB1yDN5djs14LE7QrnZ9bYFtpVo2fHal10W5FWEWX80AGjHJMxWInlr85RrUIX62j3yc+Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9871CC433C7;
	Fri,  8 Mar 2024 22:01:55 +0000 (UTC)
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
Subject: [PATCH v7 08/12] cxl: Set cxlmd->endpoint before adding port device
Date: Fri,  8 Mar 2024 14:59:27 -0700
Message-ID: <20240308220055.2172956-9-dave.jiang@intel.com>
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

Move setting of cxlmd->endpoint to before calling add_device() on the port
device. Otherwise when referencing cxlmd->endpoint in region discovery code
that is triggered by the port driver probe function, the endpoint port
pointer is not valid.

Current code does not hit this issue yet since cxlmd->endpoint is not being
referenced during region discovery. However follow on code that does
performance calculations will.

Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
2.44.0


