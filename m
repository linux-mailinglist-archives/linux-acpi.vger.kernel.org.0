Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573FA57522B
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiGNPqv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 11:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGNPqu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 11:46:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78235AE4E;
        Thu, 14 Jul 2022 08:46:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id az2-20020a05600c600200b003a301c985fcso1215688wmb.4;
        Thu, 14 Jul 2022 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=8KOz6CvW48p5QqinPQHBKS23O8fbxtvv7Y3stP5AdXo=;
        b=PT0gaQosfwj9MRRT8DN1wWKiXsmo2tvULz7G6Q9l4YTpAQ+NQTh3CymU/QMtVJKj9p
         iGrN3eYmLrL9k70cGw8BjhRpRf+cguKgeDhshPZhcsOuKSfLc67PDA3gEwIoDZcE66eN
         sCn94yOun9XQFUf6WEkuh4TsupoEyTQaRkIdHbsKdGheChQS8MdLp1ylm9agj0DlnOT0
         BM53KnUTlw1qaK3Wve7Tw76uYnBMI4X2Ucgq/jPLB4YNTBf38lGFXQuFjxdbDMHupVhw
         4OezBdn3Ori14WYr5vSIiVQLmtyNcjIDYFX4+WCU41Ji+mkPb6HcvvSPK5S0ZEckRxIx
         OuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=8KOz6CvW48p5QqinPQHBKS23O8fbxtvv7Y3stP5AdXo=;
        b=EnaWFm/yfZAbS5zjHvwK1Lh0w2ni7izgn8XPKIAcAQ2dIJ1RQBxbUb4wZXAmrbU5Rd
         /Wg+LuvASq6CnbVuGOpvMV1Hfu4PvzWrUkBYnyLDfPQenMq5mgDz+1vUr+ZkOdFDncL+
         JX2upsr+w+iMSjCwMJIb73tAsvExAAXfnm/urUjp9RUT5UaQn8OH6ID6cX/els2mpy7Y
         fE+dS11PPA9vKR9dZVcTnUTJFz4q010s8CbZNBkmA8Uqa8sgM+Cd4cFW9hIianxLuE91
         qzAXlAS4weMFo+C1T3VT84TP673EsZNjGkLDGN0MlZG7/RpedjcDT6rPMg1oWAcvBfg/
         m9QQ==
X-Gm-Message-State: AJIora+EFzN00kbWRTwX+yfBB99yh2qTK2CEAxpHW5hP6oWhXBr+uc5m
        bfaHXIr8euQw9u7azyosHZs=
X-Google-Smtp-Source: AGRyM1vV8d14wVlH4ovazryw4IMyTJKQK+pyLi72Fo8GnCV1EdDH6E2vyHee9P6dV7GN+Vsq91+tUw==
X-Received: by 2002:a05:600c:35ca:b0:3a2:aee3:a8ff with SMTP id r10-20020a05600c35ca00b003a2aee3a8ffmr9744984wmq.206.1657813605912;
        Thu, 14 Jul 2022 08:46:45 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6607000000b0021b9504cc83sm1736842wru.31.2022.07.14.08.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:46:45 -0700 (PDT)
Message-ID: <d7416381e57a4a065616105952926552b7c70415.camel@gmail.com>
Subject: Re: [PATCH 1/4] gpiolib: add support for bias pull disable
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jul 2022 17:47:49 +0200
In-Reply-To: <YtAxaCsQTrUiI4ir@smile.fi.intel.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <20220713131421.1527179-2-nuno.sa@analog.com>
         <Ys8CpqYhWp7zVNC8@smile.fi.intel.com> <20220714042050.GA76737@sol>
         <4bf06ba5994f559499c45275cd7f44bfee1bbde1.camel@gmail.com>
         <20220714082710.GA103849@sol>
         <35e8020f513a77b8a8eb12a45d48a2b1390cce7c.camel@gmail.com>
         <20220714120005.GA105609@sol>
         <fc0ce1235dce7303aac7bcc45b856fcca60fcb57.camel@gmail.com>
         <YtAxaCsQTrUiI4ir@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2022-07-14 at 18:08 +0300, Andy Shevchenko wrote:
> On Thu, Jul 14, 2022 at 03:02:08PM +0200, Nuno S=C3=A1 wrote:
> > On Thu, 2022-07-14 at 20:00 +0800, Kent Gibson wrote:
> > > On Thu, Jul 14, 2022 at 10:47:27AM +0200, Nuno S=C3=A1 wrote:
>=20
> ...
>=20
> > > If that solves your immediate problem then you need to decide
> > > what
> > > problem your patch is trying to address.
> >=20
> > So my patch is trying to solve exactly this case because (IMO), it
> > does
> > not make sense for consumers drivers to have to do the above code.
> > Moreover, they would need some custom firmware property (eg:
> > devicetree) for the cases where we want to disable BIAS since we
> > cannot
> > just assume we want to do it.
>=20
> Why? This is the main question. Why do you need that _in kernel_ API.
>=20
> > Well, maybe we can just assume FLAG_BIAS_DISABLE in gpiolib (when
> > trying to get the gpiod) if no PULL is specified. However, I do
> > have
> > some concerns with it (see my conversation with Andy in the cover).
>=20
> It's AS IS if you trust firmware.
>=20

In my use case, there's no firmware controlling the pin... The input
driver (which exposes the gpichip) directly controls the pins and I
want to have a way to tell it (from firmware) to disable the BIAS if
users want to do so (by default it's pull-up)...

- Nuno S=C3=A1
