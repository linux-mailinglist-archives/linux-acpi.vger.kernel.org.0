Return-Path: <linux-acpi+bounces-10098-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762369ED0CC
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 17:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD92167953
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40CF1DAC80;
	Wed, 11 Dec 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TV7WAq36"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077E1D934C
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933244; cv=none; b=WO3xqGmkZ8poTt9HVKvVcEsnmwuk215hevp/1YRnlyHDmAgy9kx3/ApRejYBNQBVBcG9002XAoRfM2IOKZR4xW6iW0jrJNRIZhvPs2mMIQP4y+S2g9tipdjhQt5JOQWDDnq5E9a7hMqgyNkoOBXXNIPRcqggl5txRDRrQOET3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933244; c=relaxed/simple;
	bh=TqounAX+K+Jxvi8T1JjQIXGiJfX2iNkecKUSnEv++60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2l3N80JECG1fnNPfztvM3dRLClPh/tEYq71yKpwDv8NqJcG+DkPmUDQ9MJzVhcymFlCK41HiCsNJFng4A5WF/Bz4guwsYg6N+JnDCatz2PMm+0DjlV1NOT3dgTo+pbIAYJppJN/f6x+zCGxcrv9lV77k/JiNkacqHthF0BgQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TV7WAq36; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8f916b40bso59096026d6.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933242; x=1734538042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNCYhbk8lfVWYHW/bT6mgb7P6pux9ucX6tRFgaMr2JY=;
        b=TV7WAq36l2J4CLk/dFnHX8wh3ZUukZ3LYP6ajlFKBGN7dolw8PRkdnv0TFJzzwWF+I
         ca5TrlBrOmTPh/G7gK60T5cKylMc55Gi+A5PjrNJ87apC0yqT5YCe+ib9gfmmmQUjQsZ
         mIbC4jsMBOv7LSRVOQgSSfNyhPIhOyiQcjpnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933242; x=1734538042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNCYhbk8lfVWYHW/bT6mgb7P6pux9ucX6tRFgaMr2JY=;
        b=VhR/cYtq7cJa77uaX5GCL9tLaGAHE4FTwvdNnQ4z71vEluz5ITYEolHQASdqhJjZkE
         +lpwJw+emq15DN10+HjN9/dhPLplAmmHfw8tkDD8HzBfO/umqMr1/7hgv3G4qCvesOWc
         fqBw9GRgWwHtoQ2f1TKWiTscVI9AIgEXWq/21Gnl4ALgNklr/fCyM7RrNHEBViCHRR0/
         I88sS1Y4NtODEV1fOuiCQo5lT4P9AaOTDnz6vemYlfKbuwG5P4m+q5bugoWYR57i/GDK
         rNGh0Nv55I+tjMj1emPwbXuRkfHwKVDnXbbI0BfacBq/m/ycIQKUDzLg6fodO9GDA3ys
         6SBw==
X-Forwarded-Encrypted: i=1; AJvYcCUoBmbnd/r2TxkR1U7XAzeFW+4Ori+t9fUiTtiBu+Tl1ftvXs3buWQGwiA1Loc548YWWOZ+gF3XKpTB@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1v1AdiVHD38sqJm3IidYCHYFJ/c12Qn4QXUuhl4y3oFq2Ea+
	I9UfwY1r4JPmFvTcW/t8NO4Xc2Lk/Oxll+H4BpHNikJIkh8FsLtGBcTMx8HP3w==
X-Gm-Gg: ASbGncvoF5Qepspg4C0/gJ1TDIcq3jcZN3qBy9/oYyjLig5MyoZ3cl0PNIyYsgpbayE
	FXashgmVYeeFNosNldIFPzp9mYflD6WQvjeCVC6a/aqnN5FXK+YYnjQ4/k8RpSel7oRcpStULwG
	KRpyL3S/zoryip+ttmLgK/KYpYL0Mk7jAJdqJgYJz/uWZ975BhI0dLBvEH2QioqymG7EcFfGFnP
	SrsCLLHhbFlr2HRBF6QtTOJVLTP84ybGTVaQWrBlgzUi8XZ6N8VxrxjccC+TYLCoDLVOCXdFDIS
	A5FvGPASVGozxliIlEx6dTku8Y+N
X-Google-Smtp-Source: AGHT+IGcc3JlLT/wu+C4rWFjGmYrf64CYVGHb0Do566/dBbbYn4TQZbAD2UV6tNA4A7JWCGBQjJOYA==
X-Received: by 2002:ad4:5f8f:0:b0:6d3:b636:eccc with SMTP id 6a1803df08f44-6d934b1cbc1mr64900806d6.21.1733933241771;
        Wed, 11 Dec 2024 08:07:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:21 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:17 +0000
Subject: [PATCH v4 1/6] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-1-4102e97aceb6@chromium.org>
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

Provide an implementation of for_each_acpi_dev_match that can be used
when CONFIG_ACPI is not set.

The condition `false && hid && uid && hrv` is used to avoid "variable
not used" warnings.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b2e377b7f337..2b09e513ecf3 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,9 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
+	for (adev = NULL; false && (hid) && (uid) && (hrv); )
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/

-- 
2.47.0.338.g60cca15819-goog


