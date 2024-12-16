Return-Path: <linux-acpi+bounces-10158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063BF9F3C7F
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 22:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4218163631
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4AC1D47C1;
	Mon, 16 Dec 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fxq8xg8Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A114B94C
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383846; cv=none; b=c8pw7+8Z9EngWT3veuXEZNrkfwtoHDLfbETVlzb4GqvfVjCJ1gkwoylPydb+EMp7vGIjc0rbclzgL2DWfhfggQ5WTjxrqBt6f0Ue9TijY8LqXgRN0QjdwXZjERMTjGoKtb3o9ua3QrCN/m1SYcR7xVf5la4KiPXuO4Kje+FOlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383846; c=relaxed/simple;
	bh=4fQYHchrSWa5uLGjxEoj3D06//Sn7ZmscruEw3/0WQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V4y2E70LCIue1vNb0zu3j+hgvYUxWcPV4VFKhAPLx1Mhf0pNbzsJSutXRPZ648yXbQfSvs9fj7/B5i23oU+FAwaKAepDh5Q7zTbrihtl1Vks9DcOXEeIokgLxVPvYcDALN+98uULO3r1xbqZyPvCs/bFz8He/TH5HS6sU4JMBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fxq8xg8Z; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a37a2a53so41083501cf.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 13:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383843; x=1734988643; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8AmPG7e7RmI2AaOsk1iihtx1bcIXZSCEYdSKszNNH4=;
        b=fxq8xg8ZfvL4k+CsJUh3V4P3x6sQwGywrHgEh21SURlsobd2pdgOtqM4o++lNh7vUi
         mLJYU8OrJ0aJg/UTu/SPkJLoBrcBSvui37hYpGCMzGMM8Zda8GMgswDK9vORG3iUUQlY
         xH66rIyULQHAEeTYg0Bw+pCU+cURnn8WoRVv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383843; x=1734988643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8AmPG7e7RmI2AaOsk1iihtx1bcIXZSCEYdSKszNNH4=;
        b=is2MhuPuwUE75iUEhN/q/2y2/ms+pdjvqfUfdBb2vny7RIuLzC+YVaowA9U7vn+iLo
         1Z66Sbnr1coMHKcQ4TgRKxp/GWhZCTGS00CvjhGYlNcRdoFMJBoRCaoimXOcvZYaraCO
         GKd/X9wNWm+e18m9wd6RN5VU1cz5KNuj0TVAaeU3Lqns6wd7OhGOwfvHhVy8kaVOtEN6
         tfJL3+K/8kHbDcbt08JKAyYUNdGXBpIb6gzgqFM1WozZxgKJSHXwhkBYitt68BRyagTa
         qHh2N2nFU8OIpb7HI3QjVy30A/AMpW1+QbLolc8WDD5IqOmQo2qf2D+atWERGJdhkF1a
         fAvQ==
X-Gm-Message-State: AOJu0YzRhh5JvkFi3y22pIExVCNZtUzi1twOduC1jQApwBaL0ueKzNRj
	cpTSspl21TPB5UBkg1wT0HkNA9DhxikMegLJrEYGct103xJZV4NAZTLGkNubxQ==
X-Gm-Gg: ASbGncsVaY9TAqQ6B0dQuIAS1xQSqZRwHTL0UOPLp1ZHgNSECZmkpLrwbvofTDYJcnv
	EHaAFhdxpj0qRgGq1yMKUz8EXEApT5G8MsUo5bD4QSkOwh7idPDpuR95T/nL4ynUF+cVwhTIi3H
	SXhhIk8PCeqX96MPSqYJ/lfU/kuRxP+iZeF6lMzQdkpLAdzb4nVIYbtteIQ73sUtEaqby5VarV5
	RzASopviH7EDEwcfLNaYrAocAurG0s0HdoBbl5Pp7W/HwoSzRhU7MGDcsVkRiy9NdVOBAh55+5D
	t2gooUPit98zUQWNDpS2ShEcHPyolps=
X-Google-Smtp-Source: AGHT+IE6nGYwK5u9N5YH85CBS/7ioSAcLwKhUyLy8jZqzGt9r49k/AYODQLmEjFBHtIiJqOxDlKquQ==
X-Received: by 2002:a05:622a:48f:b0:467:8703:a740 with SMTP id d75a77b69052e-467a5755691mr274120391cf.18.1734383842824;
        Mon, 16 Dec 2024 13:17:22 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:21 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/7] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
Date: Mon, 16 Dec 2024 21:17:14 +0000
Message-Id: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANqYYGcC/3XNwQ6CMAwG4FchOzuzlTKYJ9/DeBizwA4I2YRoC
 O/u4IJRPP5tv78TC+QdBXZKJuZpdMF19xiyQ8JsY+41cXeLmYEAlBKAV+7JXT9wAxVBoUWhFbJ
 43XuKq7Xpco25ceHR+ddaPMpl+tsxSi45oCLI0JZ5bs+28V3rhvbY+ZotNSP8ocAFL0ujsiJTp
 Ktqh6YbBSk2mkYqBKHQtkCj9r7iJ5UbxUhRCiCdG0ul+qLzPL8BI8zt+FIBAAA=
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

Changes in v5:
- Remove Fixes tag
- redefine acpi_get_physical_device_location() to return bool
- Link to v4: https://lore.kernel.org/r/20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org

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
Ricardo Ribalda (7):
      ACPI: bus: change the prototype for acpi_get_physical_device_location
      ACPI: bus: implement for_each_acpi_dev_match when !ACPI
      ACPI: bus: implement acpi_get_physical_device_location when !ACPI
      ACPI: header: implement acpi_device_handle when !ACPI
      ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
      ACPI: bus: implement acpi_device_hid when !ACPI
      media: ipu-bridge: Remove unneeded conditional compilations

 drivers/acpi/mipi-disco-img.c        |  3 +--
 drivers/acpi/scan.c                  |  4 +---
 drivers/acpi/utils.c                 |  7 +++----
 drivers/base/physical_location.c     |  4 +---
 drivers/media/pci/intel/ipu-bridge.c | 29 ++++-------------------------
 drivers/usb/core/usb-acpi.c          |  3 +--
 include/acpi/acpi_bus.h              | 23 ++++++++++++++++++++---
 include/linux/acpi.h                 |  5 +++++
 8 files changed, 36 insertions(+), 42 deletions(-)
---
base-commit: d216d9cb4dd854ef0a2ec1701f403facb298af51
change-id: 20241122-fix-ipu-a2fe28908964

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


