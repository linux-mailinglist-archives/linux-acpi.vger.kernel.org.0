Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42BE526EBB
	for <lists+linux-acpi@lfdr.de>; Sat, 14 May 2022 09:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiEND6w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 May 2022 23:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiEND6u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 May 2022 23:58:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F8D127149
        for <linux-acpi@vger.kernel.org>; Fri, 13 May 2022 20:58:49 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j2so18512793ybu.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 May 2022 20:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GT9/q30klIOZiNi12Byl1O8n++vZSioA/Bb3DiRLCoc=;
        b=b9aVU7IS90gpAcPOVXeUUrzRXPZYphDZXmhfMOkEgJQ0e8/RprHm3Tru+rqh0eu/jP
         +n+RJB1cn+kThXEeRgZv3mfaquhe++Vzq8HazzqAAM+xvKu/o65jXbXFJ7FLfvnG0L2X
         z6AeKhwLSb05/HIc8T0pKufqixhuDC5lp3vBhssiTDDtccAOAjgpAijozUNZ0Gic9K8a
         GS+rPR30c8EgzGZ0TTaTWHGNsyTqAxZ3GpD9QJu3i/JNT2qSik9ALRb9T9DBno78oVbZ
         9GWixvBNT3L7/uh+PeNGp8S7tXWLa/fuHpW6kLY4B9I1fgL4a0I9ZvJYqbq9S1tiD3mf
         siqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GT9/q30klIOZiNi12Byl1O8n++vZSioA/Bb3DiRLCoc=;
        b=gDBC07zw8jQBnhuHxwOkldrJdE7lbMfSQ+EiBcw1MTtdlN/Gy40FyGOPc+zsEC+rSR
         toZmuzLSJ6sRfwDowws0zkxHD2acZYTPprGYBdahyoYJhxmLK+vH3olWKrG19ClOtys/
         4/4ZHqWICUVu4W5PnjzAIQ303etXXvl/RcxlIwCPWEHAIcbkDqJxjouBhySuXJ0DBkPE
         Hz5xHCJdVCoDE5ao/748hV+XAbQOKgo9Nuo9AWr3inwmpPevw5EUX6bn3bKWEqzi3aoK
         z4w974oBU1uO/kQGiZEoRnE2GnThJCFLfLjvKg6oOHpQzgnksTcJitT4GQqo5kuN5eTI
         pOBA==
X-Gm-Message-State: AOAM532Nf6AYAt1R0bkspwyfn5v+J3QpjxHkCzqTdWVg0f+H1Uc7Ywz4
        RVrAOqW/RuW1JD9NZKXwP/yZ0yxLUnOieGL9hNJ6Bw==
X-Google-Smtp-Source: ABdhPJyA0cZpGgVC+vHuXsPtJhVk9N1EspaO4yzHpGvrbO4jnRAAMhk7yYaKZyXDuU7oq2lHHQw5HbRctiWXIBKLOBM=
X-Received: by 2002:a25:504c:0:b0:64b:979c:1bae with SMTP id
 e73-20020a25504c000000b0064b979c1baemr5867654ybb.563.1652500728034; Fri, 13
 May 2022 20:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
 <CAHp75VdqbXCYoEwxMt7xG55QDu2mXHbnpwdnHb6ktm8NdVPJnQ@mail.gmail.com> <CAJZ5v0hKrnRznpTjTyb8ANGN=REaukAbqQNB_14i_NwAA84=uA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hKrnRznpTjTyb8ANGN=REaukAbqQNB_14i_NwAA84=uA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 13 May 2022 20:58:12 -0700
Message-ID: <CAGETcx_9MNGBi1avOzYoOOaed0CVHa03dfTxYpQuOErtpiisLg@mail.gmail.com>
Subject: Re: [PATCH] device property: Fix recent breakage of fwnode_get_next_parent_dev()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 5, 2022 at 5:21 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, May 1, 2022 at 9:50 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sat, Apr 30, 2022 at 3:00 PM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > Due to a subtle typo, instead of commit 87ffea09470d ("device
> > > property: Introduce fwnode_for_each_parent_node()") being a no-op
> > > change, it ended up causing the display on my sc7180-trogdor-lazor
> > > device from coming up unless I added "fw_devlink=off" to my kernel
> > > command line. Fix the typo.
> >
> > Sorry and merci pour la fix!
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Applied, thanks!

Has this been picked up by one of the driver-core branches yet? I was
poking around that
git repo and didn't see any commit with this title. This breaks
fw_devlink in a severe manner, so I want to make sure it gets into
5.18.

-Saravana


-Saravana
