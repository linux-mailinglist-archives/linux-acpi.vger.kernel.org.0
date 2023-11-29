Return-Path: <linux-acpi+bounces-1904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A68B7FD0F5
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 09:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9889CB20A34
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811D125A1
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FFRABG8n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09F4BBF;
	Tue, 28 Nov 2023 23:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Eg+ZzyXZk8yqeNmbK6
	JWXWPVhXmFOC2yU/DrurhhVDs=; b=FFRABG8ndd8I5OxwXp1jMr9ZSx22M10Yq7
	nyqLp7S0z1OCr2zCf+TcUwSdAelfEChOQkedrAfRVtAbS5GEFlz+Cc03g99KAjhD
	dcAuceiDr7/KIELR3IyvurYr99aPGkeXD8HkhpMZd4Zy4BeKm5TE9bZrQAhDUWdY
	Qv4LiVO2A=
Received: from localhost.localdomain (unknown [39.144.190.126])
	by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wD3n10F5WZlADXrEA--.37816S2;
	Wed, 29 Nov 2023 15:15:18 +0800 (CST)
From: Haoran Liu <liuhaoran14@163.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [ACPI] fan_core: Add error handling in fan_set_state_acpi4
Date: Tue, 28 Nov 2023 23:15:14 -0800
Message-Id: <20231129071514.31486-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3n10F5WZlADXrEA--.37816S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry7tFyUKF13XFyfZF1UWrg_yoWftrb_u3
	WkZryxWFn8C3WxKa1IkFZ8ZryIkrnxXFs5uF42qFyfCry8ZryrXr1jvrnF9wnrXws5Crsr
	ta13Ww1IkwnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_a9aDUUUUU==
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwgw3glc661WbqgABsY
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

This patch introduces error handling for the acpi_driver_data
call within the fan_set_state_acpi4 function in
drivers/acpi/fan_core.c. Previously, the function did not account
for potential null returns from acpi_driver_data, which could
lead to instability if encountered.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/acpi/fan_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 9dccbae9e8ea..f2553a47a705 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -154,6 +154,12 @@ static int fan_set_state_acpi4(struct acpi_device *device, unsigned long state)
 	u64 value = state;
 	int max_state;
 
+	if (!fan) {
+		pr_err("%s: No ACPI fan data "
+			"associated with the device\n", __func__);
+		return -ENODEV;
+	}
+
 	if (fan->fif.fine_grain_ctrl)
 		max_state = 100 / fan->fif.step_size;
 	else
-- 
2.17.1


