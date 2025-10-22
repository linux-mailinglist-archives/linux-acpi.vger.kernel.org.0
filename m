Return-Path: <linux-acpi+bounces-18068-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F4BF9E9F
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 06:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350E5468680
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 04:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D02D73A5;
	Wed, 22 Oct 2025 04:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWIAvNof"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C2F2D594B
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106146; cv=none; b=cp/LXSPCKp+PNvX7oT2EFgbJBBnQD047nzXFKENz6s290gYUrlvRznA9OJprb9G5c4dSzAf2vjRi9QvwkWaU4WGaw5aORRUWxWijIA1WQm4JXPatYHRReALS+BkSJvV1FwLWmAsWg55GPwHZL3fw/GYJQhCIG+KY8svlf8RLW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106146; c=relaxed/simple;
	bh=MW4it84Oe/dptYdFMqsXjx3kV/biDh03d8d64XgDmRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ojlIDQBp5y1JvEvwsCO5dYMXhHPXVmtMgje33GCBNthjw2oOmj76n/MNEfiJSI4MOyrLBcqQkSH01VyPhGEfXDgFr3oxGYC4FKdIny+QiOoSpQuxOanx7Sacy0jg1THaShAg+eW/exrym1HsWKlWVYCLwdnp4u2EoDo0alMNi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWIAvNof; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso549886139f.3
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 21:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761106143; x=1761710943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEw5FbM3fIxysAn/HQ5qF+JSuajA12j38hiocn2pFY4=;
        b=HWIAvNofpJdOh0q2a4NzIJAHNkchFnOIfkO/t9+VHppTWoYbrUmnqFkOpf7Qmu21rN
         j+FplWlP50AriG3xaG5CA2zskh3wE5Ze+8Wv/QJptDgZmWDIOIkL9Re5BWbdU3F69Vol
         R0xgsvyPGbkb2HEWc2dXYLq9A+MJmkKku2OLnDg4/JzQhS7yi+sEBeKj4ynMCFjZBmb1
         Mnv4tUUTmT3V5Qm/un63N5GxdajYstdhzYaHUwLBQuWfgPwN8X0s1WAEYg2CewksuXzb
         vo548yHqTpfkylVjthYo/gejEKJf2RHABmS1SEBRjcpxWMBNbIhT1PPK6YinAsB5jb3D
         Z3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106143; x=1761710943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEw5FbM3fIxysAn/HQ5qF+JSuajA12j38hiocn2pFY4=;
        b=DJ2JGwF7YxuJnj42BskDgbQRIn1C+R/L2knBbXnBttb4uJkZIIFFLdkNMKMYNHDFbM
         re7IA8im7ek3f6VousKpX+GPEA139j8Av5PmyqS4ku5n7h11Or2EoyA3ukjXIEtzxKEt
         uYw/jSeLZS/Tpe45M/fzJuslYW1H9wsrFrM8ekjefC3Py4VH5slmpfcY56qto0Kf1MEW
         99fJ3HqBgLyyD0AFCUJ34k4FldrKBWP6iJKV4WlRhNAAs1ffnkU/j73tIIAktLIoQUwm
         6GaRgBxLn2DSVg9D0DKR4WVUiE3qORxqtph+jleD+kzOuabpzAqbO63PdB5YQuQ1aUcs
         W9MA==
X-Forwarded-Encrypted: i=1; AJvYcCX0fyIandJXLnN/e5sE10SbiXHunsWM4ZRLldlQkTPHJCSXncscDzcQlarFM6HWnPw5iXh05wDuP6xp@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/ruKTBkBKJUFsERJX09F82lG8V1C0qL0FNxIBAbl0VS1rEk/
	Fq9MdzT3vzuMcimt9enJ+Wn2m0RPu8f75wDLwf4VIXA6DTON+qf0PHaX
X-Gm-Gg: ASbGnctqAN0rQzS4IX/oBTaQAG4w8/xaXshYXzuP5fR/1jefpkAFck584CWksJ/z7ms
	NgyPTm6rHcWc8ueqcrWN8CKkHRjLyr576ILXaUWTMpyOnNN2OQN3u729N6sZF7I0cVw4DwuSiDm
	MzzOZXH8zovWvfvNEcx9WkICm9Zy161UtDwP8p8kxRjB4+R0K2iMtRQCZqoNUtBoSQKRLrB8Kug
	QFzQKmcKuQm911XWf5C2trI37m6iZjwcUm0lL3PQQ+vMQZDLCtevsiRIaEVOQdjxqG1vHqC+MA1
	eMAG8eVMZUwNURsQ0qaVgSNOPiqnMS5W+jpfKJpGVH6/Vi92Ipxzetp3BfH9hPThEqEu5mOcSnf
	V7fNQu5DdQGZm/eI6b1L9jbGQnYmGP5+qZmsAC4qBRxK8ouvRZxr10EEmIsYI7ujJOBtsq7s3It
	YhkuZP34Dee/W2Knpb09vPmEaa4MhBURyA8WLhlBfg+OYViho53Ca/L9zPsqFAFbDqidmyeaxuK
	SBuskpoNtgjp1E=
X-Google-Smtp-Source: AGHT+IGi+HG544y5rI9TG7VHo47lrEeo2lT1g0Tam3Wcn6OeSr+gRnQ9mh2vuhld3fbwmO7bH5SAqA==
X-Received: by 2002:a05:6e02:188b:b0:430:b05a:ecb3 with SMTP id e9e14a558f8ab-430c52899ddmr295700205ab.9.1761106143223;
        Tue, 21 Oct 2025 21:09:03 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07a8725sm51436015ab.21.2025.10.21.21.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:09:02 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH] ACPI: video: Fix use-after-free in acpi_video_bus_put_devices()
Date: Tue, 21 Oct 2025 23:08:58 -0500
Message-Id: <20251022040859.2102914-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code contains a use-after-free vulnerability due to missing
cancellation of delayed work during device removal. Specifically,
in acpi_video_bus_remove(), the function acpi_video_bus_put_devices()
is called, which frees all acpi_video_device structures without
cancelling the associated delayed work (switch_brightness_work).

This work is scheduled via brightness_switch_event() in response to
ACPI events (e.g., brightness key presses) with a 100ms delay. If
the work is pending when the device is removed, it may execute after
the memory is freed, leading to use-after-free when the work function
acpi_video_switch_brightness() accesses the device structure.

Fix this by calling cancel_delayed_work_sync() before freeing each
acpi_video_device to ensure the work is fully completed before the
memory is released.

Fixes: 67b662e189f46 ("ACPI / video: seperate backlight control and event interface")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 drivers/acpi/acpi_video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 103f29661576..5b80f87e078f 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1974,6 +1974,7 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 
 	mutex_lock(&video->device_list_lock);
 	list_for_each_entry_safe(dev, next, &video->video_device_list, entry) {
+		cancel_delayed_work_sync(&dev->switch_brightness_work);
 		list_del(&dev->entry);
 		kfree(dev);
 	}
-- 
2.34.1


