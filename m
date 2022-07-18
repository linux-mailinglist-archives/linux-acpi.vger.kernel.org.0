Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84FB577FA8
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jul 2022 12:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiGRK3s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jul 2022 06:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiGRK3s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jul 2022 06:29:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66631BE8A
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jul 2022 03:29:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so14623707edc.4
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jul 2022 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sKM5awpHr7el0GeuVr26/+wwtxAG0q1PHjMwBcOjjts=;
        b=rutmtYgUq+Ba2+Bv0EZdlEInayTULpWKgLgK1cRDVT4/jmKTMFpDnX0mr/Yt8qFu24
         RASSdB8BiGTWF6uixdUvJTm1k3kS5IizXE0PZEHuHyJG+WwZrmLqPrfMgeGX3DoumiqF
         ESargpIDPjE9pFbcu8JMw+TL7trxLKNn2UYsNR+F4IKDV2hNBmQY7KF1zo3thw5vJH3N
         JqMzS1zRgjCUkJnVi2hpgZ8Yc01fai7/a4Do3+yH94njuU1w6irek2xiXGAe9BY0TREJ
         DThjBP3p9XC45B1se7KotMA3rFKP0l77CzfU3fme1FBHrKwk3aSpjvATg7zhel1sMyk5
         J0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sKM5awpHr7el0GeuVr26/+wwtxAG0q1PHjMwBcOjjts=;
        b=Zw1D0wjRokenQ+HqxZ/ueq1icZbLe1URmlVSPkxvsSeHkQj2TIYYmqrEKXDP38aWPD
         Ao++kG+4vbaMxn0zJRli+IYnYsoXuUL+kGz2TcLK/rxL/Eh9te3ZWKyrc1C4SRoY4H8A
         NiTNjTvanSbqZWZ/aMNB4B7J7UM78KgRZS3uQ8M8eDgN22QDNVKDC+S04PdtqxEDdWvO
         UVTBCNK83NtUdOSKgVI/t7nL8/0LvxeWeBWwd9cedibAqDT12SuxC53n86arsF4D+d+G
         tDwGois/IPEc6N96vne+V1wB5giS/GjwwU/sS5lLMrn4G0FQNEDa3hAP65Rcon+eZqYb
         EiiA==
X-Gm-Message-State: AJIora9jwaB6raeB7zVCKIG6AsNwRxvGZ3NqrKdDjDQBFhpgj9mjQu/8
        wi4Vx4PWfvZUiiB4EobXapPeR6nWItOuuqGum96vDw==
X-Google-Smtp-Source: AGRyM1sQO2Si4Wai7llTNN0MLodyhtS3wCMM8NJdZjyYvK1VZyWIItNJRxT6FoP0UfHh060I+PUOTz/DTjycN3mTVz0=
X-Received: by 2002:aa7:c0c4:0:b0:43a:20cf:3c68 with SMTP id
 j4-20020aa7c0c4000000b0043a20cf3c68mr36444723edp.172.1658140185369; Mon, 18
 Jul 2022 03:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220713131421.1527179-1-nuno.sa@analog.com> <YtAvHMmGay/3HACZ@smile.fi.intel.com>
 <e0638b02bdcd0ee452846b86ce83458173912ef1.camel@gmail.com>
 <YtBnIxh6rDJMwpEm@smile.fi.intel.com> <5d9f9272334177e3ea864467f50095a8709bc0d2.camel@gmail.com>
 <YtFYFbP+xqAUUHZa@smile.fi.intel.com> <88114aeb10f7316cf3c1396179949f2fc351ad8f.camel@gmail.com>
 <CAMRc=Mdz+8yfrATQPJ=uY33k2Dwt29g6vZbP3mSjkB_VAzP5+A@mail.gmail.com> <7aa6f7bc6c528fda0649888d282aef39f1d055d4.camel@gmail.com>
In-Reply-To: <7aa6f7bc6c528fda0649888d282aef39f1d055d4.camel@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 12:29:34 +0200
Message-ID: <CACRpkdaZTRwvWJkgSOaCE-281Mq5KXGS9pDaUKuF7O0Jje14CA@mail.gmail.com>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 18, 2022 at 9:50 AM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> > right in that the character device is the only way to set this mode
> > ATM and. However I would like to see the first user added together
> > with the series because adding features nobody uses in the mainline
> > kernel tree is generally frowned upon and it's also not clear that
> > anyone actually wants to use it.
>
> Hmm, you mean something like a system's devicetree needing this flag?
> If so, I don't really have such a thing. I did all my testing on a rpi
> using overlays.

I would assume a driver with a .set_config() responding to this flag?

I actually think some gpio drivers using pin control as back-end
such as
drivers/pinctrl/bcm/pinctrl-bcm2835.c
will do this out-of-the box after this patch but I may be wrong.

To me supporting this on the Rpi driver is a good enough demonstrator
of the usefulness.

Yours,
Linus Walleij
