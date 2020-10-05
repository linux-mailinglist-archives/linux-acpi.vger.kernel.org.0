Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1BD283007
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 07:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJEFL3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 01:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgJEFL3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 01:11:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2790AC0613CE;
        Sun,  4 Oct 2020 22:11:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so4806527pjr.3;
        Sun, 04 Oct 2020 22:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TRrUN+Gf55/veNHIEjtq43T0hOIwF7XqJTaOaH6RnZg=;
        b=X4QFhcL0cCi9uDY2OOfllSmNh6w4PpwN+3GBYiFXQGhfHRV5tNXUZxS+Ln1Wioq/HW
         VcAKg8C0rB8MnEeogP6smw/iddS8qdPiKzAihBfxdvk8VaxNz0fx/chjJP4Pum4r/IPN
         56vyawGAKJQHyveUFoTW/dP2iVKLTE1uR2/m7/zKt4PaiIVsBIBIK/jBroS7zPw7KytU
         O+4vtjgExRLbLrUwmP6hRnh+7vftNTq8Sa4qf0VHqwQyE1tpSBBeeh8jJfapx2QpiDx2
         KcXn6Wb27tJCmQO6OPPDpy1a34WilaCjj4EnUyDoDqKHxZZO8JI2t4erg1A6G2igC0KI
         oc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TRrUN+Gf55/veNHIEjtq43T0hOIwF7XqJTaOaH6RnZg=;
        b=LhinaBK1SpTMy/4tazFJq/Q0K1VJ8X5TexhJiFH49/1r2Lr44POES5acNqzyQSCjzf
         7cLzcfdhadv2S08LHZcQTtpiYvS0VePj+gvpCbJvNKFeN6JPG/PolHMpl3S3totLvel4
         p2S1Rw9M3Zsv8pcADC5OByllDxFchscEoRRLPHtofPLSGg12zjQhhZEariaT5JbARsXt
         aiYgu8EfWcc81BIgw+ZVZGVMUCrFUO3cwc59N4HdWskK4UgAiOdU01sDQMSYIgIX1JNS
         cDq2KKMCNzzeI5JF7b2LHUEPctxm/LGi+dC0XxaG+DL8qr+whepDe7KZeBOXayrU8ecF
         Pkkg==
X-Gm-Message-State: AOAM531zJAoJpahvMQWfU1tCpHVSsGl6nOa1dwXNA+O6Pe/7qpxMqROe
        DN4HARqUGaIMb/4sIwVgRXg=
X-Google-Smtp-Source: ABdhPJzZ6PArn6k0s5xU2CLN3JM+yv5BLjGJZeTB0/MCAElqFaQtaR+4C3bR1xGUIh5mjpykBBokEQ==
X-Received: by 2002:a17:90a:1f43:: with SMTP id y3mr14728940pjy.28.1601874688332;
        Sun, 04 Oct 2020 22:11:28 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id n7sm10606778pfq.114.2020.10.04.22.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 22:11:27 -0700 (PDT)
Date:   Sun, 4 Oct 2020 22:11:25 -0700
From:   dmitry.torokhov@gmail.com
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / button: fix handling lid state changes when input
 device closed
Message-ID: <20201005051125.GA3245495@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The original intent of 84d3f6b76447 was to delay evaluating lid state until
all drivers have been loaded, with input device being opened from userspace
serving as a signal for this condition. Let's ensure that state updates
happen even if userspace closed (or in the future inhibited) input device.

Note that if we go through suspend/resume cycle we assume the system has
been fully initialized even if LID input device has not been opened yet.

This has a side-effect of fixing access to input->users outside of
input->mutex protections by the way of eliminating said accesses and using
driver private flag.

Fixes: 84d3f6b76447 ("ACPI / button: Delay acpi_lid_initialize_state() until first user space open")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/acpi/button.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 78cfc70cb320..b8dd51d8f96d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -154,6 +154,7 @@ struct acpi_button {
 	int last_state;
 	ktime_t last_time;
 	bool suspended;
+	bool lid_state_initialized;
 };
 
 static struct acpi_device *lid_device;
@@ -384,6 +385,8 @@ static int acpi_lid_update_state(struct acpi_device *device,
 
 static void acpi_lid_initialize_state(struct acpi_device *device)
 {
+	struct acpi_button *button = acpi_driver_data(device);
+
 	switch (lid_init_state) {
 	case ACPI_BUTTON_LID_INIT_OPEN:
 		(void)acpi_lid_notify_state(device, 1);
@@ -395,13 +398,14 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
 	default:
 		break;
 	}
+
+	button->lid_state_initialized = true;
 }
 
 static void acpi_button_notify(struct acpi_device *device, u32 event)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 	struct input_dev *input;
-	int users;
 
 	switch (event) {
 	case ACPI_FIXED_HARDWARE_EVENT:
@@ -410,10 +414,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
-			mutex_lock(&button->input->mutex);
-			users = button->input->users;
-			mutex_unlock(&button->input->mutex);
-			if (users)
+			if (button->lid_state_initialized)
 				acpi_lid_update_state(device, true);
 		} else {
 			int keycode;
@@ -458,7 +459,7 @@ static int acpi_button_resume(struct device *dev)
 	struct acpi_button *button = acpi_driver_data(device);
 
 	button->suspended = false;
-	if (button->type == ACPI_BUTTON_TYPE_LID && button->input->users) {
+	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		button->last_state = !!acpi_lid_evaluate_state(device);
 		button->last_time = ktime_get();
 		acpi_lid_initialize_state(device);
-- 
2.28.0.806.g8561365e88-goog


-- 
Dmitry
