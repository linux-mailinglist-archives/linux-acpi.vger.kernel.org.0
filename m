Return-Path: <linux-acpi+bounces-4077-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D111E86FDBF
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 10:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A280C283B9C
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C55219E2;
	Mon,  4 Mar 2024 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g95mKmpi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E919224E0
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544510; cv=none; b=YWQQ9USILl1qM9uEkEqcXxyKN0EWu/2lWMIzQWE7BL7HB3A2ZK2v5YqmRv5Ad+S4ETzKbUxr/H6inX6zvmMiVx4Faa8/G7q2PpSWG+SkhwrjFXIBFcirDdx0psICXik2LPwyYuEw04zzH49Cvkeim1e89W4rSMOV8t48OXD1K6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544510; c=relaxed/simple;
	bh=DYSJweXIpw6YwRUOqNGWryLCMLbPJLKr3W4We7Zoob8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOpudFxynZAJ4KEKxr6Je8MDXnlg8oMRPIDr8oUKKzVPCvBK6odGkcJRJpzlMZneolR0WLwZFGtWgYP6nZXntFcOq0K/RpwDDqFZF2UNs3NW/nvmioi4vgAa4g78N+nflnO+SlGNApBdygJnwAmh586eAEa1zZclL8gRo5aM7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g95mKmpi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51340e89df1so1263430e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 04 Mar 2024 01:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709544506; x=1710149306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6fWMcd4GWhZ5Esfhcun7a87Cz0tR0W7YGBDyBNZUJgI=;
        b=g95mKmpi8EkiN5jmIq7sghJ6A4UYFwq5UwTbyRXttczfrmSFKJOTdpsgHqJ3U8h4lg
         MfNTflyNd6+zjPLY5z7rgAzDbRqgTSzGaie/YmkT5rApVdVYn+pIQXpzkTRSQduZIQC8
         XMx7zlROpg/aFpcgMUHp0hLJF71wF9ovhvYYPd0LnZ71IbbL7Lem2VqgjYRp3tGDtteD
         Jnid98Gdsseo9hq79YcjG5xnz5++Ov2S3qvBTzeZTqQ4J+NlGTWgE+Q15jKjbOYaaX/E
         q6pU4D4q7xEh+hdNo16Hda+qQzwDxZE+6vlvsi2JFlH1g2IdaoUfu21L1yTngeqcVbQR
         taHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544506; x=1710149306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fWMcd4GWhZ5Esfhcun7a87Cz0tR0W7YGBDyBNZUJgI=;
        b=nMOochMIrN76zVeGAR+JSCYIx1iZN1IAF+6V7Y3wUSCEIf3L3vtiadoStHtpAJkoxS
         z+vIyFGgrbdsNrVPL3UJCkV6YDoLDtzyw8qVZh4vgbiktsUTE/fi24qS09yBaDiH+0hU
         GSV60AWBtYQ+srPW4TxmB6ZYxL8EiX0TTaHTYFODptycORS4lYHwLucEIhktulxzfE+N
         ixHVb4eQIkDVLxt0ug8P+3Yk8Uc2hxpW5iZ+twAw1W7Jxe9XdlSIf+dfGTcTwA/Z8Qwa
         UhOaOafC4Uw3M1DJD8+LZV+BbExVy94dYND9xGNlKC9ORJOHjrzfJXXHK3Rp6SyfhL8V
         wBUg==
X-Gm-Message-State: AOJu0YzSZP1nTit1qbWK4bdyXcwdyCv6XleP0r+J+QK0Pw5F1dUyKN1R
	sZncx7AcpInFudqQrDy6Ri9qnc3Kbdgy8rc5aLh9ELt4aQYglH4pqcdYdKFASk0=
X-Google-Smtp-Source: AGHT+IE4/9O6hcMMHVLwGBzgS2Eb7Z6tCBtPILk+3kig1hrlD/k3AMtg0SXI1yH87muc9NkWAtQKWw==
X-Received: by 2002:a05:6512:1389:b0:512:f657:122d with SMTP id fc9-20020a056512138900b00512f657122dmr6650763lfb.12.1709544505757;
        Mon, 04 Mar 2024 01:28:25 -0800 (PST)
Received: from localhost.localdomain ([176.59.41.46])
        by smtp.gmail.com with ESMTPSA id u26-20020ac25bda000000b005133b2d1acasm927094lfn.50.2024.03.04.01.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:28:25 -0800 (PST)
From: Sergey Kalinichev <kalinichev.so.0@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	Sergey Kalinichev <kalinichev.so.0@gmail.com>
Subject: [PATCH] ACPI: resource: Use IRQ override on Maibenben X565
Date: Mon,  4 Mar 2024 12:26:38 +0300
Message-ID: <20240304092733.49466-1-kalinichev.so.0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ACPI IRQ override on Maibenben X565 laptop to make the internal keyboard work.
Add a new entry to the irq1_edge_low_force_override structure, similar to the existing ones.

Signed-off-by: Sergey Kalinichev <kalinichev.so.0@gmail.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dacad1d84..485ecc235 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -588,6 +588,13 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
 		},
 	},
+	{
+		/* Maibenben X565 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MAIBENBEN"),
+			DMI_MATCH(DMI_BOARD_NAME, "X565"),
+		},
+	},
 	{ }
 };
 
-- 
2.43.0


