Return-Path: <linux-acpi+bounces-9739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9972D9D5C59
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 10:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469ED1F2238D
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACAC1DDC3F;
	Fri, 22 Nov 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/sY87vJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B741DED6A
	for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268909; cv=none; b=VPCdnUo9p/wZNemz9Jn2OmOWeZpGA/JEFCXbc/zdCpIUAwa24Vn1U3F0YebB8n6sLJRMRwiXMSwGr1ZbAO8UMUdy3Hwhh1T76RLuIHYN1QJ3VDGzjdaHFaX6PFp3cm7iN6qmwMfDkGV56UNi+JhxBcFyVuiiMyh7qh35Kfm08Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268909; c=relaxed/simple;
	bh=4H1xI8rZic7uj8BVAr4deS1lVj9r+ITu7MlYRDSB8Ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sItbOQ1gYHfGlPYESrLT0ClCZ8yBpuLrdBVfSc6qmMs92AzHQ9vqYy74iRFCiy6QxCdZEmctRIpxO2/bBrBWskAU8K2igjBWDzxbY2nNbDAP4V/iBrZ69pdrwrRBM7BPGGi+orI/dKMtJzHPuCTEi3CMc+JkwxIbWutipUOIdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A/sY87vJ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460b16d4534so11782301cf.3
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 01:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268906; x=1732873706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrSmAj2jkvytw0rNLCddg1aexjt2xHCHXsrUaR3oGCc=;
        b=A/sY87vJxtLNW3pnMxjNevbIQvdRjQ4qjdxdDwQOBUUB4T7cEX9oxWyKrlDGKyfKRN
         Rk3LMSBF4ln1WUQLoY8ED0ux27iR8uspjKKZfg+K2LL14MmUks9R61PUn16FBb5ryQZF
         GWDPKk2ShrGJjhKngu+NSbYVjROvh+Mpyz9cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268906; x=1732873706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrSmAj2jkvytw0rNLCddg1aexjt2xHCHXsrUaR3oGCc=;
        b=rU+s7SY3wZIDKBBPNsXzWaShqP9eGbPqN9Xjy4e0fB55rQ9zn9kppCA37tNTzQK6My
         7uSbU1gnty8JD2J2fDwmuzVQFMWG4EkXKoEXPIwlemdhPRr9iOVhuZlXARWLJl12WHL/
         FMAefjmZLYCYTuziq3M1+DGsLYa3V1/TS/cZP85WfpKHNChTb62qdV6zVKEDfToUWAYq
         VOV3n2HkCODMPobzLI8JijzVbA43UrMBv8+htZeCUp56lTJwICdHvuILDMsvhD96yT30
         gsMFu4tJ3L2/EXx037yLt8NFPbs8oiD018xYtc88W0syYo2/oPButT118MjiPQ2gVGrx
         3RuA==
X-Forwarded-Encrypted: i=1; AJvYcCVFqwNkgWN6ZkzJjBfzoLWpDuZYrA7c2ei4O9LUSFj435wWnmF1lTsDKPevazpXaoFqKSjvWkprHbqJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2DM9+uONJKsm4miOCBcUgT7s4lccdRcxx6mWTnwtDHDVJPui
	C5wQo1CEG0ZEDEctVxrnR2ahWBLHEtQqg9QtBo1mcK5vE6W0jwAoJNGC0jgKlg==
X-Gm-Gg: ASbGncuKqQY+EZTvnuqCQ3REzqqsMhjMqppJ6yDsCa4VxqUBcQpyK0qHrdE1XGHG+hp
	GykRTBDn0aV+2FX801CEJy8LeZFP5nN2tF01JgmyIqs6L8Yo3PHCqX8VZQNV6n0THyMdZPYm/yK
	zCTULBxYzAodjHgoP4NwA8YNvlSUKYuNhF5gyeJia3MkN8E4ETf1SojhiKkSCmdSn3kDenBpFzU
	yrmcM6QBOUTzlq5isRnYafxPWOg7sERs7gOBQ0onrHhzMMrbbZ3/f59EYEJVuJtfEQGghbSTLcX
	GckSaTs9nJxlQTbsTaaX5fQ5
X-Google-Smtp-Source: AGHT+IFru2WAUE4DOiSVjGZ5la48og7nHQB/1X/SGFbEnNNed0D8aT6/FZPgrfye+Wt1XXhUhzTTyw==
X-Received: by 2002:a05:622a:2d2:b0:45d:9357:1cca with SMTP id d75a77b69052e-4653d57be12mr23934371cf.14.1732268906271;
        Fri, 22 Nov 2024 01:48:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:02 +0000
Subject: [PATCH v2 5/7] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-5-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of for_each_acpi_consumer_dev that can be use
used when CONFIG_ACPI is not set.

The expression `false && supplier` is used to avoid "variable not used"
warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4888231422ea..57298c7cfb5d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1005,6 +1005,9 @@ static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
 #define acpi_get_physical_device_location(handle, pld) (AE_ERROR)
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.371.ga323438b13-goog


