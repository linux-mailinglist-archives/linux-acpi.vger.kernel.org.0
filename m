Return-Path: <linux-acpi+bounces-10099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500AA9ED0CF
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 17:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D044167A07
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412DF1DACAA;
	Wed, 11 Dec 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l5TS8ffB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7311D9A50
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933245; cv=none; b=BnUC7paAbvYHsRChcZJj0GflkbZmoVup2/pZet1xojUiA8TfhuJPmf0FJFZ3e/bQRDQ9jBwPFr/q2YnHYAL59zt5B9Ue3cf/PR2EQB9tW3xr2UwsGIhQYkO30QXu2dX1PhmD9fW6pGUTApVn9JGkNXviET/7dpQpUaNAOyGKqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933245; c=relaxed/simple;
	bh=Kqe+G/l8nHfp8psC13t6cysIquELOSvwbRiUrehr9ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVj9jLcgSJ/lPY9XmJL11+VCRKIPAyX3xA3okgBMO1Z/HW1cmAeJAZmQnu2d5drJ4lJGLn6wSkiH8LQKgYiaVf0zQ9wh9p5SQrC7oArHpo8f5ST2vgPlphx1owouP015iLE+8QP19VFdMjhjIhiByrqrYTSKKdf5atCwsE8IIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l5TS8ffB; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d88d3d1eb6so7994856d6.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933242; x=1734538042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT3f5Gb/3D2wa9sLrS99ud+PgqVP7v8K52z7Rn+R4vA=;
        b=l5TS8ffBdfP1JSSz98T1X9wrtUMJYH89rkasMjLAv+aJQ+MyEBSWmYEdTWKlXOtRRU
         VXAGVR2hzdYTgl73KDLBaDvOHHb6zDegiRtCNVb7k30SbTNDTGjZ9calhKeYhm15T5OA
         c5bOlgVxxNnKgstRaDKyX92W15MxKsq5OsDxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933242; x=1734538042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT3f5Gb/3D2wa9sLrS99ud+PgqVP7v8K52z7Rn+R4vA=;
        b=rwWy2gypnAKcc7KKOkC5UE0XT3wxDE7DPCfn9hhxqjN/iCvdotMyWH9ghmUFTJkGnE
         yMaOf51sJkdhF66RDniCFow1bGZNTywCOv1mn/JbcscN6EAuCtcbUPwYZOswIozu8rql
         Yt5Fj+8yRsnoE6JGVudOZFLHzqqwouhsJqGbQeAdkIoHn1RQ0UhtSJjUB7nCI+VakZIz
         RCROD8b3l+2IHKZJ5WT0XhXR/WVqrPasCjttOXELsKNUZGc3VQiainO0BZACw0lUodMG
         FXj7HnzvNGAi8XJ0wlI8q5ALlfZxALhenPjmmnTPWKnf/DT0xZ/V18IO2XWKToPboThd
         Nx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWB9hnakeZOnoAj/s2Gk1lGE6GLcO2ASOzi9IR62vtPFItpzgXkYat3FqCXDrIaizVAat84kX5OzWZL@vger.kernel.org
X-Gm-Message-State: AOJu0YwKKPDzc8/a7tvD1ySDfwMqbyFboqlW/oKm8AkKoE0sq5lRsvZk
	wquqOQ9mV2mvx4SWY3vAx4+6+qYd7BKkZCNTcYXMx1GtjDrro/l7iYbwFiAW9g==
X-Gm-Gg: ASbGncvuPiCkbV2HsCCTPcl4J3PO91UrKiyx3aPANgPT/rGNdIYVYXF0krqaCMi0KJA
	ekGEITRHbkMy+A3EJM3YevU1nIeqYeSfjGEffL8DYu8MAxSaZGBOTke4/gA6nXiiURSpZm0l3jX
	5wqsKlG81/EQcQ+/AZe2lk0TyDXukU9Vt/j8hzXHDdcHKDwrTKbWl0kuGT+mx9RBfcRNaYpnrzZ
	rTcOyP8h5dkNIAYhS2sZqbUFtvhlWe+ARGYRfbC+NqCHz5b0H3AHEDT2rnmtA89nEqRWMOSMxNp
	cWQ7y84Uw2pp9XPUBrkQUOImFs0AyCg=
X-Google-Smtp-Source: AGHT+IEtktKFv3qaTtZ9OL5m9Tz4Oa3HoUJP5EJ7WrirQArVIj8ul98ZYjRW1cJOo6oehSupJehWdQ==
X-Received: by 2002:a05:6214:21cc:b0:6d8:b5dd:7699 with SMTP id 6a1803df08f44-6d9352f1ce0mr58803916d6.17.1733933242384;
        Wed, 11 Dec 2024 08:07:22 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:18 +0000
Subject: [PATCH v4 2/6] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-2-4102e97aceb6@chromium.org>
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
In-Reply-To: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_get_physical_device_location that can
be used when CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 2b09e513ecf3..b312a72f48ad 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -43,9 +43,6 @@ acpi_status
 acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 		  struct acpi_buffer *status_buf);
 
-acpi_status
-acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
-
 bool acpi_has_method(acpi_handle handle, char *name);
 acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
 				       u64 arg);
@@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
 #ifdef CONFIG_ACPI
+acpi_status
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
+
 static inline union acpi_object *
 acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 			u64 func, union acpi_object *argv4,
@@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+static inline acpi_status
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
+{
+	return AE_ERROR;
+}
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv); )
 

-- 
2.47.0.338.g60cca15819-goog


