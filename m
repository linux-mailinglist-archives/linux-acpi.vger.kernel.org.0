Return-Path: <linux-acpi+bounces-428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF417B8A50
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 20:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 8210FB207D4
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0D1D68D
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QX8u5bIB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471101D522
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 18:22:55 +0000 (UTC)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18018C6
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 11:22:52 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49d8fbd307fso75262e0c.3
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 11:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696443771; x=1697048571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93ffs6Ol2kMcPT/3DmQKAdiDLS9hn1pGsiSqatK8OJs=;
        b=QX8u5bIBIm77lZwle8EKqVte+Um4sgbLiC27cdfDk8Lpq9oZWaskA13unqAFvs+2n/
         pMrrEj6M5LiUKDuxbitr6hrVii29XJZku55RVANvhaUR94+VEsYOBn0/a1Cu+Pj4i3ui
         cTLDs1hTe2dwFzzpIW5UvjGM9cF/q5/O6d/hehXXp9xpuQAy5omhNJnwOyxfkDCThGqy
         360uqpLFbQd2Kaq28pkMjsXgpt74WL5jE5xNJ9UcYjx0ebSKvW/6LmH5MoulLVCuBzXz
         h4dxjPRKYsFcIYSBDxh2osRZiDJLYojdh7hLEzhEuEPuFdyBJR5UnWbEURcPxfG19eGy
         VzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696443771; x=1697048571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93ffs6Ol2kMcPT/3DmQKAdiDLS9hn1pGsiSqatK8OJs=;
        b=odUkliVeBEWxy/ZPLoP/vuL4zC89+akg2HURCxPIqFHTEqQcdLtYtDQ8pwlVvrwfv5
         yH6N54et5ZpqZwbtFwbiJNtZ+GJCec9J3mgkLIeaOt5p1v/+sT35VCurp65Qw8g8n64r
         fH0+KLFfcNRFJuCFyvwMqruBDT/LXk8909EUXY/CKWn+hRD05F0PGjEIWIj+TWHGoO2G
         eiX0nj2Tt4IFQ3JYkeEQjx4hpVDH5rCf8AqwqKtqXUxL1M3syFbFDSvUfST1BncrvvL2
         kjNRnwV1DfztWXzqD9acoHfnMVy7Ezf7VR2NBYwIQdJSScxvG2yn9HGGlEUXLHPOa0Y7
         cATw==
X-Gm-Message-State: AOJu0YzLQNVqIEiVFs6DIcs82gqrg8yYjvmsf283A4EMEOqXBf/Hcn9j
	TaAUSDLK0+35rtGu7YM1Cs1wiBxy40RNJyBQmrHVPiKwbze22VJP
X-Google-Smtp-Source: AGHT+IH5gfj/VOy9TkmlkSdFeXfKzCyMWsO4ud+J31ASiJwEdF+EsTzjobW7bcCpu3bJnjcZ82GU/waoIOzaJPaa1A0=
X-Received: by 2002:a1f:ca83:0:b0:495:c464:a2fe with SMTP id
 a125-20020a1fca83000000b00495c464a2femr2877473vkg.2.1696443771162; Wed, 04
 Oct 2023 11:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926145943.42814-1-brgl@bgdev.pl> <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
 <CACMJSetWH=Z5ubHb33W0mYvpqkU7vv=nKNBSa9eLmAi94NyrgA@mail.gmail.com> <29764d46-8d3d-9794-bbde-d7928a91cbb5@redhat.com>
In-Reply-To: <29764d46-8d3d-9794-bbde-d7928a91cbb5@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 4 Oct 2023 20:22:39 +0200
Message-ID: <CAMRc=MfM+2MoeUvqGMJ3hjpg0Y1jHH2FwMTEN3o-JiCugiDXTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] platform/x86: int3472: don't use gpiod_toggle_active_low()
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 4, 2023 at 6:30=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi Bart,
>
> On 9/28/23 20:40, Bartosz Golaszewski wrote:
> > On Thu, 28 Sept 2023 at 14:40, Hans de Goede <hdegoede@redhat.com> wrot=
e:
> >>
> >> Hi All,
> >>
> >> Here is a v2 of Bartosz' "don't use gpiod_toggle_active_low()" series.
> >>
> >> New in v2:
> >> - Rework to deal with ACPI path vs gpiod_lookup.key differences:
> >>   acpi_get_handle(path) -> acpi_fetch_acpi_dev(handle) -> acpi_dev_nam=
e(adev)
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >> Bartosz Golaszewski (2):
> >>   platform/x86: int3472: Add new
> >>     skl_int3472_gpiod_get_from_temp_lookup() helper
> >>   gpio: acpi: remove acpi_get_and_request_gpiod()
> >>
> >> Hans de Goede (3):
> >>   platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() helpe=
r
> >>   platform/x86: int3472: Stop using gpiod_toggle_active_low()
> >>   platform/x86: int3472: Switch to devm_get_gpiod()
> >>
> >>  drivers/gpio/gpiolib-acpi.c                   |  28 -----
> >>  .../x86/intel/int3472/clk_and_regulator.c     |  54 ++--------
> >>  drivers/platform/x86/intel/int3472/common.h   |   7 +-
> >>  drivers/platform/x86/intel/int3472/discrete.c | 101 ++++++++++++++---=
-
> >>  drivers/platform/x86/intel/int3472/led.c      |  24 +----
> >>  include/linux/gpio/consumer.h                 |   8 --
> >>  6 files changed, 93 insertions(+), 129 deletions(-)
> >>
> >> --
> >> 2.41.0
> >>
> >
> > Thanks Hans, this looks good to me. I'd let it sit on the list for a
> > week. After that, do you want to take patches 1-4 and provide me with
> > another tag?
>
> I have just send out a v3 to address Andy's remark about me
> somehow resetting the authorship to me on 2 patches from Bartosz.
>
> While working on this I noticed (and fixed) a bug in:
>
> [RFT PATCH 1/4] platform/x86: int3472: provide a helper for getting GPIOs=
 from lookups
> https://lore.kernel.org/all/20230926145943.42814-2-brgl@bgdev.pl/
>
>         struct gpiod_lookup_table *lookup __free(kfree) =3D
>                         kzalloc(struct_size(lookup, table, 1), GFP_KERNEL=
);
>
> You are allocating an entry for the temp lookup, but the gpiolib
> core expects lookup tables to be terminated with an entry lookup,
> so this should alloc space for 2 entries:
>
>         struct gpiod_lookup_table *lookup __free(kfree) =3D
>                         kzalloc(struct_size(lookup, table, 2), GFP_KERNEL=
);
>
> Despite this already being fixed now I wanted to explicitly point
> this out in case you have used the same construct elsewhere during
> your recent gpiolib cleanup efforts ?
>
> As for your request for a tag for the 4st 4 patches for you to merge
> into gpiolib. I'll go and work work on that. I need to coordinate
> this with Ilpo, with whom I now co-maintain pdx86 .
>
> Regards,
>
> Hans
>
>

Gah, thank you for bringing this up, I need one fix for a SPI driver.

Bart

