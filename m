Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E98F578018
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jul 2022 12:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiGRKsX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jul 2022 06:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiGRKsV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jul 2022 06:48:21 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA301F2E2;
        Mon, 18 Jul 2022 03:48:18 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id nd6so8432805qvb.6;
        Mon, 18 Jul 2022 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=odInwset3JtekyfvwHYQ7Zjgrovk0OVJ1s+jC7toYFw=;
        b=LjW3HvpT+uww2s2o3355LRaTe3zeVKWpHflAEtPcwJkQt04/lqcHRGoDlLS08hwCk0
         hWg15EuDX08T0uC6JlIM48KTXBafqnCr82QwSLf55QIonwrrE6J27rk2SoH5BOMHv+8B
         TQJ9O6CKDjJN90uvXU2s8EQ0NYJ8m/PJNxBx92FA8yUxdR8Jd59bLUisXsqyFOnwjMU/
         O03iwUEPR23CAo2yGI2Uq4Yrq6FlY8tyaFcuLOfMQOxteL6oC0g84m397Kt4fST3aA/x
         7v2p1RYGYfN1zQdqQt3y9HScqM9kUBGxTCPxe/f1I8A3RpqLnFC2pVFLfLH3Om8v3Lc/
         hJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=odInwset3JtekyfvwHYQ7Zjgrovk0OVJ1s+jC7toYFw=;
        b=OzztLjVYSoy/qHJttKu7RBs66E54FVHh8XC62wKarVmtzU59fuOecXDJINmD/AIvLA
         GghUeBiWYP70nbBpBTyNwVjnlVr5uHgpzeFD56/n2/FX2l0dfOi8V7CvjuKRMr83P4hk
         F8s1hzqgbh0JcN9XN8kuQrNe3LGS4YQX9HpQlXVBLIeRZGtbyb6o0EKjwiSk/qIcOguw
         DAeOZ6lbqb/+4JTHi7XnFfxxvU4fgU/dCYPOMRCtq3rNFASkozLdjTPfyoQ1FYNOACXJ
         Zv3+WRohUlAHu3KX6HobA8BBClDxFsfAwZ9PT9srGnI5xtLKMJfEdKbOmeitIaCGThtn
         ibCA==
X-Gm-Message-State: AJIora//dXnACX9Ps2VKI5Rb63N2kFI1AUwyXpkdBe6EJSKvpFz/I1/s
        tiG3rw1/VjnPtIrqkysRztIiKU4hXex/Ib3Z
X-Google-Smtp-Source: AGRyM1vzwysDmuzG+cF+FcZfHt6F5DwRuJ9Qdt73Z2c6zAb0Fa+XaeXhNT+gqI+qSQGFCtB5lolBjA==
X-Received: by 2002:ad4:5be3:0:b0:473:4914:d912 with SMTP id k3-20020ad45be3000000b004734914d912mr20247040qvc.0.1658141297735;
        Mon, 18 Jul 2022 03:48:17 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id y7-20020a05622a164700b0031eeecd21d6sm2182327qtj.69.2022.07.18.03.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 03:48:17 -0700 (PDT)
Message-ID: <8461b72ae951e4311952052c467fb1275ff9e58a.camel@gmail.com>
Subject: Re: [PATCH 3/4] gpiolib: acpi: support bias pull disable
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 Jul 2022 12:49:19 +0200
In-Reply-To: <CACRpkdbitDErSCMbKFe0yZB63+uTGwt5ROMbEV_iAPck_RN7sg@mail.gmail.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <20220713131421.1527179-4-nuno.sa@analog.com>
         <CACRpkdbitDErSCMbKFe0yZB63+uTGwt5ROMbEV_iAPck_RN7sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2022-07-18 at 12:32 +0200, Linus Walleij wrote:
> On Wed, Jul 13, 2022 at 3:13 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > On top of looking at PULL_UP and PULL_DOWN flags, also look at
> > PULL_DISABLE and set the appropriate GPIO flag. The GPIO core will
> > then
> > pass down this to controllers that support it.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Do we have a semantic check that PULLDOWN and PULLUP
> is not used in combination with NOPULL here?
>=20
> (We should also be checking that PULLDOWN and PULLUP
> are not used simultaneously but that is an unrelated thing.)

I did extended this check:

https://elixir.bootlin.com/linux/v5.19-rc7/source/drivers/gpio/gpiolib.c#L3=
948

on patch 1 to make sure that PULLDOWN and PULLUP are not used with
NOPULL. Is this what you have in mind or is it something else?

- Nuno S=C3=A1
