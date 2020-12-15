Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887AC2DB39F
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Dec 2020 19:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgLOSVy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Dec 2020 13:21:54 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46712 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbgLOSVy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2020 13:21:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id w3so20308430otp.13;
        Tue, 15 Dec 2020 10:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+XFDBz9AVFERtV4gyVS75YweyjyvDoPFj239t/FPrw=;
        b=BdYEaXz7sI/pJWEKGSgJeDQu2sdYIiX/d6JVR5P0+9N6CPmf8fLKhQC8Xu0pFtpmqq
         bruV3bpcdxNrVBCL6GIRnRiVt3RgzawMhN9+8uSlUpC7XCvCN3pTyFjXKg0rZGtNeMGS
         pMKlxah5GSVLQKWVEEb8W+NqDEWdjurCBufKJ7P3jIyKpRWEL7Tm0XF3O1KQHnoWHVPw
         PdzB+ymb93oboXwHWCkAMwrPwXDatgyvQ+BCZI1F8AT9wHV0R4hdss1w+nhJLWS5B1HF
         X45aHwUXK6ik5o8Ct5C/4bA8cyfQ/WPsuvct09y37lFPtbmtFtqBzCgaOnueQDuZf5uf
         MJbw==
X-Gm-Message-State: AOAM530chk8M88sUsjnPSEJqntPqEmkR7WJbrCIkL8kSJepzx+x4bDbV
        pwb54pQfdVtObjloEY0CJwL05wYaw3O9R09iliI=
X-Google-Smtp-Source: ABdhPJw15aj4vZqCRJ7VWkheSyb454wUezb7Sdy+A0HuDl435n1oUox0Kb9WQjzuf/Wt6BOaFjT2BEZ3r0hZjFg2GqA=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr24836368otk.206.1608056473001;
 Tue, 15 Dec 2020 10:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20201214123823.3949-1-ionela.voinescu@arm.com> <20201214161158.GA11066@suse.de>
In-Reply-To: <20201214161158.GA11066@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Dec 2020 19:21:01 +0100
Message-ID: <CAJZ5v0hn=Xcdyi=E_km-ZJNqY-fbP3w3kCcVWVKigHQh5NsZhA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] cppc_cpufreq: fix, clarify and improve support
To:     Mian Yousaf Kaukab <ykaukab@suse.de>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 14, 2020 at 5:14 PM Mian Yousaf Kaukab <ykaukab@suse.de> wrote:
>
> On Mon, Dec 14, 2020 at 12:38:19PM +0000, Ionela Voinescu wrote:
> > Hi guys,
> >
> > I'm sending v2 of some of the patches at [1] in light of the discussions
> > at [2].
> >
> > v2:
> >  - Patches 1-3 are trivial rebase on linux next 20201211, with conflicts
> >    fixed after eliminating what previously was "[PATCH 4/8] cppc_cpufreq:
> >    replace per-cpu structures with lists." Therefore, I have kept
> >    Viresh's acks.
> >
> >  - Patch 4 is a merge between:
> >      - [PATCH 4/8] cppc_cpufreq: replace per-cpu structures with lists
> >      - [PATCH] cppc_cpufreq: optimise memory allocation for HW and NONE
> >        coordination
> >    both found at [1].
> >
> >    This functionality was introducing the problem at [2] and it's fixed
> >    in this version by bailing out of driver registration if a _CPC entry
> >    is not found for a CPU.
> >
> >    Yousaf, it would be great if you can test this and make sure it
> >    matches your expectations.
> >
> >    Rafael, Viresh if you think this last patch introduces too many
> >    changes, you can skip it for 5.11 which is around the corner and
> >    have more time for review for 5.12. I've added more eyes in the review
> >    list.
> >
> >
> > All patches are based on linux next 20201211 after patch at [3] is
> > applied.
> >
> > [1] https://lore.kernel.org/linux-pm/20201105125524.4409-1-ionela.voinescu@arm.com/#t
> > [2] https://lore.kernel.org/linux-pm/20201210142139.20490-1-yousaf.kaukab@suse.com/
> > [3] https://lore.kernel.org/linux-pm/20201214120740.10948-1-ionela.voinescu@arm.com/
> >
> > Ionela Voinescu (4):
> >   cppc_cpufreq: use policy->cpu as driver of frequency setting
> >   cppc_cpufreq: clarify support for coordination types
> >   cppc_cpufreq: expose information on frequency domains
> >   cppc_cpufreq: replace per-cpu data array with a list
> >
> >  .../ABI/testing/sysfs-devices-system-cpu      |   3 +-
> >  drivers/acpi/cppc_acpi.c                      | 141 ++++++------
> >  drivers/cpufreq/cppc_cpufreq.c                | 204 ++++++++++--------
> >  include/acpi/cppc_acpi.h                      |   6 +-
> >  4 files changed, 181 insertions(+), 173 deletions(-)
>
> For the whole series:
> Tested-by: Mian Yousaf Kaukab <ykaukab@suse.de>

All patches applied as 5.11-rc material, thanks!
