Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5932551BEC2
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 14:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359374AbiEEMGF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 May 2022 08:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356598AbiEEMGF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2022 08:06:05 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA44551C;
        Thu,  5 May 2022 05:02:26 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id f38so7249523ybi.3;
        Thu, 05 May 2022 05:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7v2CD/TPwrcoEWudBwZsC3kPJhWxSkWgF2bGSBvAsoc=;
        b=voMCLYKcOy7jEVWOHmkPjpOMDJxfxAe6GIvnjnMTW/qMGq4iIkHibwTsj8fRDdAsHA
         bDaB9j2uutSY0hIQJ4Bf5RtXrTQ8gJp9koKLGPXR+qhwyoAcKRUcoN8u1Q15+2p4J5fq
         BMF53JbGa4Dvh40vLPChimmy6+NX2/mgJq3jJQ4Vbfqda0QjZsHAR5AP9udP1SDSQFHN
         hnnusqocumRrnvgA21NpHpokAeYk3MOeXQ9YotXyrUc2hnsIxYanfbwXj0q3T/pi79FI
         Txecs+EyZYO38Wr8C5Lzo5TIv+LatIMhF5Mfel1y7FcC8zu5z+pX0SanZWdo8ipesMuV
         DSpA==
X-Gm-Message-State: AOAM530epU9i9aIczjmY4Q91Agap/35lnnohE+MkiMM23fpwem3EEssJ
        TwakJdozX8ggv/S4xv6EwparrpyMtDjkj2lugX4=
X-Google-Smtp-Source: ABdhPJyKpd7G7qLA+GPK2PlKD+1TSCHY7kpSqAdE7H1yIDAZVQ+IQ+Nlt3Lzo4yG35XXp+zVRbglifazAfGWMMGzHUg=
X-Received: by 2002:a25:3795:0:b0:648:fa25:5268 with SMTP id
 e143-20020a253795000000b00648fa255268mr22558130yba.153.1651752145467; Thu, 05
 May 2022 05:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220505015814.3727692-1-rui.zhang@intel.com> <40b8ad06-6ef2-113c-fffb-2fa001603b3f@suse.com>
In-Reply-To: <40b8ad06-6ef2-113c-fffb-2fa001603b3f@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 May 2022 14:02:14 +0200
Message-ID: <CAJZ5v0hceDVkv05=SFbO53wsmHWkrs1SSoxZ=FuErYsnNutGWg@mail.gmail.com>
Subject: Re: [PATCH 0/7] PM: Solution for S0ix failure caused by PCH overheating
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kvalo@kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        merez@codeaurora.org, mat.jonczyk@o2.pl,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Len Brown <len.brown@intel.com>
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

On Thu, May 5, 2022 at 10:23 AM Oliver Neukum <oneukum@suse.com> wrote:
>
>
>
> On 05.05.22 03:58, Zhang Rui wrote:
> > On some Intel client platforms like SKL/KBL/CNL/CML, there is a
> > PCH thermal sensor that monitors the PCH temperature and blocks the system
> > from entering S0ix in case it overheats.
> >
> > Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
> > temperature above threshold") introduces a delay loop to cool the
> > temperature down for this purpose.
> >
> > However, in practice, we found that the time it takes to cool the PCH down
> > below threshold highly depends on the initial PCH temperature when the
> > delay starts, as well as the ambient temperature.
>
> >
> > This patch series has been tested on the same Dell XPS 9360 laptop and
> > S0ix is 100% achieved across 1000+ s2idle iterations.
> >
> Hi,
>
> what is the user experience if this ever triggers? At that stage the
> system will appear to be suspended to an external observer, won't it?
> So in effect you'd have a system that spontaneously wakes up, won't you?

No, you won't.

It will just go ahead and reach S0ix when it can.  It will only wake
up if there's a legitimate wakeup even in the meantime.
