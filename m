Return-Path: <linux-acpi+bounces-18862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A4C57766
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 13:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E14E6189
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6434834FF55;
	Thu, 13 Nov 2025 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k70PRfsx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1734DCFE
	for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037604; cv=none; b=Nhp7vOE9R00OnGPBp+e+Y60RqClWY5mKuDVleO8xzj7FpRgvHmazFwq704/7eg7eJ0LiXaOlBijZ0wxXCfNwa5DxrCfP1IliyZeXqr9F5OlPmCZpxq1rnnWtKqQntVwcIlUKldysrMxOVP2vNwwKak8FxfEdyxJSxwQ+NQawEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037604; c=relaxed/simple;
	bh=+kTwDuwG6rspdkZ99dNoC1BLBNHio/t4Ku94BnnhqRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbxP9o9z3zZx2T2hvnak57QbjMe2mPoFHJpUsb27gHIUfUkbw5sUrbvaxDTvK+j+1cYDnq3to/RsftpBs8OJ4E+5Pmbdmww5CEQzy67jIPG16SpgHk0YZyTu6dVSGYwLGXyHGGeoC+CkvJ46hXrpe0fn4qq1raYSXjzaEQy+vCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k70PRfsx; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37a3d86b773so8348411fa.0
        for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763037600; x=1763642400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUOrtPsGub1HhpXyzrUpFchIESa38qs85WIyjbHg4K8=;
        b=k70PRfsxSapODP2hSfOJ/F/sCO3uVA5pmXnaBQcvEkzOkrmmaBgIMLdKvCB+GjKFhg
         DHsWqidK96RQgK80hLFLKn8nbDnEnRAr7avhDtWujfGOLfFdfCNodLgos8wYgp+7v1+p
         Aiu/OK5XSqJZyEwCA4xYQ1XazUzGGHwajHC/6EQ1w0E0KzdqLFPSTxZUJogI+93I0xOP
         P4ZugIH4/7WVZZuklJyhwmIbYkYJ+gpGNSmwfIwbcdqiCaPC4E3PhjqkMPgWMWM4v40q
         uS93wPY0UOD90sqXNt/OXYWk3xKuvblwxguwJNUzpCwYTbn7cryMGcJmhsGCo+4WPMeO
         sHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037600; x=1763642400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AUOrtPsGub1HhpXyzrUpFchIESa38qs85WIyjbHg4K8=;
        b=PdpJNyJJVf3xYDmkUq3f+veYjGczpWU4swG9g+hS83ACZ4aaIqFmtaGUboGyGZ4hIZ
         nmBaCc0FBjtODJQxYX/0Hsth0PPwGUCaoBT/5biZw+8mz9JKwcFqyPdo9ulesIKIGC7v
         mr6ya/T2mrE8dSr2VelGL0WmZnVexYA+SSObVQHCIiPzpfljBm0GAcNm4N/fek6IIkf3
         Xndf6v53syBD3JwH+3HCboFjQ7EmmPmM+3WB06/2z102Vmb+RgefJc4HlOoscs5bJqi3
         l4vFirshJtOVuPepNIhXh38dppaCwOIIyUuGTm1EseLgvx9AFpPZdCK1iEF3GGA0uDZN
         3c1g==
X-Forwarded-Encrypted: i=1; AJvYcCVaHqBhVseopiC7n5hP+Qr0oDlbnJpU9p/cjJwFqrNJ0tG/92vyWqgu53vQs8WejOUIyO0MOjYo9XME@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzhFf5BIY/osBXG/ly1qXiB+xhDEtpjuhkEZyU9GPZicRkm/7
	BYXf518Ppu2jF15l9MBggXyrn0qsjPU/z2M9UsJsIlUcUI7sSb5pNFnAdlRxvzTbtoMV5EqQqIL
	xcr5+24rL9WsO0EZYa4r3MYTHPMGC2VjO7TMpny9RrQ==
X-Gm-Gg: ASbGncsdT9R838llSWICehIq2LzwJafdSpw1w+DktI/+QbWalroCpUkXZBtWvthZz+S
	ipYCjTfKW4LRCmoSO4XGCuSSzEvoh1kBOxGUv96L+RL9h4XRZexbqFkInRdGN7Xiv8RrTVbdUk/
	PdhILvBZm+fETA89hzliemUIduxjL4n2GdyZvePjoo61iv7ZrbKaLcyF4mj18eApme9fa5X/sHU
	LQohXcMbYnoa3UwDuliy7JYn/VQttGiwyZymwPhClGQ6GOvwut3LTrS+HaRZw9jtQVzF/YiQch3
	zaouYhTxX1HIjSU7
