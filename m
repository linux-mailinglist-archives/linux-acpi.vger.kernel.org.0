Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54E2172C5
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgGGPnn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 7 Jul 2020 11:43:43 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43961 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgGGPnm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2020 11:43:42 -0400
Received: by mail-oi1-f177.google.com with SMTP id x83so27674340oif.10
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jul 2020 08:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lpIrGlVAIO2nDCq0i2VBwFQwDMZE1vnuNJJHbr59xHM=;
        b=qkXqDv2omjk/xG3xE4u6CAowUQE/vhGx879mRKGSGkUxmZihgX0WuLIY91wC2bWF8O
         Mi1DrePaTv+EIXZBQ2sPXedWcIIHjaEQztcoR1R/TecyVuYV0lZHfG25dFwDJfgj7fdg
         ywPHxXMWO+8facVkKjotA5Evfz89PFEbiVtg9x2ujiEEwS3LT0W9062fxNg0MBKxLfKt
         lIdULYIDtjHBl8afgE7BcYHB8hO26Izz0zo7C9VVDJBzX/KKjijqhlZBsleKY++OOSq5
         sMxNxUsNS1eDhrecfnGrAREcnB78cSytoUeSKRwQiM1I9ixVEYKlrlzehoPmETEFz2mN
         thQw==
X-Gm-Message-State: AOAM533FNj+4AWGVPLg3rPj6SjWxT2hDdqvmP7LUL0RuRrDKPWSToQpJ
        d573If30FkScXUVs5wmnlmDWVDpbzULsqcgSpTg=
X-Google-Smtp-Source: ABdhPJyQdpLaQuGjRN6AjpNwn+HDG4Qfd2TaU3xivjeCLZdVLTQK1qKc2+wG6irgSrL6Y8aJ+vZuAer5sYURVpphd4I=
X-Received: by 2002:a54:4e87:: with SMTP id c7mr3874582oiy.110.1594136621901;
 Tue, 07 Jul 2020 08:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <bug-1854502-8448@https.bugzilla.redhat.com/> <9b3d85b5-b562-631f-adfd-6460bc6c4179@redhat.com>
In-Reply-To: <9b3d85b5-b562-631f-adfd-6460bc6c4179@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jul 2020 17:43:31 +0200
Message-ID: <CAJZ5v0gO7b8X6MMDO_UvGBc-PNH-o=U47+MuS1uk4E_tSF-Ogg@mail.gmail.com>
Subject: Re: [Bug 1854502] New: Noticeably Increased CPU temperature
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On Tue, Jul 7, 2020 at 5:32 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> I got a copy of the below bugreport in my mailbox and I
> was wondering if this rings any bells.
>
> Are there any relevant power-management / scheduler
> changes in 5.7 (vs 5.6) which might be related?

There were a few, but I'm not sure how they can cause thermal issues to happen.

> And is there any quick way for the reporter to test this
> (by e.g. picking a different scheduler / cpufreq-governor).

Well, as usual, I would recommend looking for possible configuration
differences between the good and bad cases, ie. different default
governors, different cpufreq/cpuidle drivers etc.

Also, if the system is Intel-based, run turbostat to collect CPU PM
information for both the good and bad cases.

Cheers,
Rafael

> -------- Forwarded Message --------
> Subject: [Bug 1854502] New: Noticeably Increased CPU temperature
> Date: Tue, 07 Jul 2020 15:23:38 +0000
> From: bugzilla@redhat.com
> To: hdegoede@redhat.com
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1854502
>
>              Bug ID: 1854502
>             Summary: Noticeably Increased CPU temperature
>             Product: Fedora
>             Version: 32
>            Hardware: x86_64
>                  OS: Linux
>              Status: NEW
>           Component: kernel
>            Severity: medium
>            Assignee: kernel-maint@redhat.com
>            Reporter: aria.aghazade@gmail.com
>          QA Contact: extras-qa@fedoraproject.org
>                  CC: acaringi@redhat.com, airlied@redhat.com,
>                      bskeggs@redhat.com, hdegoede@redhat.com,
>                      ichavero@redhat.com, itamar@ispbrasil.com.br,
>                      jarodwilson@gmail.com, jeremy@jcline.org,
>                      jglisse@redhat.com, john.j5live@gmail.com,
>                      jonathan@jonmasters.org, josef@toxicpanda.com,
>                      kernel-maint@redhat.com, lgoncalv@redhat.com,
>                      linville@redhat.com, masami256@gmail.com,
>                      mchehab@infradead.org, mjg59@srcf.ucam.org,
>                      steved@redhat.com
>    Target Milestone: ---
>      Classification: Fedora
>
>
>
> First things first, I'm running Fedora 32 with latest packages on intel 6700hq.
> With latest kernel-5.7, cpu temperatures are noticeably higher.
> Using kernel-5.6 my idle cpu temperature is around 35-40°C, but with kernel-5.7
> its around 50-55. Htop and KDE System Monitor don't show anything using cpu and
> idle cpu usage on both kernels is 0-2%.
>
> I first noticed this issue on kernel-5.7.6-201.fc32.x86_64, and it is also
> there with kernel-5.7.7-200.fc32.x86_64.
>
> Booting with kernel-5.6.19-300.fc32.x86_64 fixes the issue.
>
>
> Are you running any modules that not shipped with directly Fedora's kernel? No.
