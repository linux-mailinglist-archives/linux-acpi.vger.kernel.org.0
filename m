Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96BB5746B1
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 10:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiGNI1T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiGNI1T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 04:27:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCF73A4B8;
        Thu, 14 Jul 2022 01:27:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s21so2061524pjq.4;
        Thu, 14 Jul 2022 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ztLGCCkeV5a/XGyTeDizFV1wTs7Q1XqL0o28KlXFm1A=;
        b=OP356JUOP4fH/EjFvx32+QeVDXJX3zqAWbFdU/G2Wvf0kj/dFRdbtVMjvP+UK4T/yI
         THFAmvatCl6qNRVrf5IX7xbbZ9vrMJjbqQM2YqEu42uPxuRWWDxYhDdFVmd4T6s459YG
         UnFOFVFnhTrKwjAwmJPJnchXn7o/6tcXBa4jRh6j6nBPUmpSW/l+IhQe/CgtDm1rlk0I
         k1UF3mO8me4Vt1wJ9wRHWIK/fhyTYllRlLAL+58cSAnlMvvPSB8f59CnM0L/zN21XV1e
         X17mL1sTP58mFbGSAS/hoXKGCTgN/FVM48TMDbZkb5p/gbqN+p3Di782HR2nvbBT9/tD
         9z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ztLGCCkeV5a/XGyTeDizFV1wTs7Q1XqL0o28KlXFm1A=;
        b=5dzcKAuILYzMX0+edXuPTiDNgsNniv++ExJAGQNGv99YsXRjwNYNRVlCHs40rqxUeu
         qGezN5JRG/F/iGU21RjB0+zGg3gEqHIcXPNT+kE3RmGYU1ZZ9CnOTOt8Xqj80Qy3B9LK
         m0QTQ3FTWWByzrvH9txcKr3LoW+PSiTFyHYqxTXSZYIztDXwLoUCTtCz06OmeWg5WQrk
         wW66HJ8cPjNmfWeeaibibvrgwf0DeGAb26R32dHAZgNX0YGWFXl05tPwrBuLoH4nEjy5
         cdAWT6DH5uX7xK7ySIEW9CvFsimmF1Kk2IIoCetVgg0bJH3X5wd6F9naZ/WH7ZlL6y9b
         uCzQ==
X-Gm-Message-State: AJIora+UI+yEG4H8nqb9KVuMoEtva5ioRM1jUlOoe/YeBz2/RfxDwZ2m
        qOgfiO1F1q5adkPOqBd4CsQ=
X-Google-Smtp-Source: AGRyM1uHpx3R8uNmwJ+NPocgX8uue42O1EV83C6B5plCAuCvdarosMdVhFfTIvtO2pFzDpuG8lT01A==
X-Received: by 2002:a17:902:d50b:b0:16c:474:ce67 with SMTP id b11-20020a170902d50b00b0016c0474ce67mr7498995plg.112.1657787237704;
        Thu, 14 Jul 2022 01:27:17 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090322cb00b0016c33dc879esm828518plg.113.2022.07.14.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 01:27:17 -0700 (PDT)
Date:   Thu, 14 Jul 2022 16:27:10 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] gpiolib: add support for bias pull disable
Message-ID: <20220714082710.GA103849@sol>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
 <20220713131421.1527179-2-nuno.sa@analog.com>
 <Ys8CpqYhWp7zVNC8@smile.fi.intel.com>
 <20220714042050.GA76737@sol>
 <4bf06ba5994f559499c45275cd7f44bfee1bbde1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bf06ba5994f559499c45275cd7f44bfee1bbde1.camel@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 14, 2022 at 09:14:21AM +0200, Nuno Sá wrote:
> On Thu, 2022-07-14 at 12:20 +0800, Kent Gibson wrote:
> > On Wed, Jul 13, 2022 at 08:36:38PM +0300, Andy Shevchenko wrote:
> > > On Wed, Jul 13, 2022 at 03:14:18PM +0200, Nuno Sá wrote:
> > > > This change prepares the gpio core to look at firmware flags and
> > > > set
> > > > 'FLAG_BIAS_DISABLE' if necessary. It works in similar way to
> > > > 'GPIO_PULL_DOWN' and 'GPIO_PULL_UP'.
> > > 
> > > ...
> > > 
> > > >         GPIO_PULL_UP                    = (1 << 4),
> > > >         GPIO_PULL_DOWN                  = (1 << 5),
> > > > +       GPIO_PULL_DISABLE               = (1 << 6),
> > > 
> > > To me it seems superfluous. You have already two flags:
> > > PUp
> > > PDown
> > > When none is set --> Pdisable
> > > 
> > 
> > Agree with Andy on this.  The FLAG_BIAS_DISABLE was added, by me, to
> > allow the cdev interface to support bias.  cdev requires a "don't
> > care"
> > state, distinct from an explicit BIAS_DISABLE.
> > The FLAG_BIAS_DISABLE allows gpiolib-cdev to communicate that to
> > gpiolib, without altering the interpretation of the existing PULL_UP
> > and
> > PULL_DOWN flags.
> > That is not an issue on the machine interface, where the two
> > GPIO_PULL
> > flags suffice.
> > 
> 
> I see, but this means we can only disable the pin BIAS through
> userspace. I might be wrong but I don't see a reason why it wouldn't be
> valid to do it from an in kernel path as we do for PULL-UPS and PULL-
> DOWNS 
> 

> > If you are looking for the place where FLAG_BIAS_DISABLE is set it is
> > in
> > gpio_v2_line_config_flags_to_desc_flags() in gpiolib-cdev.c.
> > 
> > Referring to gpio_set_bias(), the only place in gpiolib the
> > FLAG_BIAS_DISABLE is used, if neither FLAG_PULL_UP, FLAG_PULL_DOWN,
> > nor FLAG_BIAS_DISABLE are set then the bias configuration remains
> > unchanged (the don't care case) - no change is passed to the driver.
> > Otherwise the corresponding PIN_CONFIG_BIAS flag is passed to the
> > driver.
> > 
> 
> Exactly, but note FLAG_BIAS_DISABLE can only be set from userspace at
> this point (IIUTC). If everyone agrees that should be case, so be it.
> But as I said, I just don't see why it's wrong to do it within the
> kernel.
> 

Believe it or not gpiolib-cdev is part of the kernel, not userspace - it
just provides an interface to userspace.

Bias can be disabled by calling gpiod_direction_input() or
gpiod_direction_output() after setting the FLAG_BIAS_DISABLE, as
gpiolib-cdev does.

Does that work for you?

Cheers,
Kent.


> > If there are cases of drivers not fully or correctly supporting those
> > PIN_CONFIG_BIAS flags, then that is an issue with those drivers.
> > 
> 
> Look at my reply to Andy in the cover for more details
> 
> - Nuno Sá
