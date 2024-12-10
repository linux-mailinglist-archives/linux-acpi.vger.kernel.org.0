Return-Path: <linux-acpi+bounces-10048-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2870D9EBA66
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EFB283DB1
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4FB228369;
	Tue, 10 Dec 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ws4Sj/MV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9B0227578
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860577; cv=none; b=Kxs9XHh9pD5GphaTbPuK9p4zojwabDqXdN/Y+/2RmDHThEb19mN5kAYhbO9N5LBi/rwJn/TScOVVxebI2ZkG941waVOi9bIRJO1T+hFlTFlKiMYUY2sVh76QH8gvWbj38pBKUyKwI1lXQe2tmrYJrLcJd1AXRKbA1cPU/CRViiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860577; c=relaxed/simple;
	bh=JEumEao6OwtFIq3N27scJvmQPpmiw+AAjw5tpWVO+jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkOIFrAL+LLHzUNhBusnJPgx1tNBMD/kF9o6s8GkhDDkp4Bo0ie8t7bZSVbf3R48MlH+zl49h8njIiTr74vSkgXhdAS2GeI/4nnQNB9A6mdnIqC2vjOhhG1N5OLAySPyLFd7ehG8uHIky2pouybAGQUi0WsrnT7r1FkC3/V0uyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ws4Sj/MV; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4afe2f6cecdso1562682137.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860575; x=1734465375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FC4QnqJ94HTxVX1/4qkFrZziKxV3eN8ciCJ+f2BMLY=;
        b=Ws4Sj/MVvQsDZ4JUz9UwtCUys0nLv5tjhXrxEueNLtG3HUN0QaVVC7sqvLLuf1BLsC
         VRCNlSBoXBWcofxTdC7Lw69wE82O+3lURT/ZrEgdPjOj1lKbKohYLM+VA7GQcazKjctp
         02Aoc3IwuphW2yVTskgPEYHo+iqHeEICVgWEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860575; x=1734465375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FC4QnqJ94HTxVX1/4qkFrZziKxV3eN8ciCJ+f2BMLY=;
        b=IB7UbxFVowEW4Z/4winBUKygvhjW62PTyKWYJF85mRcliaaVM9YMpbs5zVLvohnvjl
         gefSQOhDMmacrWqm3/jtxSodgAUuER2qnkbIKCv9FiER5GtMdeQaKlIkUTwDLoEVRwyH
         /iA+m3o+6eCrJrNmOKagdBWML0yJSl9tm01rsvqlB9a7Qh5JERv7GW2MptOcRLWMqeOo
         85W6s3S+EcBsinR9hMf30/pKdl/4GH44s0kwpIO9SToipDC9ckcIHA9igwNyKa3Y5HQ0
         rWQZwWbPYX0kuhomZSLCaYe0+V0PRjnVW9paB5cwSCUnpRuI7a/2RW2MYG4O+uFYf09W
         5cSg==
X-Forwarded-Encrypted: i=1; AJvYcCUbtob52XOWZeZ6H0vIKRd5bZPDOCQMT1CYMGNQQC27IsG/uhYG2ZTukVRCvcnz7UeQbJyLvE2tc1vW@vger.kernel.org
X-Gm-Message-State: AOJu0YyxEN7hkMC+dElx8h0KE8IWQoBmUiXQSBfsERh7Ps4sv0i2Wl/D
	sVy2qcH7Xs1wJ4a31wWyDlLsbWcu5fVx1t464U2c5p6iaQDOUIn2S0D/u/up6Q==
X-Gm-Gg: ASbGncsjGkR41S67vW7EhuMbci/L/1Px7RZL/T09wSQPXM959TTcZ0SumLJazhrXYSf
	2vOHRiWU8+zh/ODx1nXDPXeda3fOWgz12Nnfrx6xd6RNneqaC5B63fg58guF99kCdtveJYUQp30
	LLR/Eb11bX29SCSGtels/1MWE88Pp/pA7i//BGRyC6i5hYcdOFkGUO4UpXF/kPeUGv/0+VZzwSQ
	6Roz3TpclOusD+MnBLphqTakAk8sixkuT3VA7rGeiqMYHp+RxBisR3QZM8r7E8rBDSZ+WVtv6Ub
	bGRXQuLevgq31pZfaVoCRpbCLBbv
X-Google-Smtp-Source: AGHT+IF9huJ4RGbON6vnfjO82QKXcufJ1oPqeqqPWduurqVjnR4pau4FlzjogA7CTu3zPtWKx5FO2A==
X-Received: by 2002:a05:6102:34a:b0:4af:fa96:1ff with SMTP id ada2fe7eead31-4b1ca3daba8mr12220137.6.1733860574875;
        Tue, 10 Dec 2024 11:56:14 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:13 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:55:59 +0000
Subject: [PATCH v3 2/7] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-2-00e409c84a6c@chromium.org>
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

Provide an implementation of for_each_acpi_dev_match that can be used
when CONFIG_ACPI is not set.

The condition `false && hid && uid && hrv` is used to avoid "variable
not used" warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b2e377b7f337..eaafca41cf02 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,9 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
+	for (adev = NULL; false && (hid) && (uid) && (hrv);)
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/

-- 
2.47.0.338.g60cca15819-goog


