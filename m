Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A6637BBEC
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 13:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhELLhx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 07:37:53 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42664 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhELLhw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2021 07:37:52 -0400
Received: by mail-oi1-f172.google.com with SMTP id w22so8078307oiw.9
        for <linux-acpi@vger.kernel.org>; Wed, 12 May 2021 04:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEf3z+0k8rZTNLLEmN03F/pZ3Kna7rwDY+HNkRlpdbE=;
        b=Mlfa9GHHi2VYwakUHcXesHeg4GhU2+AWbAjo7LZUNST0Yz4BCtLBOqn9h3HYT/qh3z
         d8bXgqEq49971Bfghs/kbJw5uurCF5oaAaWkFAiU4q8X9Yh+oTaq6a28rIcfig7Chpmk
         qI7QU7Zk3lgDsl0BRLbImSuUqCUPaOj5rehzQjQuHjk63XqMKrFbrT5MMHOvTsoZf1NH
         qMZZRGQxSs3/31qNRabjv4vB8bpF6TzWwQ8qw4LD9LvBRmLUinu7zwFA99B7rBe8VpbF
         hYOZSmW3O5gabuyXMld1XPRoEu7ZuAiW4r8mslDYo8A3InnMY5bMVK3nLvL75QeBmbu4
         nXNg==
X-Gm-Message-State: AOAM5336hTu6EY4CKAT7/dFLfLpS0FV4lLzd0p3GDU69b4FB6DyKQJEz
        UQ/VV0HfNR43uhKb9TEi76hUQ8IryPg87lEPEeuCbAZD
X-Google-Smtp-Source: ABdhPJwthZcnerxi0bQLzu6f5LDyeaJT6DW4K8mlTpPBiy0BkqMMpWPY9Dhe7IITJ9woZHEXBj929QtNlQV221fCi1E=
X-Received: by 2002:a05:6808:90d:: with SMTP id w13mr11170232oih.71.1620819404359;
 Wed, 12 May 2021 04:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210511025024.10083-1-mario.limonciello@amd.com>
 <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com>
 <BYAPR12MB26937BC445598D567C964734E2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <CAJZ5v0jRSUV7_MN6Ru0R6tNq11Qe7Swv3Wy4sfZYbrn0H8r-tw@mail.gmail.com>
 <CAJZ5v0i=Zx_LOR1yZ0EkgrH4jy9+j=++kRBOJm_da3_a1=HDTw@mail.gmail.com>
 <BYAPR12MB2693FA7AE60DADDDDE0809FCE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <MN2PR12MB44888AB90D99B2A3B4A70961F7539@MN2PR12MB4488.namprd12.prod.outlook.com>
 <BYAPR12MB269399B97D4BBC07B5758CCDE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <CAJZ5v0jznwY0Cs9uKQDx5UASOggTEXUmwUiVUT998jwS0N1AcQ@mail.gmail.com> <BYAPR12MB26932E89C5FCE71DB23482E6E2529@BYAPR12MB2693.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB26932E89C5FCE71DB23482E6E2529@BYAPR12MB2693.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 May 2021 13:36:33 +0200
Message-ID: <CAJZ5v0jj++na0XaObpq_6pSToDm_NA8BEmq_bPWc=x7x=edNag@mail.gmail.com>
Subject: Re: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 12, 2021 at 4:47 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> > > In processor_idle.c target residency is calculated by exit latency multiplied by
> > > a latency factor parameter (2 by default).  So when these systems have the
> > buggy
> > > _CST C2 value of 400, that's where the 800 comes from for residency, not
> > _LPI.
> >
> > Yes, that's right, sorry for the confusion.
> >
> > My point was mostly whether or not it would be sufficient to swap the
> > values for the last two states or if some new values needed to be used
> > and the answer appears to be the latter.
> >
> > So I don't see any way to address this that would be cleaner than the
> > quirk mechanism as proposed.
>
> The root of the problem is that the states get skipped.  So yes technically
> your suggestion of swapping the values of the last two states would be
> enough to avoid this issue as well.
>
> My thought is to do it by checking whether all the latencies are arithmetic
> progressions and if not then emit a notice this is a FW bug and sort at the
> end of acpi_processor_power_verify(pr).  This would be done on all systems.

Sounds reasonable to me.

> Let me know if that sounds good or if you would prefer to stick to the quirk
> approach as proposed or something hybrid.

Well, I prefer to avoid adding quirks if poss, because they become
pure technical debt when the quirked systems get out of use (and
there's no good way to determine whether or not this has already
happened).
