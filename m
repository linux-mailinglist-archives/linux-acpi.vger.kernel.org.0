Return-Path: <linux-acpi+bounces-18587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5A0C3BCE2
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 15:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE483A22DB
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F278340DA6;
	Thu,  6 Nov 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NQksQhbw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763E334392
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439573; cv=none; b=kbFa8JHyasb4C+r79yrbUHTJ8EPy0PAfEzBtGEOb1QLOoh4/4YK2I9/ohx3TVwRIzEwq7RS26dKLufJ+1cbYu9YMooU9apSChRGho3ahvCD7EEnVWBLDb8OgbZUHO3E+r++mux3qW4uLt6fGyu/V8/iaRyQKp2xcMkiRGUIrxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439573; c=relaxed/simple;
	bh=ZU3J3KxzMLZiq+JBf+y24I7tWoIUO98cBpv1QovMR+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjrvn/2iewqrKs+gjo+GScDPrREkiBWO0gnwiF6LL4jXZgWs+KYbbUMspNwDKTBCKZJeXoj+14GMhatGcdjtg7KdgztMeL2Xh8EiTlATvOOfc0e8kueQYZfwDPF9Ri/zn2TqbXrXJFH1zkP+mOSdN6JkNkgTy6BEyfvLv3QnYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NQksQhbw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775638d819so5354375e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2025 06:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762439570; x=1763044370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1lJuE5lPEDINt9CtnczujlD4ivugkfdO9IHyIZSbEs=;
        b=NQksQhbwtSt7PW4gcNe6H+3op45fN45nmq5F6i1o7dv2469qEbwto2s2bF0i908Vv0
         Pq44ph3/Le7kBfaEjGVOTIx1XMXudjXJSqwLND9bULv8NCJIwuy5zwHPKU9K5CESyZGe
         N1xRS2IfNd0HI86kPC7LfehkZL2cQC8TeAkMwNBRn4RZt56oTy1pVUDp55SOJgzi1YUJ
         RnGDBIB1lsmWpYRS4bEdK3SsO7xb/L4B5d47y3bLEh89IZXeVNMDZFO0tmZYjZ2PX0Uh
         2GeptiUxNLHFkaencYHHUp1z5Ubh5cP1k3h52R/z4yhve4f30dOHZr07NpVljxyXXQJk
         uWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439570; x=1763044370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1lJuE5lPEDINt9CtnczujlD4ivugkfdO9IHyIZSbEs=;
        b=r6nqeN41Rm1GOwbaGxuNS7COcRCx7QlRMJKPokLIAlPi9zzLBRmh33xUK/PHnZO6NH
         Q8YYD8IroWcv4w3B/pcwvIwQmnON8Zij1uV7oBjAyN5VHn1fwih1QwCIoRxQI5rqNcRj
         ATzWWvUjzyLIneyAfs1BWTjxerKpgAFOjSeDM+6sZVb5F9ENsqoVQBitIDG7p0HqcwPn
         s3aRaD8BBnmsMn2O7t2Eq89ei3Zn7gfz1MDeo7lHTPHFQw94KCTMyd9e64JoNOJ/PuD/
         1u6SRnwZBVbCXzoVUs0d/AqvLnXAYqsJ0qpuHiLGrPNN9+qcEjMOLEzQdy6hbCbCGRBO
         S+tA==
X-Forwarded-Encrypted: i=1; AJvYcCWilDwA0nzfS+f6Yopu8UCM+/Kj+IMvHaOcnkaDEv8qsnsitEMBw/HrmHM6GTGzZFsf/71f0gMQ2ZsR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1MG2traC+OxkLYNpZ/UUqFEJEIUyHDOMN82nYeDwlpf/q1KXb
	hNN2NXymf6TATgJhfEwDyChMMkfKBjUzSJ4pdGjshQHRavuHf7tyYBLnADAI7edzwjIB09HE8fk
	YH7k/jsM=
