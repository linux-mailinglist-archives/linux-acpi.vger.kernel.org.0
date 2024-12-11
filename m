Return-Path: <linux-acpi+bounces-10100-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C51839ED0D0
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 17:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F581683DA
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 16:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8A71DC999;
	Wed, 11 Dec 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HO/qY15m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB81DA11B
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933245; cv=none; b=OlHcE7uKCpePaOOpuq/cc3U3gUK1HTgRlHH0YGxEjW64wF07eCbNZJzhknjCeJuvF1beFldeJB1+cxt8xFh0l3SBj9MeL9IpZIKBU2vdzELXlVvaSZN1TWqEicyRgRN+sZ5nSCkvklV3qyBFW2eCbCb7z2yQ3h7OjBuCNLKagVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933245; c=relaxed/simple;
	bh=Al9wzob7Lhv6GfLgpukZha8snPi/gtMWzqmI5Nh5O0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTYrTmLAJIcdqVHxfWmAt5yHiSNd9evVNj+QkvrTs1aVtlfoCJW91IiME02FWpgAb20xiuX332drZgic3jiBUKcADJRDe34rNzzQQeKJ/wCsGPPa93TF350pkbbqTozuKFvd4el5RbCuvrsL76afzYLX5iG9vj0UeWnXt5qDhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HO/qY15m; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d8fa32d3d6so56514026d6.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933243; x=1734538043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTwO2nGd6wIbXXez+6l1I38nMUW2rTd+Ao412JHVCs4=;
        b=HO/qY15moLUF1pboU2g8cZo0H+/lhuE9UZA7CGcSY054umih7oTbcygFUhw1QVlWzQ
         Iv3IFyxSHLsZS70V5cWDrnBNm34AM4ZjKmhEuZo9fZ1PCaHx2O7nfdNf/EnLyzq8beUo
         pRt+3LzSpvt/h5NVyJ0dPRzQ1cV/cq3KbK730=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933243; x=1734538043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTwO2nGd6wIbXXez+6l1I38nMUW2rTd+Ao412JHVCs4=;
        b=F/JUpUo+YX0AYueFgXQwp+7bEP9bXGCqC0yxRng/lGxevyxUcbpXx06gbBGz8yPZ6Q
         uOksaresxb+gt1S7VcWH5vWlcHRxC08blnqAfp850Go450wLzVH+Zyd00GYFHMseUcAx
         DgvxP+zZ/7U3MNLMsXm7pa2LnDfomjbXu2RlZDmZwo42sIYnX5CVifHW6+HEayZSkypH
         EoJEE/mAcG0T6cXM6VasyqwN+IeonaiFczUJfrlgHynt+16XF3XzNWYYUsSIH0sd0Nf6
         nbBvPfy0r/EqTIV7RlFLg5jnYqqj5BWZT5tyS6TQQDwEDobbDh3F23kbeHC5DYP0uYGi
         UeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX9tKRZ9OA5fT7/kXU+jRPWbw7R46oLXVFPjyBIGb1/NbSBUC9zXk0xbLkEvUwLAXvU3wElBoCDDjm@vger.kernel.org
X-Gm-Message-State: AOJu0YwFsVIjlsdxd6KG7rWUfcFPFH1otifEFMERzyiA2GcL6vsT0b7W
	ByY5WZ3Fdd8D8ZLre2d9xc61LTKFd49b8NZS4N6dwthUFznhs2QkC5wuORbf9OyQF34i/eVfAtw
	=
X-Gm-Gg: ASbGncvvZiKIeVdG2DeqiB/HJ9IVD42n6qk0PS1CgwH84pSoBNSczTVE9AsPyuBk9Jw
	6ymDIfNbXoE1IMrZY7RpRF2sPM+oMQHHZEj0p/ne1yFMNCRqNn1dCeDuR2dgqxn0WC49D4YeYbE
	g+BbSGMbpsbYLMlsa9ZBktCBfj9vn7vj7wBQl8jsP61LNidFK6isPciOloWMbuBRpLpFq6/4xrM
	ZMrIpy/NYbgROvhq9YutuLzBTSsfnnlEBzzwkHLhzPHZAfP5gPfqsT5YNtJxsN+ksalMSRT8DMt
	HjiI0R9dpbI/bHpfAhM4kseL/AJe
X-Google-Smtp-Source: AGHT+IHNI8I7kNh1BQAzlY9E5JVcbcVT91dIbzXQpJE1CHokvbatsoZUS9G+d6jIEJjgxda5ooPoQg==
X-Received: by 2002:ad4:5c42:0:b0:6d8:8f14:2f5d with SMTP id 6a1803df08f44-6d934b2d7f1mr64995796d6.28.1733933243062;
        Wed, 11 Dec 2024 08:07:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:19 +0000
Subject: [PATCH v4 3/6] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-3-4102e97aceb6@chromium.org>
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

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 05f39fbfa485..fb88f21bffb2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -854,6 +854,11 @@ static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 	return NULL;
 }
 
+static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline bool has_acpi_companion(struct device *dev)
 {
 	return false;

-- 
2.47.0.338.g60cca15819-goog


