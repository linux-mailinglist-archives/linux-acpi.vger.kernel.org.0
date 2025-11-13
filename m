Return-Path: <linux-acpi+bounces-18861-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F22C575A9
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 13:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F57F3B5674
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 12:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F22E22BE;
	Thu, 13 Nov 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="j57X4rR/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99F334C17
	for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036172; cv=none; b=j5+8v95hf7L3SgcCH6VvLU73XhSF6Z20ug1T/aRpN1ynSdywMvlQ3q5xSeTiQIfXp1pKYw7Skag9g6jJq7ZLx0+pyw2rMUm0eqroZvaDuhJbB9dBEzKFUC01L5ycHp3lEkLyzaWY426i4IwRj8PQsskH/PSsmaA5N8TXofSaBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036172; c=relaxed/simple;
	bh=vU0vVcdj7jCdwUcv/gue+zO1DQjdA2TBS31EUlfSDg0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JD/HFceBIaO0d1NHeMFn73Oic6Y2a9cpsQj8IT7oBI05M+Hfi8TD2h/HtlaJqmiFUulHDI2VlBlfKrudnPfBkQHRNzKIK4+weQVZrwzG+/6NYws8DeI+2FH+RGBaIopBTH0NAZmUMi3K08CaGpeMTOZB0AUyse6nFwmVQlCDJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=j57X4rR/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-595819064cdso632349e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 04:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763036169; x=1763640969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l60Ejo2T3NWsKQGzNLhTDzj0QFomTxhzdJot6ahjhjk=;
        b=j57X4rR/BDRd2kJENJ8TIEaMBnzBplNYPwmy2+vUZTr1WArZI1gRwzQGeVTraqEnY/
         NpDD+F0rXpRMJtss17Ofv3EXj8b1fN5CLeuwzV54qL1cwcepclHYlECVFWiwfkX1a4t+
         KzE0HC62ggt51dy9l2iboOERT5XVhguwKKn7L51ozbYra7nHvfUNZ60z35XSxrBKmlY0
         SQlT80QbXai0A/00YtDahUmQzhhsPZpsb3vRqFctM9cI43/H0+jbeCVNW1sqhEfNvBxL
         c/IkhpCJ1Kj+NZXml7nS02vE6KRcmu0K9jSzQgeknWz0N1L1mTjaqeR8Cm3nQ04nM7Sm
         5nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763036169; x=1763640969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l60Ejo2T3NWsKQGzNLhTDzj0QFomTxhzdJot6ahjhjk=;
        b=kgCBR0hsSJ9uyIdxUkRz1MpNR6s8RNTF5E6PG764Ys3hG9bo/8oAzcYWk804ujtwVc
         sRMDLzPRsEQM+v26nTToecTRFcGr69xZFZGe81KrJ5gEHXhVsDsGJYbxpYv5UnHqyx3y
         QpLNoemtJ/1LtLxXIDxY52lWJUwxWnlNw3mAOPzXhFXq0CML2lWR9rAuSenrEAT296UM
         Zy5xNqpOsrCFxwwCzB+ZYvLFR/LhTORXPe//hbzrkwMkyGguZVY9s/cimj+5CVzRpKaA
         cQNiGyMASGJUbdYEic7k0Ymavm9Xca/B00oBUpwZjqvRF7ul2FDsS5UJpVHMV12hrEdO
         FDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVwEPOe8t6TZ5aLC5cGiowcxZBe2tMLCk99SxQIBnzcHdmXsBCLd9gLJ1rBv3C+cpto5qCjworhgCK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5CcUZI7BhD8d17dMhIEW/esKfVek6bMXnP7dMiAoUzgi7ypBt
	oKVd0wTTUJYr1N559W+4FllS3YBo0/lCOUAjZTyR4Oh+To9G1rYh8RipdWPLG41q5iNLXSN6ADQ
	k/WD66vnzJa9rQgPx4/0Fn9M8+bEODcO4/iP05Dzc6Q==
