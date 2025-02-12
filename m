Return-Path: <linux-acpi+bounces-11088-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC81CA321C5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 10:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E14F3A5CBA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 09:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CFC205ADE;
	Wed, 12 Feb 2025 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ztVFH6tg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51803205AD9
	for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351341; cv=none; b=hQKhKzog2VhobtePSWpMlhpBXUoGebMiqMh21vw+11tOmrIWeU5LR2AvOH6Hu/S2iwWG66RitOFYu1f+tw4iy1YSDg4nK8pDdPzomubIKjcN9RPmiw32x4zbEi7RdN9dfA7mzab+aGgUnqc/IlqygWlnlTgSpOlQynTYxtDYriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351341; c=relaxed/simple;
	bh=OvqYnpRvYG0LGpobj7IV6ZwhbVEj/AeD6iszKsbWduI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWy9IKKugnqDKWu6n33+U/Ay9Y/K8Q8NYBNoYyQk0+yQQRUuknc4JAxRmSgDsWjyhoYWDOYsnWct3aAYCljdnr1cs8GQok48nfv1yiwPM314XRIuXcXB2E47URfjjocpmHgrLdz7l6Nvhcc2ww/nkwoxhIeP9XaGpLCq78pTlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ztVFH6tg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43948021a45so27813645e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739351338; x=1739956138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKD7ISvSvAMVM8VZFenVGXThc2qL1nsB/7rDLqi7zUI=;
        b=ztVFH6tgcKFyITLyax9Uh/QI3oS/EEB/4M00x3Y+BsVbY3fflQLVgztASNjpJWWInW
         wn9hUdzVn8OOuoBz1Wxtiuc5pDIMF8+Qs2Om6Y2OuTROhHLkvqx8H/kEf0ukRbdwIfgv
         XnqvaFbBa3F1XlvXeL0nG41rdRDlW1wcF5NvJB+QBmdZUSWoCn8n8mLEdtRbVF+anfPQ
         ES+yublnF2KG3bAnt8R1N5po76QbfnoWA3i8DH1LKDzJM8g3+Vpmar5sX6hVudwIb8Hf
         1Un9mbe/KLAE2W/pd3UXU+7pDHsGDu8OtpqDI9soSXJB5w0wo5A99L0QgEyFZdrYr7VP
         9K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739351338; x=1739956138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKD7ISvSvAMVM8VZFenVGXThc2qL1nsB/7rDLqi7zUI=;
        b=xJ/+qzAEygLUOd3xIIG6xZYUb4ym17BYqZ+zoYzBmSXiRylzwYEResDuWe1xMIwoEW
         dqJoO6uwmha7NgVhP1I44+KxKPXnl7VqvqcKp5rBsjN1LBJeu8hVl4BzcGvsf3yL+JNK
         coBIi8qNijxcQbq4qEvTft1/fcCrSxTjaV93Rsr2vQSKmUhetFbk8IdeVf0pOKgx0ciS
         B6eQL+iLJP/z/k1TR9n/7+KjLfCLMHejPDAkwfURE9vXuUUSLbtiCqZPrgG4gcIfBd0L
         ZAgpHEmw9x+A4ToPH+M9WT5z3fp6KF3QCOlj5iAB20BoUv7LE11xn25Qm7V+EvaSUOiy
         6zbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyB839K7UqfNRfXfcDjUlPvzgneHRSlrTSh4r6d6BJaDisDRy6ChQuLe+yltILemxVel1ZPq8VgzG7@vger.kernel.org
X-Gm-Message-State: AOJu0YwxpLJWJVN+8egeyjtlPD7w3R7K0DtaTf9uJ+fXpMNSOlnZqdCf
	NFsOgr7oQbZ3XthUymVeEMokXTt7KnwlU2Beoz/LxJx+5NDFlfQRMg1BbNiSQ2I=
X-Gm-Gg: ASbGncvhve5zJ06gII+VOuOdzvbRqCcgwK7BmRhyZe9HVCinJ5xWqBPTOZaKo6h2T9I
	ANTMABgvsG4dm96zS2tiBUXkYv/a+eM/l/AIAPSTcDNh0GKUquYtMjqvyQCTYVmU5kJNIr4Xfu8
	QGRH6+zBLZI9DPphAVop33RCjEhwkZjw6h5Nnog7Cz38MPsL/1AulAxxBK0Dvy/w1fM1ybmv0ca
	FeTRE5Ecj0PMAg0rdbPiHd9vy3lNMJTT1GebjhEc3hujMLxYLm0nx1JMiJHPUnm/+2WY6NZrfg7
	pYJZX90XtMXSiYE=
X-Google-Smtp-Source: AGHT+IFkWvd1ex79ASDD1erZLM9AfGHHCjVCSYDIPWJ+oZLpJ2fy77FdM8qDbkbqPp6eM3En7ZTtig==
X-Received: by 2002:a5d:64c2:0:b0:38d:d666:5448 with SMTP id ffacd0b85a97d-38dea2d363dmr1957104f8f.40.1739351337520;
        Wed, 12 Feb 2025 01:08:57 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a078689sm13220325e9.37.2025.02.12.01.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:08:57 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: mario.limonciello@amd.com,
	westeri@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	Mario Limonciello <superm1@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org,
	Delgan <delgan.py@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add a quirk for Acer Nitro ANV14
Date: Wed, 12 Feb 2025 10:08:55 +0100
Message-ID: <173935133349.8493.1997870240852943455.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250211203222.761206-1-superm1@kernel.org>
References: <20250211203222.761206-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 11 Feb 2025 14:32:01 -0600, Mario Limonciello wrote:
> Spurious immediate wake up events are reported on Acer Nitro ANV14. GPIO 11 is
> specified as an edge triggered input and also a wake source but this pin is
> supposed to be an output pin for an LED, so it's effectively floating.
> 
> Block the interrupt from getting set up for this GPIO on this device.
> 
> 
> [...]

Applied, thanks!

[1/1] gpiolib: acpi: Add a quirk for Acer Nitro ANV14
      commit: 8743d66979e494c5378563e6b5a32e913380abd8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

