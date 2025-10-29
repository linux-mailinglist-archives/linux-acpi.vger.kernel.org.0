Return-Path: <linux-acpi+bounces-18334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5FC1A9A0
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 14:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF1E58298E
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D23563C3;
	Wed, 29 Oct 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WR9+EXbh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25A35504B
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740945; cv=none; b=uwRagFv1aUP8g5optgZpUxHHuIWuJkLIlkmemHZwAN6OpgOfb+MuUvyVeRaxFn/bgU4cI7dhieMp6I2ebc6YpD+Lx+pF9CDvu0BAUUHAMU4NQecjQKeKqPwZifKp8lB3Y3go+Y3isFiyr6C2Dw2anucr/LLaJ3JtAGzglYVKiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740945; c=relaxed/simple;
	bh=pihEqw63iH8miaFJi/OO1LHWkAM8Q7yQvsG/Unqag2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AqwbAAs5g2sX7ZEsY4NYeiqHs46Q8gdovfQ02n51YyEgKaKPsDZ+ORcTEukSM6XXm/bsbJDD2d+XKoGWAT8vOOgW8L3pMN12amssVneRQgz25vzvKG1xxIJxTRgKEZpDK7lp5pYCRkWE7gMsyVS+t882kxVTmKs8SgdfsLbCm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WR9+EXbh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso33239505e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740942; x=1762345742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKWwb+CWR52sgUt18Trk69nB3HUB32xJzIqtVQA5qjo=;
        b=WR9+EXbh1JT2hN6kYidRWlnEbB9zJanMCKu74aeCF+PQz1Ym4bYQxSFviEAsFcM9uH
         CveF8xtcFMNZ0R/Gjk8J2Qs9rEpTC2ZdljqlwZSH9Ltzwj4ftfqEAFWzSXcWIMXwpQsI
         pp44SWFtnPrYDOkL8pq7gPQiH422RUmXwXnq14B8L9P7bREyU6VdVykuiVDfDHHJxy/t
         5aqFy+/+Nx0TnAj8jC9Ligr5czwxlP0QhriQC9oWOYJ41ZYwsgHSQPgtRvfMPCzJQDZc
         3WfDiZi/TG5j1tfUBx9smtuYaPT6RHj4t/+wFmTSBIbQMl5Zj50qVihkDOfveWi6vUBq
         TL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740942; x=1762345742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKWwb+CWR52sgUt18Trk69nB3HUB32xJzIqtVQA5qjo=;
        b=NCrdSgEpUaixoantfCCCUuyX0Qd9C1ok7VLQGO2KQngQMOGlADY86oVTO9dw9PmV0L
         ullOO6m7rk8tN7Uk/VHNHsDjOP47MltL3WsykSyCTWsHUCPv6+8DVjGLS6B2wMgUl7Rc
         PeWIPi6lANYA8AQ43iQLC5/lzvALG0++ikXX18S7GQLaDwAUUJMgGvGGIpOiBnRF7oAJ
         jp0lCUw2u/o7V2bIawiWUyvgbzTouaQzL6BoMJJM+r/W04yMJDnNKHgtka9aZD6DRgRq
         Trj30mmDssqWp7lGfAGQVUqDiwQwUrSA26s5SKXZZTleEMpb7mJLNxGzWYplCsU/HuQx
         O1bw==
X-Forwarded-Encrypted: i=1; AJvYcCXNkIy+PfE//Q5l4PHTnIyfJ+Ka/YogCJfPEkxjseIEWytGa8qdazQGPvNwTJcM3/9Ts/rOeXPkJ7Fx@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRmNSZXXMuI6bhafyWgeczAVhoqS9sJxcBpc6OMJyqzF1tkQ7
	9pb6fPHLOCylXEmwDQ7qXJ5Apwk4Cc6+kUzRxcpzJ1apgUsWJtWuxSv93qSQqEI1GSU=
X-Gm-Gg: ASbGncuyHP1aZ9T7jtvW/BXpoTvy00eyUsKpWrLTPWiELEb29UoGuIVYNh1IIm4rDTF
	XhxQiY1oXKbPC9ffhhfI65kFKkvf26HgX8bcs+H5MXvBzg3ZZDVUB0xVNAH5R+mRzc7Q20eieWG
	A54i2SrmB2Z1BRgfrAmGzgrWRW9YyOD1+xvyrxQtCQAaUsMvmRF4N6QtqUHPSFvxQGOf766qmL3
	Dco9bBT3PfGzd375K+ipeCGvlv1GCWb8necvevekn3wee9Lo1hKQpmLp/+6XmDgRbZ7WJK4zCr2
	abFluVKrCXQ3V/dEPWfbW8UM7Lhpp6trzoGwj50AlHOcHKPujS746ovpc92IWcvx1e7Q5L38OUw
	VANwnrS6UYTsl+l0SMKlSOMe6Fqy7K14k3Ua88gY49be2OuOJQODHt9+HlmwT78yFtN1Gnv3tVF
	V6Udvz
