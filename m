Return-Path: <linux-acpi+bounces-10101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E7B9ED0D4
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 17:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AD61880670
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07A1DDA39;
	Wed, 11 Dec 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F5Dat/X0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC111DB55C
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933246; cv=none; b=uhcyGaP2vG1f6Uz/4RRhcxZqveABpCeSO81rPtMzTOJyfP07vcKp62rgLU0OEKmADaWJ9if77hnUX5ARmVdzX6WzzXgjP/McgAF7TibqaadYgnqrHz2FsfAGTSTnshg8CVJWl7NnXfE+xQFEDjYMKg/N0LnmAlUyIOdEVKNcShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933246; c=relaxed/simple;
	bh=Q0tZOYhuY3Ey0IPHXjXrOvps1QIhlGU9kBOlggkrfY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nLzXGOCrL9gIbVwhJ+7alp0JVsRMIHddDJN0sntVI6g5dWTLWhZgmMS0Rga8Mgs2guJKfvT0VCQs24U8hgxfQTmWncMC7aLvwM4CO32ZD+rNHtktM+nFiOk4zk8EHfvk10upa+AlPOADpZET4X0NHAEYs2O6CTYv0KbVEMtEZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F5Dat/X0; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d8f544d227so29626726d6.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933244; x=1734538044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aEfR/qabxahuoJOZlYtnmnLnWgQnj7Jexuo0meaq20=;
        b=F5Dat/X0wqCmvAIHzvdm2dKozxp4NjsqpyVj26QvOSwBDhlpolJCgOjhDmFhOG7OQr
         v1O68cIx9CuhilfX3HuspiJOraUOO1cOjdh+R2vJjwYzyPCoNLvf8bJDMwSlI++l8Mw0
         q65oQSNU5HovOoIk4eIM4BfOJKREMvdKA4xdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933244; x=1734538044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aEfR/qabxahuoJOZlYtnmnLnWgQnj7Jexuo0meaq20=;
        b=hv/wuUBtWa7ekN3P+oecFkdB7lFuAIWXqWtf0hgbM0n01KI4a/cYNQDCx1gYg2kklU
         PIrxHy0hiVvb2Wwnp+RhOoRa1b1Rt4phEVUg4yZGcQEOKXEct3cRSQWHjK4fV/Q1lxUz
         jnhlHfCf7PEea0Ve8u8C+kowEidE6XT8QIf3b0MvBVKUEm66OYp56996HykV4A/U+zGf
         s0eMEqbTUFR/MnEBrtZXoDCICWvMP7XBey/p9A30JtA1Xqg6xJo8zxa8i39Rmv/HEGAV
         1PGhQROikB0y5o3VIWi2uDUSV1zJvjXAIGfm/2yissROgNhK+tWmH8eGDT/fW2OHhAVD
         jUyw==
X-Forwarded-Encrypted: i=1; AJvYcCVgkDT+km2waEBFU4b2D7iIKQg9oH9tS3p0cOpatdcXR5d+PL0ErQDI1L9cZaPiCnz4lrbEfhYNXLfa@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXqrU4epoNEgJ/5qnOvYqfV3e+nEfeZgbQVl7pP9po5OJXAEV
	0aswMi4jMwWKHWkflY2Bmn6SN8IKYjWCix5DX6B4F9A+cQsr7Vgg3scM7Di4Vw==
X-Gm-Gg: ASbGnctRUNgbTfptzWiHXVsXZWZwp3lATCC35EOgklJhy54RFvnl31gtAg5QDhLu3O5
	INX54lWUDMwVpco0mZhisNcaF/hrF5wZ3kMxlNQ+KxBPmF16WvIapXtHehIUGcVN6dXyaPC6tk8
	bcwM7de64xg7eHc05/9fxppSOeOrg8kTSx7zUOKrzW6eUkz3WlABLogTRufdBWoL0fbWCUxNpw/
	d3S7xpQSzStExf+xz3XvtB7hETU5UefdjzhhWwiFlWoAIC6X7kF2rVwLuyy6ViujTo5hpV6qxs5
	ubwgA9ceKLiM80Q8op4CtLPmPy9v
X-Google-Smtp-Source: AGHT+IF87GwFnPD41KxfMUhVnNyyBe54GEcWZX003dqF5ZJl5NACMpzgazmytTFC9qeLl+gKHOK6SA==
X-Received: by 2002:ad4:4809:0:b0:6da:dc79:a3c9 with SMTP id 6a1803df08f44-6dae29c181cmr3825226d6.9.1733933244430;
        Wed, 11 Dec 2024 08:07:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:24 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:21 +0000
Subject: [PATCH v4 5/6] ACPI: bus: implement acpi_device_hid when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-5-4102e97aceb6@chromium.org>
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

Provide an implementation of acpi_device_hid that can be used when
CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 80ddd76b3a6a..b6b86acd1d9d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+static inline const char *acpi_device_hid(struct acpi_device *device)
+{
+	return "";
+}
+
 static inline acpi_status
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {

-- 
2.47.0.338.g60cca15819-goog


