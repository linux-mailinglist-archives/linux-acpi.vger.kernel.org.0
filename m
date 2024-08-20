Return-Path: <linux-acpi+bounces-7704-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F791958112
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 10:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1542C1C243E7
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA28F18A6D3;
	Tue, 20 Aug 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="L1zCUkdl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2518A6BD
	for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142829; cv=none; b=TKv8duSNHnOwWT8krTWA+7L/AR4ksOiJQn5oGVW9ad6QULPX3vT/3/uGVLAqNM0jgQkM0YOQHVAp5NHPOGgMkaTLt9LcodeWgbNgvwuXNxZsWwdDwAm/hu4jERFVi0l6GX9XF+ubXl7YdRLf8tC8bae5x6tSTgIohsbQvDUxsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142829; c=relaxed/simple;
	bh=1LtjsPFrjjd6hYsPJu9b0vm4sQPyFxCduIQ0ZLAHK1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shVHOo00DdrJwvLCgE9fa5waWDGlWRZq27s/u5MFqjbBwLI4X4rhELJ+vFTXq4dOwtgXi+oEpXbe6T5SX3yuZaWhRJ2SkkhjvkEKk0aQl3Esz3dJM3WsPYmwjCCZJURU81+upL9A23DjPjqhGlJIqDPKrH4ebjiwd3yomGMQk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=L1zCUkdl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428178fc07eso39578925e9.3
        for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 01:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724142826; x=1724747626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEL7tQD7GbeuTlapz5M/BtFYtXhOkUzJpx0LAanx7Mw=;
        b=L1zCUkdlkz0LTAP9emCVCeq6n6u4uoBBO6bRqPp+rFao/f5mLfExKKl7IJUk7m8+Am
         jlnWEFWDmvbE3Q/vQyH+g7mijE5tAmK5aW/6WrtM51j5ApN2FbUCqY/H09YBItlDqJBd
         3XlLv/kQJ/xagDcXqRZG8UNi+Ix305NYpADtwkHuTcxLy+CNoFdMUhfPnGZAnOnA3w5E
         47mRFptK4bSu0MVVWXteFx4HdGQeBPxLdtrl12bT9nabNJZdE6VCB/jN75SFiwQWLIdT
         i68YZLBlrhu0kldvveyhMxqD76oxbO7axOuZmFiuPZ9ql1UZhaslqwXmeScYpPpMnEDw
         5+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724142826; x=1724747626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEL7tQD7GbeuTlapz5M/BtFYtXhOkUzJpx0LAanx7Mw=;
        b=IbK2vSfm5fyDzsl+obenGjojM4T5NU8a9sieCRIX4djVVbwjGzq+8DsZ8kYY952h0p
         RzRPxGItBi8jsiOuR3I4lN+3Lu0cOsrIy2XhWB/OfwDmaBh2WYPq5cNe+ACzdM4m5Nxb
         iq7HmMsflvbht7H7yZ/XvhtjSaLGN6Z8YkCBeEl2ucpRndpWjZOm3ACbF42EGOv4hb8R
         JF1w6//mCoPhCnTEWuk8gYwWgFmqm5DtTbUKmnMObgayQYI3rwGVOaxilxWB90A1XAeo
         G8VN8d7fXIWCOKF+G1nPyIToKqyku0yqpzXLJD75vP/K9FlbE9A5uObeRGd+Z/E7Me9S
         IDQg==
X-Forwarded-Encrypted: i=1; AJvYcCXWx1kLa0mJfOsdablJ6KfoUOzM2S0/HWp2R7du66h5kZU+s/TyxB+xMAl7jVw55gm8TsbgyzOc9O3z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HSOQ4FBTu8L1ktHE/RqbGkyRCgVneBg3N2EKSBTWfPFg1rA3
	Ls/4WKTXBnhPSfc45jfqFBNIQr4A5hSnzv3HZpPXtl1dzAs5m0TMPk4VxwnaeUY=
X-Google-Smtp-Source: AGHT+IHnn/RvdT8xKBMoBdrZ1Ash1eRln9exy4n1RN2NlwHjGcXkKlMk+nXjGb9x8VTio5VKmPJ2+Q==
X-Received: by 2002:adf:ee0d:0:b0:367:8a87:ada2 with SMTP id ffacd0b85a97d-371946501f1mr10050186f8f.26.1724142825520;
        Tue, 20 Aug 2024 01:33:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ddce:8248:19a9:4bf6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a8fcsm12468056f8f.63.2024.08.20.01.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 01:33:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 0/5] gpiolib: Add and utilise for_each_gpio_property_name()
Date: Tue, 20 Aug 2024 10:33:43 +0200
Message-ID: <172414281950.19982.294912238748441566.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
References: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 19 Aug 2024 17:28:55 +0300, Andy Shevchenko wrote:
> There are a few of duplication of the same for-loop against GPIO
> suffixes. This series addresses that along with proposal to eliminate
> the exported gpio_suffix_count by converting the array to be
> NULL-terminated.
> 
> v2:
> - fixed a rebase issue (LKP)
> 
> [...]

Applied, thanks!

[1/5] gpiolib: Introduce for_each_gpio_property_name() helper
      commit: ef3d4b94d2d88b160887ff9ca737a5f8ec101579
[2/5] gpiolib: swnode: Unify return code variable name
      commit: e42fce0ff99658b5b43e8dae4f7acc43d38a00ef
[3/5] gpiolib: swnode: Introduce swnode_gpio_get_reference() helper
      commit: 7fd6809888a82055fcca9d14417d5e2675f0acc5
[4/5] gpiolib: swnode: Make use of for_each_gpio_property_name()
      commit: a975a64692c39991fdde2f1d990b7bdd48d183fc
[5/5] gpiolib: Replace gpio_suffix_count with NULL-terminated array
      commit: 4b91188dced811e2d867574b672888406cb7114c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

