Return-Path: <linux-acpi+bounces-6290-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9589490260B
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 17:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875ED1C21C6E
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C54142E8D;
	Mon, 10 Jun 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GVWNEYq4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92D13FD84;
	Mon, 10 Jun 2024 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034731; cv=none; b=GjHT4WqMPI1bp9haXy5p4YY4mgTjtZMAGcHokvo3l1rjjaZLp+TkEH6K03iSIienBHBUwA+/gY9BD9ZxjR8g2f4HR1OQRP8SPa4BYDNCPSpF9ykb7dcu8UDtn+xQnwchZKI/98OlTnLckkVgaYyw13GXHbHITw95S8Kbif4O1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034731; c=relaxed/simple;
	bh=fw/y4pJzNvdZK5afG+PBEc6PoUftleG4LWfjkyyWgdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lePg21Xo9Vff2TOg0gwEMlIFL83TrXEr07QqStGw8lsz4xA9Qnlsmo/CvA+NV1wkN+eys8wVZh+hyooS5EtbpO/724k4hEEVOe2tjzLLu3W/BauH9L0w8hy0G5vtAOQC+bf+/CLJEMKCOc7XXXkZF9XmHf14TRuCyIiyt6ttzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GVWNEYq4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718034727;
	bh=fw/y4pJzNvdZK5afG+PBEc6PoUftleG4LWfjkyyWgdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GVWNEYq4y+p2k1nI1DUXu7alKrv2JzMLdd7m1xEYzSdZPco7wja8EFfrCcprjytw/
	 EolLTnczB1aUEbmoq3VqgAq1en1p0ifc3aYwylU4wMucr9gcnQt15PvtkyZ8ovW1OU
	 Cy2feObWyJHw4bgYSj7PEpZVKihVA7RuMSBMup4I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 10 Jun 2024 17:51:08 +0200
Subject: [PATCH v3 3/5] platform/chrome: cros_ec_proto: Introduce
 cros_ec_cmd_versions()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240610-cros_ec-charge-control-v3-3-135e37252094@weissschuh.net>
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
In-Reply-To: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Matt Hartley <matt.hartley@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718034726; l=2290;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fw/y4pJzNvdZK5afG+PBEc6PoUftleG4LWfjkyyWgdE=;
 b=YwRtoGnULOkQW4zC7aYLAfiJtPtABdChOCDtEiivHlKe43kEW31FZZYr/2i5RDBLTZ/6hSZ8+
 0ubd9utJXmHBNaKggVI2w2zDtjYRcWiUroX+AJrud72Oq4MN0Yz7I5J
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Retrieving the supported versions of a command is a fairly common
operation. Provide a helper for it.

If the command is not supported at all the EC returns
-EINVAL/EC_RES_INVALID_PARAMS.

This error is translated into an empty version mask as that is easier to
handle for callers and they don't need to know about the error details.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/chrome/cros_ec_proto.c     | 26 ++++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index fe68be66ee98..9cfe885a5301 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -1069,3 +1069,29 @@ int cros_ec_cmd_readmem(struct cros_ec_device *ec_dev, u8 offset, u8 size, void
 			   &params, sizeof(params), dest, size);
 }
 EXPORT_SYMBOL_GPL(cros_ec_cmd_readmem);
+
+/**
+ * cros_ec_cmd_versions - Get supported version mask.
+ *
+ * @ec_dev: EC device
+ * @cmd: Command to test
+ *
+ * Return: version mask on success, negative error number on failure.
+ */
+int cros_ec_cmd_versions(struct cros_ec_device *ec_dev, u16 cmd)
+{
+	struct ec_params_get_cmd_versions_v1 req = {};
+	struct ec_response_get_cmd_versions resp;
+	int ret;
+
+	req.cmd = cmd;
+	ret = cros_ec_cmd(ec_dev, 1, EC_CMD_GET_CMD_VERSIONS,
+			  &req, sizeof(req), &resp, sizeof(resp));
+	if (ret == -EINVAL)
+		return 0; /* Command not implemented */
+	else if (ret < 0)
+		return ret;
+	else
+		return resp.version_mask;
+}
+EXPORT_SYMBOL_GPL(cros_ec_cmd_versions);
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 6e9225bdf903..98ab5986f543 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -263,6 +263,8 @@ int cros_ec_cmd(struct cros_ec_device *ec_dev, unsigned int version, int command
 
 int cros_ec_cmd_readmem(struct cros_ec_device *ec_dev, u8 offset, u8 size, void *dest);
 
+int cros_ec_cmd_versions(struct cros_ec_device *ec_dev, u16 cmd);
+
 /**
  * cros_ec_get_time_ns() - Return time in ns.
  *

-- 
2.45.2


