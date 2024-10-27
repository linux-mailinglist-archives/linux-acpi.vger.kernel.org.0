Return-Path: <linux-acpi+bounces-9012-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF079B1C84
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Oct 2024 09:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC8F281ACC
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Oct 2024 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350373BBC5;
	Sun, 27 Oct 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1QLLr7X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200662905;
	Sun, 27 Oct 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730017833; cv=none; b=Pir1OenGgf5CZV3ITy9Uadp34at+eVKifYTSwhuzyi0DRsJ2Cu1CZC4iCs26pT5zUDLEjfjiZgbgSMBxmjWgE3e9ZPatyZ6j7ugz/XDVE9Wk/91vPt5GRFVcuFnJWIqf5rYKhK2ZDbDX07Vj1b2MUHrqRpMIFglpfmXMMhCS+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730017833; c=relaxed/simple;
	bh=gouKImRFYnaBBzBkfq3ig2WZ7pomlL4cL+zGTR6yjno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9gZMBSrSgsDQ3plPbMnF/gU0ZJhwUqbIN3Y7BGqSJjQG0Km99Xia73FMkPsOsn585Q88KiSrt+8hvcO9KC4KLitDOE8zQg4Yd+lLOULx2JDOw6PkxcsHFvEre6wc2vLl7gRROUTRjIM9vLGaLGouJ3bW53D2Mn39/XeJhmo+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1QLLr7X; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0cee600aso430316666b.1;
        Sun, 27 Oct 2024 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730017829; x=1730622629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1vGrccCsw2x4e5+h4aYR/O+/2E7ZxptNRn/W4DOcxw=;
        b=f1QLLr7X8N6n2ubt5MG3jVpTpFmtzPpsd2ctciWesFkuefhW+jEbZRNESEf2iUVqSA
         wCmfI3pi1oC0axt68+cz5H2bGBP0AL9yEqyzO9gXhYObFJleueaEP5DQewNPMwP6myqt
         0ElcfdX3ttS4Cp5A5Bvr2zibp70MUdQsUnwMIX4n8KyWKcH9x3U7Nuu/hswDV36jNxRV
         B5z1lR3H/ruU1csFuTDEXFis/DID9CrBF8Oofylf+x5nizPzrl9qyhCXox/QnBPEt+T/
         VrayIbBlUns52pJfLOlXBdjqLs237n7oxGKykyWrDGE82iyZ0F548K7VsPoZF7k/Q9wy
         NcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730017829; x=1730622629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1vGrccCsw2x4e5+h4aYR/O+/2E7ZxptNRn/W4DOcxw=;
        b=iKMiIp0I9MP6QyMeJri1M8hkCDZpvma36OqafQUeva5fTFDRjtrTDqtCXZPH+aY7Ac
         Tc47Dm28HaZxECEMgF7TIuw2DG9vSpD3Dehrn/1qzn88Cmd1QI71mxaWkDtHE+TMUvsx
         5DT0ScMOPwYJGTDinia32yLdO1CeTexRw4MkW+gVD70b258L9PBy/Fbm4q/M1gS5ShMK
         eKqWWvgt1KOW4LpWxlkl+nBOY2ecHtSYK+QqCIMWt4z6K/Izck2iScZ07my3ugRHZRaI
         vqusMeFK4+QT9b7KLkDoErmrj/zw2spsKmkza7/mAUZ8i3mnKfwCJ0tbuj0CWh//UTDV
         jUfw==
X-Forwarded-Encrypted: i=1; AJvYcCUNZeRwtnwdZUp14kWhqgxJfulDJuNbivxz0zfvtyXZlmwgwSuc5f4oxCQSkJNeno7bLTSbFJF//EYN@vger.kernel.org, AJvYcCVGUoMWaP3lxcaHkxlIrzTd0/0We76EL3xwAqzEW9MHL5f7mXNVEGYUf529+sQq6RrqQsjy+QwT9JJ6VPNB@vger.kernel.org
X-Gm-Message-State: AOJu0YziBv0vq5cHNR6At3roQvksl+gMNWdTO6C2E4Dv0L5udBlnm9hi
	yBAGDgX7cSypAH7o/HKjTHr/oHKatlYeOhSyBDBhm2zQDayYTQxM
X-Google-Smtp-Source: AGHT+IGpTZr5g9u1ganARRHI/a/Z328l3kVJ2LzfOfQz7zGGkjPTal0tIv3/I6wF+OSAZEn0CmiFew==
X-Received: by 2002:a17:907:9447:b0:a9a:c03:ebc8 with SMTP id a640c23a62f3a-a9de5fa914cmr406119866b.37.1730017828980;
        Sun, 27 Oct 2024 01:30:28 -0700 (PDT)
Received: from qamajeed.. ([154.80.48.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec79aasm255515866b.40.2024.10.27.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 01:30:28 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH] ACPI: thermal: Use strscpy instead of strcpy.
Date: Sun, 27 Oct 2024 13:28:58 +0500
Message-ID: <20241027083007.11199-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI thermal driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>

Hi Rafael,

Any update on the patches?

Best Regards,
Qasim

---
 drivers/acpi/thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index a0cfc857fb55..0c69d04fbac9 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -842,9 +842,9 @@ static int acpi_thermal_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	tz->device = device;
-	strcpy(tz->name, device->pnp.bus_id);
-	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
+	strscpy(tz->name, device->pnp.bus_id);
+	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	device->driver_data = tz;
 
 	acpi_thermal_aml_dependency_fix(tz);
-- 
2.43.0


