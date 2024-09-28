Return-Path: <linux-acpi+bounces-8477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE27D98912E
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Sep 2024 21:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8188AB22B59
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Sep 2024 19:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC5175D32;
	Sat, 28 Sep 2024 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnWCcuhk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832816193C;
	Sat, 28 Sep 2024 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727552866; cv=none; b=XcK/WzeX2w/gUb2jC2COnMuwlPuZ5g6Q2u1g3rZa6OlBLnEk2vWaGnVssh/pE4seXtYOg1PDsYRDDQnbh/KgDqA3P+OQ5wZgKkqLhqL3SueVqxtKOtdMaSTGPdI2ukAMjVgBkiis2WmpEXufr2dg3gs+cZ3cSIEgj8Sv1SEeHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727552866; c=relaxed/simple;
	bh=qpWlHZ/NTb2o2BGag6w0MPuw2Qc51lis5IwTedMxSUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxMvORfbWu/ntYelnAmSzP1ZpFqmggME7k2rQoVOQzNEhadtR+rMBIE1wHlorJEooqcEZoCBnfeksiPdCxsoL5XkJTp+ymB6b0I6QQVGB0IgOW6I34uDpNdPmFmGf9+p9P1I+zsOlnzTiu5TDtdDZ/6bxKTEo/R+CiKMih8tfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnWCcuhk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so484307666b.0;
        Sat, 28 Sep 2024 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727552862; x=1728157662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3oxEQMoTQStUkn3dra5fpJFLUFy7oc4EXVsPFNPtyI=;
        b=VnWCcuhkxuYY+eEhMqibieeXTgGQ3xMjbaSmv1hox582G7L67KGMPtOtSatXib8Lqt
         WRDvuSOQ27bnleX2XPicm4IpsmeHqLeAw+dpHHSeuSZlt5WUQni7JqgC3Jtq0WQ5hiS2
         Zw0En85zvz5Xl5ifRL5chUVlRKC5M5MoheoVweLUyHglJ9tdtX3nHyfkDYaTbkjo4hA+
         z35qoTj/xhyjMcdvyrIGmIIWmgJe9dAf//SD/6lVgjd+Qx/ajBkHu22R22rySsDSXORx
         S431dlsIwPMTyGPkFss28IF+Y5wSKT/p/PNQjy0A4BvFg6hTdL0VKl26ZDNO93Jtmrci
         hKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727552862; x=1728157662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3oxEQMoTQStUkn3dra5fpJFLUFy7oc4EXVsPFNPtyI=;
        b=uK61+2amKV08AT0B0uBBhd7hBBD3F+3rLIr2UyC+cgoAtGuf39i4NNsPWKKFDTJviw
         ipvNQO0xiFRSOBuUekyDm7BsLu9YbV2EFyu/lZz87VpxBX7r20zfSr2MG64VEZ1FfcHs
         AEBm5OxCu9RpbEdgQw5pwKIeTTSNoHuT+hV6XAOAiGmlQ4kRZF1IaVhshfBkffX7zf34
         dx0dZnKdWJpixqEYNriWsqKnjI4SnQMqOfP/KFeArbjm2pdGXqMqiE/3akqy4j+4lvUH
         zBsOq6wR4lh/P24XQ3dakm9N5ZDmSfW9rOqZPTCYG7d9e6xglIEvRm3y9IVRi9WADdK6
         AlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgT4CnHwxBFIhD7ShvWifdF3/fQHiz+COHQRVTgsA75Z46d+mIdrB5GS9YkmctWY+I5Nf2XzIjHh03DLct@vger.kernel.org, AJvYcCX6PRXihAq783ysuoIEsAIKjho1a95CL8MWhPg3qSgvwTntWwPgq+BXPappAztJvQMIZ259CphPAnEW@vger.kernel.org
X-Gm-Message-State: AOJu0YySuGOnyZLvDR+J/0ZiaCkCxAdHhgy6ay53FC/iQRYmYygI1+WT
	vV7XcybgtHZV2Xm75LzRNjCz8uq1w6X9z5kEhF4c0M933OnszlAmiszAAg==
X-Google-Smtp-Source: AGHT+IGSWiSfi9MOzvxotcEzEItEyOMuxAJNIYYdCRTAk8pdsv6wrtk6mfojkV8nVlRWfO8G+BUGuw==
X-Received: by 2002:a17:906:4787:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a93c4a69b1fmr805274666b.47.1727552862166;
        Sat, 28 Sep 2024 12:47:42 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-2243-8f1c-2a7e-ca73.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2243:8f1c:2a7e:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775c22sm283707466b.20.2024.09.28.12.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 12:47:41 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 28 Sep 2024 21:47:36 +0200
Subject: [PATCH 2/3] gpio: sim: switch to
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240928-gpio_device_for_each_child_node_scoped-v1-2-c20eff315f4f@gmail.com>
References: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
In-Reply-To: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
To: Hoan Tran <hoan@os.amperecomputing.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727552857; l=1102;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qpWlHZ/NTb2o2BGag6w0MPuw2Qc51lis5IwTedMxSUc=;
 b=exW502MojY/GuHnYjnxzF0t5w2M1q4MukLV5X5wjFNs3gRlr63O1Py6ybGW/BnO8t5t1kPHbj
 pRliwo5CcS6BeQeBw6hh8NZmKPneKGcnxKRozQXVMyjBY+hELNjNjTR
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to device_for_each_child_node_scoped() to simplify the code by
removing the need for a call to fwnode_handle_put() in the error path.

This also prevents possible memory leaks if new error paths are added
without the required call to fwnode_handle_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpio/gpio-sim.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index dcca1d7f173e..f387dad81f29 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -520,15 +520,12 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 static int gpio_sim_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct fwnode_handle *swnode;
 	int ret;
 
-	device_for_each_child_node(dev, swnode) {
+	device_for_each_child_node_scoped(dev, swnode) {
 		ret = gpio_sim_add_bank(swnode, dev);
-		if (ret) {
-			fwnode_handle_put(swnode);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;

-- 
2.43.0


