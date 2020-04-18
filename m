Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C351AE908
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Apr 2020 02:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDRA4B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Apr 2020 20:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbgDRA4B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Apr 2020 20:56:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5AAC061A0C
        for <linux-acpi@vger.kernel.org>; Fri, 17 Apr 2020 17:56:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so3904539ljg.5
        for <linux-acpi@vger.kernel.org>; Fri, 17 Apr 2020 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qs6wrAd2usiw5E/NvfsaWD9NmqabIB9KmK4sn2np7kI=;
        b=U4x5PtWjYno+y9kpXnPl1TultiRn27j4BA37HWNBlr8kBkFNbIKmdMCjn5+3qALEe6
         dRH3LlE3dIu3QUb/4qxHvQ9l4xMOL9Mb/kG0fdw89qIxkUEdLh7LgPPZdg/O0R+zWCWz
         DW9rBf94bWBr7s2zss5IpNuRxdZPbLRIPLmgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qs6wrAd2usiw5E/NvfsaWD9NmqabIB9KmK4sn2np7kI=;
        b=dd66YAWpXncD11yd/bz0Rlsw0jlab4ZuT4ifQS/hdPSS5USrspczZtYdtvQK0LJNmI
         yr+WWqmYFF3tEIZfAMSjWiKZB5iYxC4Fs/IVANcinhJaSFk/vZoAorsPW7/pHNmlU0dH
         pZCsgs6E4w27zByNnY4gyT7FxV53CtEsLBYHVCyES0AM/HdvxMohRQIk5qKnKkPqg7rq
         wBj1r+LWZF/q75Z2EUo7t6u3EBFq7p33pQdzxTmqQM7h+uPQqDIdXmwqdQoSqxEWNW9G
         lMw4TgVgHnr8qFi2jno3ySs1CbvLdOL85EcKcobY+0IABGrtyWVQDGX4Bh9biwhGeeQG
         Djaw==
X-Gm-Message-State: AGi0PuZxUa26cZJvZwu8xw7OM9wn14+01nylWkg0J/0K93aaV9ytznWj
        +n3ZzG4pA8Mjc4bOJCvod4/g6Bdwu3I=
X-Google-Smtp-Source: APiQypKj23y7zDteMfmyzadx6D8BBz6GLbT5M3DvpIcBWKkepuiczg629pqR+vggRnB0qRTZkgwp7g==
X-Received: by 2002:a2e:7a0a:: with SMTP id v10mr3729883ljc.143.1587171359389;
        Fri, 17 Apr 2020 17:55:59 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b16sm17367386ljh.20.2020.04.17.17.55.56
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 17:55:57 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id x23so3291834lfq.1
        for <linux-acpi@vger.kernel.org>; Fri, 17 Apr 2020 17:55:56 -0700 (PDT)
X-Received: by 2002:ac2:4859:: with SMTP id 25mr3711879lfy.59.1587171355790;
 Fri, 17 Apr 2020 17:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200205194804.1647-1-mst@semihalf.com> <20200206083149.GK2667@lahna.fi.intel.com>
 <CAMiGqYi2rVAc=hepkY-4S1U_3dJdbR4pOoB0f8tbBL4pzWLdxA@mail.gmail.com>
 <20200207075654.GB2667@lahna.fi.intel.com> <CAMiGqYjmd2edUezEXsX4JBSyOozzks1Pu8miPEviGsx=x59nZQ@mail.gmail.com>
 <20200210101414.GN2667@lahna.fi.intel.com> <CAMiGqYiYp=aSgW-4ro5ceUEaB7g0XhepFg+HZgfPvtvQL9Z1jA@mail.gmail.com>
 <20200310144913.GY2540@lahna.fi.intel.com> <20200417020641.GA145784@google.com>
 <20200417090500.GM2586@lahna.fi.intel.com>
In-Reply-To: <20200417090500.GM2586@lahna.fi.intel.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 17 Apr 2020 17:55:44 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM9mrkGfxtVVNWkqnDNzcok2LAqdfVbQL2RV7yWE0tMWw@mail.gmail.com>
Message-ID: <CA+ASDXM9mrkGfxtVVNWkqnDNzcok2LAqdfVbQL2RV7yWE0tMWw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cherryview: Add quirk with custom translation of
 ACPI GPIO numbers
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        stanekm@google.com, stable <stable@vger.kernel.org>,
        Marcin Wojtas <mw@semihalf.com>, levinale@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

- Michal (bouncing)

On Fri, Apr 17, 2020 at 2:05 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> I wonder if we can add back the previous GPIO base like this?

Thanks for the patch! At first glance, it looks like the right kind of
thing. Unfortunately, it doesn't appear to work quite right for me.
I'm out of time for today to look any further, but I (or perhaps
someone else on this email) will try to follow up next week sometime.

Cheers,
Brian
