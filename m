Return-Path: <linux-acpi+bounces-19929-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E8CEE6ED
	for <lists+linux-acpi@lfdr.de>; Fri, 02 Jan 2026 12:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58FAD301EFA9
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jan 2026 11:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E645430E83C;
	Fri,  2 Jan 2026 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFox6PX5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABC30E838;
	Fri,  2 Jan 2026 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767354854; cv=none; b=eMN44RbbhclVlh+8rnbAtJUQYGMo3eI286/WvRGoG56LS+/0lFBoSgg+KnNFBtG3FX1B8TyjgKSMLaG0XXci0RmQvJp4WUMiWNLzdlxDP9gn6dvMkUu6kWZm0OKHQlvNhcNZ2ifFTiOkLl3+7z0GceGDIruYwQdjYcpKYOpH/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767354854; c=relaxed/simple;
	bh=ESlutolk38gGVt5VNG/SJrxI+uFMHMF2oDzj9hr/Xuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp8xVInMtpimbSizuqrbM5XCVguF1Cx2+ixwqjLybAjqRwn9E7sjNkF0/SSMp9Fd7M7YhBI3etBFpuXhloTobZqaI2dlu84liTvcX4ldTC9uJF1Yq3cpWI9wDYRuFqWZjP8mOvRWQmCL5wWYvtvwq62wjJ46PXOoywAxKMOJOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFox6PX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F4DC16AAE;
	Fri,  2 Jan 2026 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767354854;
	bh=ESlutolk38gGVt5VNG/SJrxI+uFMHMF2oDzj9hr/Xuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFox6PX5MU9nW/0czEqwTTmx1CHO62ZHnKDDSUQNXZwduGXDQ2RiFgN0bS4eYX8RN
	 p3bdNhCp6Qy2LXkDrf6nGkQyoQBP7pRcb59ecEn7ne5FqiRqZfYzqflOvCuUvF2ygA
	 eEbBOmPamwFQ3bbZqGrXd5FFmTaqH3zYT7ygrAlnyVbBakNgNGY7CVCZleFN+DxULN
	 4Ud4tSMWMUJW4E1/bQo3wADg7FmwlzN9c6FPIaWrdXv8SCbE8js/d/KjOrGwBuSXK/
	 PLz+SYwBEWzslV0psOzqUTh+4MWerfv0hs4yziHegzi6uwcFpuU+wpS/iEzrRdke66
	 7v5Vb9w/ubMGg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Hans de Goede <hansg@kernel.org>
Subject: [RESEND][PATCH v1 2/3] ACPI: video: Adjust event notification routine
Date: Fri, 02 Jan 2026 12:52:15 +0100
Message-ID: <2409089.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12824456.O9o76ZdvQC@rafael.j.wysocki>
References: <12824456.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Adjust acpi_video_bus_notify() to cast its "data" argument to a struct
acpi_video_bus pointer instead of a struct acpi_device one, which allows
the use of acpi_driver_data() to be limited and will facilitate
subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index be8e7e18abca..54e09e7f8e77 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1540,14 +1540,11 @@ static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
 
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
@@ -2076,7 +2073,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 		goto err_del;
 
 	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						acpi_video_bus_notify, device);
+						acpi_video_bus_notify, video);
 	if (error)
 		goto err_remove;
 
-- 
2.51.0





