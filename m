Return-Path: <linux-acpi+bounces-2526-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C081709D
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Dec 2023 14:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077961F23260
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Dec 2023 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB43129EF7;
	Mon, 18 Dec 2023 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G7YmeNJN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F77129EE6
	for <linux-acpi@vger.kernel.org>; Mon, 18 Dec 2023 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4b6dc0080f7so87431e0c.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Dec 2023 05:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702906681; x=1703511481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7/HSEoWUiPX3oPiGjdRAm9msxrJboMutH8zCgBm4kc=;
        b=G7YmeNJNkp7dPXd3m7u9ka2oEJdR7Ts2LPcMSbjq0tUwuRU4wTsTEcUrndmljdlRgB
         X1frRtI3HRTsuJ8WaKEuAaZ1QujcdQ9pwX+viOZFPU6S675CxayYogG4dLxYnrUxOIxk
         ztDsWXzCIpj4xFBtS54/IPlKbc090UqbnnFlHUODGgpCfAXO/U2k0nbUzoDH33cLtdVu
         3ejUwm30L6IYAd1S3NAKbE7/NJm90iJj3QU+SMEMVKV8qbw1JbrNK/xzm2pXv0EryvPU
         OgyAWZQ5/7pzkEzMsKviBOEY937V36YmggXuImDiCOuNxA48qCPkE1iP8S/B35tQbe/7
         Jqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702906681; x=1703511481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7/HSEoWUiPX3oPiGjdRAm9msxrJboMutH8zCgBm4kc=;
        b=f+q9ZiOEwoCA0riQgD7mqRl5LpKAbUAgg7oOchL7vVbhdHKamFS0pGdB6DFn1piFZC
         kY0Tw0szWGze1EDNUD70A4P9oDK7vv3ktgqXriNfJ1X7XJEZg4krNeCY/+FIPizf/ZyR
         Z7/8EW+p16IT8lqS3kLn1aO+XurXaylz2qY0VPxgfvBWAjQp+8CdrcRjwqWAisteB+Mc
         imWk+747IImNbliXCcrHBjq+7N5QjA0yQZKQCoX4S+FQhtkHQ5OsozzOx2YSJETwnjd6
         sKjnzCh+dui8fS78A5xeprBT0uLlHDSX+mbY+yWG5rVrWDWFD89a8c6Dvx9t9+QF2Auk
         uJSQ==
X-Gm-Message-State: AOJu0YwU+5+HjgSWEUX7dbJGO3wC9jdL04BnPc50Mfa+lXoO+VnuqHQ0
	BGQ6ddFhcQE4RhZHvrqxhtIskFGj+yoGywI1HnF3HA==
X-Google-Smtp-Source: AGHT+IHGOmkzLosVMFpAId8QDQkN/D3WS1NE2rrsuRg5qtMabd5LmSLFAYjKn3K+ctGA41jHAhESWi54xrSKmIEmEzU=
X-Received: by 2002:a05:6122:4b0f:b0:4b2:c554:dfcf with SMTP id
 fc15-20020a0561224b0f00b004b2c554dfcfmr10820006vkb.30.1702906679298; Mon, 18
 Dec 2023 05:37:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MfZm7TDHRRLrDmnyj3vmbscmpveR0fveYfsGz0SdaskKw@mail.gmail.com>
 <ZYBKn9UZIhY03DiV@smile.fi.intel.com> <ZYBKxv_M23j0k_K-@smile.fi.intel.com>
In-Reply-To: <ZYBKxv_M23j0k_K-@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 18 Dec 2023 14:37:48 +0100
Message-ID: <CAMRc=Mcu4H12pV0rT4OXLsaEShn4r9XM2rbQ1VK-SmgxwidWUg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] gpio: mmio: Make driver agnostic
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 2:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 18, 2023 at 03:35:28PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 18, 2023 at 01:43:40PM +0100, Bartosz Golaszewski wrote:
>
> ...
>
> > Thank you! I guess you forgot to add --sign-off to the `git merge ...`
>
> Sorry, it's --signoff.
>

I never sign-off on merges though, is it mandatory? Probably not as
there are no warnings from next like for regular commits about missing
sign-offs.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>

