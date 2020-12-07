Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5445A2D197E
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 20:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgLGTaA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 14:30:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41797 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGTaA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 14:30:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id 15so5488066oix.8;
        Mon, 07 Dec 2020 11:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zKVYyE2btS5Zmt/3JSRrYr9q8pHZIlvwA2xtZ/GJ7o=;
        b=ZCmkWmWurt16WBFVjdOG73fhlZC4rAm5kquMUXYodIYJ66GIjpBBEjK9eA/Crs0SX/
         AfPpjt9OxqKkoFCuAgzo1BOnn1nbL2j8mt1pkr4jpXWbCFmh3xOnDdfPcwHdgWy/ec1i
         2tDWN0YSF4uCB9k6fC/iXz/i1ZzuCUIGJ5IBu6Lhw6uPWUyUuMXk8ewwiCr0t5i3BhJ1
         nW5nryiF4pasbvmXuinTf6gIY4lpMP8fHJf7LDQY5zqZpbEn4EtIyNIJyDEru1vALy73
         t3GXAcCDKzIbLWljOAmWEWU53bAvsTJgLKp7wdHM8WVwLDEww1qtLdjqf5vAQfl/G/f9
         gFjg==
X-Gm-Message-State: AOAM530xwREFFt00+1Thyo8ipL5GiYICbZYqC/afpX5Yqd+Q6Pkdmmjf
        wauh34fPiaPLKwQHANG9EsvCphPfdEKUwKnAMqA=
X-Google-Smtp-Source: ABdhPJxZzsT8tSxR91QcuQmS+PlJfB/5CunQOGdydGFfrIuLTUKa0BO4zDIgOzmexb1XqHRtW0IO+KfN6dOed/+D1dY=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr261202oib.69.1607369359070;
 Mon, 07 Dec 2020 11:29:19 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201202171120.65269-1-markpearson@lenovo.com>
 <74b6ef2c-ac13-bffe-edda-478512950d22@redhat.com>
In-Reply-To: <74b6ef2c-ac13-bffe-edda-478512950d22@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Dec 2020 20:29:08 +0100
Message-ID: <CAJZ5v0iWD5Ej-1oCfMAskvQoovMRVc5TkpST1t9brsJirx+5zQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <mgross@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 3, 2020 at 10:46 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/2/20 6:11 PM, Mark Pearson wrote:
> > On modern systems the platform performance, temperature, fan and other
> > hardware related characteristics are often dynamically configurable. The
> > profile is often automatically adjusted to the load by some
> > automatic-mechanism (which may very well live outside the kernel).
> >
> > These auto platform-adjustment mechanisms often can be configured with
> > one of several 'platform-profiles', with either a bias towards low-power
> > consumption or towards performance (and higher power consumption and
> > thermals).
> >
> > Introduce a new platform_profile sysfs API which offers a generic API for
> > selecting the performance-profile of these automatic-mechanisms.
> >
> > Co-developed-by: Mark Pearson <markpearson@lenovo.com>
> > Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Thank you, patches 1 and 2 look good to me now, you may add my:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> To patch 2 (since I'm co-author of patch 1 it would be a bit weird
> to add it there too).
>
> Rafael, it would be great if you pick up patches 1 and 2 for merging
> into 5.11 (assuming that you agree that they are ready) then I will merge
> patch 3 once 5.11-rc1 is out.

I've applied patch [1/2] (as 5.11-rc material) for now, but I still
needed to fix it up somewhat.  Please check the result in my
bleeding-edge branch.

I'll get to the other patch tomorrow.

Thanks!