X-Google-Smtp-Source: AGHT+IEwidGHoNOMaYo4htt19dYp1oulw6jtGUPFtCAr2wRYS9NFrgMFss39wedYdFqyQ0XIZvSRls+UzQXDbZ99yYM=
X-Received: by 2002:a05:6512:3b1e:b0:594:51ac:13e with SMTP id
 2adb3069b0e04-59576df8da4mr2157404e87.17.1763037600276; Thu, 13 Nov 2025
 04:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
 <e0e81310332cfdc075bf13f66d7be712b42964ed.camel@pengutronix.de>
 <CAMRc=Mfcir56ZizXgZZpt4nQY234PA9jx3CQ24YCVQJFBQ7msA@mail.gmail.com>
 <7aa5a0ce599f86cc29e5075aa4e35155dfcd013e.camel@pengutronix.de> <CAMRc=Me3mOaFpn=xwpDwBzLWjOqS0Gx4rV0E=v_aEg6s_uJyvw@mail.gmail.com>
In-Reply-To: <CAMRc=Me3mOaFpn=xwpDwBzLWjOqS0Gx4rV0E=v_aEg6s_uJyvw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Nov 2025 13:39:47 +0100
X-Gm-Features: AWmQ_blTF4bGHOPBFto4bdAeuDnTVCZ4z2kdDUSFoogNBWSvY3rUo6lXRjR-7mU
Message-ID: <CAMRc=Men0Dc3rokguW-ghsViyMmJzLgvJZtx9ACur5h7U4z_7w@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] reset: rework reset-gpios handling
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 1:16=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Thu, 13 Nov 2025 11:30:39 +0100, Philipp Zabel <p.zabel@pengutronix.de=
> said:
> > On Mo, 2025-11-10 at 17:57 +0100, Bartosz Golaszewski wrote:
> >> On Mon, Nov 10, 2025 at 10:02=E2=80=AFAM Philipp Zabel <p.zabel@pengut=
ronix.de> wrote:
> >> >
> >> > On Do, 2025-11-06 at 15:32 +0100, Bartosz Golaszewski wrote:
> >> > > NOTE: I've picked up commit e5d527be7e69 ("gpio: swnode: don't use=
 the
> >> > > swnode's name as the key for GPIO lookup") into my fixes branch an=
d will
> >> > > send it upstream by the end of this week. It will be part of v6.18=
-rc5
> >> > > which tag will need to be the base for the future immutable branch
> >> > > created by Philipp.
> >> > >
> >> > > Software node maintainers: if this versions is good to go, can you=
 leave
> >> > > your Acks under patches 1-3 and allow Philipp to take it through t=
he
> >> > > reset tree, provided he creates an immutable branch you can pull f=
rom
> >> > > for v6.19?
> >> >
> >> > Now that -rc5 is out, could I get an Ack to create an immutable bran=
ch
> >> > with this series on top of v6.18-rc5 (and merge it into reset/next)?
> >> >
> >>
> >> Hi Philipp,
> >>
> >> I assume the Reviewed-by tags by Andy and Sakari under patches 1-3
> >> make them good enough to go in?
> >
> > I assumed I also need an Acked-by by Greg or Rafael.
> >
>
> From MAINTAINERS:
>
> SOFTWARE NODES AND DEVICE PROPERTIES
> R:      Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> R:      Daniel Scally <djrscally@gmail.com>
> R:      Heikki Krogerus <heikki.krogerus@linux.intel.com>
> R:      Sakari Ailus <sakari.ailus@linux.intel.com>
>
> Looks like neither Greg nor Rafael are mentioned.
>

Ah but also:

DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
M:      Greg Kroah-Hartman <gregkh@linuxfoundation.org>
M:      "Rafael J. Wysocki" <rafael@kernel.org>
M:      Danilo Krummrich <dakr@kernel.org>

So depending how we look at it. Greg, Rafael, Danilo: can you leave an Ack =
here?

Bartosz

