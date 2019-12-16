Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532CB11FD86
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 05:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLPETB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Dec 2019 23:19:01 -0500
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:48074 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfLPETA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Dec 2019 23:19:00 -0500
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id xBG48Kll028133; Mon, 16 Dec 2019 13:08:22 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id xBG488Qk017365; Mon, 16 Dec 2019 13:08:09 +0900
X-Iguazu-Qid: 2wGqvJJtoWA1JGcIjc
X-Iguazu-QSIG: v=2; s=0; t=1576469288; q=2wGqvJJtoWA1JGcIjc; m=c6t1eqbr5EJEYmX/jEMSvsBS/AYPWiWSv9JFMDMFpMo=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1112) id xBG487U4027663;
        Mon, 16 Dec 2019 13:08:08 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id xBG487Re019649;
        Mon, 16 Dec 2019 13:08:07 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id xBG487r8018845;
        Mon, 16 Dec 2019 13:08:07 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     linux-serial@vger.kernel.org
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, shrirang.bagul@canonical.com,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RFC ] serdev: Only claim supported devices
Date:   Mon, 16 Dec 2019 13:08:25 +0900
X-TSB-HOP: ON
Message-Id: <20191216040825.523720-2-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216040825.523720-1-punit1.agrawal@toshiba.co.jp>
References: <20191216040825.523720-1-punit1.agrawal@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Serdev sub-system claims all serial devices that are not already
enumerated. As a result, no device node is created for serial port on
certain devices such as the Apollo Lake based UP2. This has the
unintended consequence of unable to raise the login prompt via serial
connection.

Introduce a whitelist to only register devices that are supported by
the sub-system.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/tty/serdev/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 226adeec2aed..0f414aa4d870 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -663,6 +663,10 @@ static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
 	return AE_OK;
 }
 
+static const struct acpi_device_id serdev_supported_devices[] = {
+	{ },
+};
+
 static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
 					  void *data, void **return_value)
 {
@@ -675,6 +679,10 @@ static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
 	if (acpi_device_enumerated(adev))
 		return AE_OK;
 
+	/* Skip if not supported */
+	if (acpi_match_device_ids(adev, serdev_supported_devices) == -ENOENT)
+		return AE_OK;
+
 	if (acpi_serdev_check_resources(ctrl, adev))
 		return AE_OK;
 
-- 
2.24.0

