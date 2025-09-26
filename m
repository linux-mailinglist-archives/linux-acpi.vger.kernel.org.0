Return-Path: <linux-acpi+bounces-17351-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEFFBA3CCC
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 15:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDBE16A9E8
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24F22FBE15;
	Fri, 26 Sep 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MEdFAQ1S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58962F7479
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892300; cv=none; b=X0z1YsmxifJN3xxNpaC2ruGzB3TQLFGaUEFotfATvHCu42KNIgoo7d+o1UlAN8gLBDzYGL0z3/+n9eKFLw4cSe9AZUFauOn0LaX1ODFBQdUouZn13W3UKGaLhh1+6/eF5HQx9pxyPYS0ng/CLkL0Pf+ZOBPB91Y252A3Xj9y/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892300; c=relaxed/simple;
	bh=747DSL3/0b26gMfctw9GAJQ4wcs8qWL90knTYpPv+GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trA9+I4QTqtE0k/RaLTxPIjHEbduGMG24APFExaKV7Az51j5aH6kHVyg7AnmfO0S7/eNoxUybYnhT1eWdndSBp5o5oLILngRNiErN42ZT2dAvGxs0GNzch8yqZVnTzEchFPS742+UvEmRtfBkt3UYjlo/EWuryQTD2vpWvmz1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MEdFAQ1S; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso2129288e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892293; x=1759497093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEFN0lLdAUAhxOrw8NBMU68FYdHDfoPQjtv/CBRcNWg=;
        b=MEdFAQ1S/grHZMhcCO6tE2MJcK4ibjWaeuhsoYyuBn71UUcnUC/shY5ocmLp/qu7WP
         7okYhCuXdM2bbt6BvNRcorf2eaEw8bYT5GfWfnogq8O28zLjMWCbeVbc5r+A5z91fMDr
         LpswgYv+M4HDBm0DOXhHwb1oqtph27Tu0Jodw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892293; x=1759497093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEFN0lLdAUAhxOrw8NBMU68FYdHDfoPQjtv/CBRcNWg=;
        b=bZPUFJRNVUoYStdf8cM6ex+PAgSCATPixr37RlklDl5u8jycE+e8MQyqL3LQoqDPMo
         qUfnE/v+JTVh36rsejpMDaVpFiZZwERo0SUJX7M8waiZOC1ZitK0qjRsag3ra0M2htjc
         HWi+QoDWJSvV0Wf5D+D1se7bAnn1jQmh6YEry38N5JhRBSItL8GYDRiJFQFBpR2YFMyc
         AJcZId+3gKZ9VpAcIbWl0yiFlIlnxS3ZDNF3RObsoNxoCZy7VexkJAlkoBCInrIgpXkZ
         OmHk6aZ6aqbeQb6b8XCgYQxI4N9ta5939VqQfgMIiHQGtheO/b0KBcDoCGrNdLrKMiwH
         NEdg==
X-Forwarded-Encrypted: i=1; AJvYcCUYuImNCaATA4LLx93qonHaUwRGL1oeWLLHOrJCvYQQdlnDG8DeJKTomxenwzZ/XOdHOA21w1jbiPcT@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVeQZ73fBEX/wr3fY/cDUDNizRIstMCz0xWvgIFKYxkBg71E6
	BFFSJ9SMHLO55ELH4/c38LTXQB3LuIwT8ItekHOitCHX5ot71j3G8Pv5FCB43xd3xg==
X-Gm-Gg: ASbGnctYXqCZispqEux83x8C8Ia+KuJJT1juwo+0KFJowznL1dgdj/euAaEfaGbg9dO
	sUBIl4jVB7IVMQSEysUUv/QpsDHyWGTfuaZVPuWLAFr0AJ+8O5bBHJsi3YdfH3ibbkdYm0RMsZ1
	GsfCD8BFZ5xFjYv9xIKzttcz5scYhSOBs2Peyw6GDFzHv2YBAscGt2BbTB3ZmXrLUWK/X3REXiS
	rNFNPVdju0XYFLPQXZwFA5Ze8cPn2L4w25tuKuC+x+WBAeI2LXG7jUFCs1s/FpU1ocr12z0Wk5C
	tOKVMG7MsqyY7xbHE1zkp/pVOIbJxOosfDqmX1fnJj9jJrBT/UCtu0rWgumaWS7IFllw/FPhqX8
	PlkuQHd2TddLdEa7dOucZoaL1V8Xe4yF0GhyxuHCisrFDFusVLybM0IXxw9ccR9z786ZotMpVqX
	FOCw==
X-Google-Smtp-Source: AGHT+IHoXncX6KzHuffRNxD1bdNRByMLtGFUXJU+Vx+pJpeCHx/eyFalgZtv/Aq9A8oN/XwwQ6kRbA==
X-Received: by 2002:a05:6512:e9e:b0:563:d896:2d14 with SMTP id 2adb3069b0e04-582d2b4cb9amr2443275e87.36.1758892293127;
        Fri, 26 Sep 2025 06:11:33 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:32 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:30 +0000
Subject: [PATCH v3 06/12] media: ipu-bridge: Use v4l2_fwnode for unknown
 rotations
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-6-6dc2fa5b4220@chromium.org>
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
In-Reply-To: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
To: Hans de Goede <hansg@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The v4l2_fwnode_device_properties contains information about the
rotation. Use it if the ssdb data is inconclusive.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 441d1a5979fe94bee4738da68e185a44dbd411d4..6155046ef4fc6b5d074194d1b8113212304136bc 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -242,19 +242,23 @@ static int ipu_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
 }
 
 static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
-				     struct ipu_sensor_ssdb *ssdb)
+				     struct ipu_sensor_ssdb *ssdb,
+				     struct v4l2_fwnode_device_properties *props)
 {
+	if (props->rotation != V4L2_FWNODE_PROPERTY_UNSET)
+		return props->rotation;
+
 	switch (ssdb->degree) {
 	case IPU_SENSOR_ROTATION_NORMAL:
 		return 0;
 	case IPU_SENSOR_ROTATION_INVERTED:
 		return 180;
-	default:
-		dev_warn(ADEV_DEV(adev),
+	}
+
+	acpi_handle_warn(acpi_device_handle(adev),
 			 "Unknown rotation %d. Assume 0 degree rotation\n",
 			 ssdb->degree);
-		return 0;
-	}
+	return 0;
 }
 
 static enum v4l2_fwnode_orientation
@@ -297,7 +301,7 @@ int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
 	sensor->link = ssdb.link;
 	sensor->lanes = ssdb.lanes;
 	sensor->mclkspeed = ssdb.mclkspeed;
-	sensor->rotation = ipu_bridge_parse_rotation(adev, &ssdb);
+	sensor->rotation = ipu_bridge_parse_rotation(adev, &ssdb, &props);
 	sensor->orientation = ipu_bridge_parse_orientation(adev, &props);
 
 	if (ssdb.vcmtype)

-- 
2.51.0.536.g15c5d4f767-goog


