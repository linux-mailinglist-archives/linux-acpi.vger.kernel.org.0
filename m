Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E260079B1BF
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 01:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbjIKVSy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242655AbjIKQDp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 12:03:45 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB301AE
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 09:03:40 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c07e122a78so3304996a34.2
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694448219; x=1695053019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjGgx/qsfESzch376+5oi8LKtc3yIfVpyjdNPeJr0YM=;
        b=IqgKLwGHB2c+YOvo309pWtvFau9RpYk+a8TJKUlD7mRl2RA4g7IZlH+Owv6dP1BcJe
         5ifNfwqe9rhbB6utXjARlKAMZwuaLO2FzoSXkEuL530YIbMr9WB2oZfCqknJ+k+4gnc9
         33CjhoN5Md0sD1cpFVFAS8QbD7IcLE/2qFXZzC8pPLpfO0a6cAw/QXJdchF7S+jPvXWa
         Bz/nGTX0Ki2RFGSnr/2DlvaTZaIhClNi24FThlEEP2Ky9pJ72MvXMYzJg9XBQpSGz6XM
         x6qV9tuiWtYpuuHVcEKDOkiN0YzpCN7Eyzv1Cw63e2jX+u2lGjO4b2mLt0B4Kelg33tr
         4jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448219; x=1695053019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjGgx/qsfESzch376+5oi8LKtc3yIfVpyjdNPeJr0YM=;
        b=pUz5yyh0DcattInZiK8oSNVYLmTk5kcWYin8Sm8qRhflaMDgqMeRn1YBxmQV/2oY/n
         u0GaePQqSfwszP8E5K/nJJx9yGnhCCwQoCH2YiJ6WbpsYnWTmZEe8wU/gNspMBDqNNbS
         kRsFTCalnXMoiAQwSmq8bcvqTfeOhrYIXoOADb96f/42CU6aTLj0I2jp+dhOlGThECdS
         4LTR5DY/vVQFD1RNFG1C3hvJCxfuRUduPL5R+/35rxvQ2os0k8cJH4cSVmempMkQ9/5B
         9d67Vpka18BVqoeB+LgmfOOIfzPHTL7DabTDMG8GdJboY4SdD5IEZHWgULAqMkfiQFto
         v4zg==
X-Gm-Message-State: AOJu0YyH6frPqe+yIQIv1nTH2XPLaXFTe3xsQ13Fu+32FvAhOJgQaiXi
        Cp/VtTP8PHz3Ln1JR0bu3LMq5LbRmFT6nGiHr6k3uw==
X-Google-Smtp-Source: AGHT+IF1yXG5te+VZENGbmsEJ8NJo/z1jgMv5tj0n2Ra074S3+aBtzRPFr249Z8LfT2JGb3cLSR9ZERaLrPdqnXjwtU=
X-Received: by 2002:a05:6808:a1a:b0:3a7:53a8:aed2 with SMTP id
 n26-20020a0568080a1a00b003a753a8aed2mr10695492oij.7.1694448219432; Mon, 11
 Sep 2023 09:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-7-hdegoede@redhat.com>
 <CAMRc=MfeKirks7N7scu+dh+M1Nf0bNxzC7PE2Q7J4bxgpRnECw@mail.gmail.com>
 <0b1e0312-9144-85ed-666e-a84110b26418@redhat.com> <CAMRc=MfVZCqc-v+5oMkTkhfLvq1pE66E7GykqT2ymxzS_kw83w@mail.gmail.com>
 <01a85a3d-c888-11d8-f47e-be2a26d0cb9d@redhat.com> <CAMRc=MeGRreVVz=tCnEWtvixV+ZNEXXvG5SVRRmmnWG_sawMcg@mail.gmail.com>
 <bf866db7-1231-2fd6-eedf-b287ca4fa1b8@redhat.com> <CAMRc=MdXLBnjFPE8Ac9tFQj6BXEyV6kRyDFNytsdQa++Yk6suw@mail.gmail.com>
 <22698b72-b293-9ad8-908f-f6aee85430d7@redhat.com> <ZP80AKHkUyFP7B06@smile.fi.intel.com>
In-Reply-To: <ZP80AKHkUyFP7B06@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 18:03:28 +0200
Message-ID: <CAMRc=MdyZs7bPSnrKJDi388kjKZnA3vHLEa9unqboiSHwNa=Fw@mail.gmail.com>
Subject: Re: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using gpiolib
 private APIs
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 11, 2023 at 5:36=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Mon, Sep 11, 2023 at 04:12:00PM +0200, Hans de Goede wrote:
> > On 9/11/23 16:04, Bartosz Golaszewski wrote:
>
> ...
>
> > >>>>>>>> +       lookup->dev_id =3D KBUILD_MODNAME;
> > >>>>>>>> +       lookup->table[0].key =3D chip;
> > >>>>>>>> +       lookup->table[0].chip_hwnum =3D pin;
> > >>>>>>>> +       lookup->table[0].con_id =3D con_id;
> > >>>>>>>> +       lookup->table[0].flags =3D active_low ? GPIO_ACTIVE_LO=
W : GPIO_ACTIVE_HIGH;
>
> Actually you can use GPIO_LOOKUP() macro here as it provides a compound
> literal.
>
>         lookup->table[0] =3D GPIO_LOOKUP(...);
>
> > Therefor I don't want to / cannot change the hashes of the commits,
> > so a follow-up patch it is.
>

Which makes me think, I should have used it in my SPI patch...

Bart
