Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4A51D56CC
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgEOQxi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 12:53:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45958 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgEOQxf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2020 12:53:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id A53572A02C7
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 3/7] ACPI: button: Use input_device_enabled() helper
Date:   Fri, 15 May 2020 18:53:27 +0200
Message-Id: <20200515165327.29212-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515164943.28480-1-andrzej.p@collabora.com>
References: <20200515164943.28480-1-andrzej.p@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A new helper is available, so use it. Inspecting input device's 'users'
member should be done under device's mutex, so add appropriate invocations.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/acpi/button.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 78cfc70cb320..7e081bae48ab 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -411,7 +411,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
 			mutex_lock(&button->input->mutex);
-			users = button->input->users;
+			users = input_device_enabled(button->input);
 			mutex_unlock(&button->input->mutex);
 			if (users)
 				acpi_lid_update_state(device, true);
@@ -456,13 +456,17 @@ static int acpi_button_resume(struct device *dev)
 {
 	struct acpi_device *device = to_acpi_device(dev);
 	struct acpi_button *button = acpi_driver_data(device);
+	struct input_dev *input = button->input;
 
 	button->suspended = false;
-	if (button->type == ACPI_BUTTON_TYPE_LID && button->input->users) {
+	mutex_lock(&input->mutex);
+	if (button->type == ACPI_BUTTON_TYPE_LID &&
+	    input_device_enabled(input)) {
 		button->last_state = !!acpi_lid_evaluate_state(device);
 		button->last_time = ktime_get();
 		acpi_lid_initialize_state(device);
 	}
+	mutex_unlock(&input->mutex);
 	return 0;
 }
 #endif
-- 
2.17.1

