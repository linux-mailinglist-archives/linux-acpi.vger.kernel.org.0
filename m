Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3392A4BDDB1
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbiBUQwl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 11:52:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiBUQwk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 11:52:40 -0500
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A9C220C7
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 08:52:16 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2d07c4a0d06so144822837b3.13
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 08:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/HNKJ2e1zc2bePek5Whx8xUvH2ewxwDEcpS6dqGjns=;
        b=cv1BkES8fgmphG+F6zQzlquZ/QYJS2mvoSGkukHV0GbP/gJw06Hpl/bKf6Q1chua8r
         kcW2CIfL8jO2ths3n76Den3pYwQzgLVnox2q6fMt/+exQESeSxZHo12vo/eVdi9gLvl8
         b9d4WuZZu8YYuRRrKcVp/nuw4/U6dek/W5U8LUVbZnu2aAxeXCG5eR51iAqRbMgcc2ZY
         CtkebbUY/g+EuWQD7fhuQy7hSQlCTJj13SrRpU/DD8wUTBVTg245/xqgAJKySm8mHIzK
         lgs0DKL9jetG/BifkP9jscCjfXC4WHNTDghEJclHwC4x3mp5+R+3nKhNd8Y8qVy7le+1
         6UWw==
X-Gm-Message-State: AOAM532NcuiGiTJPdrRsTHgDub1k0c0Vf9Bw9MmwXAiFpCIYkkyw7n75
        YoipnkBJLyElyKOcJlP3VpCtiZDFaKp+UhNeJBZsIzl/
X-Google-Smtp-Source: ABdhPJyr9xZXz9IJIUi4UCrJMbpTxhRcewWbtEBGjOSDoKsLpQgKujjiN8HFloR+d/Kf+AtXqnF/8MsUH6KoMUvKSvk=
X-Received: by 2002:a81:8487:0:b0:2d6:9167:ecab with SMTP id
 u129-20020a818487000000b002d69167ecabmr19865283ywf.515.1645462335857; Mon, 21
 Feb 2022 08:52:15 -0800 (PST)
MIME-Version: 1.0
References: <0718fe87-230f-b293-b998-b83f3c133367@cs.wisc.edu>
In-Reply-To: <0718fe87-230f-b293-b998-b83f3c133367@cs.wisc.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Feb 2022 17:52:05 +0100
Message-ID: <CAJZ5v0j=c-ctwqmRfvVtep4DtOf=6Gf=zs+B19aPDpQ0447oRw@mail.gmail.com>
Subject: Re: /proc/acpi/battery gone again, breaks wmpower
To:     Carl Edquist <edquist@cs.wisc.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 18, 2022 at 12:17 AM Carl Edquist <edquist@cs.wisc.edu> wrote:
>
> Hello there Rafael,
>
> (I found your contact in the MAINTAINERS file for the ACPI section.
> Hopefully you are the right person to ask this question, but let me know
> if there's a better place to ask!)
>
> Slackware 15 was released this month, and after upgrading (to linux
> 5.15.19, according to uname -r), I noticed my wmpower dockapp for the
> WindowMaker window manager stopped working.  Apparently it relies on
> /proc/acpi/battery, and does not know about the /sys alternatives.  Maybe
> it was written before this acpi interface was deprecated.
>
> Since wmpower has "just worked" for so long, it appears the only
> maintenance it's received in a long time has been by the Slackware
> packagers (slackbuilds.org) to fix compiler issues with more recent
> versions of gcc.  But people like me definitely still use it! :)
>
>
> I tried searching a bit to see what's going on, and I found an earlier
> discussion where /proc/acpi/battery had previously been removed, circa
> linux 3.14, and then re-added, after it was brought up that (possibly
> among other things) a number of WindowManager dock apps still relied on
> /proc/acpi/battery:
>
>         https://lkml.org/lkml/2014/3/17/393
>
>
> I didn't find a more recent discussion about it getting removed again, but
> some git-log searching brought me to this commit:
>
>
> commit 8830280a69ddfdbba7fb24d79dce309817783c6a
> Author: Thomas Renninger <trenn@suse.de>
> Date:   Wed May 27 17:33:03 2020 +0200
>
>      ACPI: procfs: Remove last dirs after being marked deprecated for a decade
>
>      This code is outdated and has been deprecated for a long time, so user
>      space is not expected to rely on it any more on any systems that are
>      up to date by any reasonable measure.  Remove it.
>
>      Signed-off-by: Thomas Renninger <trenn@suse.de>
>      [ rjw: Subject / changelog ]
>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
>
> Out of curiousity, I tried reverting this commit against the latest
> master.  It does not revert cleanly, though it doesn't look like a lot to
> clean up (conflicts in drivers/acpi/ac.c & battery.c).  Would reverting
> this commit (assuming conflicts can be fixed) be enough for me to restore
> the old /proc/acpi/battery interface?

It should be sufficient.

> Or are there likely to be any gotchas there?
>
>
> And, I'm afraid to ask, but is it out of the question to wonder if this,
> now twice removed, acpi interface may ever see its way back into mainline?

Because we promise that user space won't be broken by kernel changes,
it needs to be restored to make wmpower work again.

I'd rather not restore all of it, though, just the part relied on by wmpower.
