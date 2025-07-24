Return-Path: <linux-acpi+bounces-15306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF749B105AF
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 11:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A327B1936
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52E4259C92;
	Thu, 24 Jul 2025 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="XDoIcopH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818E259C87
	for <linux-acpi@vger.kernel.org>; Thu, 24 Jul 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348903; cv=none; b=jv6U+uHTR+gcn9V0nxeQR0BPqwPMWd4TINYWXHYUkhbcecw74UQexk1OlYxycKVzdMPClXFD6dEddFsv6gnu7EuUgAy3agGSFu6/0NY2MUMnrcDyFRKvjr2PAGKsWfX6JnyQe7TvsXbgMEZZorLocS7gDE9Kv+TNWJmKQ0pbbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348903; c=relaxed/simple;
	bh=MBz4iwUTBD7tFCHnZ6+JubnfKialJN7mn8OjnqBcvbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DR05rhWKPx2jUl8C8PNzpdcZzCfXTL22yZhHmydHTqAXWQXJJ5gQcoiTUHe/tlOYXwk2EshfWqcxGqyXI5OKuTFK9dFBP6qeqs1J/pviHesMw3bO+k/aeyzJPEIfH63cqaJyIjcXgrCGcC2Fz11RHizeGq2+MZCArzKmI0QN2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=XDoIcopH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234b9dfb842so6201145ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 24 Jul 2025 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1753348900; x=1753953700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqvPnkRrB7oXEkshrPQipnY6iopteZAJShBNqYK6f24=;
        b=XDoIcopHCuNuSSCKQzXGmm7VBoNcN4CJRKRSRKKaD0g1mYIszd9lLpFrRt6EHiLphV
         knp785rzEgqTkzGmR7+wCsOcKz7xgMaFInzje5I7QFJXUzSUvy3QF3yGkxkoOD0lujO3
         JmYFB+hl/cE/gBN31Xy/08r4OT0ugBaiX79rSfiDjtkVYqyDbeSEwTDL8V7OjcK24j+C
         Gbf0R+QINXonJaBlbOfnowv/0oZ7QfaYNTOXwwA4IGDdzGYomnjhA7oaH5hUmSdpWxaf
         8EKPX/+2lddJlCOW6Sn/EEozQ06vQOMaa1A93tnY3ALG0ngOEDOW/cCNw8lALpGJE4KU
         hWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753348900; x=1753953700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqvPnkRrB7oXEkshrPQipnY6iopteZAJShBNqYK6f24=;
        b=qSW82eZNIMon621IcfsqXxdo7Up0LJaGEGSswJe2og4+H9cGglcjLzrjwhCLFUj7Jj
         1d4Poq13hdqpFEUxQhQBqcAQ/9GBDQqVsTFy5ovKFmRK0IxEcpOH9M7s1k7Q6AM8Bqlb
         EK27TP1rtv3hymdTkTRh8v3wunJ8ImlIv/P8JvJhi4c2JOd6KJAKFwLn28LSSzhX3bwe
         0J42vLgU6W21yuxhrXC7+9c1a5UI6hADEJhHexNPAxjAX1uxhVhmjoN3UsRi+/zuKWVW
         9npgAbCN9jxNcT/nK6i22dvfvhDjw6qlqiJ2kYmY4/2mS2Ub/ydu+bVRQzDgjTmvUr3V
         uoUw==
X-Forwarded-Encrypted: i=1; AJvYcCVhmEM5fUAbBPodH+4OPWE0PUFAAJBrlOTeqgLzE+Tm/v4ifY2XXj1Zkwm1mnHJ7dnl23Y3Q1X43Akd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43I2bAPeeFrxOBbXEksAzjDyOR9OI6R/Cx+Nr2+zk+cfjuVkd
	NoGstwH4WYd+6ArUrL6X7MWz+obW/uTLDML/uDw8An2X3g/RPcUUROIQShOBZDUYO2M=
X-Gm-Gg: ASbGncvc/Z2wFpeYtuLhoofGyETVc3MOAVgfk2JUdmNTR7Nypf91ZwgjW5Tj5k/KLG9
	gdf+LfOdSGjDO3xs/ZHp3yiVoyM7J/+91bkqNlgYRj9TMEqBk1FFrzCR3IsUMY4lO9qV7zUJlQL
	k/R81PNbej7cKhwCI9wN2oIaavbB6/n6v2DqxvAQvbjkxIRMSITRRIkGnAZeyQbY1i4Ge6vfyUh
	scGYv+GYW2Y1HtMlHPz/2NRFohT//js+Hs3mejIVsfXFceaUIsAU+KJFTCvi57So3s6X0XEQlUj
	uNCbc+Ryf1fYvwVsjnyaz0IY3qousYJ51GUw1T2elLgOO6Ic8C4SgZ8sUFb8DNwCIec7MeyNXcb
	3ufRUPLrcK/2SgUFztkVd8Uvi1eau1k8YBpIvJFspo4uo0sDDIdZtBns=
X-Google-Smtp-Source: AGHT+IE2cTDYuQ//Nl54CzxM9h7KhUuyIL211ZcA/xCbsrshSiP5Plf/oiQW3J4mDHHU2oBPU65F3w==
X-Received: by 2002:a17:903:40ca:b0:234:966c:a2f3 with SMTP id d9443c01a7336-23f981b27d6mr89262515ad.27.1753348899997;
        Thu, 24 Jul 2025 02:21:39 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:fd43:1ae:25a:bcd3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e66384406sm912306a91.33.2025.07.24.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:21:39 -0700 (PDT)
From: "Guan-Chun.Wu" <409411716@gms.tku.edu.tw>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Guan-Chun.Wu" <409411716@gms.tku.edu.tw>
Subject: [PATCH] ACPI: PM: Use nearest power-manageable ancestor
Date: Thu, 24 Jul 2025 17:20:58 +0800
Message-Id: <20250724092058.10075-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a device’s power_manageable flag is false, we currently only
fall back to the direct parent’s power state.  In a deep hierarchy
there may be a more distant ancestor that does support power
management.

Walk up the parent chain until we find the closest power_manageable
ancestor and use its power state.  If none is found, default to
ACPI_STATE_D0 (fully on).

Signed-off-by: Guan-Chun.Wu <409411716@gms.tku.edu.tw>
---
 drivers/acpi/device_pm.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index dbd4446025ec..81b47fb00e80 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -84,8 +84,23 @@ int acpi_device_get_power(struct acpi_device *device, int *state)
 	parent = acpi_dev_parent(device);
 
 	if (!device->flags.power_manageable) {
-		/* TBD: Non-recursive algorithm for walking up hierarchy. */
-		*state = parent ? parent->power.state : ACPI_STATE_D0;
+		/*
+		 * If the device itself is not power-manageable,
+		 * walk up the parent hierarchy to find the closest
+		 * ancestor that is power-manageable.
+		 * Use that ancestor's power state as an estimate
+		 * for this device. If no such ancestor exists,
+		 * default to D0 (Fully On).
+		 */
+		struct acpi_device *ancestor = parent;
+		/*
+		 * Keep traversing up until a power-manageable ancestor
+		 * is found or the root is reached
+		 */
+		while (ancestor && !ancestor->flags.power_manageable)
+			ancestor = acpi_dev_parent(ancestor);
+		/* Use the found ancestor's power state, or D0 if none is found */
+		*state = ancestor ? ancestor->power.state : ACPI_STATE_D0;
 		goto out;
 	}
 
-- 
2.34.1


