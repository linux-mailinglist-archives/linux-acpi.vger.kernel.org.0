Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC18A95D
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2019 23:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfHLVc6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Aug 2019 17:32:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38755 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLVc5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Aug 2019 17:32:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so14798929ota.5;
        Mon, 12 Aug 2019 14:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T15PQcJHH7yU42jE/kUBJ3OwgXX/58NrUUahBWzpzL4=;
        b=G2R9656/rcW0V4dhF2uQBWvIRaxHl52h+Y2tDCFsLRcOreggoyvLGqQP2FQJnzlg6c
         VbfLKSYwmVRQvjiFIaTx6RNOeMgR3NbVPZzZN6uEQ+Ol0Nusci3Cavg85K6JkTF5rtzY
         fXzIan4315aUwm+j9qmURv/gJQQCi7BI3Azdtr2ivkFfz+od+iS8i5BYccugUP1v/YLG
         xpOGhNujtHtiQd/W+Q8J3FeMGb/8VsqORuOmtySVBiya0J3QGSVxxd2iwADQPJaiD1N8
         yEzJn4CC6xEN9O5mknqCC6wppufPDsqaw85J8f8+nZRdvinnYC6AM3Dp1PV7NO5WiLWB
         lEDA==
X-Gm-Message-State: APjAAAVsau3izYZIyyWmQowVwO6tyVgjx3iRIVn9MCkV+jHGMkbwyeSY
        toHK1gzGgakwS92/pDG++jx8jlsY9hoGtybncvs=
X-Google-Smtp-Source: APXvYqwaK5aWRHJ+wdTXMof/4nNlU3VL0vED6upaBLHtMIxnpspFhM/Rtu6oTRDYjm55WB455ZAI702KHRy0rJHmJg0=
X-Received: by 2002:aca:d907:: with SMTP id q7mr840724oig.68.1565645576650;
 Mon, 12 Aug 2019 14:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <5997740.FPbUVk04hV@kreacher> <a5548466-2e8e-84d0-357d-e2ca0c72097c@linux.intel.com>
In-Reply-To: <a5548466-2e8e-84d0-357d-e2ca0c72097c@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Aug 2019 23:32:45 +0200
Message-ID: <CAJZ5v0jpcJDN75EhcWWgtMWwYt0dWa+XE8RK2hFzbskeb2f3pA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] PM / ACPI: sleep: Additional changes related to suspend-to-idle
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 12, 2019 at 3:55 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> Hi Rafael
>
> On 02-Aug-19 4:03 PM, Rafael J. Wysocki wrote:
> > Hi All,
> >
> >>> On top of the "Simplify the suspend-to-idle control flow" patch series
> >>> posted previously:
> >>>
> >>> https://lore.kernel.org/lkml/71085220.z6FKkvYQPX@kreacher/
> >>>
> >>> sanitize the suspend-to-idle flow even further.
> >>>
> >>> First off, decouple EC wakeup from the LPS0 _DSM processing (patch 1).
> >>>
> >>> Next, reorder the code to invoke LPS0 _DSM Functions 5 and 6 in the
> >>> specification-compliant order with respect to suspending and resuming
> >>> devices (patch 2).
> >>>
> >>> Finally, rearrange lps0_device_attach() (patch 3) and add a command line
> >>> switch to prevent the LPS0 _DSM from being used.
> >> The v2 is because I found a (minor) bug in patch 1, decided to use a module
> >> parameter instead of a kernel command line option in patch 4.  Also, there
> >> are 4 new patches:
> >>
> >> Patch 5: Switch the EC over to polling during "noirq" suspend and back
> >> during "noirq" resume.
> >>
> >> Patch 6: Eliminate acpi_sleep_no_ec_events().
> >>
> >> Patch 7: Consolidate some EC code depending on PM_SLEEP.
> >>
> >> Patch 8: Add EC GPE dispatching debug message.
> > The v3 is just a rearranged v2 so as to move the post sensitive patch (previous patch 2)
> > to the end of the series.   [After applying the full series the code is the same as before.]
> >
> > For easier testing, the series (along with some previous patches depended on by it)
> > is available in the pm-s2idle-testing branch of the linux-pm.git tree at kernel.org:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=pm-s2idle-testing
> >
> > Please refer to the changelogs for details.
>
>
> I have tested both pm-s2idle-testing and pm-s2idle-rework branches
> including recently introduced commit "PM: suspend: Fix
> platform_suspend_prepare_noirq()".
>
> Works fine for me on Ice Lake platform.
>
>   Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>
> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

Thanks!
