Return-Path: <linux-acpi+bounces-10047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047759EBA65
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9F11678BA
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81B227BBB;
	Tue, 10 Dec 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="luzU6aTT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C1227578
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860575; cv=none; b=YjxPJ6OYW8woEBTPn7etZdRCFC2XRfyJCZEURpN3+4mB+NfUZdIrzBwqYKK2v8yNkYei/eGBPcUKKGmmHDwAZEJJyw/TiCT5URIAYP8HyCNioU/G5jnBqzeVFdJ5GZrHjGAZNcFWZvRiq6LIWQtqi35ISpFqltZ3xrfK8ng2LYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860575; c=relaxed/simple;
	bh=sdF7tOeLaLfCdiDlVogKRTgQV5yx9VBAgCr2khnDCdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYGnfzO4pWTc1capiScKhuKCBH+3RHfU1ZHtDgSnppc7NZStji+xPl6B6tJmud57h9TbwCXyTJgSObfLjurxWuajrsJWA8gLv07CCtwM6yhbal+0+NRXmRNq10L5BMmgJjf3dlSpVqz5TOnnV9wQjilLMUPj4ln/xJt6XdVf70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=luzU6aTT; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4b10e0654afso1362021137.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860572; x=1734465372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTX31YxAcEET+qmrwOGI7rmuqifx9R2Evse3TExOMoA=;
        b=luzU6aTTSezSex1ALcfr8qm/Cw43J8blTOlKNcRbTvmt2thKSm04esfPknpK/p4PlZ
         lzXIXwS80VEBJYaklDfFc3P70PWXSZiRXWH/+ATNeATzC93i5+9o11+s04HJoVVxLXct
         lg+PTzl62ZYA9JYwTeo2CZIxc5S4oZSVr1tGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860572; x=1734465372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTX31YxAcEET+qmrwOGI7rmuqifx9R2Evse3TExOMoA=;
        b=hH4GltzbTxpp/JiAcwWWzuahmFTVok9+El3kgmgzLtiDHczsz/3GXF7E5qakljbsoY
         D92KxBqtj5vJxbjwvEzazOD2xSgA93j7w/7p5eAisA4vLmMfZWkYR4vl69H0TN4HM6k3
         IeuwfjhgkZ1CrpakCL3/kHo27TkCkOySMmAh4c4SPnLw1PGOpZRHxsc6xoCQj7+0sr7m
         faaUrtldXb4SnJdI4WjwqHQutLW07ffMuw45jY7GE5QQR4Jlac6RF3Ci2rpJGwB9vjAu
         yI7SIG1/gckNNYBe4P5TouME5XOd2p1xGmz+rW7rW2z09mGq7avahd7T1T6OQu5X8MCF
         myOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWK2dLeWKGf37XclOQG90wHEH/z9+emO+lm2Z0iLKAfih6SOZzAhg7AIxDS5+Af+ZLRalt7UiXJ7kB@vger.kernel.org
X-Gm-Message-State: AOJu0YwjEqPaxvyVFDdqPHFuOX9jgGdAdCarMspbtP7rNLFhAcvzMMx6
	FygSU0p6kA9381T3y5HP6r+jr5gN/okbXKTDkLkFnMc7fyVGcPrpbcDpCOQzYA==
X-Gm-Gg: ASbGncsD8EbHxUhzps7IFzCiHaPmWPkId6SKYo/bL5cpvyIkMu4PP9ke7s7gXoQwLBB
	8QGzGRVNdCV1FMDCEtWy0Kth/lsojKvCxdc1v+d06x5+4pFeBkK2PsgUdhlTX6fsuqqzkCcDnru
	y4uL2avTVCbhCn3HLhILD+yX+bCw2n2f9KkHznJ24SBTFB1tAY8MYnWKovd0UNSrcb9cwHerjgq
	n6NnHc5bKu6PRBM+BzT0vjUaXYnX7W8YQfrlrKBuO0/nYDPWHsqs+Tok/9rnJIOekBlRykWD+8S
	i1R2B+G5nDsCdQ6hT2YCc/Pdmbkk
X-Google-Smtp-Source: AGHT+IFOlLOc71KptU+gM+mbs7OSqZvI0F+Ca1OaQ7iYQclHhw5OIq3pXc1ymxgCi+mj9I6EK0fVEA==
X-Received: by 2002:a05:6102:418b:b0:4b1:1971:383f with SMTP id ada2fe7eead31-4b128fee492mr811079137.8.1733860572588;
        Tue, 10 Dec 2024 11:56:12 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:55:58 +0000
Subject: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0

One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
throws the following smatch warning:
drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented

Fix it by replacing the condition.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index a0e9a71580b5..be82bc3e27d0 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
 #else
-		while (true) {
+		while (false) {
 			sensor_adev = NULL;
 #endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))

-- 
2.47.0.338.g60cca15819-goog


