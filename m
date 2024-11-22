Return-Path: <linux-acpi+bounces-9740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D49D5C5D
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 10:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE2FB225FD
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1386D1DF248;
	Fri, 22 Nov 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGHAPEzL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02461DEFC6
	for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268910; cv=none; b=aaC81iE6ynK5Rri34aYCuxv0yhjGrG1GzeWPqC0tSFWvuaaP6nF6DAFuucNjA2dLhvm8PaB6AAqzbyQxxCjplNz6Xe+sypYJr2lGj9gue8zxtNqUg02Gpy5UgUzFUNn2VzCPOhYPtllE4x7HMlcl9nM2N/hY4Rwsc13ea8JIuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268910; c=relaxed/simple;
	bh=4cTEN9eOVpTN9Nyc7Cl2/7/R18o2ZkyvA49rT4c3S24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KmWH0NEy/9LfAJvsRgpEB1IlxUpp33SjLh/Rl+q+pbK/DDoN9q0gK4fxXxCZRTYaz1kffzKieybLZtqW/bb8OizVxho1uNbDUvsh8ReumhpnSfi414hOKSprgy8ZogsD2qgXn5ibQr3otbmsWyoRfLvGqAoAsFbtns6Qc4GTNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fGHAPEzL; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4a487a7519fso322949137.0
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 01:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268908; x=1732873708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/QkgKOmc9/c2cCjRI19/30uaM7Ny2Es4XuDA0KGTSM=;
        b=fGHAPEzLf/8i13EPFHoTmj473H/jY0wXpMLEXQ6qPP1kqgSowGlK9ov9Xz2q43SUc0
         hdNUQlHFpKUT9LcEoTIKnuN8ChpDpvRqYyzLvRvpm3xCgIwVn9hu5TOl7KiBhusTzigt
         fVIawulg6IUZGsEB0W2zeJKG6vb7bcKkAXDp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268908; x=1732873708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/QkgKOmc9/c2cCjRI19/30uaM7Ny2Es4XuDA0KGTSM=;
        b=J264BcfYU1dfqCKNFrolH8aPT/4WQQVp0RUl77Y4if7v+oRgaG9ZhLAmelHr+WLB9s
         RD5sAIuv8vDWi+UJLDrzJLHWYqcygFj76WVBz3UziNsPh6h7E+3Oc6S2MHdu53/khM2f
         LbpQgVSgLwRiY/E4KrmAcw1fUbOG3n1eYffM+peFj/LhR5Bc0MUbGaLcEU818VnZR/5F
         znwml8qKkzMliCDBvy80/FpEqURxlCjAJaMweb0tRrLwKtr+oa/aEVUdgDGUmAIe43Yq
         IENnEruVWNUWXSfMZJhWfidS0MSfM6HT7QT5bRzOyrSgjKXVwWB3td9fJhl7K415fKLq
         U2Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXxmQOAxRlN/voV8/kwEa2+JOoASqH44ZL/CnlhK+bh90RZatAoB3dqJH3TsqqDPGiPAnaPPEXwzOa0@vger.kernel.org
X-Gm-Message-State: AOJu0YzNiKmERMnNCAEA+zuTMQLhwfZZojk4UtQk/ZrhoRyRznIOAGqu
	gWM3gA2AAndqPhfTVXbNBiJXwfV6fROlToENKaP17cdPlOruENl5RsFvlmrv0g==
X-Gm-Gg: ASbGncud/Hspmg+dNh9k/OCWnZbjXkLdYmam5wpL/aibKPCf/SRbYHAt4lpS4BA1lLW
	CXTgjIs0dRja79HUShkU3uXKutCacy6doCSeevJIySGxbWGRCDQnpT/+M8xu556af3JUCeL2HU/
	2bYTNgc/QWR6hS5DCZoxX78Z9ooGMly5QLKIK8EYt9lJsWGBleZAiVfiXWwTPQVsqg3oz9ceE6f
	oBw3WyGG9q6vrYaZfm+CW+JYsExTwvtTwUlPNCPkg2bQWbWyyPQH6gEchp5ZDzDYhffJp47cQ+j
	RtSM4K77sRC1iPxnORPIo7oc
X-Google-Smtp-Source: AGHT+IFUbTeZHYJsenOKlTvdD0U5qrkMPADbncarGrIZ0AbdaxBfQXQNtKr0lRUxMa4p5cx4/MlDgA==
X-Received: by 2002:a05:6102:374c:b0:4aa:fafa:e100 with SMTP id ada2fe7eead31-4addcecef0fmr2390924137.26.1732268907770;
        Fri, 22 Nov 2024 01:48:27 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:27 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:03 +0000
Subject: [PATCH v2 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-6-bba65856e9ff@chromium.org>
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

Provide an implementation of acpi_device_hid that can be used when
CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 57298c7cfb5d..cb1b38245f15 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,8 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define acpi_device_hid(device) ""
+
 #define acpi_get_physical_device_location(handle, pld) (AE_ERROR)
 
 #define for_each_acpi_consumer_dev(supplier, consumer)			\

-- 
2.47.0.371.ga323438b13-goog


