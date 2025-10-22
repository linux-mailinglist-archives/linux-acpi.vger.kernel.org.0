Return-Path: <linux-acpi+bounces-18067-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A33BF9E90
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 06:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C3BA35303B
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 04:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155A12C21D8;
	Wed, 22 Oct 2025 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwm5t3cm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FC2701D8
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106073; cv=none; b=lT1dseG1wumOpKZg9rS7KQN8g7wwWqFZKdPXQmjWRpCNe7zqYRiEv6N6KESduz+kZXNnRRTqOmCE3R1yRNwaDVyhgvCTmZtppPge5+jgGq0aJsRfo64Xk98QSFz3HfLwwTP5CA2SOnrVsvZEGtaD/iM5EJvd8cRQq0HMjjOsUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106073; c=relaxed/simple;
	bh=MW4it84Oe/dptYdFMqsXjx3kV/biDh03d8d64XgDmRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JprrcyoDHS515OXa1qOiF18QDUN6stqdaxGn2tVLl326a2Vnc87MHA+aRFFMRXAbV4E47Lvycy8f/gAVu5cMSTRMy5NGCmBmkRHgWSqPv4qiRNl/BpjImRaNBm7jHMVPukLbrIR4CTAnjXDTyXKMpRkdlGTcuCfE61FRWTJ4osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwm5t3cm; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430ca4647c7so23346985ab.3
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761106069; x=1761710869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEw5FbM3fIxysAn/HQ5qF+JSuajA12j38hiocn2pFY4=;
        b=cwm5t3cm1hRHihqOBNWEEcJS6PIEzbVRd9e9t0JEbF27S1OoPbG0p3em7oreN8PlsH
         i9/4f9NmRPjCm+gD/th02pVl5s4+m1f2SO882nmdzOjNDlSucuTxBdlNYThdJsGdRbSS
         YDSplIVRFFB2FqJj3gtMUXBc6qxRiAfIhuty2k2H9eI/+bpN0BIir++ot1c2NGmZh7iD
         BiN15QEfsgOEFTXfs9pfPNkDDVLCTFKp9uIx5zMq/K2ixav2v0Ns8fehnpZVUbFjmBkZ
         QCMAUMCcQnnr1A67lWNqzNd6FJQyWjXshNpPv0lIZimvEHZtUF8z19lzOsp0L5u+8hec
         ss7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106069; x=1761710869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEw5FbM3fIxysAn/HQ5qF+JSuajA12j38hiocn2pFY4=;
        b=Btc6Gb9E0wTuq7A+0C5aDfVDYcMNidqOJSy6n2HN1Pkrz7PLmP97XGCo4wcbgWfVHR
         +9l960MCPTi8+MHmrtbbhzs0Dv+TuFKdC7P6AKDheBIf+LJ5qAj+MYEP4vPwq+VyTGot
         oDMSxXQ3FQJls/0PbIZbUOukmpaX3D1wECUkaHd3vjCPQgTx9lGKSblOM82Ddld/iVlx
         f14QYe6oNLTwSxzGkb+eOrXR7fwuWKzfr2SsewTrA1/+B5jw6aoYaLjYWhS6sriRGlka
         24Ym3+wlqjAUDxkXdG/msA61OrgcU4cJgW+ajjlQDGoA5sk2niVQqlkE8Wm641QZ7hJB
         esWw==
X-Forwarded-Encrypted: i=1; AJvYcCXCejcltI154WKhao7RKhKdSqMLEPWE5kuy/0ESDsRuxGgVWNYu4PRvDoLDBXNBrMloNiFSs+a3DofV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyla8I6jo29RaZxcmO69sx9PixYdKMjZ90DeD1uHXsm9qbi7How
	35cyhlEq2n0izMAooIykwWoMMRnC5oF+m086ocqvg+UhCnFf+SIPXIbN
X-Gm-Gg: ASbGncvCtdHDcF9KFRmnFEpfihhc0NdpLFy64pJt/HGRkIAhrJFq1zQRglcEqGLR3lo
	pLIY0c7hxO0W3bTLpZblkHo2x5nlAgcYIz/6x8hE6S9Wmcpr1dMaeG9F4ZQ3t2kh7zqpOblc32e
	ShQv/hpccsqHLXAWIuvk9VQG9B8+HOBY07V0WkkmrISzzZv/T0er01ABiIOm2bbNrDarncJspZL
	PXJu4+UhKbhr3R/L9OvN3Mkv1N/8xwbNsigRiQ+kDY5jvbvj6O36lklMkAWfH5bavj3gfzxTSGx
	n3RShsW7XonhV8j+wit8C3vh5xN6oE4Yt9u1IUNBpeTW5fWVwnYJIfHN/SJtNPPUfmEM0pcPiQn
	VUpirwHeUlQfBWGj+x6rPNdMw0AaW2HBkt6uTD7I3krbMEctlpVXoso8HC5yw9yWYGTl8c/iKqk
	xmpNq6wQYmgx5fNyiHWYOVtJ++eQp+5z0NUlKHC4E9qbK+MxDAco/uiGi/p5jpDd86ul+nAylPj
	4VWnvLahcgGMobmQiEZWsz/zg==
X-Google-Smtp-Source: AGHT+IHycVsOrBUODML9NXrlWEyYylPn+mFR0f8GM0RC+6bm0D8tC29dIctmGREmTFZcZ0hx5duVJg==
X-Received: by 2002:a05:6e02:16ce:b0:42f:9e92:a434 with SMTP id e9e14a558f8ab-430c52b5a2cmr232223235ab.21.1761106069589;
        Tue, 21 Oct 2025 21:07:49 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a973ea40sm4752982173.31.2025.10.21.21.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:07:49 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH] ACPI: video: Fix use-after-free in acpi_video_bus_put_devices()
Date: Tue, 21 Oct 2025 23:07:42 -0500
Message-Id: <20251022040743.2102717-1-danisjiang@gmail.com>
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


