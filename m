Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58952578008
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jul 2022 12:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiGRKpP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jul 2022 06:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiGRKpO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jul 2022 06:45:14 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88305101DA;
        Mon, 18 Jul 2022 03:45:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g24so5675062qtu.2;
        Mon, 18 Jul 2022 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=dhyYncsSwNhmK/zesZRgmRNflzipmfw4AdNK0DnS8ks=;
        b=EOQFrWCcdIyqgNyVgqdOdHQW6jFkMNZYlC9u3ZQfCjER7XFa8FislpNofV15GryMOb
         ezBMwacJxsVO5vi48alYDlUD0KXCU1xxbZnDzgNbTBAyznJrsaYM5iZwJHfVRMVSLk8e
         o2GtMysDYqU6NxtMohvDj4hERkwh3xyHhcIJsTgwtT72eW6/Pv09zdOA2hweEXnw4ERr
         zdXuOoRl9XvSxHRENA3XWnr5kSTlsFHirGDLJOY2OzsGPAJOmjzgT2IV5vXbSPDm5a4t
         imRU3lnObNZJxw5shwoARQCX7PFuviG5RVUXVvwurF35PxIVDm6YqC3spvpOSwCR3ANs
         eluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=dhyYncsSwNhmK/zesZRgmRNflzipmfw4AdNK0DnS8ks=;
        b=okc4KJD1LHtO3ZJW1tCOpMZqiIPLPKUc7Ydl2BfXOKn7qR+XVKtEwSgKUT4mAWVynI
         pQvJ+i6xUaNrttOIOoKMVC1LgQSCAHal5djYEmKHu0jwjXFOdLpxfZZJu1AZ4CbBA6Ra
         qTeiU1CGAlWbzfyk315vSXYnTfHsG+OPAbwZHux/tVApHABuAs5n7TUkSQx97tA0e9UU
         LotjXBKaYgTlmiBMpwIghV8kT1RT2/y2gmdHze5gyTvTFBqRL93DMj/aD+0LledOjWlF
         Pld0+JyvLvGxXHPGkpgjSb+dzxAJAso4EPGdBytgZ77tIbdVJ5g1pRGxXyQxCfUu1Xq6
         wRNw==
X-Gm-Message-State: AJIora+gIAs+7sEyMr1a74c7NwxGSNUvVLe2MoMOeSPc2r6td0VM5R9w
        f+CxdmYnpvc7Xe05cyVvR60=
X-Google-Smtp-Source: AGRyM1uWrBsv0fVZemcmlvAm1yR7/VPuEGQfzX7ctLTMbuPRCrZ+2pr141AG043eQTrKvDkNTb/NZg==
X-Received: by 2002:ac8:5755:0:b0:31e:d70c:acc6 with SMTP id 21-20020ac85755000000b0031ed70cacc6mr13036055qtx.587.1658141112606;
        Mon, 18 Jul 2022 03:45:12 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id ay31-20020a05620a179f00b006b5de51ec1asm5553847qkb.26.2022.07.18.03.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 03:45:12 -0700 (PDT)
Message-ID: <9e0a4d4c9cd626bcd9850748b8202b49d461ff2b.camel@gmail.com>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 Jul 2022 12:46:14 +0200
In-Reply-To: <CACRpkdaZTRwvWJkgSOaCE-281Mq5KXGS9pDaUKuF7O0Jje14CA@mail.gmail.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <YtAvHMmGay/3HACZ@smile.fi.intel.com>
         <e0638b02bdcd0ee452846b86ce83458173912ef1.camel@gmail.com>
         <YtBnIxh6rDJMwpEm@smile.fi.intel.com>
         <5d9f9272334177e3ea864467f50095a8709bc0d2.camel@gmail.com>
         <YtFYFbP+xqAUUHZa@smile.fi.intel.com>
         <88114aeb10f7316cf3c1396179949f2fc351ad8f.camel@gmail.com>
         <CAMRc=Mdz+8yfrATQPJ=uY33k2Dwt29g6vZbP3mSjkB_VAzP5+A@mail.gmail.com>
         <7aa6f7bc6c528fda0649888d282aef39f1d055d4.camel@gmail.com>
         <CACRpkdaZTRwvWJkgSOaCE-281Mq5KXGS9pDaUKuF7O0Jje14CA@mail.gmail.com>
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

On Mon, 2022-07-18 at 12:29 +0200, Linus Walleij wrote:
> On Mon, Jul 18, 2022 at 9:50 AM Nuno S=C3=A1 <noname.nuno@gmail.com>
> wrote:
>=20
> > > right in that the character device is the only way to set this
> > > mode
> > > ATM and. However I would like to see the first user added
> > > together
> > > with the series because adding features nobody uses in the
> > > mainline
> > > kernel tree is generally frowned upon and it's also not clear
> > > that
> > > anyone actually wants to use it.
> >=20
> > Hmm, you mean something like a system's devicetree needing this
> > flag?
> > If so, I don't really have such a thing. I did all my testing on a
> > rpi
> > using overlays.
>=20
> I would assume a driver with a .set_config() responding to this flag?
>=20

Ahh if that is the case, then there are actually users of this flag
already.=20

"
git grep -lw "PIN_CONFIG_BIAS_DISABLE" drivers/gpio
drivers/gpio/gpio-aspeed.c
drivers/gpio/gpio-merrifield.c
drivers/gpio/gpio-omap.c
drivers/gpio/gpio-pca953x.c
"

This is also one of my arguments why I think having this new flag is
better than me adding a workaround for the device I'm supporting. Also,
in the cover I have a link to a new user (which is an input keyboard
driver that I'm refactoring) of this flag in .set_config().

- Nuno S=C3=A1

