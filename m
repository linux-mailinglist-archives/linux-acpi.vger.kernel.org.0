Return-Path: <linux-acpi+bounces-8301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199B2979822
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 20:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82941F21614
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2691C9DF3;
	Sun, 15 Sep 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/CyauE6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBF2F4A;
	Sun, 15 Sep 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425546; cv=none; b=OV9bI8L7J8JYxnmIToka52M5IwFwMnap/+zkPOaHfeVH2n+vEl7HF59VVgwgUOUpxNBbb1sybcNitRgpYaBdTYx2DzkiUJkFg6Vm8u2HLTHiDoIy+l1VLELKGHsSYqUHQrCAPysrm5D+yPlNoqkVASL0IKGwnMKH26qleDevFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425546; c=relaxed/simple;
	bh=ydBrSEwZEYhmEdutLXk0R2TlP1+Zip6bTFm5aEfLWFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlUBgGZHPSy+VeFdVktXKyTYo04jebDCNchFTIsu+7g2yAz497vpBd/zkWVVFpeToBBc+SAEPFSlLC53DBl6btOiq5Guup6V/szQadLRcfFaWo+eXXsf/PO17RhnhzqadFkRugI5kk6+0O1pDWVGyb1I/wA79QSlox8uxXodIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/CyauE6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371941bbfb0so2591433f8f.0;
        Sun, 15 Sep 2024 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425543; x=1727030343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXXQfTNvP9tw/3KAVWW01hLOQc2h3QS2AuRwa1s00cY=;
        b=g/CyauE61lb30Md3Dq8kmdMcdEkBdSD+KrwIdvnIh5pqV8X7cKBuvPS7vl7bhOvYbx
         UIKABcGc4bzsyI4j/e7ZNC/dYsP5fNrRntleKjmqsEziVfn/BPD+s3cZIS++BFwXNisc
         a/mWRGweiKAlF2cmuy1QfQg1lKcZZhqZ53uQ6fF2RZNCWh8YacGFkyjZa8lkcPCdPMCP
         BrkVh/RK5mVtMRDbpe8/RKBucACJI2OGMgpfpNwTKjn0wTYV9YBOehtdvCjaH83ROfok
         95pOjYCo/oA8oad3B9pkV2q54wW9qgzwCAl6PNqQ7ftqI0GwyQJ4E9UDr+0QwHZ4MHIe
         90wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425543; x=1727030343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXXQfTNvP9tw/3KAVWW01hLOQc2h3QS2AuRwa1s00cY=;
        b=hgyHw3vAbAUKhuOm3xAfd0tCIXM4T87Bmh8OL6yMgZ+P1LSnN4FpbMsK5Ri8T5ZJ5U
         d9Pw+OO31KTvRkZXFmV4A6yvw1c00m8ZWHHiW5H6xYVcbpGs6mZxOeiMxMR+fy0Pq5hI
         ldjPsdDTa5WwNJI5UoeD4i6z9bylPkEk2lV1vKyCD36D2arwrwQhcVKRgVeuD7wAttYF
         I+1FCmAbORTrNwNkCe610gShNDomd2rbQjoVL0lVLTngOuBMY0j3sz9id8YXLNXZmyiA
         E7aUPobf7kCp0rXp3Lr6mxTEsdV3oWCg6sFHjqr/TBL+w38zMp4JFX+BlqOat2RyGLvl
         wfEA==
X-Forwarded-Encrypted: i=1; AJvYcCU6cHPz3/wZKMctF103acle8LjrALIe7BkrR05PZCpoxrNBn+xLtEhdijQ/3vPltIzj+uCoU2RbrONT@vger.kernel.org, AJvYcCXsx4WTvAxl4S/ubVcUm0rjOcRb1yJRWbIgCAWEfVsW1eIoefC7OqQjIxPJVRRoBlL9trd5zYr2GYGAb2D2@vger.kernel.org
X-Gm-Message-State: AOJu0YzAFlXzeBPKnH4OnVw+HnN70c2Nfex0dEXLAPTgk7+cPXg1YG7J
	SSSmWZGVTwMyLUWJevf581FWXgSlkYTxsL+B1g/2gjtUwK6lHfEt
X-Google-Smtp-Source: AGHT+IGG5uS+gl23daPy1wzJJtGgTL69VrlGQ5EgG0cUPBKQHCZLmdT9Mw2XD63oMUeYUEbcPbg7WQ==
X-Received: by 2002:a5d:4dc6:0:b0:374:c581:9f4f with SMTP id ffacd0b85a97d-378c2d58d9cmr7067632f8f.55.1726425543042;
        Sun, 15 Sep 2024 11:39:03 -0700 (PDT)
Received: from qamajeed.Home ([39.45.198.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f2001sm5162357f8f.48.2024.09.15.11.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:39:02 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 02/10] ACPI: ec: Use strscpy instead of strcpy.
Date: Sun, 15 Sep 2024 23:38:14 +0500
Message-ID: <20240915183822.34588-2-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240915183822.34588-1-qasim.majeed20@gmail.com>
References: <20240915183822.34588-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI ec driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 38d2f6e6b12b..991143ef06d2 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1634,8 +1634,8 @@ static int acpi_ec_add(struct acpi_device *device)
 	struct acpi_ec *ec;
 	int ret;
 
-	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
+	strscpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_EC_CLASS);
 
 	if (boot_ec && (boot_ec->handle == device->handle ||
 	    !strcmp(acpi_device_hid(device), ACPI_ECDT_HID))) {
-- 
2.43.0


