Return-Path: <linux-acpi+bounces-18519-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A117C348F8
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 09:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EB23A6C3E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF3E2DCF6C;
	Wed,  5 Nov 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mgyiBinW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30352DAFD7
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332477; cv=none; b=rCaqrINVPL68nsddntYUm1C7b09eEXRM1S0482+uvHz7YvA97MQG5hiRdsfrnWS5wMro+Ed27xrmF0AM59h7FQhBam6rLGm3lkN/1F/U5QtdPJJl+O0YGsWyLNTs9wJmHddJ6V48VTMbHsWsS9Hvjd7YGgBdzYfRJkHx3cncWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332477; c=relaxed/simple;
	bh=r9cDw/aJYsPjA+g3Iqusl0ZJO5kkF5Y1AkYeG2Ln6YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WikTT4cC6zR97kG823BPErxzj061Q6ctB2DyHotgOufU/n3G9aZsBhTfm7uN2jCno9ObAlfWW/hRlRuIuAXbRqYLTYZdBKrNjQhDcKqniBUAkweIxn8WZV50wDd6SY1LnScp8jCQ6aaVX6nFqS5WjUlV1OOV62JamAytmmoTmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mgyiBinW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso5408741f8f.2
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 00:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762332473; x=1762937273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTmt0EBBpoH00wEC41/FLfqCbZ/Fh2wyVTiBtA0d/dY=;
        b=mgyiBinWBB0fSgC+g88kkirgvo+BWvUhFAsealfBiCIW/m5cpu2dcXcf3Dtql20nMi
         C+7NKsZsMnOFEazCy1qkw6zLpWITchj7yYMudq7imSMsuc2gJKYXCLm0bYpaijJIHHUu
         lEPQujvCwK57wbXu86MZT8tLN1tUIRwI/Of25R/GNBeUIrGN0oC0W/33fVyuTLiov/Lz
         4fa14DtzFrKy5Ha2CGW66nuays+qsU+RNgJwxWIpmexUAZMsPEVPKRiTOEnD+xVIWLcr
         PSWtYsfnKJNxdozKJzBxf/jZR+6ZnYTPLVTPJvNC/h1XQcwHMjRjLDt0rbuZpbfLD7iK
         xJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332473; x=1762937273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTmt0EBBpoH00wEC41/FLfqCbZ/Fh2wyVTiBtA0d/dY=;
        b=S6fPP/Rmh1YccgHFOJ8dGYbm6suxFqyfRiQRROt7tF382rVxl+wSe+akaQunFMKOj2
         2YNP4NLPnNSFoOo4x3tMxOPcSuwKYwdHNENWi5ldk8MGU9/qfixgKkXwweVlstG5/XYK
         Z1QIl7xaKB7tsvIxOKjHgpg/dkqLaa2M45D2b+HSmvXuPLW5wJHEIkUmLf/M5w1CFU1s
         FR/06CDrVxiWAaoAybUCqvHHZgWov+Yq8iTX62UKiJSqmZGPZRBc0fvVdkyrDEuaBmcY
         D+0RDoOaIBAyRjWQ+7o5w5+iDs6oAUdjrmV5olI3lzn/rcbANSXZABf5qTGP+3XppWAd
         Txww==
X-Forwarded-Encrypted: i=1; AJvYcCVZhjX9b2jpAPF/GqS6ZVcwAgAGgUvSe2EssULTULNNCQxjf6tDORKd5XSUstDzAJCCyqqjPHwZOId+@vger.kernel.org
X-Gm-Message-State: AOJu0YyaiHzWYC1LNxOwl3kihErBiVREWOBJB3hWjdVISqeKM7ur/pXf
	VYtw6oz5ssZ4Ey/owikP+kV0Ezsfxv0h1k1UWuusLbA3zyP9JEjt+ahYP1bOe666bDw=
