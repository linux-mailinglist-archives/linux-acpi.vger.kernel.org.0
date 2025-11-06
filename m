Return-Path: <linux-acpi+bounces-18584-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E2C3BC5B
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 15:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EB11888147
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DAB33A02B;
	Thu,  6 Nov 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bviEkLQ7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DF32ABE0
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439567; cv=none; b=LwOdVgpMAwyMQzxlEquVUKl01i9rO4Rbx+GWl64y93nM7jfM+3nWJya8O6yymevPM70k60VHcf+UxzxK2/ll7gq/DpBtfaZo9Wukz6P3/mYVcCz1/0kpqJo+CowPr3/9zoIH2gwYQABHtLzwlvi02afDa00avPlCuS74eTRulTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439567; c=relaxed/simple;
	bh=r9cDw/aJYsPjA+g3Iqusl0ZJO5kkF5Y1AkYeG2Ln6YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqRly4DL4+bdYqKk1oL+n+9hoAh9yPGEhKThMFEe6nzdOCjUuUZHJMDLywucHaEAl7QqOeaez0Vmuh9eCWkggj7bDngqIfGDq5z3O0rngH505DiQ9fH611sKKW+IdUzw2CHuxdopXuBGUrVT1HoIokG1H9FQSNdOdhvAxsMn4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bviEkLQ7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so9151855e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2025 06:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762439564; x=1763044364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTmt0EBBpoH00wEC41/FLfqCbZ/Fh2wyVTiBtA0d/dY=;
        b=bviEkLQ7ZEUOWu9j3GaXhxC3o1AchrEXbWEtFoP2nWndi3KE/zSlXsJUscKtlCafw/
         1Qthu1NImSXV+31zMTFYfoket/oraK7L4CZ3EmRurCMZZDGWD0gHM9Ex97UHDNdjgRk9
         BDxPwZytdy3Ec9lCBVjRqv1OyDosF73pEJnfG5EgB/PQrwtLPTxGr2xdu2ifm3zBdZY6
         a/U0sNMD2KrahoRw5EhED0+/D/7KqPfDN9ONHMsRJMQ2jBPFrtmM0xpogU4ddn1KBkLt
         PKT+kOET6KZMhp+rG5p0OzsCGH9mKn8VDlZTQjBNar4ZEEn+GFWDyGhtXCrTwmhc4O4w
         WAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439564; x=1763044364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTmt0EBBpoH00wEC41/FLfqCbZ/Fh2wyVTiBtA0d/dY=;
        b=SeiScL+7Gkjt31l+VExpHqVxhD5Z+JjIo3s3bMUlMBc4ljK0aBdGpkQRay58NLEavC
         1P9WWOIeCQhq6jhad2+mXBr39ryzY/jK6o75+EQukctKp3jllyIh5Rmhjp7ro6qamuoN
         8vYkeCNsXm35MxfAairL75mDlT57dNmREI/NbSkZK9LnCHpqn4YhhpxkSj6qsYGQJ6Nv
         OrT2ltOJ6872Isl9QWphsvjhCn49V6XOD0QyMDXBcgy2qXosMgCzF6jFGXFMbJrEMJxX
         Ge/qWGhICTaq96k68QuOgmy1l/RXkQHQpLFg7YWS+6bfJmFz5L9TWvhVhteZThffFtPA
         2Paw==
X-Forwarded-Encrypted: i=1; AJvYcCV1E2zLiKguX9du4N55iCTYRgwsNInDZYgDnIOhgNID2ux/XsWz1SJa0z8aumgzuylauq1mRlejmwIs@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCdylamf7hKgU3HmX25l2W+Y1rlux/bxSXsboF15lDlRpGkX8
	Tc7ibELu+XjLnb2P/3hEnzl+gUb6AXINB49tWUifEbo+oiJaDyNf7Pq9V/LMx8MS6OE=
X-Gm-Gg: ASbGncv+3bbJ3WovBYNPIO9Q2Nl4h8a7+2bKmZumur1oJZNX8klGfcQ2d32boA3ODkn
	pCsuSgK1/L1USvngwMsL4HVUS9460Jn3XVNtXKbuau3zYBN7WMVj+DOrTvD98K1m324WpeQOCKU
	24bw6jHzXkf3ruF6t5fID3WG6AUsGrIvlFPOYxIGk43qFLj+xjDZPuRqL0lj8ki4kjKAXs4/02C
	9KbgLQF+MapwYG37rZBoySk4mG6bE5OBQbpmc4N7LQDMcHStMzo2iz8Sl3QDaCKIjPmB7Nvoow/
	5RtfYj+k4WRiEfyBihYjn94uqiHfd2t3ftSiLE3Zl6DuP7xsm1WyEeGlBtYayt8faxYShbSJuHO
	g1tSasrxnxNRdWZzQ2N1bKbGLPmdx6SNnY8+0Qd12Wqkksi/6Kq74XTE3D0qI9xaDWrJzMK1ey0
	dj3Y4=
X-Google-Smtp-Source: AGHT+IFhkWZTruVv1KVnkMn6Da0iRScGHxJI2FkysYx9T/xa/YLkWepHynbGqxvTul+SYZGDVHSdqg==
X-Received: by 2002:a05:600c:528d:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-4775ce15009mr86580575e9.32.1762439563549;
        Thu, 06 Nov 2025 06:32:43 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm18871515e9.2.2025.11.06.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:32:43 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 15:32:30 +0100
Subject: [PATCH v6 1/8] software node: read the reference args via the
 fwnode API
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-reset-gpios-swnodes-v6-1-69aa852de9e4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=URxmTnl0JV1lV+vabMO/0fnz/R+E+W6aKsco0eYVKD8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDLGHHrzJIusI4JXnxY86OBpevmi97a7q3/R4I
 Umf7gMWwwGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyxhwAKCRARpy6gFHHX
 cl+XD/93nrVvksz9PnWr70SbhGfmgwHvJcgFbahMtNX8oKqiuvbH0qAXkO+xYV1xh9IoMZ4KL8H
 mvxJCSXdD5JNI8C1dm5i6r0a/axUKXfKcEllT8+c0UGUlT35eYKBJLMcLbheYjgXg1PPrpCQa97
 G0D2xZdabvf63tZYnAAF6ZyNJgj9NGw8Pzw5EdjyuC+WlkUd3nGaUaDRzvUDqxlRetUDxb15BIi
 x+6EQ9f83hQiCQyh6ncnfI+sovqPGh95CsqAjqh7JogOLDxmZL9NZ1LvQOYoZQR2r3vVqJMYNdJ
 F0ZHQssIGCk4bsMuTTWsxwC6qPApfN5fTtiWIVVRlSdPnngrNxDKxmcLZ6mSbSMLBMoAEGsg9ux
 4c1cvlYSH//FESEp+uPH4D/FQvEEvA+x+3eJVm1+t1tYQvTnYBVpKsOOFWCn4FwI4HdixLKNOTR
 sn/NjPEReJx2nWxkOkmCLr4SRasxW5cN/IgceNZyTSxb5f2y2CGxVVuZTMtSvaeVBuVKTW7jepg
 wQM+cLOOxWsc6e8LkUCErcndyd8huuy9udHr7vn3hTAHttej+RQn07Q8uxdpb9ak8RGNwaFDjOF
 235qrtmZoQqsj/7j4b0rsAiWKC3SCcqCGTZ70Zd6GI1phbcKeKbKcYh5tzmcCx49rdBZOv6fSsn
 JX7Wk07CWN3FZ3g==
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


