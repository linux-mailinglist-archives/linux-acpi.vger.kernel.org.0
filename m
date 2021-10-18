Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D043162B
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 12:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhJRKez (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 06:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJRKez (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Oct 2021 06:34:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AC9C06161C;
        Mon, 18 Oct 2021 03:32:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ec8so69275522edb.6;
        Mon, 18 Oct 2021 03:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9oymfw+4Q4EUp1uQeLx3eQf8ONEX3UXuex+M2PDNds=;
        b=TLcNuIRaSirV40yLnD2LydRRcHu8A7AjPD2HK+FHjwSJo6gUjyVbnCHhI+jqYN5RHD
         hkCMWchYgbxajYsDhGhlt+CrkPWAfPxDijb1YMP8TC4k66Lx3suov6MuVE2m6gqduHu4
         HQw58B/cY+yxTP5mypeRaeBTMdb+71GzckWUcwZkKm8FzfBeisuR4z7UzrFk1Qxd40aa
         ZjYjX7KnlkdUNu7tvfNb0IuxpwokrP8x2o9uh+nKkQN+Xzlg0YmGVfrnBGs9wTsQiEhe
         P8H9+ue4Cm8oMKZscaVPV7q69ZkBWWu6qbjGr2qabtJ+q2uyojF786MvSTQ+A0lykdhy
         CjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9oymfw+4Q4EUp1uQeLx3eQf8ONEX3UXuex+M2PDNds=;
        b=kTQ1IW+bwqnX3OYsdBVQnfu/MO8VYKQ5o8EEtBHOHi+nkYjclnGXtEZ24yjZ1zyZyI
         KKOyGSUZEqAHNPUdqDaA+VCCaoPHf4orQ9jv4d5ifygM5Kw2fZTn+gTEbms8ZBDBF5M7
         43BRUWI+lPzsm4gtxV49E2BX03wi6/OeKMRa9e6Hq67roDfb2MAH6V2YhmcyeLwyxnFR
         dOX3bqPc9EKOZc60op+qfM5lq6SsO6giFHM1Pvo25g9jxa3UjoPKiwS7fYjy9F26hMhW
         0zRHs1ATrcPVIM5PzCAViEqfFEq1x9hppXAjKWpPCUf8OjleLI7tiRj8VmtHHrDxCalz
         afNQ==
X-Gm-Message-State: AOAM531GnxOiGwnsXpWi42moARVQNw7MNMKtL1YfztoJsxXjIyn9S2r6
        Rca2oRVi47wjDxJ0wWVZwdls38NB7r69bbItzWU=
X-Google-Smtp-Source: ABdhPJzkUhCoOFoa940+tHJH4mn3FIsJ2GpQaTuZz+KSQGvDqGpJYQy6Yc7e5QGMdefJ2ExRxqsor1ZTneugg4ohpCA=
X-Received: by 2002:a50:e188:: with SMTP id k8mr44898028edl.119.1634553162983;
 Mon, 18 Oct 2021 03:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211017161523.43801-1-kitakar@gmail.com> <20211017161523.43801-2-kitakar@gmail.com>
 <3e6428f1-9411-fac6-9172-1dfe6de58c28@redhat.com>
In-Reply-To: <3e6428f1-9411-fac6-9172-1dfe6de58c28@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Oct 2021 13:31:51 +0300
Message-ID: <CAHp75VcA+=OsmX7o2WTvYgf8TNpE64qEHq=MVm5vVP-4RBk+ng@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] ACPI / PMIC: Add i2c address to intel_pmic_bytcrc driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Tsuchiya Yuto <kitakar@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 18, 2021 at 12:16 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 10/17/21 18:15, Tsuchiya Yuto wrote:
> > On Microsoft Surface 3 (uses Intel's Atom Cherry Trail SoC), executing

...

> As Andy said we could use a DMI quirk for this, but chances are that the Microsoft Surface
> DSDT is not the only one with the wrong HRV value. So instead it might be better to
> just test for the SoC type as the attached patch does.
>
> Tsuchiya, can you give the attached patch a try.
>
> Andy, what do you think, should we go with the attached patch or would you prefer using
> a DMI quirk ?

TBH I have no strong opinion. Only one remark on your patch, I am not
a fan of removing COMPILE_TEST but at the same time I'm not a fan of
ifdeffery. All on all I think having COMPILE_TEST is preferable even
if we have ifdeffery. Btw, IIRC similar code (i.e. BYT vs CHT by CPU
ID) is being used elsewhere. Perhaps we might have some common
(library) under arc/x86, PDx86 or so (headers?)?

-- 
With Best Regards,
Andy Shevchenko
