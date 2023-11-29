Return-Path: <linux-acpi+bounces-1906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5227FD470
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 11:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23554283336
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 10:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FB3101C0
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h0sVgehh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91DE8AF;
	Wed, 29 Nov 2023 00:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=xpJTTKdHjlMBDZ7Oqe
	lLGxQdRARxit/bAj42fJtrMCk=; b=h0sVgehhTNhFRzv849YRR8Xr9gsPP/wulp
	J+H8chFOrVTHNwTrKV52UA4Uy9OAFQ2v91g4+VWSh/BuCUvgp+E8Kd9FxPVg/ltC
	0Rz4+WXuDl6TEuny97NhDrnlH+fLaGx5bABi+6s/QAs5e8I3KnrBx+tQUseLugoN
	aBKayErMM=
Received: from localhost.localdomain (unknown [39.144.190.126])
	by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wAH6_yJ+WZlBfKnAA--.15849S2;
	Wed, 29 Nov 2023 16:42:50 +0800 (CST)
From: Haoran Liu <liuhaoran14@163.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [ACPI] sbshc: Add error handling for acpi_driver_data
Date: Wed, 29 Nov 2023 00:42:47 -0800
Message-Id: <20231129084247.32443-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wAH6_yJ+WZlBfKnAA--.15849S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr48ur13Aw47tF1fur4rXwb_yoW8Gry8pF
	ZFgry7C3y8Gr47Krn3CFsYvFy5ua1Iv3srKF4xG34fWa1Uury5u3sYya40ya4jkFWxGF4I
	vw1UJFyruF4DZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEPl8UUUUUU=
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZQE3gl8ZaQm27gAAsv
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

This patch enhances the acpi_smbus_hc_add and acpi_smbus_hc_remove
functions in drivers/acpi/sbshc.c by adding error handling for the
acpi_driver_data calls. Previously, these functions did not check
the return value of acpi_driver_data, potentially leading to
stability issues if the function failed and returned a null pointer.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/acpi/sbshc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 16f2daaa2c45..1394104d3894 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -267,6 +267,12 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
 	init_waitqueue_head(&hc->wait);
 
 	hc->ec = acpi_driver_data(acpi_dev_parent(device));
+	if (!hc->ec) {
+		pr_err("Failed to retrieve parent ACPI device data\n");
+		kfree(hc);
+		return -ENODEV;
+	}
+
 	hc->offset = (val >> 8) & 0xff;
 	hc->query_bit = val & 0xff;
 	device->driver_data = hc;
@@ -288,6 +294,11 @@ static void acpi_smbus_hc_remove(struct acpi_device *device)
 		return;
 
 	hc = acpi_driver_data(device);
+	if (!hc) {
+		pr_err("Failed to retrieve ACPI SMBus HC data\n");
+		return;
+	}
+
 	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
 	acpi_os_wait_events_complete();
 	kfree(hc);
-- 
2.17.1


