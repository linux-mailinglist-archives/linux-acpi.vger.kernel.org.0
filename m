Return-Path: <linux-acpi+bounces-10097-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECEB9ED0CB
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 17:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4EB188048E
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03551D9A7F;
	Wed, 11 Dec 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SwtH0BVo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F081D63CA
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933243; cv=none; b=BEiGXewbqGf7RprZ18b+3CuBV4vMASnbdII7HSHB+vX/JdqHe4NxuSBOaAjoahCyUn7Vn8hBUcMj86bT1gZs/OtcDe4IfC74G5tNGZN7F2Mj6pjRu32J63pKw/yxI7ia735z1Fyx2OMqs3D5eKwI6vLNY8Wjprme2AGRCSQRAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933243; c=relaxed/simple;
	bh=q3MgbVb5/iRtsmwIocyzfKWa+QzfMXSv2W6hqdMRRbU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D/1HlMHVPWMlk6Ynv8VOTjCotxcKCVqXuuw1pcvhSwF7QXWfuLDKKmBiIZpqNIGFyJNdXVL1LwSgXD8twFu2Rv6Waq1jqQjKFycJ2XdtW9bP71dwW73K5tuF3HDiZfEtJ9Y7tiENWzp/HJDt1FaetYozNSTdjBTBPWqB4ySQSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SwtH0BVo; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8918ec243so69127926d6.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 08:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933241; x=1734538041; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9J29LWzCU8drwsrvfcYJ/OGiJlSXBsqUHcuK76qfw=;
        b=SwtH0BVo+O14WgVT40QQvmNeSNIry75n/djR3g+DUOM8b41RjU14l3rgIxA6MxyNGG
         aNRGPZUwSbnpur+Y3MqdonNzg8S1e5iHecW1XzBCObCqRAPiE32q8oGFQxwYaDsBXWj2
         aHz1lyGj3+S+xa5W4BJc9bCSIlMRF7J1iTAgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933241; x=1734538041;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3O9J29LWzCU8drwsrvfcYJ/OGiJlSXBsqUHcuK76qfw=;
        b=Kh6wcZTJZof5BGuzYmjSB6BblZ+uFOA6otAy+mPakrZb+iVhaO9YLoZrTl08w81ccq
         30xJCWOc8MQNp3tXRfb4PYNxJeW1mCzQgpPO6gkYVfhPX5sbBwQmOMwKrYPC9/NcaPye
         DUqavXwyXwQHhlY8bfWDmkTSHNpfEtdXuFKdacIQwahF8SA9+dMknbMSKvYWdlCHMxr3
         +Td3F+nCEXFV0DVXXBADY73ogIE7SnUXeKcYCUYInwTtSp8+exmNMi8IQ3kOvtR9YR1S
         U/Imu/uFkj/ntHoOyJ/WDp+R515JFzHpMzVAfUb2z4ykE7KGvllsYTQK6tHJVyBQfYKX
         KYKw==
X-Forwarded-Encrypted: i=1; AJvYcCXK5pEkDU0nPDajtYN/ObwUuLyU6148OLpRdMbKn6Ope9fnec/v97ZiNqCEWz1N7bit7KqcRcvtN5YS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+gQgRORM/qCm5ZAMhJe2Al+1H1tkMZCcHTCELjCIogIZ/zYE
	EY/2Epombi5Zh4zLWzkxBvqz1zBK91zUaOrjvTb2CZrLfiXzCqNQ8C4Its1CuQ==
X-Gm-Gg: ASbGncuYM8cdl1MUGpk7ko4esjBaFZobH0YRcxXXkQLoS8babQO4LHCpJnHLFNbMvLv
	fohPLP/Qoph9bWLBmQz1Pn6Z+zoyerz7FJvcSjKnQ+sGJgINzNl8+F0BpWLTFYZOVxIqPFuR1D/
	+G/4tyxUzPVWB5R6OSlGxEhdVkJ/eU2m/gsF7AAUguRQ1UoAxI+6H0wvVtwTj6/GFD0h3JzmbJ6
	30JsIvYgbSeYyfhySi4z0DHUrvU+RcBFoYTZgpqxQIOaQI87/WCfaGzP/o2v1izADn/SrdGpk3b
	Z/+jSxL4knesBEzfGAbUt+jH0GWf
X-Google-Smtp-Source: AGHT+IGjXMkyooU2Nlfv5traS1PR40dqAVdz7XsfULYSTHtrwgyML8EAsh9I9AC7bVBVYJ7VALIc+g==
X-Received: by 2002:a05:6214:766:b0:6d4:1a6e:d343 with SMTP id 6a1803df08f44-6d934b2bb72mr58520676d6.23.1733933240945;
        Wed, 11 Dec 2024 08:07:20 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/6] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
Date: Wed, 11 Dec 2024 16:07:16 +0000
Message-Id: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALW4WWcC/3WNSw6DIBBAr2JYlwZGROiq92i6QDooC6uBStoY7
 150Y9LP8s3MezOTiMFjJKdiJgGTj364ZxCHgtjO3Fuk/paZAAPBOQB1/kn9OFEDDkFpprQUJF+
 PAfNqK12umTsfH0N4beHE1+l3I3HKKQiJUAnb1LU92y4MvZ/64xBasmYS/FGBMto0Rlaqkqid+
 6GWuwqc7WqZVcZQMG2VMPLz67Isbzwv/jIXAQAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

We want to be able to compile_test the ipu6 driver in situations with
!ACPI.

In order to do this we had to add some conditional #ifs, which lead to
false positives on the static analysers.

Let's implement some helpers when !ACPI in the acpi headers to make the
code more easier to maintain.

To: Rafael J. Wysocki <rafael@kernel.org>
To: Len Brown <lenb@kernel.org>
To: Robert Moore <robert.moore@intel.com>
To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Changes in v4 (Thanks Sakari & Mauro):
- Squash the two ipu changes and merge everything via ACPI
- Space after ;
- move acpi_device_handle to avoid fwd declaration.
- Link to v3: https://lore.kernel.org/r/20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org

Changes in v3:
- Prefer static inlines to macros (Thanks Rafael).
- Link to v2: https://lore.kernel.org/r/20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org

Changes in v2:
- Add helpers in acpi to avoid conditional compilation
- Link to v1: https://lore.kernel.org/r/20241122-fix-ipu-v1-1-246e254cb77c@chromium.org

---
Ricardo Ribalda (6):
      ACPI: bus: implement for_each_acpi_dev_match when !ACPI
      ACPI: bus: implement acpi_get_physical_device_location when !ACPI
      ACPI: header: implement acpi_device_handle when !ACPI
      ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
      ACPI: bus: implement acpi_device_hid when !ACPI
      media: ipu-bridge: Remove unneeded conditional compilations

 drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
 include/acpi/acpi_bus.h              | 23 ++++++++++++++++++++---
 include/linux/acpi.h                 |  5 +++++
 3 files changed, 30 insertions(+), 26 deletions(-)
---
base-commit: 6c10d1adae82e1c8da16e7ebd2320e69f20b9d6f
change-id: 20241122-fix-ipu-a2fe28908964

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


