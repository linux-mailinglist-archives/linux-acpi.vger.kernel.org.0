Return-Path: <linux-acpi+bounces-10049-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6489F9EBA6B
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A218283ABA
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5454228CA4;
	Tue, 10 Dec 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Da8DHjme"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C81228383
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860580; cv=none; b=gR7nD9leQLcNXs2dVa7BYJKiXgYee/SbQeQqz5LaGlHfxS2ZLV7mVUhWfH89qRjE8QNBdnUoJ6Yn43ykDyTeH1Y2PnmtxONtJL4CHFiG8e1fIyjaeRF8wsYbO3iTLiwfQfWTOGk6ikPtbWmn8pcrr2yd8YutDdCMpMqrN4CbKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860580; c=relaxed/simple;
	bh=chc2biaIGBXBwkFrS62DYUV3DrLJW93SY6ROXf7O2qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E88UEsq1txRsvQ1akFjuFWiwqSstyZLCh2KyjiKK9+WN/icfRHvwHqHDopP+g2+Wqnv343zv1GEJU7yZL6TJKpb9+cCLiu2nAKK9jLLgRtCacUNdgA+6M/n7Y3WGqs4UAqy1aiqc8b1StSksJiHstIJCw9CoTXrGlTBMHKO/ZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Da8DHjme; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85c48f5e2c1so822852241.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860577; x=1734465377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipHTgEYnJA8+ZRCN0225YuFAf9jLp2OjhxHNBjpqWmI=;
        b=Da8DHjme4nPG8jec2YpUq3oIuQqq8FayWiTME97aleolJmcMikScO8lPjcHwyw4dyM
         DTOJ0+eP28+CX4SneF2fr5oP238XvlzqceCZTFnHmJcD9vl/Xaf8W/ses+KkUIPavQjI
         HaaVsGVJ/FmelcUieLD0kU3FhS/bYCLs8Hp2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860577; x=1734465377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipHTgEYnJA8+ZRCN0225YuFAf9jLp2OjhxHNBjpqWmI=;
        b=fZd6S5aBvGSRqQBOIUckHhXN7oNGPN04A+Gmq40yqiRjWk1S0JSUoAW858979C+iyq
         zTdoNZsJlWIMMcjZeFUwRjEtW7H/RrIvWGG8SQDMVqTv35ZpqsHJ6pNel7q7oVSlnOKs
         xamJ0jq9M0vVa48d5EGgbVf7fOmGIcz/GsgIpYQOWbhdUwcO9MATFSn4Y06m2c/+1NgU
         MyG4fMhkgsQcwRARACrWl79lY6zXyOL+Cdy2g5d+8RQ1sbi8y2QP10O5w7FktYhiTDBl
         OJVkAJ9O1iu/7jE0lhWihcIICuF5PWczsHXLU/ioA12NrUrr5Ap4lrNd4K01ZtedQ8Zt
         WQUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZkVFdaEFN6cSERm/0CnDJdSOlQqmSzgqiaKzPib0Hzkaa37cmDGWhoX9pxY9wcRMt+oecUYb27d57@vger.kernel.org
X-Gm-Message-State: AOJu0YxItOogn+eVGEvTQwd45/eT3CrrAb89xZpi6/gm5nS+U6DClIyc
	Ovs+pZJbl+yxEex/VYZAK8lmNRt3blHvcC+NWaaSGH+TUjckBOT5ioTdV/H4uQ==
X-Gm-Gg: ASbGncta3ODCARTTQaQ/RbGLm+Usa4VrXakJsKV1lQC3IJYUxcWJeDt0eXq03qqTopd
	PdAbko+RNoS7xZbEsi2AYBX3McB9itYt91Wgcu02PXwbJVqgnKMZZaRqKfU014lhCiGQhyc4MOT
	kiyK9ONlVQRygCv7YedBk8oq4V7xcckfoi9/c1DymorztAthIrI+AOvpBYlbp6/KbKOLiPHyaei
	G36FD9j3EU6vRtSxOIXWdSTSeZcut9TJfoc2/1muJm61cRKgL+Cw50HTtWWmcTtOrZHn8ytovtG
	LyOuHh70tD7flYVQUslWieYX7EIi
X-Google-Smtp-Source: AGHT+IH0lF25QvlNGwotiz6cjbBqZqy/AoYoxDEDz8EsANwxf772+wFf4srhmhHPIWngtFbdyB/avg==
X-Received: by 2002:a05:6102:d91:b0:4b1:24c0:4274 with SMTP id ada2fe7eead31-4b1291af18emr998015137.26.1733860577115;
        Tue, 10 Dec 2024 11:56:17 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:15 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:00 +0000
Subject: [PATCH v3 3/7] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_get_physical_device_location that can
be used when CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

dasadsd

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index eaafca41cf02..520f12155e7f 100644
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
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.338.g60cca15819-goog


