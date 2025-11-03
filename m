Return-Path: <linux-acpi+bounces-18428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2537BC2AC4B
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655BB189197F
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F352EBDCB;
	Mon,  3 Nov 2025 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZIIVqjOG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50522EBB83
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162542; cv=none; b=hateb4a4UUFtOuVC0O0gX7FUDzQfQJ9IduUU5jl73JxwyQpIIP9f0QwqLv8sXtDh/85qpEnrS6ivOiPaE/Lc4wIdtcPiZYfOFE6phRs9XTuGipkMkVp0PYCxcwKyaZBsC551ahxhJ27yyrz5SgdZl5A5JJlbl7qVDnXYRDa5vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162542; c=relaxed/simple;
	bh=mPvck7FBusBIrrU9DyUagtYmYc59qQeaw9PokJWo0q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6ZmUlNvbtq7XMc4yInGHsuhSOHdTslq4x79AOnU4UvD5DOZenh8iyGt5WtCw06zT4t/Jaw1PNPGQ0YVDFOiqm0k6nuoAb51rZSFBtmtWq5sddEIXiOEi+ZcvDZFV4WFcYQFO371Ywdpx7yK0cyb9SNB8m5N6YCbOxOEsGSJ9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZIIVqjOG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso1690007f8f.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 01:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162539; x=1762767339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8B48CQ+SAe2K7TCbIb4c6gbeJWwmvGMrpBNS173gJ8=;
        b=ZIIVqjOGRLFg8cNHZ/X3+PWpT96Gkohw73TJiPQQ0JxXxVAJ2Kge3x11xOV+JoTA05
         Tk/mQtNiQcuR2iTCmMZ7EJAPkWYmOSanULylcbiFWV58g4vG26oYJZbUK8HwE/q2zvc/
         npornGaIuaC6e0HupMBdmPsTyrmaRuBPs3ulp2Rs6icmxe6uPJgCfVXhPEVhWmOlh8p5
         /yqI0i76G/42phNQRWpla5gJTMOSKBrJJZPdoa6DNb2jcxbh3M1iWDQyxfLl+4ouMwrY
         UtZRnTXo+qmbg7mbaElSaHf0NAadSQ21UO6ivp7mW/OO1MESc42AaclI76Ick0LWERtL
         LZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162539; x=1762767339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8B48CQ+SAe2K7TCbIb4c6gbeJWwmvGMrpBNS173gJ8=;
        b=S1XyXszZe/3FRrp9SoJChQ6WLg2c8g/NJO4y96xG28ESP6sTDerHJaQBC82S8e3uaj
         vRmDhexUUPpQ2DKa0gimd818N6gK0llJTbOyrdfpZ0ypYdnTJsc/rhFe41HoXM1IEwTf
         CMWTH+TT4KDIUihfEHMh51oOWpzkLihAQSuTgPK9G+l4P17HEInAZJlQD8pQE8/dfNw0
         dJTuKvI1D5LViq7jmCGcIaFZj79UQxafFyfcGVu9ITKitxfuCtQiuhp1lNg20T8vQvXR
         aLWsEqgtmBj/GJJfoIFPsPdDO7pRzicv8IoiETyFDhAUCOud3X3sSBm+TNiw0SnqiB4C
         D5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXGBaFLElJ4c7bJy0B71Fi87xJUZo1xbjFf/FGbW2KQdf1fdGZgnCKeU6YTlLDPC7BmwYgXg/jDlCM8@vger.kernel.org
X-Gm-Message-State: AOJu0YwjkQ9l59N0ckbCZLB221JWHCYpZqS6BVfEvvqYC6XvSyRiNVNi
	gcQQKvYbPXYUrmXfkl0lMmU3xqU3vNcmVyu0/SQAYg/7I0Exyx5IPm9FtCY4z1S8WT4=
X-Gm-Gg: ASbGnctIEcj9OoCAa9zfqoTTb0bELqvckHPhsNGyRNeEMMXzdfbFVgLluJwxygkkUiU
	z6whXMBEGuDnw+pZtZKUwOhm4cmGcnYVWJSBnz4NBVmVBvozbBOb+tyqeSB2UxQtKfvQGuVZ9Ia
	frHRuCXhDTFmHas1BW4vX0Hzwy1lzb8JN081yeKo7g8a/3DF/HPLB9XBUd9xDQQs5lWnQY+w5Kz
	zALLt9VLa7gVD7Bk686ifAhKQDSZ9IjTk3c2TNpsNzyF2nm/MUZecNkjlTU56FS4z7zv9DoLQz6
	HJ0yF/GlEMgZYEscL0zdhVTMhwdIdNe+c625PvGFWCp4hLE/ZK31+XSQjWuaapv+mgLU4Xlm13T
	Wa5Yu1sXQgIdzEeEx40m9XtNPdsY2g4DuH1M1St3dP1E/WDpc9MI8dGvmSX8pKZu3pyrn6w==
X-Google-Smtp-Source: AGHT+IHfu9OcksipHflpqjCQ92EerKc5s6qdafFQZQsWv4ZSgHg4geHKeDG/1frk/G+Q89VmFDb2HA==
X-Received: by 2002:a5d:5d83:0:b0:429:8bd9:571f with SMTP id ffacd0b85a97d-429bd68d090mr8088868f8f.23.1762162538612;
        Mon, 03 Nov 2025 01:35:38 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:21 +0100
Subject: [PATCH v4 01/10] software node: read the reference args via the
 fwnode API
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-1-6461800b6775@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=SV4IzN+VcOwOjZe7Sl4nz98LmAMqSJepmGpgIZqgDMU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdkajN+2UJXULO0gRWdo33RyPbNYEQqxjBtc
 hXqRX69jc6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZAAKCRARpy6gFHHX
 cpJsD/9w+Iw+J790OWkhVJtQY9JTsw0MQBsIW33yqUuXrhdQM0jpfqYnE7s5thQeJVzIgtQLQtB
 Rwge+GfVlxrVEYTF5kY5aYsWJQPPSI3nBhTZ4l50i7rQLwM3ds91MpuzYldh8vTjo3I34Pq4+zF
 gdv42cYZac7aQR0537bMArdctppn0polCA0bkjcXRSt4RoBI2g6r/NC67EN9i7jC8VDUTiv0uka
 FttcUOJw3/8wQQYJJYekLRjm1+w355yQSe82NraYvivVs0/nOyLwSeOeSnbE2S9GAoTj9jqKSSD
 n5FFcthtAMmURWsOglbYDUau4PyDIqqSXlxOiHg6R5jsBmQiNF6W8UydTUSnKiQ5/TYhKP2y1HM
 Fhba9bRXzhbirtR3ANVy0TRc2WoYYZXbJykvLp58Dnoa7cVgyM4QXUW0QjJ8k62vWp42cOdkZ23
 QNugqQcqolsBG4gR+JasP2a6ioZwaMcsGMVF8yIhrMXp6i5ffDL8Lx3Y9xi/z7r6pvhDBCGhdO1
 PJkLqThPBo4674CyWXFMglw/uBM9Qe5VwN06B/grSkp1Hf2sR+Hs6c5ZObNtJDDd/+lbZ49u8o9
 sFgWocYOyFYQ1+2ajdIhmS8rvSwlU3+oSaZmCD4RSscK3xWM3O6XNFTK89cU6q4T20PZjAP2735
 sqWbpGbtGBAZqEw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference all kinds of firmware nodes,
the refnode here will no longer necessarily be a software node so read
its proprties going through its fwnode implementation.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
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


