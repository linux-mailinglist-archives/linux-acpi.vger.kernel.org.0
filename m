Return-Path: <linux-acpi+bounces-417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECFE7B7F2B
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 14:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3241A281899
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F313AD2
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:32:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13117134CA
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 12:01:11 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEABBF
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 05:01:10 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-4525dd7f9d0so886201137.3
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 05:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696420869; x=1697025669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VxF9d0mojGG7o4cVpSUHCY76AoqXAbBRiV4n80jKEw=;
        b=oHwv6/DPYak/DiW3035/fi4o8vRulpJFL0nXAb1L5f5gW1bFQLIyz8cbFCYnMHUseq
         8x9SmHPE79FkiEj1M7fKZX3HEpq2T7M9fzoC720BtQVXC5zw8PsjPWRMPzK/ZCQ6/nhJ
         7MYHuApyLSVuLlJL7NaJ1dM2Q0R7TcVaEXQvH8YZSqHKKW6Sf7mUv6leK8FRU3rgHxVl
         S1ETvyihTnfD0chxYCSydvEmqQx1RJVPrNzRZPoHNiTTtYU5giP8d33q1Aisrjq3Viyx
         ajhhPkb+txsnhHvKJvp7PH+lbVkPjUQpwaYmMVgrFq0Ts+E/q/01c/zTSj+tCi47R95Y
         bzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696420869; x=1697025669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VxF9d0mojGG7o4cVpSUHCY76AoqXAbBRiV4n80jKEw=;
        b=nLAnv7nEa04uQ+9Q2wZjtnlWY9vex/8tN302BAh5TG1LhHMSIVYOBrbClfuj7hOhbC
         PhGeXvwc5a04LBc5mQhDKxTalO3LQuXjI/aC2evem63nlgH6CsDgYqQDY2rf/zipNvhK
         qBmdiWcvozzz8vO9meVrqijts+9UBOfO5hCFG/naCPG3T06H6OcyDCz6K+dUuRsWKQl0
         mMMnhvT9WHdDkXCHGvSPiv3spPoaiEXYBkG87uhkAfMahDfdFnRfmNanfg9awvNfFlCf
         lbjs9nVq2EtXCNtRpHVvwxQKdwhm5V6ogGiDmDnXtculg42+u0SwlcdxaptnDll+aDYf
         hxkw==
X-Gm-Message-State: AOJu0YzZj8QasP17oe2wpKaCCESTMFhpQ6btwsGaobrQsMOYCN2YYchU
	u/daP7PIx615VM9iXSpwbYtuYUlKIGI1ki8LVT1EEw==
X-Google-Smtp-Source: AGHT+IEx3AgtVmbiogi6y/J2HxxHzWhr7s02jCF0ZQyoHV8FsEEVFDac4kKEaiIaQ5/oedvf5e19/1rxUgniaHEkusM=
X-Received: by 2002:a67:efc8:0:b0:44e:9afe:c5b9 with SMTP id
 s8-20020a67efc8000000b0044e9afec5b9mr1545555vsp.23.1696420869527; Wed, 04 Oct
 2023 05:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-15-brgl@bgdev.pl>
 <CACRpkda9=VULj4Cy_sit-UpUQnVEbS-RJKAeULVCw8ZCRTq1sw@mail.gmail.com>
In-Reply-To: <CACRpkda9=VULj4Cy_sit-UpUQnVEbS-RJKAeULVCw8ZCRTq1sw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 4 Oct 2023 14:00:58 +0200
Message-ID: <CAMRc=MdTk1B4MEh9C624Upm_EcaQgJd9OU-AGfU0G-DU1+qk6A@mail.gmail.com>
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
To: Linus Walleij <linus.walleij@linaro.org>, Dipen Patel <dipenp@nvidia.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, timestamp@lists.linux.dev, 
	linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 9:28=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Using struct gpio_chip is not safe as it will disappear if the
> > underlying driver is unbound for any reason. Switch to using reference
> > counted struct gpio_device and its dedicated accessors.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> As Andy points out add <linux/cleanup.h>, with that fixed:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I think this can be merged into the gpio tree after leaving some
> slack for the HTE maintainer to look at it, things look so much
> better after this.
>
> Yours,
> Linus Walleij

Dipen,

if you could give this patch a test and possibly ack it for me to take
it through the GPIO tree (or go the immutable tag from HTE route) then
it would be great. This is the last user of gpiochip_find() treewide,
so with it we could remove it entirely for v6.7.

Bart

