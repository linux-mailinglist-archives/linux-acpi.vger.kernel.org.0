Return-Path: <linux-acpi+bounces-18254-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6439C1110B
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 20:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403BA1A63048
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 19:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C1329C55;
	Mon, 27 Oct 2025 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMiaqc+O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B0328634
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593197; cv=none; b=BQsV6BlGujHxJRx00swp9P7m80j5xqXECz93juDezY3de9emgUpQWri7r+NaHlyOS7X7h0lzFElheWq4GOOE+51NfzgvoLmJIFkVG/1LJTDNTPlY6zf77vHYUJCP3QVV2mo51qLwia0CnVyO7ZkAsfC1ZUwHJoEkqU65XFuJsa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593197; c=relaxed/simple;
	bh=iQOzmEJHlgxLjp1nbGQtHxUZf94hiD6IyzJ7eGBOWSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnWGAtYNMrUncOkoRUCVSS+04UDBIiFyK0Celr5M5nL+2VF1sDiK19Tz+15lzVB2p8fD38oCADrpTaOVLLWhod5/lHo+2nWtkkJ0j6mTXBNFLC3tMqyRIo3M0NC2t8A/qL4qzCgV1tqw+GdtyJhgg40UWb+1IFuYYPfI78nJmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMiaqc+O; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso9097836a12.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761593194; x=1762197994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AlOW5hBp20/42EbC8lJVEdvKeYhWhq4EPh9ulr7sv0=;
        b=VMiaqc+O37V4hJB977/uEa9gjAUoEABTJNDDuDtnO0juZ+pIE4Cap3BvjBjXtS6iIy
         OVE9CLLetDNsM/9vj29kFNdtjCK/K1309SN3GKCOXH2J6+/T9X/J2OD41KRqLEhc7fGK
         WEav5lRbPfdLr1aclSM1YF/UG1mu91CKhXAhdoDfGwcO+A24f33IOVy7ySRjk5sVr5QX
         WyXX5lKkLXi0foeGuE/6WLBh5pPnQDB6NjnEARudEmS52wQj4LCttZ/Ju+GTHcCHoJW1
         rP2d7UHSfdcVH2g57AEqBebNuZutFblwCK3B8Gbl4g9b2XZeISW8u6hqb6DEA8nVG8oj
         EsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761593194; x=1762197994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AlOW5hBp20/42EbC8lJVEdvKeYhWhq4EPh9ulr7sv0=;
        b=UG6HPJbwp818+MzZ7hyW3Kv0cic5bTVUJWLA+LHYlwJ2iJ23SMPUxa7KTxiA9lJOeW
         /mFZ6zsZZ729hTAdRCoHooB4OSoZBUg7er3JCSKxtrw6RqszXRbSE2AOwYayubwVgz6t
         yTNH9QDlmo3wWEA2e+cB8d4lZxBNDX89teBZlo+moBlP6kpcWZvO3D/jILi8dVFXArG3
         g6eSc3sLDZO0qGWxqeUzqj+1aAF4EmVZ4zSASPNoPvQT62OdTWHR58hXRCNduUYjyUn1
         qM7f3Ah21jynfPz1+y3KkeXp4zXZUdX8s1YOj70efkbR3ofcIRx5oDTdx2We4Hd4zOA4
         4ssg==
X-Forwarded-Encrypted: i=1; AJvYcCWbXiOQ2qJ0sAsllxNgfqsuuHuNdjn7Kb9T2n7eIL63/k53TNAJGkxxXD1cA318ZkuUFwlTNA7B/m1+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7f5xSzkbPoODvP3ToMtq5EEOysMrrye6vdRZiROij9VEWSupA
	sgZiY8z9fisUor+gIubqH53mu/imZZ+47OgdqnrUazI9HFdAtKCymzOU
X-Gm-Gg: ASbGnctYFlGfxBR6oiXoc2OjAdzEGXt5bfkJKiAgPmS+4jaEY8Et9hebs/5JvjlaCS/
	CPgI3VXL+lq6Qj8cW534uDUK/PokygXpXqV4u91BVCAMgwgInBb4j0ZXv1UEGG36NRU87WGisWA
	sVJF+b6Qg9Mb8HUejHBADVAKhyKel2FmV8RTqnYKU9LVvM7loxZcd5UwqYRvnQ1w4aXye5IER6M
	fW6h3/I+AHOl4+q0puy2BiWxGIb9d2ufx7ONaer3OzTo/Jf0MOF7ZqkVHzBdbXm61FYNkCpcVou
	/ofJKkn1Y8PMfU/iDrMyvtHcmJ6/1+T5MbWsSnMy0MVBCExn/y7MCH1TN0i5V3PDYnZUdqtfObd
	2Yg2qzDfjZyeQG8TIM7XJhlbh062LYz2dDjYPwnx84MpCeBJwZjl+T7Tk5HrRx3lW2KXLqagYdT
	L2d51IFuBRqf+vzCFHvJ9yb9tVvEp5s2faftgfGZuKEOPNrmtPxG+S5KFnpSshCN1zuQ==
X-Google-Smtp-Source: AGHT+IFPiHMTL3g4M/qClrSKQXF9o1Cf4JfpI61mEzl81YLLDBQ+Ab1xTA/JPrbROMed+uVjA8bs+g==
X-Received: by 2002:a17:907:1c02:b0:b6d:5840:4b43 with SMTP id a640c23a62f3a-b6dba48eddcmr105014966b.22.1761593194001;
        Mon, 27 Oct 2025 12:26:34 -0700 (PDT)
Received: from localhost (dslb-002-205-023-060.002.205.pools.vodafone-ip.de. [2.205.23.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c549fsm863403166b.37.2025.10.27.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:26:33 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: ACPI: i2c-muxes: fix I2C device references
Date: Mon, 27 Oct 2025 20:26:28 +0100
Message-ID: <20251027192628.130998-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the device references were changed from relative to absolute in
commit e65cb011349e ("Documentation: ACPI: Fix parent device
references"), the MUX0 device was omitted from the paths.

So add it to fix the references.

Fixes: e65cb011349e ("Documentation: ACPI: Fix parent device references")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 Documentation/firmware-guide/acpi/i2c-muxes.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
index f366539acd79..96ef4012d78f 100644
--- a/Documentation/firmware-guide/acpi/i2c-muxes.rst
+++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
@@ -37,8 +37,8 @@ which corresponds to the following ASL (in the scope of \_SB)::
                     Name (_HID, ...)
                     Name (_CRS, ResourceTemplate () {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                    AddressingMode7Bit, "\\_SB.SMB1.CH00", 0x00,
-                                    ResourceConsumer,,)
+                                    AddressingMode7Bit, "\\_SB.SMB1.MUX0.CH00",
+                                    0x00, ResourceConsumer,,)
                     }
                 }
             }
@@ -52,8 +52,8 @@ which corresponds to the following ASL (in the scope of \_SB)::
                     Name (_HID, ...)
                     Name (_CRS, ResourceTemplate () {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                    AddressingMode7Bit, "\\_SB.SMB1.CH01", 0x00,
-                                    ResourceConsumer,,)
+                                    AddressingMode7Bit, "\\_SB.SMB1.MUX0.CH01",
+                                    0x00, ResourceConsumer,,)
                     }
                 }
             }

base-commit: 9e9a765418a5b45238a0f537c38fdd86dba6cf1f
-- 
2.43.0


