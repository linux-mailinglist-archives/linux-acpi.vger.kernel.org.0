Return-Path: <linux-acpi+bounces-6687-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C55B91D40A
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700511C20A27
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAC339FD0;
	Sun, 30 Jun 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="egr/LSvP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96F433D2;
	Sun, 30 Jun 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719781027; cv=none; b=iIN8FSEgG4F+3VC4tYdOod6sJ2e41/GTh/X00eNx8U/YoAAYqQBzZpNsV7/sNBeuRf4m5a/zBKA8D8qBWw/YVSKK5AqkScY8+uRewjc578f+xfUHXyzdQCTq4T7R8HrrkXZPNEDmI+Kv+1X8xVrek60F5ErP1sqMfMaYWzDRC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719781027; c=relaxed/simple;
	bh=HfNMeLsLGK3GWeWdm8PDMkaGehstSeUbS2E/1F3j/j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlSAX712eoJx0mm3uZlpOPoqqqlBSvI+QXSNOdJ20aBwHS5eDPgCc5/bi765SwhCoQYvuh4lejyeA+UnGa3jb7rEmLO+Qv8E32ZQJtXJt/32iDHUNSx8kHGX2V0JCmN59rCNo6imlB5yjURYMItFb//IHPy7hOJ8AgFxAdQV2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=egr/LSvP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719781013;
	bh=HfNMeLsLGK3GWeWdm8PDMkaGehstSeUbS2E/1F3j/j8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=egr/LSvPDvA3j/9HdQ6I3CE5Q+GS1MMGkd4YcDK+BsqN7xlMhPTJatqAL9wzu4mbD
	 DFX2Amzxstl/cLJq0+3b7ho3jDV1gKfUin7krOfBccGpSSycmIXHdXZ8P7FbZwvi7O
	 lwULwGlHLAqi2VPQ3ev6mwYnVfaM2dRbhglrln+s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 30 Jun 2024 22:54:10 +0200
Subject: [PATCH v5 3/5] platform/chrome: cros_ec_proto: Introduce
 cros_ec_get_cmd_versions()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240630-cros_ec-charge-control-v5-3-8f649d018c52@weissschuh.net>
References: <20240630-cros_ec-charge-control-v5-0-8f649d018c52@weissschuh.net>
In-Reply-To: <20240630-cros_ec-charge-control-v5-0-8f649d018c52@weissschuh.net>
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
 Kieran Levin <ktl@framework.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719781012; l=2821;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HfNMeLsLGK3GWeWdm8PDMkaGehstSeUbS2E/1F3j/j8=;
 b=8384owFHstCikEunmP6XRgZQqzrhTs9O28evm8/2oNYKdsPzZ3MAYfO27KtPXanc3hbDGG1MR
 pKoHUW7jUyKAewTjrhCcFnGQbrbPZ8fQ8vyzkuW0WFsUwQVk+ZEKoWG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Retrieving the supported versions of a command is a fairly common
operation. Provide a helper for it.

If the command is not supported at all the EC returns
-EINVAL/EC_RES_INVALID_PARAMS.

This error is translated into an empty version mask as that is easier to
handle for callers and they don't need to know about the error details.

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/chrome/cros_ec_proto.c     | 35 +++++++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index fe68be66ee98..f776fd42244f 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -5,6 +5,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -1069,3 +1070,37 @@ int cros_ec_cmd_readmem(struct cros_ec_device *ec_dev, u8 offset, u8 size, void
 			   &params, sizeof(params), dest, size);
 }
 EXPORT_SYMBOL_GPL(cros_ec_cmd_readmem);
+
+/**
+ * cros_ec_get_cmd_versions - Get supported version mask.
+ *
+ * @ec_dev: EC device
+ * @cmd: Command to test
+ *
+ * Return: version mask on success, negative error number on failure.
+ */
+int cros_ec_get_cmd_versions(struct cros_ec_device *ec_dev, u16 cmd)
+{
+	struct ec_params_get_cmd_versions req_v0;
+	struct ec_params_get_cmd_versions_v1 req_v1;
+	struct ec_response_get_cmd_versions resp;
+	int ret;
+
+	if (cmd <= U8_MAX) {
+		req_v0.cmd = cmd;
+		ret = cros_ec_cmd(ec_dev, 0, EC_CMD_GET_CMD_VERSIONS,
+				  &req_v0, sizeof(req_v0), &resp, sizeof(resp));
+	} else {
+		req_v1.cmd = cmd;
+		ret = cros_ec_cmd(ec_dev, 1, EC_CMD_GET_CMD_VERSIONS,
+				  &req_v1, sizeof(req_v1), &resp, sizeof(resp));
+	}
+
+	if (ret == -EINVAL)
+		return 0; /* Command not implemented */
+	else if (ret < 0)
+		return ret;
+	else
+		return resp.version_mask;
+}
+EXPORT_SYMBOL_GPL(cros_ec_get_cmd_versions);
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 6e9225bdf903..b34ed0cc1f8d 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -263,6 +263,8 @@ int cros_ec_cmd(struct cros_ec_device *ec_dev, unsigned int version, int command
 
 int cros_ec_cmd_readmem(struct cros_ec_device *ec_dev, u8 offset, u8 size, void *dest);
 
+int cros_ec_get_cmd_versions(struct cros_ec_device *ec_dev, u16 cmd);
+
 /**
  * cros_ec_get_time_ns() - Return time in ns.
  *

-- 
2.45.2


