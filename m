Return-Path: <linux-acpi+bounces-11741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC34DA4CD78
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 22:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBAA173CED
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2B1EEA36;
	Mon,  3 Mar 2025 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhU53xHk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD4148316
	for <linux-acpi@vger.kernel.org>; Mon,  3 Mar 2025 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037246; cv=none; b=se8qc6Ds59CSHjxjQCw5vYKETrfPbuWaXh/P6iMlKU+Yv4cF5g0ED+AQzd0kBWd7O1OHk13SPHux4qv1VOPbunvx4pOLXqrU3BBwRW15c0xw+kK/+x2d6hPGo7xHV6LtSP1Tx8ux0HIEdo8AIWAJiYjlmfiG8FQ7sYDASg+C9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037246; c=relaxed/simple;
	bh=kyTAF5oP42cj5EqanLbUt92SwRxyFXVD6MHQi6ixHPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6uq2xWYEcGUSbIYRRSZKDp7hyFEJqOHkaLVBvJYuWoCMKegh0KQkFt5S+D+zBZPIwMO3NsKzvhGM1OrJUO4eXpdErqe5oiaTkPs8FZXefsyC/wojhDRaZnOUwjNvKo/D1rFc3YAYjPJoFkCNNikgZ8rVlh0q+MM7uTjzBaSUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhU53xHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3032CC4CED6;
	Mon,  3 Mar 2025 21:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741037245;
	bh=kyTAF5oP42cj5EqanLbUt92SwRxyFXVD6MHQi6ixHPc=;
	h=From:To:Cc:Subject:Date:From;
	b=YhU53xHkOJNQ6KE2vPRw6ryzcUZCcfwXBBFr2I/AqmmdXWXUp1GTphEpz9u3J8RIA
	 4p8NTTz6iWTsrHyrMy/kRZ40DDZq2NNdomL90QUZrqqRlgjnVm3bEiWajSJSoet48M
	 IIVAlQuythJ480+erjdhjptlpPhKXBBfDqr3EI2StBfIQcLi8gMAM4Jyzr7OLx/uJD
	 gZR5BllXWoQvuQJn0cmabi+zWiKM2+2EEfWM2BSWzmL+Xog3jjzZTYvMCDrmfJ3dr6
	 tfp1eJYWz+0eBwYiVbXQEuZNZZvHWs0OkUPicaIBpwbjHNfP4t8KZT1uG/deo3jsFE
	 /23yCVLiBQaig==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org
Cc: Yijun Shen <Yijun.Shen@dell.com>,
	Richard Gong <Richard.Gong@amd.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: button: Install notifier for system events as well
Date: Mon,  3 Mar 2025 15:27:09 -0600
Message-ID: <20250303212719.4153485-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On some systems when the system is put to sleep pressing the ACPI power
button will cause the EC SCI to try to wake the system by a Notify(DEV, 0x2)
with an intention to wake the system up from suspend.

This behavior matches the ACPI specification in ACPI 6.4 section
4.8.3.1.1.2 which describes that the AML handler would generate a Notify()
with a code of 0x2 to indicate it was responsible for waking the system.

This currently doesn't work because acpi_button_add() only configured
`ACPI_DEVICE_NOTIFY` which means that device handler notifications
0x80 through 0xFF are handled.

To fix the wakeups on such systems, adjust the ACPI button handler to
use `ACPI_ALL_NOTIFY` which will handle all events 0x00 through 0x7F.

Reported-by: Yijun Shen <Yijun.Shen@dell.com>
Tested-by: Richard Gong <Richard.Gong@amd.com>
Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/04_ACPI_Hardware_Specification/ACPI_Hardware_Specification.html?highlight=0x2#control-method-power-button
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/button.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 7773e6b860e73..61701c646e92f 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -24,6 +24,7 @@
 #define ACPI_BUTTON_CLASS		"button"
 #define ACPI_BUTTON_FILE_STATE		"state"
 #define ACPI_BUTTON_TYPE_UNKNOWN	0x00
+#define ACPI_BUTTON_NOTIFY_WAKE		0x02
 #define ACPI_BUTTON_NOTIFY_STATUS	0x80
 
 #define ACPI_BUTTON_SUBCLASS_POWER	"power"
@@ -443,11 +444,16 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 	struct input_dev *input;
 	int keycode;
 
-	if (event != ACPI_BUTTON_NOTIFY_STATUS) {
+	switch (event) {
+	case ACPI_BUTTON_NOTIFY_STATUS:
+		break;
+	case ACPI_BUTTON_NOTIFY_WAKE:
+		break;
+	default:
 		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
 				  event);
 		return;
-	}
+	};
 
 	acpi_pm_wakeup_event(&device->dev);
 
@@ -629,7 +635,7 @@ static int acpi_button_add(struct acpi_device *device)
 		break;
 	default:
 		status = acpi_install_notify_handler(device->handle,
-						     ACPI_DEVICE_NOTIFY, handler,
+						     ACPI_ALL_NOTIFY, handler,
 						     device);
 		break;
 	}
-- 
2.43.0


