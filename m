Return-Path: <linux-acpi+bounces-11754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F079A4D6E6
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 09:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDC23A7EA7
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1491FA167;
	Tue,  4 Mar 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKShz5m8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE518A6A9
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077957; cv=none; b=s5eQgZFCdKLW9cc7LoNd+SDYxDOI4GkCoLqKXlOjAuzOni6UHGcsnDVBMZW34U0AIEyaVjuw+Ma31pVSt8T+o68XHcBbEuye3+ZSXGHdP5RX3+XpshpEYfCJSkww2TnCMzDuYf2MqwSK2/rRR/q22W/Fudhcv7QTRRN83W6Rbs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077957; c=relaxed/simple;
	bh=/0SJkcPrDcWFOUGtF0J/DGFOTXNav/MeYdDkxX2pjFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYuYcLHIcB9xqhFa9LpAfYz53SbwrsezxNGBwohOctag1HxCe85iXDTSpoDZGu9v6kGNxtM1aV8XtKKpw9/P9ZyizYZl3Xu0HAAkkZXfy23Q8/emTF6VXLYP9lmZ8VPDZkHaS9n1fUb7OMWrqflJ7ziZ2MYcr7q1uf98Z2BCDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKShz5m8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so56713321fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2025 00:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741077954; x=1741682754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0SJkcPrDcWFOUGtF0J/DGFOTXNav/MeYdDkxX2pjFM=;
        b=bKShz5m81i3KkHbzcyXPBe4Pjl5YJrkLhMFFvQI8K7kmMdOzSC+uB/NOUN4WPEalua
         ClFDTUB+RiGkXa9HHi8JsxvDDkzd0WLtderAUzCnFHXKqhouHp/KtIS2+fm/zhcGhTfl
         iwNl3/h7T1ONhryTk3HEJrGOd+OcnSukGwHG7SMRcJe2Bcb1IQI+zDzECuwyepNMOxlU
         YjiVIcJgmZuui+1vXa5wM1E4m8ZLd/z+ri5Z4ObakGdpK1+PtOg7FuKHuhoBmk47cg+h
         lTnBQhxzbMLUzZ18DcKewvWMEv0z/O4iJjBxQ1KtG3dwbzBF4LTbr8o5pJFpJWLpedy4
         MbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077954; x=1741682754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0SJkcPrDcWFOUGtF0J/DGFOTXNav/MeYdDkxX2pjFM=;
        b=RUezro+dS5HKHtYAbLzHqNXw+SQIxH3r27DRrBTSwm0yng3kG1jDV8UZOnwi/vRQdJ
         dLKDgwiViGgEKuKDNDXPqzSE256tbrWF59neKRp4DEEIciLclSZEdsV8lYq3D3Egf3hs
         Gs1yA1e0LX9ZPu1lWR1CnORE0UBXdz9Ivf51zVpwZg61T9TiaCdRFxWf97xlCkmc53Zs
         o8xLq/O2JvxTSKROJq0TcSB14PCUPXvC0aayd2RlqHEy7p2ySFp9MKeazePPZQlTE1tt
         f4PjtDbneDNkWxqh5OD5TOx1aO/Nhnmpl37lKg8X0JdWm5m79cAHMYq1kZvjsWtzvUfh
         I+8A==
X-Forwarded-Encrypted: i=1; AJvYcCXhR2kPxAnvnLEZ3Pfkin6ktMHKtXND3ab+nmDGI+cFCQ9Rrp+FVJiSudHVVeJOmmi/l7t1u3v0vE/9@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+QceDLI/7r8Sj4LkT4xXoM+nF5a8Sy03S/dZe2Tq/gMLo5Rj
	3A7a5gb+WUCQXuXvzBdpvqpbYEZrzwvgTh4uRkjqvMYZu2CDnpGUBZxeP12dWw0tEO3F/Uculp1
	lAI/bYzMnZKPfLBGqUY09qK4bStebwMG/O4XCtw==
X-Gm-Gg: ASbGnct0L2TLl0IawLUO1auDcDTQeDXm3Oz90H/YoUqIUO5EsS0IY6Nf3Zmc4+npIH2
	4v2fSWWi9QwU7kMpEkikRffflbZfsp4PpoN1tAEJ534xx1itnW0RtncMftFRPNJxIWsn80l2aIn
	x34Lo2gS0F6OqFG02ott3qVaotMw==
X-Google-Smtp-Source: AGHT+IHsVxclGliNqaEX2rQGkMgJ98ubJoLnko5L4jIGDJ4jURzN0K+jt3I2W3bQVmw/PNLGXa3fvCQ+389PMRa318A=
X-Received: by 2002:a05:6512:128e:b0:545:958:180d with SMTP id
 2adb3069b0e04-5494c37d98cmr5919737e87.38.1741077954243; Tue, 04 Mar 2025
 00:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-4-andriy.shevchenko@linux.intel.com> <Z8XUMRAlR3H13zha@smile.fi.intel.com>
In-Reply-To: <Z8XUMRAlR3H13zha@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:45:43 +0100
X-Gm-Features: AQ5f1JrkaHhT1A9qOrQA_wrC0Y5xjg5i_-rTm_Muy8k7fJlbX2FpNCXPxucoweQ
Message-ID: <CACRpkdaxnCK6arrYBi7j7qBQXqxYma8owb4kZj--y4BNQmfD=g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpiolib: Rename gpio_do_set_config() --> gpiod_do_set_config()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:09=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Mar 03, 2025 at 06:00:34PM +0200, Andy Shevchenko wrote:
> > In order to reduce the 'gpio' namespace when operate over GPIO descript=
or
> > rename gpio_do_set_config() to gpiod_do_set_config().
>
> This change was made against my custom tree and I forgot about that.
> I will wait for the overall response to this series and if okay I
> may issue the correct patch.

For the correct patch, with the same idea:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