X-Gm-Gg: ASbGnct08/GSurhGRUCGHXeBLXDTN7OzHWU6o9xHBeBox9h4OCPVQInhqx3sIfcviYZ
	qBsXzK/RjeZYuP0lMoL1TGRbTUtI9lIPBaX04LhmwycSLmObeej1Qb0mh58tOJxhmMVRyBypN5a
	TYvKJb8XLO6G5kkYYOk/kyoULO3SjCcfEPembpo6Z9h7Kp08ugl1tWxcJ6z13T5ab1fEWblt5V9
	ugDf++OHWgs2Wk4h79c0ThR8iO72sAbtTfGF8Cv0OCKj2h1rzEQKErLDBAqf+6tgRiz/9NHEJ7N
	6owIDWEsk6yW5Y0cSgo8V9XI7sin80TDnqWFsS0n7Ek0Dbj/eGJTNaunR+H59CI5vwzPZa822xg
	wsS9m+pwGt7aBEV72UIltTBuJZOPauJTesumLBPwRY7UjJ8MwHkQnFo5NSHhMFiB2estIdQ==
X-Google-Smtp-Source: AGHT+IH+m6E6WVdfcS6ls7YmNBuKBG9FV5JAluo3xUcZkxIadhZrNqI56KfB5EmPbH1Np5HIAcrzDQ==
X-Received: by 2002:a05:6000:4102:b0:429:ce81:fe0d with SMTP id ffacd0b85a97d-429e3311c7fmr1609181f8f.60.1762332473294;
        Wed, 05 Nov 2025 00:47:53 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4e71:8371:5a52:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9315936f8f.34.2025.11.05.00.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:47:50 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 05 Nov 2025 09:47:32 +0100
Subject: [PATCH v5 1/8] software node: read the reference args via the
 fwnode API
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-reset-gpios-swnodes-v5-1-1f67499a8287@linaro.org>
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
In-Reply-To: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=URxmTnl0JV1lV+vabMO/0fnz/R+E+W6aKsco0eYVKD8=;
 b=kA0DAAoBEacuoBRx13IByyZiAGkLDzGgxErq3XTBSHBKX2hVQ1nWMaGMH0fqS57EsLUZNHmkt
 YkCMwQAAQoAHRYhBBad62wLw8RgE9LHnxGnLqAUcddyBQJpCw8xAAoJEBGnLqAUcddy+YUP/1d+
 hunHrEvjaYOZrXyexTBe7vgqA+mNYDsISiJVcApUeHI4DbwZeiLr9DgM4scHLYocuSzI9BWnRxh
 a0Ru5i/JYr2W3v7z+i3z2tW5LV+JWlfv7cGAkDtw24lEKkuMuFZDRScKCVGR3Kgis1idsA0lXbk
 JWbs0m1O0EliG4r9fVE2Qf4rJ17aHMFFcdoYq7uLSJZOb3IKxqrWR1uaBNlJhxvo+TnjdscfYOw
 UW58nqyFNRQPxDM12X4uQVPv3DeT0svG6O1beQQLrYwG2spn3H1UBR6cY5sAPE7bxlcMubm3Q0o
 JAEWAPv3gDJK+qim+4pJhMeEXK3nzmt05NlFbqvGlJl7ff+Uo75YS0MlXm+m50huCg4PYJGCktb
 xGIbhRvqM/6MNANPotyPiL2ja82vJABG2Xv7wLhWhwngmOM903iFIxqstayxkeAdolJlE4ajP+e
 rgf0qohN58Y/cDE3A0MqrW77T0Qw23CvILOBirYeZ1bivxMNdESj4DeRTwsjz7lmlcMuDMNN2R8
 CH5jnWWwgJuS+TxHqeYpbnioLZ2fj6WMMj1urlUKWsJdcZtL8GknzpT2fkG+NjY4w+fb7koWLsj
 gDptVl6Fy0QrqC/rWURCsThoXMwagjm2/ZOLETpo6kKPF4jiACGjp4YzsAarb6sGdN+iK5lbYm9
 UotW8
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference all kinds of firmware nodes,
the refnode here will no longer necessarily be a software node so read
its proprties going through its fwnode implementation.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index be1e9e61a7bf4d1301a3e109628517cfd9214704..016a6fd12864f2c81d4dfb021957f0c4efce4011 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,9 +540,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	if (nargs_prop) {
-		error = property_entry_read_int_array(ref->node->properties,
-						      nargs_prop, sizeof(u32),
-						      &nargs_prop_val, 1);
+		error = fwnode_property_read_u32(refnode, nargs_prop, &nargs_prop_val);
 		if (error)
 			return error;
 

-- 
2.51.0


