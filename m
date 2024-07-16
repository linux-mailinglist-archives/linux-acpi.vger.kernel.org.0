Return-Path: <linux-acpi+bounces-6907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBDE932981
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2024 16:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACC728648C
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2024 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24B819E7DC;
	Tue, 16 Jul 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex5HoU8a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE919D897
	for <linux-acpi@vger.kernel.org>; Tue, 16 Jul 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140729; cv=none; b=POeZfhViNPkfJfXqpTTbno24EZrfUpu8PeRrtTZ7tD3YMBD0pQG6tMS+u/hbDidL1NXOrvft2XDY7f2HRH8aLpvDGtavHvhlUQwARkxuJ4VUXPy1+MVhZNbiDpDEx9tQ7B/ZjBCRZzjb+XCC2UEUqheXNXZ6ZvBUtSBvPcqdC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140729; c=relaxed/simple;
	bh=rQcNb4K4ejbzzlNboV26Z8G4Ov7lD1UwQOcSD5RCQ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjVg+mgotzzJIaMoieAFHYWVhvgpJ5OY0/p1B5/N3jZe95rlxF7omZUd0qRzjchy68lEiHrLkkK4vWCFRSI1q+GPQ2jr1wLe0r9aNrcr+ydxLCslYnCEbUHW6/Ucs11d40/CJ1rFfmd4ImBXJb32imk5eR4ubCIEiv8KS0l+vnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex5HoU8a; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-78135be2d46so4138836a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jul 2024 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721140727; x=1721745527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mH5AP4u5esygtSTJTyMxcL7CFvqgIecNY1A9Gx3tYSw=;
        b=Ex5HoU8a3quBHlfJQQ6Mvbkw3Rx5vJyng84W6u60sxrNCB2jT/Ohl+zY97mCpoPDp2
         J2COHSwMHE2+vBPV8bGWql6/EOKLPbLIUd/NgizOdODV6xkJ7cV0ud6p5n1yFvmee9ri
         5bF0u5b/fPIVkZzCCTLFBIBIuYmC0vqowKpVFqKTHlufKBYEo5DTi5Fc48Qos+NLQi39
         TuJ0BFUqaCjigX5QMi2xjroKi1YOyXVn4/YU8s6FqO9DPyqtjtnDvDogvFn9zEYHLhv4
         0k1d10PNGFf9cevirVFWP8gwXaukm/Tl8W3IXuDWsXok0pNbrT1opNnNw0C1x71DkohE
         l1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721140727; x=1721745527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH5AP4u5esygtSTJTyMxcL7CFvqgIecNY1A9Gx3tYSw=;
        b=Kjh+9lZESAGK75g/lXkJ7ikIRwLIwsfCi8+g+3A6FxYF/QMc/hXfEUcv+rUpvzj+ux
         OEMbEG+geZAOFuemKs9i8nwf7rqIYESlOBtPPgcmsMhI8fe3iJCoPp3W+ELFWyiKE8oz
         0GhlqNfPNv5RX0rykxI10yk/MJWYECQmoTHxeX+MFDmF15EVW57NldVhIAa/KJdpg7wr
         Eb9mmyRw/vpOakF4yz4NPal5p10BnK58yJR0+VXLjCQ5o8n8j0nHtUFlf+WUVGNevyAm
         fGsIjsa3LAjcm9/v6jREe2snZ47+CS+VK4DHn8dhM2gYFwJqnj5Gv2xYYO43H8dsHh4+
         uDQQ==
X-Gm-Message-State: AOJu0Yy58Q43IygGl2SSaw9EkB5XnTAUaAy6SP9xuP8Bu4TT72yaMRMx
	X/vF0Im/AVNSPNlCHmmyX7vaPMRZd1JgMdE9VVInmaiyAgZEAWDkwMQ31w==
X-Google-Smtp-Source: AGHT+IEp5FqqmwA320z6iPsBo5Og04zOMQTlsl9jVygYVSvvjO9H33yWViJpBfRc7HFdHACN9GYRcw==
X-Received: by 2002:a05:6a20:918e:b0:1be:9f84:c78c with SMTP id adf61e73a8af0-1c3f12978e1mr2938920637.45.1721140727095;
        Tue, 16 Jul 2024 07:38:47 -0700 (PDT)
Received: from localhost.localdomain.oslab.amer.dell.com ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caedcabbbasm6335721a91.48.2024.07.16.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 07:38:46 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: [PATCH v3] ACPI: PM: Use max() for clearer D3 state selection in acpi_dev_pm_get_state
Date: Tue, 16 Jul 2024 10:38:39 -0400
Message-ID: <20240716143839.584288-1-prabhakar.pujeri@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
---
 drivers/acpi/device_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 3b4d048c4941..81fc266ef18a 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -760,7 +760,7 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 			if (!adev->power.states[ret].flags.valid)
 				ret = ACPI_STATE_D3_COLD;
 
-			d_max = ret > d_min ? ret : d_min;
+			d_max = max_t(ret, d_min);
 		} else {
 			return -ENODATA;
 		}
-- 
2.45.2


