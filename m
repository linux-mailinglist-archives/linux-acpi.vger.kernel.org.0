Return-Path: <linux-acpi+bounces-8476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1898912C
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Sep 2024 21:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E24B20C49
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Sep 2024 19:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB7161916;
	Sat, 28 Sep 2024 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKy9eoZm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A162338F97;
	Sat, 28 Sep 2024 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727552864; cv=none; b=p8fYTOFChNmby8A9Aru+f7kgi8C8YW8e2a9wo1ssmN9Brz4hgEg69Bj/hFI1HPtW3JIqnfaJhV30O7/w3JxQD/5O6Be98VItVkFYPlWIo/RSDP0/6NZxovxv+6C5QaVtUSk5bi0kcJes6J5LthcSByUIvjm4+O+Y2RiEL8LS2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727552864; c=relaxed/simple;
	bh=UebfzqIPW+uuj+iBRyR34fzs/k+gmm86ojQNETSqj1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOgD9f09P4sFYw2bwXFQyRDFkyLZmrHZ8/24T3RqJxnJT5qHZBdH2zpDsOATBOXqMFOhzSFo2tHAKKp6phNKZr9W9W7qz/cgrg4EVQawvlTNunXAj9dyxZBkLBbh8AzkJasxMfyfxFWVfUqv1NJOayRnpPKUuJNJ4WTNJCNz9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKy9eoZm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a843bef98so436129366b.2;
        Sat, 28 Sep 2024 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727552861; x=1728157661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQ2Y+OYT27gnAw1oY0Jt+LJqwQN0EEsJJqFWe00ZFj8=;
        b=nKy9eoZmfQCXwOXu2LLbbKbNhA6XXrmLO/mgnKxK8kZdhJGdGy83EdPgtmr1lcBUBQ
         foRCfFFLRpo2P2Yrh3/q1GdBaJDq3C6LiElAkAgK6FPi+hlC+48wzA+PgRDgUj1kS0uC
         0llVx8znPYICxGAkjuCox9vfiLECfWI58fiI68ziXcWLw8ha4bxY83Db45/4x/9TuKiv
         m0exIFzGrTvll+2MS69HotEx/EPhK5ZJGNveZJDpUxFHLI3kbO7LqtF1yRTyBFQMkUQ4
         eNiz5ivyuE91KUAaG6htADUHKG1R2xRrsS3Qhuom03cJmpHtDefy/yBhYKsdAggVJrc5
         dkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727552861; x=1728157661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQ2Y+OYT27gnAw1oY0Jt+LJqwQN0EEsJJqFWe00ZFj8=;
        b=oWc0CLaBZVQBg+wqtYNPUd+XugB0+D6jNEMix3UqnpjS1w+OZnxS1KlPtTJE1X9OSs
         q45dBt2LtENMc8CDaPLYintmHgpDvbehK0HFRqfdiBDJgIvbpoD9C8hCEXQ+V8D2vsNp
         7YaGI2oaI7h/2uFhzmy+IKFCENXvZQqd6gLuq2qBw4ncog92GuWFvk9B0uIdqypvtdtc
         IGvKVQ4aeW53qmgsKiIaJX/k1RoJlPpbSsXg41St23t6SyPOpA0uaqXSSGWJMACgxsb4
         rn/3o6d2CpSVWP79wGqKY9hkViPzdItBkxnHf2w4ddGd2/284993YlDq/8GnDA7XxJXX
         pN/A==
X-Forwarded-Encrypted: i=1; AJvYcCUHL2GlYm4wcUru8FN2CQMuSEZu76rRcJJlwsVGpd41muzb1F27pMR9QdFHZSqLVQDnM2ccu0tb4aCfNEJ0@vger.kernel.org, AJvYcCVacRr/xDqRQeyc/NrsMft6RWeiV3Y6jrtgkkmVxRgJvCrL5fivqr9Osw+/ljOa8Z+bXDC37v8bfj18@vger.kernel.org
X-Gm-Message-State: AOJu0YziH308c3P2FdHkCwdSkpVGP0FMIFwdNHwj+WyH6rsdLAqbvcOI
	Z5TNq8EpegXFvDsegsd7ertnlu9r7qiiWwj89x+v/4EDsDg7yYQASPy3Uw==
X-Google-Smtp-Source: AGHT+IHYoDI0FBwnMWQaIkRID04jQi+9q4V/j7kSVTpwS6OSyvnWhESGAGjKsX6zc/FK/fFZnKBEsw==
X-Received: by 2002:a17:907:7244:b0:a89:f1b9:d391 with SMTP id a640c23a62f3a-a93c491040emr675354066b.14.1727552860387;
        Sat, 28 Sep 2024 12:47:40 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-2243-8f1c-2a7e-ca73.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2243:8f1c:2a7e:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775c22sm283707466b.20.2024.09.28.12.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 12:47:39 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 28 Sep 2024 21:47:35 +0200
Subject: [PATCH 1/3] gpio: dwapb: switch to
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240928-gpio_device_for_each_child_node_scoped-v1-1-c20eff315f4f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727552857; l=1496;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=UebfzqIPW+uuj+iBRyR34fzs/k+gmm86ojQNETSqj1I=;
 b=yylqffQpWwyfeh+roO6gds9YHY4qnBknJ0IeKvIu8ukAjKIbWAO1atKFlPtN/xn1ESol/c6xf
 O2Vso3g7QhJDGVzTLW67rkh51LWdeQzCMnNujo6qeClxJS5CxV7YNxr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to device_for_each_child_node_scoped() to simplify the code by
removing the need for a  call to fwnode_handle_put() in the error path.

This also prevents possible memory leaks if new error paths are added
without the required call to fwnode_handle_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpio/gpio-dwapb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 798235791f70..bd374fc27174 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -571,7 +571,6 @@ static void dwapb_get_irq(struct device *dev, struct fwnode_handle *fwnode,
 
 static struct dwapb_platform_data *dwapb_gpio_get_pdata(struct device *dev)
 {
-	struct fwnode_handle *fwnode;
 	struct dwapb_platform_data *pdata;
 	struct dwapb_port_property *pp;
 	int nports;
@@ -592,7 +591,7 @@ static struct dwapb_platform_data *dwapb_gpio_get_pdata(struct device *dev)
 	pdata->nports = nports;
 
 	i = 0;
-	device_for_each_child_node(dev, fwnode)  {
+	device_for_each_child_node_scoped(dev, fwnode)  {
 		pp = &pdata->properties[i++];
 		pp->fwnode = fwnode;
 
@@ -600,7 +599,6 @@ static struct dwapb_platform_data *dwapb_gpio_get_pdata(struct device *dev)
 		    pp->idx >= DWAPB_MAX_PORTS) {
 			dev_err(dev,
 				"missing/invalid port index for port%d\n", i);
-			fwnode_handle_put(fwnode);
 			return ERR_PTR(-EINVAL);
 		}
 

-- 
2.43.0


