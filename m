Return-Path: <linux-acpi+bounces-10103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE529ED0D8
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 17:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4B51884056
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153611DE4D2;
	Wed, 11 Dec 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ggZxrwYf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03A1DDC19
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933249; cv=none; b=FljOMlWWvmm964Q5fSeVcC9glNs/j0xO0CPBa1/8ggyD4INQ23tKwVTte9RGStL76GVTgVEAKXhsT/2oyU9eF8lgn3691snDdWCyJArZN3fQhJFJ1kEm8r7pKVmryptYMVqdCHHYwxhL8mpzJ5+hM5bGuL8BN/tr5b6kOrIBfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933249; c=relaxed/simple;
	bh=9zHOmlSE2lBt2Rpl8UOox++hLCi27/TryYwCxVSnPew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4vSJlO8I0A+4B2sE4/HfWEK2L+ZGrGRcklLi6msyPGEpK20+KL3U0Ntl+z6lxONE8bLFdFHvnSAEKVapGb43tM9Z/vaaEJtkgNEflQWXDcJ2zqz7YHlr8PG4nVP+z/C8K8efZoFNS2/y3/D/DjwDwzQUlL3UoNeMpy5uUBIKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ggZxrwYf; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8adbda583so77046466d6.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933245; x=1734538045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMK9uUImiu6io0KCKsugDZpWMzJZHLlDJZIO+NA/9Ro=;
        b=ggZxrwYfYxo8MedkfkE5GyjXE2AUWIFdBn+/HP2yQfTAZkVKbw7d2VZjsqpsQg3oav
         0QWMr3/r52j8KVpHqkV9cANK4UiIr/6BWS3uu7y59ly8gVMawscV2Ss5z4iVbmq5u9Hx
         VkRJjaK6tR8lUphGE4aJHXyeAm1TmKP7SihpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933245; x=1734538045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMK9uUImiu6io0KCKsugDZpWMzJZHLlDJZIO+NA/9Ro=;
        b=j/Io/C5C/5rFf0Kw+7O7bYQW5P5ACIrWAHe42veIIaOhD3hg9RHPQ0Tho9tR4o4+L4
         TDVSjtGUmZmi7cfxKJ1Q/M326B64S/Y6XOF/fH6ruEgHezrSXWdI3ZKKORtWu3sn5h3M
         ON5mX1PIna7zrjaQQs9qFIbGzGGY9Dv/9vPx6C8TbMnUP6FmlD9Mg/hLjzgNxdQi4GHi
         T3eOZEXlrW+12e2mjvnMzMZ3vQiqh5wZ0EmsFVJGmGUGENKKwjyz1RCTQN60eAraPEi9
         FSNshjmZpYWvrm2FzJu0rXawIYJrhdMvbXzLHIbFocrboI+mvRodmy/bd1Ex5Py7odYf
         6G1A==
X-Forwarded-Encrypted: i=1; AJvYcCVL2pq4fb1Jk+Cj4AkRqcKThYjFOSmbXTcK7LcCx4Umcb4UuYmX581adO5xnu3D29OljLOx+iQLl4tw@vger.kernel.org
X-Gm-Message-State: AOJu0YyZahkgonrAnSOnGfJbyMk2dgzLwDPeVVYo1yod2GdfMA+fMHUv
	Qsv5sYsjcDczajpiA9pcLso8V0IJtwEwOV4CIkeECuj927ho+po9Yd1oLYdaH07g9qbC9fJjDJA
	=
X-Gm-Gg: ASbGncsh92AI5rnE+Wg13b1us94uBs4TUs+u/D1ROIg7jZTom41qEmXqZIMxa/IAp9g
	UfotjoEXttwGzUly51Y9M5Qq5CXXVyvZy6Uwc65BZfBJrG8vq6L2EI/35113GBvpYamMtYeuRuD
	NqtJLNIYcRPjvAbNJGe5Z4DNeyuHD8xAcdsWHol/W7zXkP0iiyxnjgbFiH+Yt+/VtZa5mY4/hvE
	IhpHfZ+RUhYUt6NLgNMjl2JAdVPSC6e4w1o/wHcKTGUKmPdZ6pcM7aehaM2ZpVarfvJqHTjCN1A
	9ZrMOKkU6i81fLodnjXa8Qmljn0p
X-Google-Smtp-Source: AGHT+IHPKXKsI2zaWBcy93AAaoxDDsJF4jn7MhbcckWqatjm8Z8ybpD/fk9DT9vAC4RVxmtKnQPx9A==
X-Received: by 2002:a05:6214:4106:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6d934be3d2bmr58201826d6.34.1733933243809;
        Wed, 11 Dec 2024 08:07:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:20 +0000
Subject: [PATCH v4 4/6] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-4-4102e97aceb6@chromium.org>
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

Provide an implementation of for_each_acpi_consumer_dev that can be use
used when CONFIG_ACPI is not set.

The expression `false && supplier` is used to avoid "variable not used"
warnings.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b312a72f48ad..80ddd76b3a6a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1009,6 +1009,9 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 	return AE_ERROR;
 }
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv); )
 

-- 
2.47.0.338.g60cca15819-goog


