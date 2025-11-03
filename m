Return-Path: <linux-acpi+bounces-18433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 302BAC2ACA8
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897F03A1A94
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3A2F0696;
	Mon,  3 Nov 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gHIbov7D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC02EE616
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162551; cv=none; b=hiebRLqkrXAMMgkCG62w3U/qunJvPBLnMIJRlsBG4cubQICDPBfTZEcAyMkAfBZirVFocPPvoBrevOX+dOsWKMPWSup3Fgi7jdy6mU7eu57QhGjOMKL9OBdG8dqyCpXI9+x8/vtsvSDui4Qr3QG/scpBZMhingwntHypzaYzApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162551; c=relaxed/simple;
	bh=cxrSuSd3SffFCsNE0jm4EfEjLQ6o2VSj3hMZ52YiwyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hr9/dLq4QEJy5IR6TGuC/RkX1v0gtuQdNk8f9hFfudja3glp5O85CO/wfos/FvLiGVVVwxbNR1TDRuFNv0Igjcja+cPqSkT08YhjwlCteLbpGfg5i/g8CwNZpElOc0gdXPlh1lhc94o23CAL+pnkp/COfKsGWKly5uV4fFFJrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gHIbov7D; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso36263165e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 01:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162547; x=1762767347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ph4oPh3xLmZTcDXzCKTBGJeXK4U93djPD2oimgH5xG0=;
        b=gHIbov7DzpfAJO6Nmba4LHvyaK9qF0nsIPpFjMJS0T+bdgzmHYoZ6W4iJzyZEXbXEm
         g2jNbZmfySRJ2XEPYHeKnBZs3jc4Tp+RfMUagyZ8OEheTBilDoDLIIfLcPndetG8l891
         9T6RKP91O8kostSln5b8Hsw8DcGg491KBBmARiSCtM4VaQY3eFktNTye59od3W/gAGEc
         itJk85NzuLWrA37zx/X7IGHl/Lv0OFVSs5BR7uW/x//ieuSE9LONOSj7JTPrmlkwuW8P
         Xk1j5Fgbpl/+cvw2OhhLOAkDnrEdr4c/6ZEx5SeY3KOMd3gT92U9J1heDBdII0WWIBqX
         sGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162547; x=1762767347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph4oPh3xLmZTcDXzCKTBGJeXK4U93djPD2oimgH5xG0=;
        b=IXGxKCXtnmiktR06H/2CzqooLhvDuPBIqpIcPRKnAzF0ZlDYW22A4/842vbYp9unoU
         1HCjgTRVntvYo51ieHJ8OjiWD9u7ZfwY/8WzbIPiuQ9DVCmsSHvR5bJDZchk5/MZtl/O
         6uVSfXkU2ja67Hoi2W7ASr+axzB8FYktB5i5+VBJaNtAsAUwC6xgi+ljhbmZQMuHnTJ7
         b13oILuhbS1HW0q7X6HWtnpyE9fhzHMm91KflsPReeVVESXm24hzuvl4ucyB96O7gKo8
         yrnpgBkVzv09DsLzkRT7osdJq5mCvwqgxGjgdVZ8hEeMiFHKPsXdt+qeSjut4QCysuh8
         ji5A==
X-Forwarded-Encrypted: i=1; AJvYcCWyNm9EpcAUqdS+8ByLmyrDwsZvg74HReecwT+8TjQ8J9bTfyOW6NiSxW+jEeUOEzLW5Gq5nSyFF6E0@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzr2L2xltL3oeviy6k6Cdcz/37gBsdZwEa7nePPC0fkeDR/z5
	GwHtfZgQGpJgEXiijMWjAN48peIt8aZrM7TtbYvu8J0EAdMnkRNPzZCHGDa8kzfNwPY=