X-Google-Smtp-Source: AGHT+IE2bEto6dm9kgomx9Gy3unCJ/VhB2xVUZhKdQJiKPMytSociWC/cTOVz5iTb0q8YRFWnxzeig==
X-Received: by 2002:a05:600c:46cc:b0:471:95a:60c9 with SMTP id 5b1f17b1804b1-4771e19ac2dmr27909795e9.8.1761740942232;
        Wed, 29 Oct 2025 05:29:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:29:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:42 +0100
Subject: [PATCH v3 08/10] reset: make the provider of reset-gpios the
 parent of the reset device
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-8-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3056;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=GNsd7cWIVZyy+GvsDtQHGz7ZcDSeeiM7GomXTvhzcVM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh+tbOHr2GtTYTKacQBaZS5LtYi0PYkjtcyS
 ZfHQCN0aDiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfgAKCRARpy6gFHHX
 ct0eD/wJC+3IUqoToQlEO+77Y3Otupc+hBKyQ/4jPAzJRFTzE3xxnUdKdBUpWyvfHGdP7wSZPg6
 srN+4v97xnr+HgiTv3gF5tBVCxevzClXWLcVa+AMvcsdBw4qcFHif3XyiINmNtuOsGAoamIzh1d
 zOzwAGGOvQjqLaNrHmrHr558/Q/Ih8SBsEEHOeabr297FYe20dyCHEcDC3/mPDFN/L8CSCW9uoH
 qObFhUFkpqCCq0fz4XrY5Q5ZCtHnq5YHRl6b8gvaJbF8tEtgxsZ4R5muPFvfCvh1Eynp14oD2DF
 7JMOyHum/eWLWPQ0wFKyn9ktXBx1bldmIo0dcWIel96W0fXuuBUV4qvh43g1uiKkGB6APT5NAyI
 rZqWCJ/tiXOb00mzC6jhA0+EyseKzkQzwI86HT3GtElh0RVblkaxzJO9d32EjJt0HMPuMfbD6sH
 kkFzbokCJEkGmkZYBCuexXDTAi1iuYwqPaGaKMNLGeXrCrxmkYDbfmZVECPRLcVgv1b7Zk+NkJE
 8TXmT1AfQCtJmqJOvRnSz11OWaAltF2XzUypqfJub/tz0l3c7c2rENCt0UJ6N+iJENi1c1/5T5O
 idZ29DHHttNu5Q+fOhvGSDZIjO7e3tLEZJ5FolBTx5I9fGGZG5bkT74NnDuTfSs623EMAhbskn2
 2wbdyblzG9NPa9A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Auxiliary devices really do need a parent so ahead of converting the
reset-gpios driver to registering on the auxiliary bus, make the GPIO
device that provides the reset GPIO the parent of the reset-gpio device.
To that end move the lookup of the GPIO device by fwnode to the
beginning of __reset_add_reset_gpio_device() which has the added benefit
of bailing out earlier, before allocating resources for the virtual
device, if the chip is not up yet.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 5a696e2dbcc224a633e2b321da53b7bc699cb5f3..13236ab69f10ec80e19b982be2bee5e4b0f99388 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -849,11 +849,11 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
-static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
+static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
+					 struct device_node *np,
 					 unsigned int gpio,
 					 unsigned int of_flags)
 {
-	const struct fwnode_handle *fwnode = of_fwnode_handle(np);
 	unsigned int lookup_flags;
 	const char *label_tmp;
 
@@ -868,10 +868,6 @@ static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
 		return -EINVAL;
 	}
 
-	struct gpio_device *gdev __free(gpio_device_put) = gpio_device_find_by_fwnode(fwnode);
-	if (!gdev)
-		return -EPROBE_DEFER;
-
 	label_tmp = gpio_device_get_label(gdev);
 	if (!label_tmp)
 		return -EINVAL;
@@ -926,6 +922,11 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 */
 	lockdep_assert_not_held(&reset_list_mutex);
 
+	struct gpio_device *gdev __free(gpio_device_put) =
+		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
+	if (!gdev)
+		return -EPROBE_DEFER;
+
 	guard(mutex)(&reset_gpio_lookup_mutex);
 
 	list_for_each_entry(rgpio_dev, &reset_gpio_lookup_list, list) {
@@ -946,7 +947,7 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(id, args->np, args->args[0],
+	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
 					    args->args[1]);
 	if (ret < 0)
 		goto err_kfree;
@@ -958,7 +959,8 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	pdev = platform_device_register_data(NULL, "reset-gpio", id,
+	pdev = platform_device_register_data(gpio_device_to_device(gdev),
+					     "reset-gpio", id,
 					     &rgpio_dev->of_args,
 					     sizeof(rgpio_dev->of_args));
 	ret = PTR_ERR_OR_ZERO(pdev);

-- 
2.48.1


