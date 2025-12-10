Return-Path: <linux-acpi+bounces-19540-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B01CB3373
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 15:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3319300A2B6
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ABB246788;
	Wed, 10 Dec 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/XbDvJx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904523EA8E;
	Wed, 10 Dec 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378306; cv=none; b=P6LMNkkJuqViXx5mA5jYk5cXHCK9sFY9+aI1YZ2wcGBOxBM9SSYqqtuNaWwdhglat7zHvhWShAkjF2y+5ZQuUvfR+vlmnQprW/qvIgT2TsP450eN1DJNop3RkHIeXekofCdj3XO+RSmJLVRh4crFJ3HDGf6pje9FD8/zRKp7xTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378306; c=relaxed/simple;
	bh=eM3RJTD+eALU7muGlyKlz9VBlWFpyKgL5Nd9DIYEwVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObUVwTsOhx2hagaaikNnKxebIxzIcqJ/8T5svclCU0fyQiZF+GMQz2Mi+ppXaocgdXrHOjog6bHlHEqWsC8Do2g+73Gip4bdAYwc3QAnL9iphqdrnxK+OHOMNkssXhjanaZh3KTgHUSLacFMykvOmKOxGj/uIbLn2x8q8+MHDqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/XbDvJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA17C4CEF1;
	Wed, 10 Dec 2025 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765378306;
	bh=eM3RJTD+eALU7muGlyKlz9VBlWFpyKgL5Nd9DIYEwVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/XbDvJxeaRhQ6vqCbm9iHyH6sDZ40+kZEeWLQHQz8Che7VzTSAu49Hzz2fM66Pe+
	 TaTgKPJLwbcroF+cOp/r8f+ODMGEZgKcviXDo9iCCVm1npIYx50d3HfAahl586vFd3
	 Yx/ubDAS2LbYnZFDWzLCK9NfM2/FLIDgtAHWAZRy54sLeV561GSLR2teoZEMK322Hh
	 mo5k+zb6ogVHYco+KpjRjWlAI/SipUvlm+iM7Dceuro7r97bFGoOUPKjtjc2qME+RU
	 EvKgQ605pTwycQJjJhNKac3JjVZGdGZemxqU5aWzB079yznJ/b8d0dX2IEiMIRWe16
	 LH8bQdX96txHw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1 2/3] ACPI: video: Adjust event notification routine
Date: Wed, 10 Dec 2025 15:50:28 +0100
Message-ID: <22933299.EfDdHjke4D@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <8617910.T7Z3S40VBb@rafael.j.wysocki>
References: <8617910.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Adjust acpi_video_bus_notify() to cast its "data" argument to a struct
acpi_video_bus pointer istead of a struct acpi_device one, which allows
the use of acpi_driver_data() to be limited and will facilitate
subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1540,14 +1540,11 @@ static int acpi_video_bus_stop_devices(s
 
 static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_video_bus *video = acpi_driver_data(device);
+	struct acpi_video_bus *video = data;
+	struct acpi_device *device = video->device;
 	struct input_dev *input;
 	int keycode = 0;
 
-	if (!video || !video->input)
-		return;
-
 	input = video->input;
 
 	switch (event) {
@@ -2076,7 +2073,7 @@ static int acpi_video_bus_add(struct acp
 		goto err_del;
 
 	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						acpi_video_bus_notify, device);
+						acpi_video_bus_notify, video);
 	if (error)
 		goto err_remove;
 




