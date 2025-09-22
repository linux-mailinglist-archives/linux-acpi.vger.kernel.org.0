Return-Path: <linux-acpi+bounces-17200-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432BAB91A82
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 16:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5942A28FF
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE6E212551;
	Mon, 22 Sep 2025 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S2HgMCOH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31AE1F2B88
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551071; cv=none; b=rxHUOasrL0C9meDeFlu4chrwT+wUlFIErjnpOVXFMHrBYbUza6Vay72N8OZblR25zl5kdL41bZoNvDACZprN6DBsGCDI2Y6FqobXIWl07HSR6IZ5MMZImrCqJPhdf5wfGkq+Pw+vQUb+zw9g3xZnvl3fAav6jvF36NuJRy2+Iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551071; c=relaxed/simple;
	bh=Oe74uDY3qf44VHSaAlFOrOAr91j7S+C9t3V0aNVHzxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHPkFUQ6HBVtTbevwXFkeT9p6UDZZJswJ2c+clFwAHNAqa86gs/cizDkuyAN7mKS0lEhZNK8uxbLrLQtTAcpulhKiR6fOAjRYILz4vwc4cMZ5uLU3ocd2D+OAASR51VPKyNQie0Dve/6jNmN1GVCXd1o2Qd6pRuHIoLvTan9pxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S2HgMCOH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso21060455e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758551068; x=1759155868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoE5pKWbt7zgWUP4zjAVnETbjrj2vk0DVBGqfLHW5w0=;
        b=S2HgMCOHWsdfAm+QBSYNwOv7x6RY5yH0ezzcejVL4s3XNMr56CLYmghgXf/UcwYKfN
         95IjPdHD+A1TzpFANWGcmJsiJE95KvyutAXjGI1uky3gqBoOQoQubRQTHwMqa04gj0Oz
         yyBiJLWVZLU8ollgtcwzAnfzqb7PkpVqd+oFidJt3ZxZGJl2WPkJBsfVOCVhzPH1ssqH
         Yc3Bl3en9O0//fd5qdhLi1C4IJTTi1RFjsW1jf9UwKE8jXGjxt27Vo0fwxY9EhI+Ybpe
         nlcTKtP2ozkVp2OoO0hd8KI+LP1uwhDHZ1FxXgBUXKnxqvefJfNur8EuApQZweDpYwFs
         smZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551068; x=1759155868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoE5pKWbt7zgWUP4zjAVnETbjrj2vk0DVBGqfLHW5w0=;
        b=Csk/tKO5zz93muNxZY85aShnaxVbUfCm9d6+qCauCtVpO/3pw79OW8zIAHn5bUlUmn
         5hBc8nYk136Wy7hIMhHaeds5b/X8s3HPK4HRdFfAMuOI4tu7FEQwNxuxptMeFuNsmJ1n
         RvDmSgqfazmJI209aDK/wW0jFI7ndVxdY+s9alsFfQkB3eiaHpE5XzPv/tDnRKGVVIYq
         4DsbTqCxpDk8QAW32dNY2p9hmg/Sf+K2i80EkumspVp267aNIzJVRU2qV0WKl98vPwy7
         q7C8CIO20Vhze0scjsdszmRRKtE6u5yI7fyWhilvG2G8FtmBxHQSYxue2aQtsEc7RXgQ
         khqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFg3KWlHOa+sQ4Mu4r7/+fYEL9fWJDzAPx2MIGyVA71dtpKJOuM4ZGSGKJh4Hg6+vO5muNfsmQdEty@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1zj9KaAYolfSOoJGugu16WpFPFWuSF7fOM3ObEV0GGew05NYJ
	8G30sLBdk+Y3Kp4O3K6+cenX5h+YmYj6eLn/2+gXeXP5HVAmQfAEEVjea/jVEI80/7k=
X-Gm-Gg: ASbGncuPxw9Oc7EYPZN4re78YvCLGBCBoRU7pFlvfsFdf1w71urDg33gwpWdrYiLOYQ
	NDRyKQ2ntcyNJZNBOxRYIfMQbYCKYoHCjOB9iErGnXF8np2T7nTU/f/Vu3gEPKxnKo5AyqeItBe
	c8IIr+feRcXf0DFqJE8M3UWG8XzY1CasacO4L8TSinVcqkvOY/uJhL4USHvEiYFWfogG+8Yyixg
	JookGlazTxSdQTRKGlJXfZEjSjQcOj8QlrqhBKrO7F7DOl5c5o/XsJ9wAvLDy16auMogQyTKjd4
	wmbG0bvA6KG+CHX0WBnKyA/vVyoNSzAvo9vozNrFckeYLY+m7Pt+IcS5lf3X6udYaLO4gf8SNn3
	w8VEGIffM2jP4+zL9Ulh06JU26dIjcgWY/g==
X-Google-Smtp-Source: AGHT+IHzy2P+yoAem8bjuH51YJsL5dj6hh0tzCeowwKpBsTfXqE4o0Zpx0SdTP2F6am7I+7s/9+zzQ==
X-Received: by 2002:a05:600c:4fc6:b0:46e:1aa8:44a3 with SMTP id 5b1f17b1804b1-46e1aa845c9mr13120055e9.37.1758551068124;
        Mon, 22 Sep 2025 07:24:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:824c:ead0:65a5:c51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbffaeasm20106161f8f.62.2025.09.22.07.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:24:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hansg@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: Extend software-node support to support secondary software-nodes
Date: Mon, 22 Sep 2025 16:24:26 +0200
Message-ID: <175855103332.80479.15136170507041580366.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250920200955.20403-1-hansg@kernel.org>
References: <20250920200955.20403-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sat, 20 Sep 2025 22:09:55 +0200, Hans de Goede wrote:
> When a software-node gets added to a device which already has another
> fwnode as primary node it will become the secondary fwnode for that
> device.
> 
> Currently if a software-node with GPIO properties ends up as the secondary
> fwnode then gpiod_find_by_fwnode() will fail to find the GPIOs.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: Extend software-node support to support secondary software-nodes
      https://git.kernel.org/brgl/linux/c/c6ccc4dde17676dfe617b9a37bd9ba19a8fc87ee

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

