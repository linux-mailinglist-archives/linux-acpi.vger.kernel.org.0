Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CF5242F62
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Aug 2020 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHLTeM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Aug 2020 15:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgHLTeM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Aug 2020 15:34:12 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDA5C061383
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2020 12:34:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b79so3119148qkg.9
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2020 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNDeeEu8OInqbqByJ2ZOXoAVRjNpv1vP3OHX17fDEvU=;
        b=r4+HnsvgN0jJa837wtb65Cs7IAk9eOD6BOLmmqils8rqCozIQk8nMQH4UjLdQUceV9
         FutaSFNF12VW1gYyIbe9bMf24E28UUKNTS6f63KvHph8c2/tf63EykMrCPjZt/rJMKyP
         RaxNrHoQT9E7OaopVveRyAoLL6QVJf8wAhmhWB49gk6BoX+rXwkafWX5Zoulv8q6dL/B
         xny5ju9y/uT9f5/nEsCGNUHC4HaGW+7DSeISwT/u9ENEk9nejSi2Y632D2xk/CzWEONt
         +drlx/CsAIZPzWnSKOZ4LRiye5IwLqLGQ2YeCoSyTtxbIUcxoNsZP0gyIY7/VnO1F5dI
         JR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNDeeEu8OInqbqByJ2ZOXoAVRjNpv1vP3OHX17fDEvU=;
        b=WF2agqikQwwAxzGm4lvBObrOfc6x8Fp80AVkxQ2OsDXXiYmgYi+oP4bAIVFic4HAwH
         g/SsFSaGsDh9ntXkRAOvYCisOnUP+VlFl2+Dh8WJ65m3v7Kd3HMOvcMuf5Sx6dlOHXpd
         jKMyvVt2Q2ctGLnMliL5cgOVPFh2t31eEe3PP7tQT6WVAaVOlF/W4qa1wD1lRE+Iga8C
         cJbwGbpaf8aAC2MIhxGJk+YAZm7oX9ubmTcUbYycGycaB1Emsx8hGOtjFv61AzsuF+YE
         /RyHCb0RMrBM96a2RpVmZLhCol28DFe10FXaGlezkNvJEe1PZdHjafEu4b1BzpjrplTp
         4nAw==
X-Gm-Message-State: AOAM532DLxXUMjf9eqIyXbTXG8Viq1u/64anVu/nkCcsgghW3ycdqaOD
        Zrc6u48U5bqJYeVpFdYmkeW0MD4oA55wYLchBis+yA==
X-Google-Smtp-Source: ABdhPJxPajgg+Gh2SZMQyrFoBo5ccaZiV7aSQ1OH1I03oez0nz6bNWlF+MeK2Mit08rZfVypEhouZhxdPgfg4YTfPjI=
X-Received: by 2002:a37:a5c1:: with SMTP id o184mr1415589qke.323.1597260850654;
 Wed, 12 Aug 2020 12:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200121134157.20396-6-sakari.ailus@linux.intel.com>
 <CAMpxmJU5dG49N2FA0oSQsOfKrCr3KQ1BisON4c+nUJJmZQG=bQ@mail.gmail.com>
 <20200311085555.GH5379@paasikivi.fi.intel.com> <CAMpxmJVPTKW+sYSJ3dnfF8nLAOKEa4Ob7bpxG0KD3Tkdm+rtYw@mail.gmail.com>
 <20200323213101.GB21174@kekkonen.localdomain> <CAMpxmJVdyTkZMVuhSy0Ux8VUYTmQN_YEfH-akQsAL3zrwiz8Dw@mail.gmail.com>
 <20200810082549.GD840@valkosipuli.retiisi.org.uk> <CAMpxmJUKSR-oCGnV1E5XiAMA2nYBy5f_f8=VSoMn0zf+qF39vg@mail.gmail.com>
 <20200811080009.GE840@valkosipuli.retiisi.org.uk> <CAMpxmJWziqW-PiJPSm6aH5aXbYktMJfVjJfvfGxv8fdbWKydqg@mail.gmail.com>
 <20200812192500.GA8942@ninjato>
In-Reply-To: <20200812192500.GA8942@ninjato>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 12 Aug 2020 21:33:59 +0200
Message-ID: <CAMpxmJXzaA7M94D7O5RB1WMVPz5dK61aVO_SOsu-TGTLtBZU6Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] at24: Support probing while off
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 12, 2020 at 9:25 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > Wolfram says. From my side: I'd prefer to see the
> > disable_i2c_core_irq_mapping converted to flags first and then the
> > flags extended with whatever you need. disable_i2c_core_irq_mapping
> > could also be removed AFAICT - nobody uses it.
>
> I haven't read the details here, just saying that
> 'disable_i2c_core_irq_mapping' is already removed in -next and also
> within the next days in Linus' tree.
>

Ok, then nevermind my previous comment.

Bart
