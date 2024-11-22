Return-Path: <linux-acpi+bounces-9735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E492D9D5C29
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 10:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63740B23D97
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 09:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E91DE3D9;
	Fri, 22 Nov 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxophegV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD61D63F8
	for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268903; cv=none; b=uMOTmhEFmuv9EYAP0lYwyT79WVvksWnYyJcTKpT7U2ZvcPlOCoM/2aH5jDp1K+k9HVTY6YDAi+6rhuRZkZY6JhfzcY9pNEBKIIZJNS7F0WswQ/M1q8li+6eRSiWbpT6C4Wasv7M8NcdvAjMq5ZuZpb1RNMgCOkc2+1ArYLGdR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268903; c=relaxed/simple;
	bh=w9LCIWUOMl/uTKpIvXEyGapEo1u86swQRW6MRCHY3D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPNhvCAo2XT8v2Kb8dy45ubqnOwKsBfdWibncdEJtdS4v2RhlGskcCTdYYY/sTGzMKsizn7mv2+AWgUEJE7+kAO9KnLrbEhm6/6QWl6Cdjfx73x5K40eamYNrphAxcnQcJNlnDUg1UxWbyr8SXF49BBJcluvn/lIPwni1AXl21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bxophegV; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1474b1377so120297085a.2
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 01:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268900; x=1732873700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/BFNmnXBO58C7oe88M+ixtZQGuz6wm+Rt7+horX5NE=;
        b=bxophegV0qAeFpYhJAVl/AFaeEm2uRTWoPgNLgEsKfH2O5EzErr1+Bfjb6NHusm4E6
         bEQFa2oH9nq3H8m/zfMspitRKAbdH2ddonPWyO+7HSOEnmZNVpqTUM/CAM1wkYIkOxyi
         5aY1cwcHKHAGpj9ZoVFgRo5XEk+ZriS8B9z1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268900; x=1732873700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/BFNmnXBO58C7oe88M+ixtZQGuz6wm+Rt7+horX5NE=;
        b=LrS+lwAP3PeNNsZ0cVP1mFfFNyLTRwJtCEJ0ysoe7YqEKPBr8vAEysFUkyu1PXs1UZ
         xmnWbjgN5O6zT2dX76k0Yjx9oH7ZmguU1xKUmdmclW9TCeliIvDQvHPTBj7xb0Haivx4
         2XVWRrRm29IVtwyY70qqK7cAJ1PMlJ/hN/W1t4R/HJ6awYu6Rn6z63goe9urVy59ivmI
         0efpVB+1r7pTKRGh1NjCcnh5+FiboksHnM9VM1/yWD8BynBUk/J9wvJQjy759ohKep/A
         5d6SP9cf0qNVY6XJsw79NEhNNn23Mdrp8Fm5CtcM0ekaintfG+7iQ6hy8RjI6uCHJuIP
         RjZA==
X-Forwarded-Encrypted: i=1; AJvYcCUzmXeReIh8JgQonrfLDWuskKYCbtn4Vt/iykOA+NZ+dKAjQN27sFBXjguyh7xbQpxuzbM5IyTOVqvD@vger.kernel.org
X-Gm-Message-State: AOJu0YwdIo59lbToIkb4paAt6CJhkj1unInaTUrZb3+j0ZKwNIOfz3nb
	bf9gpi8aS9iEU3V1AWBWtzAzXathHSEYV1MDuuQFiuar8v8bcsmJvSSOKF2VtQ==
X-Gm-Gg: ASbGnctqqlYiueuwMzE1YzXRa8/B4X5LvhLf9/2jJvtEa5/Fr9L1KwPALmxiSslm70Y
	ey5L6i+jcs/vCuRotFeCGXXG3R49in6rDxdmpo7oSDmDoIebhW6/ONsZa+PqByO/+0Z446XccAJ
	ibGATETEUqYS2lLDZmhnIrusK7+tw9LcQRm6Fz8YS5YI/efH2lXAnjKiOmSwFDnDbf3rqXZHdL9
	C5dGGExbSuQpw3CAPefPyJAket+zVkV8EApww0K2PpdfFpKEME9Oe7cZ66Up1dQqGDfbbdUrPZX
	u391ivasEoV6gMVlh6VYIKJj
X-Google-Smtp-Source: AGHT+IHHdb/bCzojxcLvKgiZFS7wveq70HirCmNUp9dbcD65FOXFHZVsY9GQS/ctk0cY1TQI6tOweA==
X-Received: by 2002:a05:622a:1e8e:b0:460:ab29:e6b1 with SMTP id d75a77b69052e-4653d617eb8mr30106331cf.44.1732268899812;
        Fri, 22 Nov 2024 01:48:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:47:58 +0000
Subject: [PATCH v2 1/7] media: ipu-bridge: Fix warning when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-1-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
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
2.47.0.371.ga323438b13-goog


