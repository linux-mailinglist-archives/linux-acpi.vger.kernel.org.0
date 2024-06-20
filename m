Return-Path: <linux-acpi+bounces-6544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4BA90FF9B
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365CA281C26
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 08:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94901A8C36;
	Thu, 20 Jun 2024 08:52:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C82582;
	Thu, 20 Jun 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873562; cv=none; b=ln4z0irWfFPhjZv6wX4qhF2g8WWIiS2t3tvUY4TAfAM/3xDuTJz0YyQCq+JFQzhWzfaBKjELTxuNMRhkOE77Uysqv0LNLhhqXdqVBml3gtCYuyPvPFBDTtCx2Evvghs2VuXzWdSogMWY3yWXQz2kbYMYe+5XpVdYZ/+4JJxtzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873562; c=relaxed/simple;
	bh=okCm2wVe0D8ZLfc/XFxv1YDhLYFnaLvpUiSc+s879A8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CkHf2LAuXIXUUmaSXgqhYWW8UFA7JvIcnQufDegPH1sPZ4D4li7EjduyWDVWsH1pAcioaWdprKCMbNzD4tMSZiMFvRyXPdTzVV8U71GQJ9DBLc4Z5GF9TYit+5DMmGWGIQIfteVZIr6K5f+H10OlQIWc75dZHIDpoI3D4P7Z3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp82t1718873512t4zrur79
X-QQ-Originating-IP: 4zn7f4iOsJP4yRS/7wQCfFkZ5ba6muFzvMOR+Kmm7pA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Jun 2024 16:51:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11775350901938859736
From: hongao <hongao@uniontech.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hongao <hongao@uniontech.com>
Subject: [PATCH] ACPI: button: call input_free_device when input_register_device fails
Date: Thu, 20 Jun 2024 16:51:47 +0800
Message-Id: <20240620085147.1097187-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-1

Call input_free_device when input_register_device fails.

Signed-off-by: hongao <hongao@uniontech.com>

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cc61020756be..8765e9a64404 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -602,8 +602,10 @@ static int acpi_button_add(struct acpi_device *device)
 
 	input_set_drvdata(input, device);
 	error = input_register_device(input);
-	if (error)
+	if (error) {
+		input_free_device(input);
 		goto err_remove_fs;
+	}
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:

base-commit: e5b3efbe1ab1793bb49ae07d56d0973267e65112
-- 
2.33.1


