Return-Path: <linux-acpi+bounces-9593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F49CD5A6
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 03:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1D3283226
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B48B154444;
	Fri, 15 Nov 2024 02:54:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9327DA67
	for <linux-acpi@vger.kernel.org>; Fri, 15 Nov 2024 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639269; cv=none; b=rzNFyQDLcMlSP+ok6MG2IXu26RVcgxISTDxmhWT9eHORmHeWlhWnL5eni6qcNVqP8RFrAVRRG5HQdvv2y96kzRYgFazpD0/Y+WuGh2hyZMa821+uxtlUajZe3bmjAxRR4sxy/xgmNxeawNqqL4dVkLyZgpmE2SjRFDUVMhVAwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639269; c=relaxed/simple;
	bh=vzvUth6pPKX0APV+9gg/FozHqHbl5cf00pO6spsPTS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W6kgWb8PzIsB/VgRv1GsXuIZwvA38AB4FaQbJzqRZZC7IQXIVhIWoTcMTVsI5/5n21tKbQD+ds1X8p1+25L32VEB6bIOnBafa/AGbLFzK5AeAumTlokPXXQTQ5T4t/uFn978ltZUXXlIxHN2Cps8g93Oj6p3xsYMkwMVLlU2Ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHzd3FtzZnWTRGAQ--.20657S2;
	Fri, 15 Nov 2024 10:53:57 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwCH3XnEtzZn+WJQAA--.48875S3;
	Fri, 15 Nov 2024 10:53:57 +0800 (CST)
From: Xiong Yining <xiongyining1480@phytium.com.cn>
To: rafael@kernel.org,
	len@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linx-kernel@vger.kernel.org,
	Xiong Yining <xiongyining1480@phytium.com.cn>
Subject: [PATCH 1/1] acpi_driver: add CONFIG_ACPI_KERN_DEBUG config to enable KERN_DEBUG
Date: Fri, 15 Nov 2024 02:53:51 +0000
Message-Id: <20241115025351.85283-1-xiongyining1480@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCH3XnEtzZn+WJQAA--.48875S3
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQAJBmc1AywFawAHsa
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=xiongyinin
	g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJr1xWF43AryktFWkWF17ZFb_yoW8GFWUpF
	Zav3WxCr47Ja15Gw4xA3yI9FW3ta9FkrWakFW8X3sxWFy5CFy5Ar1v9Fy7AFyDX3ZrGrWf
	tFnxWF17GFyDJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

In the API module, there is no unified configuration switch to control debug 
output, and the current approach is to enable debugging by adding "define DEBUG"
in the file, which is both cumbersome and difficult to manage. a global debug config 
to control the debug output of the ACPI module will be more easily and clearly.

Signed-off-by: Xiong Yining <xiongyining1480@phytium.com.cn>

---
 drivers/acpi/Kconfig  | 6 ++++++
 drivers/acpi/Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index cee82b473dc5..ea198ead57d7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -479,6 +479,12 @@ config ACPI_REDUCED_HARDWARE_ONLY
 
 	  If you are unsure what to do, do not enable this option.
 
+config ACPI_KERN_DEBUG
+	bool "Acpi kernel debugging"
+	help
+	  This is an option for use by developers, most people should
+	  say N here. This enables ACPI driver KERN_DEBUG.
+
 source "drivers/acpi/nfit/Kconfig"
 source "drivers/acpi/numa/Kconfig"
 source "drivers/acpi/apei/Kconfig"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index eaa09bf52f17..d0a417e73071 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -4,6 +4,7 @@
 #
 
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
+ccflags-$(CONFIG_ACPI_KERN_DEBUG)	:= -DDEBUG
 
 #
 # ACPI Boot-Time Table Parsing
-- 
2.34.1


