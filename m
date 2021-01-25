Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE1302783
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 17:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbhAYQKN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 11:10:13 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36728 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbhAYQJs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 11:09:48 -0500
Received: by mail-ot1-f42.google.com with SMTP id d7so5497356otf.3;
        Mon, 25 Jan 2021 08:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YvaHpgEbGNK1hYYfVoX+VD9+F7xaMKXTEHaFZo2RAoc=;
        b=SA0a4xVAVvd4rW/cyUSceoIaPmwAY4QUSlO57B8i4hKvmGhKAdPT3BiYnpswHRoPe9
         MsHctXYX5PTDgHqoH0zfU8FQh63XXp48QBdtnREF23wIpRFnAqQf6vS5Na5anme2Jvt/
         2NkkbwHkjQ/nxYL7d5SzF2TCsFoamZu++hz3DruQtUHPL1NxJSebakbPz9dYxMln+iR4
         fXL5yVm5XcgqRErvb7lBVVm9z/mIXphpqB5r+ZpOaeG411InH0ekpYBrUpeXXDvDRF30
         2esuYLFDdfcJvsirUVeQH4xdYHw1Oxi/4lOXpdbbRO65nAcYIBy++3tlbseih4wolUih
         +UDg==
X-Gm-Message-State: AOAM531KLudeFShqe5gQuLbca0gOfEjXovI4AAAfuS6ASZmL6/Nkv5ON
        oyGyce8UnyrNW8LFwXDUEvX9Hdqyu/t199ZfyQkoq1mt
X-Google-Smtp-Source: ABdhPJykIN+/Xa795R8a1kQrnvteDiw/is5D9Wr88ncijkPejqn0kf9B/Uu0SaRtUa6C3Yb0uJ0qRC53fNMe2D4Y9qk=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr930088ote.321.1611590947536;
 Mon, 25 Jan 2021 08:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20210122125302.991591-1-kai.heng.feng@canonical.com> <YArN3Gec5h6jPxWq@kroah.com>
In-Reply-To: <YArN3Gec5h6jPxWq@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jan 2021 17:08:55 +0100
Message-ID: <CAJZ5v0j6Y-cbqs6sAz-bxaHPpBsu95gFnuGQJyoqgXNpfEOfcw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / device_sysfs: Prefer "compatible" modalias
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 22, 2021 at 2:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 22, 2021 at 08:53:02PM +0800, Kai-Heng Feng wrote:
> > Commit 8765c5ba1949 ("ACPI / scan: Rework modalias creation when
> > "compatible" is present") may create two "MODALIAS=" in uevent file if
> > conditions are met.
> >
> > This breaks systemd-udevd, which assumes each "key" in uevent file is
> > unique. The internal implementation of systemd-udevd overwrites the
> > first MODALIAS with the second one, so its kmod rule doesn't load driver
> > for the first MODALIAS.
> >
> > So if both ACPI modalias and OF modalias are present, use the latter
> > one to ensure there's only one MODALIAS.
> >
> > Reference: https://github.com/systemd/systemd/pull/18163
> > Cc: AceLan Kao <acelan.kao@canonical.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/acpi/device_sysfs.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
>
> Thanks for fixing this up!
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied as 5.11-rc material with some minor edits in the subject and
changelog and with the tags.

Thanks everyone!