X-Gm-Gg: ASbGncvqC2x6Xeb78RPHUAqVSgkrUCjRn8Lm2dZHQ/55Fq9Qj+VaiOIM8HNV6zMa7tB
	D8lOUCtXazJ4CzKW8pyx3aF7ZuQMeXklaxAUNAaMUsaotQhDd0t09HEb/Lp42cBIkqZ/tWpi+0H
	8mvKYkXhKOSE9Q4+YD3bFUae3C9c3+c54xOE4ui7FB+p/0ajSDRLfk8glLI6zBBvveIgv/9Httj
	guTxdHQAIPy8n5X57MiYI7vgal1W5GktsEKlngMbNSvJqqCywwDRAqtVYkql5Ojc6vQjIcIDDLm
	nmSsBGNn4Ssp7fFWvG8g8t1eeFs=
X-Google-Smtp-Source: AGHT+IG+SB5V0nyOHRjdiqtQoBEkzTsyBhfKzRDkBcnIkyOZxi4eXUP7KS/OG7XRhpbxBrkJtFZ01bW/wXaiRrz2LfU=
X-Received: by 2002:a05:6512:ba3:b0:594:1279:dfc0 with SMTP id
 2adb3069b0e04-5957ecc4170mr813091e87.18.1763036168751; Thu, 13 Nov 2025
 04:16:08 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Nov 2025 04:16:06 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Nov 2025 04:16:06 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <7aa5a0ce599f86cc29e5075aa4e35155dfcd013e.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
	 <e0e81310332cfdc075bf13f66d7be712b42964ed.camel@pengutronix.de>
	 <CAMRc=Mfcir56ZizXgZZpt4nQY234PA9jx3CQ24YCVQJFBQ7msA@mail.gmail.com> <7aa5a0ce599f86cc29e5075aa4e35155dfcd013e.camel@pengutronix.de>
Date: Thu, 13 Nov 2025 04:16:06 -0800
X-Gm-Features: AWmQ_bnrvTMvqLZX1u_e8HTISsh5pEaGIMQQeIw6rqdZq7jFkd3zAadXNSoff_g
Message-ID: <CAMRc=Me3mOaFpn=xwpDwBzLWjOqS0Gx4rV0E=v_aEg6s_uJyvw@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] reset: rework reset-gpios handling
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Nov 2025 11:30:39 +0100, Philipp Zabel <p.zabel@pengutronix.de> =
said:
> On Mo, 2025-11-10 at 17:57 +0100, Bartosz Golaszewski wrote:
>> On Mon, Nov 10, 2025 at 10:02=E2=80=AFAM Philipp Zabel <p.zabel@pengutro=
nix.de> wrote:
>> >
>> > On Do, 2025-11-06 at 15:32 +0100, Bartosz Golaszewski wrote:
>> > > NOTE: I've picked up commit e5d527be7e69 ("gpio: swnode: don't use t=
he
>> > > swnode's name as the key for GPIO lookup") into my fixes branch and =
will
>> > > send it upstream by the end of this week. It will be part of v6.18-r=
c5
>> > > which tag will need to be the base for the future immutable branch
>> > > created by Philipp.
>> > >
>> > > Software node maintainers: if this versions is good to go, can you l=
eave
>> > > your Acks under patches 1-3 and allow Philipp to take it through the
>> > > reset tree, provided he creates an immutable branch you can pull fro=
m
>> > > for v6.19?
>> >
>> > Now that -rc5 is out, could I get an Ack to create an immutable branch
>> > with this series on top of v6.18-rc5 (and merge it into reset/next)?
>> >
>>
>> Hi Philipp,
>>
>> I assume the Reviewed-by tags by Andy and Sakari under patches 1-3
>> make them good enough to go in?
>
> I assumed I also need an Acked-by by Greg or Rafael.
>

From MAINTAINERS:

SOFTWARE NODES AND DEVICE PROPERTIES
R:      Andy Shevchenko <andriy.shevchenko@linux.intel.com>
R:      Daniel Scally <djrscally@gmail.com>
R:      Heikki Krogerus <heikki.krogerus@linux.intel.com>
R:      Sakari Ailus <sakari.ailus@linux.intel.com>

Looks like neither Greg nor Rafael are mentioned.

Bart

