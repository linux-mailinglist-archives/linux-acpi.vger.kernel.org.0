Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA62E9EEA
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 21:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbhADUeV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 15:34:21 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:41512 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbhADUeV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 15:34:21 -0500
Received: by mail-oo1-f49.google.com with SMTP id q6so6586174ooo.8;
        Mon, 04 Jan 2021 12:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgrAU8KM4ELdBDdDZ1NUdXMOaBOszDUdOPw2PaPAN/Q=;
        b=ivaojlV8macIYtOzqd2k5Lsq8T8JlGrP3kD4cJZ0vKp27jOKK/doHQ83LfaCH0o4M6
         QSgSiFTa37+h4aRvMS29NjjRBk6TmCHJzBhyto83aBo5jWjsQOT3CJyXK9eLiwtwiWMZ
         pN0yCfm81ekPAdaFhPSgadwFfjjapFmqZWHSTPgApmcgHER0AGRm3YPU1Gl4GD5v/1LR
         lHdfBauLCFaQQjOiQhxig/Bo9scOPX4LUj/IysMiVciS1ioYFAEUr7m3A4I49gNkMcll
         fld2e6AlYXkP+rjaIx/jrtcsXqjpfaTR5UJfJbogH5/U3kkkhWPzt80wP32DQm5JwJHm
         94ZA==
X-Gm-Message-State: AOAM530bqNgQn95aDaQpOkYAjfA3CHpFU371NJQnhpIt9LFL4VLXAWhY
        3wdaNW1Cs3bMF6LfShtowl7e3D6B+JhLzd2dOE9V6PBT
X-Google-Smtp-Source: ABdhPJxWQUW78fC8NkEHcU+eYt3Zk22BBKXj4QWGskzqaMAHH1IWs3/6cgRSWOAPEzInEQP0JY+UKUB6rStbt8K8+/Q=
X-Received: by 2002:a4a:9873:: with SMTP id z48mr50521121ooi.44.1609792420022;
 Mon, 04 Jan 2021 12:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com> <35ac853a-266c-6944-6e5e-6286456865e3@redhat.com>
In-Reply-To: <35ac853a-266c-6944-6e5e-6286456865e3@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Jan 2021 21:33:28 +0100
Message-ID: <CAJZ5v0jcCD3qWUJQcS+nFVJWSCQEbq2eN3i07mN8yFr3WZD9dg@mail.gmail.com>
Subject: Re: [PATCH 0/2] IdeaPad platform profile support
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 4, 2021 at 3:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/1/21 1:56 PM, Jiaxun Yang wrote:
> > Tested on Lenovo Yoga-14SARE Chinese Edition.
> >
> > Jiaxun Yang (2):
> >   ACPI: platform-profile: Introduce data parameter to handler
> >   platform/x86: ideapad-laptop: DYTC Platform profile support
> >
> >  drivers/acpi/platform_profile.c       |   4 +-
> >  drivers/platform/x86/Kconfig          |   1 +
> >  drivers/platform/x86/ideapad-laptop.c | 281 ++++++++++++++++++++++++++
> >  include/linux/platform_profile.h      |   5 +-
> >  4 files changed, 287 insertions(+), 4 deletions(-)
>
>
> Thank you for your series, unfortunately the
> "ACPI: platform-profile: Introduce data parameter to handler"
> patch causes a conflict with the pending:
> "[PATCH v8 3/3] platform/x86: thinkpad_acpi: Add platform profile support"
> patch.
>
> But I do agree that adding that data parameter makes sense, so
> it might be best to merge:
>
> "ACPI: platform-profile: Introduce data parameter to handler"
>
> First and then rebase the thinkpad_acpi patch on top.
>
> Rafael, do you think you could add:
>
> "ACPI: platform-profile: Introduce data parameter to handler"
>
> To the 2 ACPI: platform-profile patches which you already have pending for 5.11-rc# ?

I'm not sure why that patch is needed at all, because whoever
registers a platform profile handler needs to have access to the
original handler object anyway.

Also, on a somewhat related note, I'm afraid that it may not be a good
idea to push this series for 5.11-rc in the face of recent objections
against new material going in after the merge window.

Cheers!