X-Gm-Gg: ASbGncvry5dN+tWEkh5rae2Eb/aNfT/ONf9fZe1Kts6l9jWkhme7WWcA+SIWghdKOEG
	EMVSmMuLr4DybdreroaIIiZWBp1xfcUrizkfAw+p8pKkBRjdK6TtvfPmbZxYeB60R7TcF2CO58U
	QZUEU305YIVa1WRVatizNLOY60pXK/fd1nKEp6qN9st2xqJBhRmi6/HTD1me8CkH4Ir/L9p9O4P
	oZUtwweSVUVaEK/5ymunj6qjHCrzKhBlB23jm+OAG2Lu5dA7XUgwTjIXDKU/XXZVeyfHmhwA6GI
	BbEzaj/KOi61abtqYtWMNHjxBPHnvnSmHSbT8vuyDdjT3bUqtrLVARyAS31ois7zss8KDM5r5t6
	6bq8bRWrh5AHW9o7v5Fxv1JS/bQ+SDCCThz6QCIayasyfwWTFBvApqH54PKyUjYMXjIDpgv8aZf
	YikOo5
X-Google-Smtp-Source: AGHT+IFWvdmE9jmhQNsKEv6lmznwGqw5UnLkSV15MT4Bl2LI+E4mEEbQhnuOQCPZsh65/2pUAKVNOA==
X-Received: by 2002:a05:600c:811a:b0:475:dd89:abc with SMTP id 5b1f17b1804b1-477307c147bmr93023785e9.11.1762162547012;
        Mon, 03 Nov 2025 01:35:47 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:45 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:26 +0100
Subject: [PATCH v4 06/10] gpio: swnode: update the property definitions
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-6-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=qZrP4QmicRIBgZpjf6GIYTTtJ4Ab1ZJJcvonbYSz28g=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdlOJbVRFWRlEo0P4nO+EKjxhnkWfiWzi/gi
 qvS22CUKUuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZQAKCRARpy6gFHHX
 clHFEADAX1IIKJHPYl9molA/DVVacZ6hlCW756bmj9ygQweMqXKTT+Ro3HmZstzi2WUcBqTt3sd
 8+9YMIIz6po2F5UV/AIL5f3SeApVKc8M8wdAuBOPRIwK1IdZ58Znzqih5oWZ015oFpBAoJ81571
 swG1RS+7stycB/WZqDNQ/plBrYXLX/JaICRwKHu2mljxJ1hPPgnj6d1TiH3YDft64e4dmT4tIz1
 SGltEOoNaz261yXI5BjxUxooq9r3RudHHPBxtSjiLu8p2ipOu8Idc19fnjwdRXqqDrm7LjgDrXw
 KHHvPc9phV8t8tgxU9gS2Wx3sA+CjsgK48wYdUdJn0cwc3szUdcEqQKYdRwDv+RlGiD2bstfqOe
 QdqBSVds+eO3WFJsA8QDpFct4yBr4vICwttJuM/Y+ZQ5x/BiDOG+gq8GQLB6TKO0/e64fTB54j9
 YfslTv98OqAs47S91aWgLaBYaPWeQppbLsQ7D7qQ4cQllrR3wVQ8WaJLpfCT5WoAIX8OtjTdD+c
 +IXcCtJSkhQX0CHlMxMHXj0qrHP2mzOCwJ5ybHVxiMFFLdNiKOr1Tm25Yer+f+o468eTofi1Lan
 IWKmRZw36aH2ahMFQR1LhngfJ7v0U30OC1plYsO0sbGc1J50/s+EfFYibxeeD+WaqpIlbnhGxS8
 zMCymHtbB6LO5zA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the recommended macros for creating references to software and
firmware nodes attached to GPIO providers.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/property.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/gpio/property.h b/include/linux/gpio/property.h
index 0d220930800276a21b5ba96a68371ce66fc4ae3e..6b1c2ed9c57594bf3ead5edc82439f9fb7f514fd 100644
--- a/include/linux/gpio/property.h
+++ b/include/linux/gpio/property.h
@@ -7,7 +7,10 @@
 struct software_node;
 
 #define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
-	PROPERTY_ENTRY_REF(_name_, _chip_node_, _idx_, _flags_)
+	PROPERTY_ENTRY_REF_SWNODE(_name_, _chip_node_, _idx_, _flags_)
+
+#define PROPERTY_ENTRY_GPIO_FWNODE(_name_, _chip_node_, _idx_, _flags_) \
+	PROPERTY_ENTRY_REF_FWNODE(_name_, _chip_node_, _idx_, _flags_)
 
 extern const struct software_node swnode_gpio_undefined;
 

-- 
2.51.0