X-Gm-Gg: ASbGnctYAmGGa63ofxA9cOnfzpACGwoLDGsxuwTN0E+fmEGUjOW39Ex9FxWDzffwiwS
	GiJpyz6XyrHZd8inJWkAXL6s9KFbZe0YDiqoiUwZyFWtA+uEMaFIeoCHaNungR9efpq+ILfW5R4
	YqRFybPcoa/wVuZ5evVqUALMIQKhcqPr6YIu0w/cOU6jr9mcyX4Hn2VlQgExyvGJTv45+tBDfB3
	+ruFozKP0pxFuaJaQbt2FlOeSrBh7ogVBYBELlp8EyLdXoUdJCzSO9H0XQTInXJNZydRxNFlemv
	DI/tO+bwsVIA4/d2KeKQe5DAWhdIEqqhzJfgJbg0bjjC8jkiyvqG8Xqiu02pTVVHu0JaCSGqQck
	xOP3RaOYvqKI97k4/dbbDtyAQQuvIx+UKW9omsne5idJ3wT88YwkyVmRb9Jprt2LFHy6Afzjy5s
	0WRrs=
X-Google-Smtp-Source: AGHT+IGxz8HU0EQJ6lzgZfLnl4y0iO0y66L/WFnuoZS3+YKjCUq4xce9jG0/f5EnqerSWAKG1YBT8A==
X-Received: by 2002:a05:600c:c4a5:b0:46e:4be1:a423 with SMTP id 5b1f17b1804b1-4775cdbe35fmr60368505e9.1.1762439569790;
        Thu, 06 Nov 2025 06:32:49 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm18871515e9.2.2025.11.06.06.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:32:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 15:32:33 +0100
Subject: [PATCH v6 4/8] gpio: swnode: allow referencing GPIO chips by
 firmware nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-reset-gpios-swnodes-v6-4-69aa852de9e4@linaro.org>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
In-Reply-To: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=bF3wV9wbD6pmGsN2CkYQyBuuy+4OPBgK3BDMknryXaY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDLGHkMfnlMeJvDLDFgQISqM70FyVPXG0oYqVr
 ozO5siLcyyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyxhwAKCRARpy6gFHHX
 cmxjD/40ARdSnLEx5bZU0Kd+ZVOlnO8HvoeOr/9ZgXnEuVudfUpnoU0K5MuiiJwmKyNZK3FmcZD
 xZgwvQn//mjc6oLvdGV1jaFuKkd6eVE+S80R7Z81v8/YEhqg3GLZkRQGpSaEBnlxA3QMUxB+1Wu
 ds0DTrZXyic7PMOvgyOb7bFDyKZfLzV1DJVrd9NiSv3N386oGJVnVO4LWSlISWE7HPRZrMQt/9B
 d5CvYKpBmYscl3ejCyXoBPJVqERunv+cxTWc94GW1adD6iU02LS0J1AXL++YPEbuLCbAQY5tk/Y
 s7D6NUsngwmBxOLxUhb3XomkspBhB9gqWbifnbt3PBqwTw6apRTzTUsz2fXLf4Ku3E/jasJvqcb
 oGHlqjxST/cHERC0kw0E0IL9SoKExYntFRF9H5rxtFRBvYhRFzjaDnSX284841PCyjNoaxppUaI
 R46tm384emT6hILW8PiAuQ7O4XwtBkVxES4SpNIvvmdyFmwi1R+jFRy6vM1wnGOouuxZ05Gp6nH
 b4Pv8DMOCrkBOOvdv+pbLDpNk8WBpWd/qPg0sCoySYG4a3BIVGJ/YrJ1bKobNR54p3bj9Z8l2rs
 01LmAGs7joXkGxet+3hqhXKYA7ciOfn+I0pn3UE3mPB08Zl8T/lxwAYk1cP3uUq/EPDwbYlLCYl
 V5nFhz9etb3r4Cw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When doing a software node lookup, we require both the fwnode that
references a GPIO chip as well as the node associated with that chip to
be software nodes. However, we now allow referencing generic firmware
nodes from software nodes in driver core so we should allow the same in
GPIO core. Make the software node name check optional and dependent on
whether the referenced firmware node is a software node. If it's not,
just continue with the lookup.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-swnode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index e3806db1c0e077d76fcc71a50ca40bbf6872ca40..b44f35d68459095a14b48056fca2c58e04b0a2ed 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -31,7 +31,7 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 
 	gdev_node = to_software_node(fwnode);
 	if (!gdev_node || !gdev_node->name)
-		return ERR_PTR(-EINVAL);
+		goto fwnode_lookup;
 
 	/*
 	 * Check for a special node that identifies undefined GPIOs, this is
@@ -41,6 +41,7 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 	    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
 		return ERR_PTR(-ENOENT);
 
+fwnode_lookup:
 	gdev = gpio_device_find_by_fwnode(fwnode);
 	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }

-- 
2.51.0


