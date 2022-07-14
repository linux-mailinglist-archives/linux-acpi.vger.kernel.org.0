Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A51574806
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 11:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbiGNJNh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 05:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbiGNJNg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 05:13:36 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F231B1;
        Thu, 14 Jul 2022 02:13:33 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 6so2146006ybc.8;
        Thu, 14 Jul 2022 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nD+0N5Ck5WL/nVS2PgpANbQsU9EZRR9EBSE+SFbkBOM=;
        b=SVYi8kUQWW22wxu91LW3l/SArgfjTfGT3AneCppkhpJYvcXEPOpgEIq3f691NGt7IU
         2g09GZJA/JMgDR2IjkPFdYUSOkS7ScfWsMNIFn8V0PM2Qcj0D1wxxjTo8S5YXrdUczKl
         nXePFW2cfbYCap+LM6vc4hU4KLCHyJobwWqhXIqXx0MR7CRMZUDTlu6hVyKDjD7h/ZYA
         DfzjfhVrUfEGHLtR9uMR99M8i3NL9jP6srLI1DRZl2MYJgiF7Z1jmQNUXgjytnWv1KVO
         iNDp1eingY42qNiLFBPV3y/CiYV4lG4qWTCAHZ75OLig1JY64EA/4RDmj9hvnVX7g1KH
         wCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nD+0N5Ck5WL/nVS2PgpANbQsU9EZRR9EBSE+SFbkBOM=;
        b=1bMTU54Ej2uPpQoAMnGnHDf80BCb5uaIcNv1s959/kltgRe9risxt9pYCH9/wAN1Dw
         eq9/rmB1YOke6BgjerVRZMhOt8WH8lZ/8lehjqfdtACKLS5VjQPo+Uz/ciJ96ghDmn8V
         u71dlMFGoJ4LU6dIkTDL/Tjm9fkhe4URO58TXtq7bR8/Nh/Z5+81ExVYuR1LXCP8TsgS
         QmahW466JxTfuqpOtM4gT72eLPJSYrIBs8BORT4QxerMnp5hKHVKIk6LiwIv6u6e+RYz
         asiTeMTk3QbYpXwC6cKQbCYQNLqprJS0ThdUIN8pCp0gnXIJVE6ZtgDZdgfMeeyYuQdg
         kTUA==
X-Gm-Message-State: AJIora9m8xBfiJIkt959F4unmvQy7bMcIuiPkSCwTLJaSipYEMcTqtDn
        m0PcA+pgzSgPopeosSyzVyWC5gzFk/cW8lpSatg=
X-Google-Smtp-Source: AGRyM1sQvn80/A2vNEn15Jx0WTcdl/AG57MJXn8FJjNjYk2q/1eOKyXJ13qX1UVQuk740CM3kPLgoefYDufOeT/l0zc=
X-Received: by 2002:a05:6902:686:b0:66e:627f:4d29 with SMTP id
 i6-20020a056902068600b0066e627f4d29mr7114482ybt.385.1657790012251; Thu, 14
 Jul 2022 02:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220713131421.1527179-1-nuno.sa@analog.com> <Ys8DPCzRa1qo2AKJ@smile.fi.intel.com>
 <62ccf0c91d32df557a2bc91c45adb45593302534.camel@gmail.com>
In-Reply-To: <62ccf0c91d32df557a2bc91c45adb45593302534.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jul 2022 11:12:55 +0200
Message-ID: <CAHp75VcEBE3kMDi5Q+89GmS9V=aF+pOcyROY9MdfyB_5OaruPg@mail.gmail.com>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 14, 2022 at 9:10 AM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> On Wed, 2022-07-13 at 20:39 +0300, Andy Shevchenko wrote:
> > On Wed, Jul 13, 2022 at 03:14:17PM +0200, Nuno S=C3=A1 wrote:
> > > The gpio core looks at 'FLAG_BIAS_DISABLE' in preparation of
> > > calling the
> > > gpiochip 'set_config()' hook. However, AFAICT, there's no way that
> > > this
> > > flag is set because there's no support for it in firwmare code.
> > > Moreover,
> > > in 'gpiod_configure_flags()', only pull-ups and pull-downs are
> > > being
> > > handled.
> >
> > Isn't it enough?
>
> I might be missing something but don't think so. Look at this driver
> which seems a lot like the reference i put in the cover:
>
> https://elixir.bootlin.com/linux/v5.19-rc6/source/drivers/gpio/gpio-pca95=
3x.c#L573
>
> I just don't see an in-kernel path (I'm aware now that we can get here
> through gpio cdev) to get to the point where we want to disable the pin
> BIAS.

Ah, that driver should be converted to pin control. It's definitely a
problem with the driver.

But let me look into the library code to understand better what your
point is in general.

P.S. Pin muxing has nothing to do with the pin control, many (I guess
more than 90%) of GPIO controllers do have pin control features.

--=20
With Best Regards,
Andy Shevchenko
