Return-Path: <linux-acpi+bounces-10161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38BA9F3CA6
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 22:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC7E1882C71
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985861D8E18;
	Mon, 16 Dec 2024 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LSEs2M+2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A11D5CD7
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383850; cv=none; b=WNPr9dOCb54gRvxLYRnJkbckLZ1HMP0ju4KVhyA2mSvDb+cHR6cJznLyG0hbelk0attToSs0PBHrLLErR/n1NcEHhQ9+wMyZvhkKZc4X4LLK9H2lO4w1otuYZK3/Q7JB+Baj2Y9QR6ABRsoFYdTK5ZZSpEBuiGjUSL+D9bmR49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383850; c=relaxed/simple;
	bh=X32i657SSLdAHHKEkAbumTOxZEIg1B0mwuSYHOFYedE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJSXNDmksPWEI8m6f3n4qc+tP45F2N9YjCmB+YGIIYMZk1ogG1FI2nE9ZJUKywLdRQ4jbGAGIR33GOaeV0oVfQzYFn7+FaW1Q9ANTl9TeLIIytsO/1cTOBwO6F1ziCKvRvQK7ghzi9BIXpvysCYkRMOvP/459cqzC/LbnoQyyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LSEs2M+2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4679eacf25cso23425161cf.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 13:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383847; x=1734988647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqBBzZFuR8Mx+keH2/BU5geK8A+jljM9pAiu8cpH6y0=;
        b=LSEs2M+2u4DUw7wALz8b4Ub6cQ2qEl/y/zuTqEE3TwDenbsNWiFE490qDAuagbC75v
         RUwY0bCqz9XbHcdpEcetZGUp/wPYfmGgQAPLKDbLGag8TmV81Tb+vMoLZ2aqvDn201/+
         sZaqERXgCo9kspL1Kdh0UuH7V7U+WZPvH86Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383847; x=1734988647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqBBzZFuR8Mx+keH2/BU5geK8A+jljM9pAiu8cpH6y0=;
        b=pvF9sDNEkYjI0MHkHuCoiN5OmXEdzdlRFItoyrB42B8rBYIFJI8gC7ar2jJvaam8ai
         ek7Hd08DTJMpaSSjGsJvBchdtacIIgv0XCcapP0hsnOAmxli7WhQJUwKHK46/vP6Ixji
         mzH+3vAG4UHQbTWOSY9TRTSrrdOQqRQwpAjhGCH8MOcM5cvMv9SO0yDyG4UlIWh7o19V
         4PkQTegAXdjiRhxiD8BzxtrJK9GbDFaW+1YWR2jRn4gKX2G9sMyWMwrHENLj+oirll90
         Bwu8BhRzbaYUEkSKb4GItfRPf4LOE/sskgbE/G+RMKKJTrsM/grabW4PGfQbBVYcI+x9
         Ir+w==
X-Gm-Message-State: AOJu0YzUsYzunNEUOoWOZYvEAKhvI38CD1nAUtIiNRNLQu7DaXK/A4Hd
	xzybHf1WACsYbHFiq1KgGkXKnXIOasniAmROHlGvJ61/cT5IgzqQy8AtEHphFQ==
X-Gm-Gg: ASbGnct5yJ/p26ILc0CgMzu7GcuSKtDLFTrT48uugNGcJ3T1xrb3Dz6dtshOr/r+7AA
	bUh8w/cr3wiR1JsrAQQhup2ySs/ZKovdkMhutZFL1VB/E/3pecP3fyg4IpjJId/7BJ92QUJbeFT
	EK0jItj34e6AnciZVVJmqQhJgL9fc0KRjzOFop5i9+PRiYrzDVQkOZ/LdeXCIUBPbGRC5Q078IK
	nsZD536BKYi4ILoubKUzTFhzlJoXZww5LtXlaKduoJYy+qRJUj0pOlPibwNxv4FeLH8C0039ge0
	pO6jowogxaOeILNovEeYr2gcdkCsJQU=
X-Google-Smtp-Source: AGHT+IFa0lE3VU6S7yMTSi6U10IiAbRleFzkYam8wiPnIWkXufZo9uMrtys/YCrx+kHmkm9mMlGHjg==
X-Received: by 2002:a05:622a:1aa1:b0:467:79eb:4a16 with SMTP id d75a77b69052e-467a5721b4dmr271093651cf.4.1734383847705;
        Mon, 16 Dec 2024 13:17:27 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:26 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:17 +0000
Subject: [PATCH v5 3/7] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-3-3d6b35ddce7b@chromium.org>
References: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
In-Reply-To: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
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
index a9b5a5204781..f38e8b1c8e1f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -43,9 +43,6 @@ acpi_status
 acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 		  struct acpi_buffer *status_buf);
 
-bool
-acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
-
 bool acpi_has_method(acpi_handle handle, char *name);
 acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
 				       u64 arg);
@@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
 #ifdef CONFIG_ACPI
+bool
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
+
 static inline union acpi_object *
 acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 			u64 func, union acpi_object *argv4,
@@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+static inline bool
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
+{
+	return false;
+}
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv); )
 

-- 
2.47.1.613.gc27f4b7a9f-goog


