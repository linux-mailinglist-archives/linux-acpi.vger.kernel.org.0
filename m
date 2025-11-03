Return-Path: <linux-acpi+bounces-18456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1249AC2C63B
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 15:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CD23BDA84
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6542D7DE9;
	Mon,  3 Nov 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0MmbxGZi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715141E5718
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179260; cv=none; b=jpjgdNS7TzA0pRQZP7pI86vIp3h6dHErrTh5jjHvGX0LZA1EKoxsP+zrM/XOFBvA0IuhL3UMT97MEGPRNuL/L71kFHPzTC56WVdRBfVvAfoN8IHBx4ickZFXtFJbIaD8iVGDnbhrjf8s+bauN/QN0mqm5CPCo+fZ8reZ6ntjT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179260; c=relaxed/simple;
	bh=qNpCvuLCPjVhSPOY/TTr8xx/nFAJiYYYEoTJa8eEaaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaO3QeLZwKiJIztG7xYrAUaj+m2Z9ES/piou0Tqe94BNgb+/vTXs4V6W8DFv8kbNxKgDCpdl3FmjKCajYDIGYM4r86+68BasrX/DMNRD+ltKdCI8C5lH+BVVSHHcZ7dj3x4HvzVvtz0gkbB0bN4+FLa4cG26lx8j0Ml5NHfeM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0MmbxGZi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477442b1de0so10665915e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762179257; x=1762784057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoMAIDiy80JlZ2DMoz5nEEW7dOP5ZblOtmfc/TQFMxo=;
        b=0MmbxGZi13Xt0Gijo4wZKWclxbyoLYC+/bfMtIgewcYC3H3i1Pu0fhPprY5+wPBwyE
         Q1Sw+Ot18WOUk8PKIgJ/Wv4JDKoStxltKBRHR9KxKuagbcP0pchNeiI7odxE1KFRL+Gz
         rTEOuqa2YCz/J+OX70vPRv1CEbYS5oUZ6uKNU4C6jEaf1to5W9Hj2LXgxQ1bYDYQDcIe
         yFq3ZYHIfai2lZiMWWkRCsO7rEP5mOzzyuap0FT3FNuYhVJqMpXArdqAoQXbk6GECMyl
         qMURQMP4x/NZK4DWe6k5fp4GVDbtYbm6sYee8RtcPYnR9Bu0xWRa5cjcaZw2IQ87kANM
         g4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179257; x=1762784057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoMAIDiy80JlZ2DMoz5nEEW7dOP5ZblOtmfc/TQFMxo=;
        b=FIOYdph01tSFs2Hr2l+Q6cNP1UlPOhKl//QbQI9xIgDld5P6Nl/ERajLUTTSKmxCMQ
         DhQeUK1P8dl9juEeehtGuQD2EwUCkwbYfDg09TEnzu2XCppfyaO2He3I95isFwJMzttm
         HKV3kfeJZA5TK9mC1cTKXS/VbYdCR36QjR6vxpDv8fSTo9nPPxu17jCgJGfFs5zy4WBs
         0T90buuVUasR5NLJ465Psge9GtwHsIuzIlpcEme5uQbL53QPixv3ae3oG9KEBg7P3izq
         yw7GRvgCF0kTYGFddTDM5bvo9QRST95t2dWkXLGc2y2tSvvMiDQ6aIwMvppZAs7ikSTq
         YYQA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+PAXtva2Yxh89HaCNjwGc5FZmHOsYcMFduqsBZk//fdQSvRUVCSSKudE0AA6fIjHObAmttnRPdiq@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjQexclo27fNFiW7Qi28vAweE1+poNovNO7t3wxR711bZyjDp
	BDOFmqdM1y0VVCTAeCvKBaAnzhBgB61ovNKvQDeLWEZb4IAjMfTzGiJGySlBg5NL50A=
X-Gm-Gg: ASbGnctTs1hpDi5yURxCz80ZiydIiQA6j6sAxLf6vMWgRi4QAOfxtMEEFcdD4PuFVW8
	/5lqWqAUmqOojP4EKVnNyrLOeN5qY0l2eZDnlT/noUcXLSqVJdWWHd7qp1K6I5I5ULG+xLy48w1
	/Vae68/n7SeGScKCQIPBHJZ+Ar3W0T6kJ6G54lNxkwKtFR37o+ePLQn+25Gm3mc01tOsSZe84dW
	V2XY3faSb4A87/Gbzeid4OntEIhseKdrXShlXART72T08q/TEbEEOvI9fYAQNL4Cyhn/RC1tXii
	Yo6mWzQZjV95yT2lE4V2l0M1nIxJAhitmcns1Kiy/sLGCnHon6QsN+pGkF15I6oslSMEl6XxK/p
	9OkQK+eWI9bQWAjkpnD0a5qXj6BS9+lIciE+j7U+pa86D4emO9eE10XC5wsXaMwLG0IRG4g==
X-Google-Smtp-Source: AGHT+IHLTxJUWh2BXzgbxjWcAhT+fbvRofGiksQw6Mxx2/kQAdhUW2RWaozukFUQgF4dPtsxkYVg5w==
X-Received: by 2002:a05:600c:3548:b0:477:171f:65f with SMTP id 5b1f17b1804b1-477308aa6a1mr118209365e9.38.1762179256644;
        Mon, 03 Nov 2025 06:14:16 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm86531405e9.6.2025.11.03.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:14:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/10] reset: rework reset-gpios handling
Date: Mon,  3 Nov 2025 15:14:12 +0100
Message-ID: <176217924320.53912.4328025839514313502.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 03 Nov 2025 10:35:20 +0100, Bartosz Golaszewski wrote:
> Software node maintainers: if this versions is good to go, can you leave
> your Acks under patches 1-3 and allow Philipp to take it through the
> reset tree, provided he creates an immutable branch you can pull from
> for v6.19?
> 
> Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
> absolutely no idea what the GPIO provider is or when it will be created.
> However in the case of reset-gpios, we not only know if the chip is
> there - we also already hold a reference to its firmware node.
> 
> [...]

Applied, thanks!

[04/10] gpio: swnode: don't use the swnode's name as the key for GPIO lookup
        https://git.kernel.org/brgl/linux/c/e5d527be7e6984882306b49c067f1fec18920735

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

