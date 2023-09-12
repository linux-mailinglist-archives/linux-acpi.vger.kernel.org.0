Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0281A79D023
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 13:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjILLhA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 07:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjILLgU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 07:36:20 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE2F10D2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 04:36:15 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44d526f96fcso1852658137.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694518574; x=1695123374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkyklPGDuv9m5eJqTo8UfIe+p8AQ+CPh9TqWA+xsEsY=;
        b=wQTszuIMQLqrfdVybcFJLEEqKjTf+mFLz9rmPB4pt5UJBu7W4odbVJ9UlHzpK621nz
         QzBRKcEVWLy1FMoM0CBNF63zsuLG1Giepxg+qYJaHp/KFErvCDMrcxFmVzIfWt8wbaXC
         04jxxfILo8JhAD6bSFAkD9GKFln5QVNgcrD7048ehzzQuPUp4Nq/T/uu786s3dBTOKSM
         o5IIJjKhLpJJncEXO95GM+U1AfO7Qoe5lsJSv61oc0BJEnIj6t3DtMpTkNIq31wbLYRu
         BAcrgKCE2Wx67KAue+ISWAMSjKBf2Uh4QR/XbjTLFuDerWmGbrwlgjaPnoqMfPh/kdpV
         JTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518574; x=1695123374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkyklPGDuv9m5eJqTo8UfIe+p8AQ+CPh9TqWA+xsEsY=;
        b=NkHRkqtT5lAJ4FvqafrhW+GvGv1B7q0VbW8it+PDt1QekbRfIC8qiXERTgPtbZlLnd
         ju9KjU3+WjM7eYlHvkcWmuc5y8u9eKDYEQPJlh3mNBWMWleJ2gfXEYv3yYFUQP21PO5o
         HjLv244MBQA4M5eJmBNgXTr8S5h/sEVipk+aOX7roubocFI+QhjQ5cLaeTGRMIAWQYEs
         RVfQe4YWnizpdlVbRkCNQGgbmOSOwzP+YDcfgQ0/tLmARR6Ie2qRRBNktKQbsi2Fk3hc
         NkohcCN7dO2dxdZjlTY2NFPnSR95sEBrLzwRA2ildQLZhlNAtZ6zW0cNE1Uwu0pIH3pI
         ReWQ==
X-Gm-Message-State: AOJu0Yzw+fgJtIiAFXM+CyU4rUolYpRfH7wrT6V5t6qk7FXnkOn5aPh1
        8TeV99412Tm+U/PtW5wJn1Oxsda40ZZTCH1HdOfBiQ==
X-Google-Smtp-Source: AGHT+IGjfDBklMzue4PESJ9TiuKC7nGDQU+XSLUDl1gzCHaxB4VVGDKYWL2qRjaBXpLHqpNzIl9sXX+QT4/jkbxyKeU=
X-Received: by 2002:a67:e957:0:b0:44e:9219:136c with SMTP id
 p23-20020a67e957000000b0044e9219136cmr7663297vso.15.1694518574363; Tue, 12
 Sep 2023 04:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230912100727.23197-1-brgl@bgdev.pl> <20230912100727.23197-3-brgl@bgdev.pl>
 <ZQBMhAAgXw0LYa0Y@smile.fi.intel.com>
In-Reply-To: <ZQBMhAAgXw0LYa0Y@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 13:36:03 +0200
Message-ID: <CAMRc=MdRVJyh-4qS3OVXEFNoMJ6YSAcz7Qs876PWQfiho8hvaQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] gpiolib: add support for scope-based management
 to gpio_device
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 12, 2023 at 1:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 12, 2023 at 12:07:18PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > As the few users that need to get the reference to the GPIO device ofte=
n
> > release it right after inspecting its properties, let's add support for
> > the automatic reference release to struct gpio_device.
>
> ...
>
> > +DEFINE_FREE(gpio_device_put, struct gpio_device *, if (_T) gpio_device=
_put(_T));
>
> Looks like this should be
>
>         if (!IS_ERR_OR_NULL(_T))
>

Good catch, thanks!

Bart
