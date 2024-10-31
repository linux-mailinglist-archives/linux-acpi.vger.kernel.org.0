Return-Path: <linux-acpi+bounces-9203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E639F9B8146
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 18:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E92831D7
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D8A1A0BFD;
	Thu, 31 Oct 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYnciURx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0F12BF24;
	Thu, 31 Oct 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395937; cv=none; b=bSJ3b0XBTl5MYycv+twcwSk6sm3M+EtGW+ZL6IfFDn8p4zqpy51wrxubKLij2ZaA/ppLZIVFaxtbk8smp6XrCH0Witxe2oB/ZxIMEtDEnZBp0O12BRUTmejJi8C2/YS7NTaUMWU7dGN0o1+gOvFUviwvbjzLuCnNIGocH0fqzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395937; c=relaxed/simple;
	bh=M0pIn94Azowchec7I7p7M49ATq272Lmt8o7hlwxwDKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rHNaN0B8BniGPsi4bfkIr81KtqYk5UGvjU3cWWvwzOdhfR0hd17Q8mRh02l3j0Y/RdHXNxObqJUbZ4qGyLdHm8Ydui6MjGXQz3nWF+wsKJST7Vl+30jzHQKZPKXPpXbO16J0fnJxyFH+ZBOrL2/hC8SH8FHBBycTF/SyLaFTQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYnciURx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e4908837so153709e87.0;
        Thu, 31 Oct 2024 10:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730395934; x=1731000734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4sLwJ1Za+GKDAjN1FVw7zfT75tbwo/FRlb/5kWrOi0=;
        b=dYnciURxf/GaGkqrOXnL0AQacmy28UW4j7z5p4UMY4Oh6Gg2YhsRLJ5Antkjnc8wbc
         J98X0Nwn8kmb+dKmFmjAWtcOO45P+WFKu16z1RQ1E1od6GfC011UyOtRsaiaZNW3WrdW
         IbCTX0j+wVwTrpz4x/Cvz6YKSJp4OaBr6DrmvV3O7IhDguUwaSybT4u0PUUf8GSUfRCn
         4wd+JoDoBqCbbKX3Ip7g3zmYrB1fEGdz5Rd0opz9SMzFS5x92xoDWKwdSV/AprUay1IR
         fAOPM9Nyf43i9CR5QpzHnbdd+lLGAmrAyvAOuMX+neYC1rFXHowqhrFCmBy0NbRzcp62
         xvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395934; x=1731000734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4sLwJ1Za+GKDAjN1FVw7zfT75tbwo/FRlb/5kWrOi0=;
        b=ftQFXcxmO/S4NmQRjbe6XuNOr1EC0mJEdyaCRg2ZlD8vBD/et2Yc6/Fifw1VNjzQVL
         Z65FcsLemUGt0JJfQ4p/l5fSB3NzTmaPv0+lUJMOgdgsZqL9mxNBLQBjfjB9qlpiL1Do
         gfPVnDAv66QSoELlwon8ikPvDFrzQfArfun/GAgTol0gI+WhMsNrDt+O39U/7yEsakMV
         2FAM6Fy9i1UEJmu9JzbmlYZiUCQVxtSzRmqPMVMiow9HExwp9nDsOZo9kMpSe3ohd7mh
         YLrxf5A7WMS5LOcaNP96d9DXVPGfrhLKMVOP0v9owAwbFvOZgnT2/65uWllQ/EfxESD4
         v2+w==
X-Forwarded-Encrypted: i=1; AJvYcCVAFDs61RKYCPEJKQr2uy93uOIXbmPnIC5fTwmjsUPHlmSrWDhwaQmf6TEbhpRE23sAWTCQObCHe9d3@vger.kernel.org, AJvYcCVmbI4C/uy7PEoK+6et7ip6uyhNKe4LUHe2MxLZimaMXYSBuHbags2dFFQVrl1ptAIBzr6oVftEuWGjtON0@vger.kernel.org, AJvYcCVunY7LKYYJxHWsmZTC7T3WKklJ4MlP8DYQOfa0M7/a3vEoRxObgHJYZ62EFRSj9cffaRoGLYiP@vger.kernel.org
X-Gm-Message-State: AOJu0YwKBUVoxtMi/+gPqJ7tBDr1PdorS5+/SI0xFgX6bF5X7KwErqMG
	W4R3U0Z8T2w+MKU9q84Nnpzftkx++r66zi0d6+aBcJs3mh5SbPNt
X-Google-Smtp-Source: AGHT+IFe87xKBVd4yftUeVT3qx9Oy2VAjU24uHaxTTbj4T2Gm9PoVBGwUR8pD/gNPDXKGc4fcsTaTA==
X-Received: by 2002:a05:6512:2354:b0:52f:c142:6530 with SMTP id 2adb3069b0e04-53b3491cb47mr3046431e87.6.1730395933433;
        Thu, 31 Oct 2024 10:32:13 -0700 (PDT)
Received: from localhost.localdomain (109-252-121-216.nat.spd-mgts.ru. [109.252.121.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde3287sm270315e87.273.2024.10.31.10.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:32:13 -0700 (PDT)
From: George Rurikov <grurikov@gmail.com>
To: Robert Moore <robert.moore@intel.com>
Cc: George Rurikov <grurikov@gmail.com>,
	"Rafael J. Wysocki" <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPICA: Fix dereference in acpi_ev_address_space_dispatch()
Date: Thu, 31 Oct 2024 20:31:46 +0300
Message-Id: <20241031173146.1459-1-grurikov@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When support for  PCC Opregion was added, validation of field_obj
was missed.
Based on the acpi_ev_address_space_dispatch function description,
field_obj can be NULL, and also when acpi_ev_address_space_dispatch
is called in the acpi_ex_region_read() NULL is passed as field_obj.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
Cc: stable@vger.kernel.org
Signed-off-by: George Rurikov <grurikov@gmail.com>
---
 drivers/acpi/acpica/evregion.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index cf53b9535f18..03e8b6f186af 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -164,13 +164,17 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		}
 
 		if (region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
-			struct acpi_pcc_info *ctx =
-			    handler_desc->address_space.context;
-
-			ctx->internal_buffer =
-			    field_obj->field.internal_pcc_buffer;
-			ctx->length = (u16)region_obj->region.length;
-			ctx->subspace_id = (u8)region_obj->region.address;
+			if (field_obj != NULL) {
+				struct acpi_pcc_info *ctx =
+					handler_desc->address_space.context;
+
+				ctx->internal_buffer =
+					field_obj->field.internal_pcc_buffer;
+				ctx->length = (u16)region_obj->region.length;
+				ctx->subspace_id = (u8)region_obj->region.address;
+			} else {
+				return_ACPI_STATUS(AE_ERROR);
+			}
 		}
 
 		if (region_obj->region.space_id ==
-- 
2.34.1


