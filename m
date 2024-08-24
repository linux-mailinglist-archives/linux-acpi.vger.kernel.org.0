Return-Path: <linux-acpi+bounces-7814-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872DE95DE7F
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Aug 2024 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E8F282E7D
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Aug 2024 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D421617A5A6;
	Sat, 24 Aug 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCvKE3Kw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48DEEC0
	for <linux-acpi@vger.kernel.org>; Sat, 24 Aug 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510623; cv=none; b=Cbv77kz4CgVFBCcrTKL624btBEtISkSbV6C1P/jHteoqexboF128h86r1Hra2KEuH7QwEOxo5krmJu4KsH56aU1EG1X0XSJUMbe/JqoQr60MxupDnzi3w/EUFe1njeixFI+7yinpAWimtnyCmKj1TbtqqNBWhqg8CMIVZtIZ4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510623; c=relaxed/simple;
	bh=TG/Q635uFGX6ibz3TtyerVGS3vHIeINHxFOb8QYWcCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaKJ1VgAh9F3A17R0n5uZpLRQo71xq+JCVrBzj/mg2RoqVadCE6WtG/4YQXUWpIPXuJy/YIp9lkmKv+SKEg16chlOlqdurkwQKwqQVGFDTw7/9ItOGZTzH9JcIxvlhiqypWB1wpc8AUDNCpvl6UTyDxJNjoS5Gu7mZ5MENnsv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RCvKE3Kw; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53351642021so3176495e87.3
        for <linux-acpi@vger.kernel.org>; Sat, 24 Aug 2024 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724510620; x=1725115420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG/Q635uFGX6ibz3TtyerVGS3vHIeINHxFOb8QYWcCg=;
        b=RCvKE3KwgPp+3R2Y5oyMruspdUzBEqtT1uyl4YorwiWu1H/kaGpX0FSc8+LbySgNfq
         eVyFMSmIOUmQ5QVJt1Wt46AgfFSgWajs8mRDQaNr4AcWJax5KseAdzBd5uUCC6659EA+
         GHWGEhl8LNoDIV48zIdNaYfm2HzahTKZhUrEhJSM4JR50yXGUM/1oFP7tjr5X4/Jr8J7
         K2OdnHByzsfo/Mw1MhwzyR/fj/KqhUSKU5oOIAsuK16C1Kns+5urqajgWraxZmrNE1t9
         Qw+kb4IeVBJ9lPU7YZ0X1FA5iFIUP8WTE9QTQS+Mm/Konm+WwqxNXQ+eyvZZhBdlTTOs
         BRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510620; x=1725115420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG/Q635uFGX6ibz3TtyerVGS3vHIeINHxFOb8QYWcCg=;
        b=kf6HpJgGMZX/3gLQyrWoLw044NGroEHfZxq8R4w1+XPJBkq5qvAFyPETAt0CH10C8G
         +52yY3D8OX+OJg0nefubFl4li9EsxUj4YpTbfuMFjWy23UDPVEbNKLikTq+bRrGhYVZV
         g+Lw4lrBUhskXPKrDuKGiqBy/7EICLEFzvs6h3M6yDwR/93IQ11zUNXqzBrF/UYtEFFG
         F/LxPOLLcgbSB4CQWZ2aY1qooSlBXl/7XZEuufsAy1byoT5yWi6TfU0iENk9r07wtr99
         u9PbK36w7b7I7z0GZLrHaspf4QCO18+v5/zaq7I7rSmLU6HvYiIh+6R3nMBJSgnC4JzI
         tYMA==
X-Forwarded-Encrypted: i=1; AJvYcCUuP19Iy+mTyrxqBEMwfhFRzrxtY8vS95KXoU7ClB5uOmOz6SknbQ9Mq5zJAlRd03MMIFW6h6ldF14p@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZiBzCRIdhcqFX+JpYJ3DFCC2D/mO3je5XJk6BnX5mgFcO1pe
	AjVPz5llba1p+KgLdKRsegD2PsVmX97DeX4/NkMSppWLTBBVzEwKTpRgJIAybmk1kOU25VMYWVa
	tPsz9oGDh7wdNLO2kCpagcYby5BqZafgon+vnQg==
X-Google-Smtp-Source: AGHT+IF1Lb1IYekbSwByfy+rWqqhhcaUglxVrpppACcE9AnsPrA9/GqTgMiYryV6a1z6VO0NT+wvEAYG/Ss8+fd6IzM=
X-Received: by 2002:a05:6512:b1c:b0:52e:987f:cfe4 with SMTP id
 2adb3069b0e04-5343878551bmr3688925e87.30.1724510619375; Sat, 24 Aug 2024
 07:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 24 Aug 2024 16:43:28 +0200
Message-ID: <CACRpkdZosbVKr9nY91oMTQUcn2zrm2t6ZjxQiyQbwQx-kt71Pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] gpiolib: Add and utilise for_each_gpio_property_name()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 4:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There are a few of duplication of the same for-loop against GPIO
> suffixes. This series addresses that along with proposal to eliminate
> the exported gpio_suffix_count by converting the array to be
> NULL-terminated.

Too late to the show, but excellent patches Andy!

Yours,
Linus Walleij

