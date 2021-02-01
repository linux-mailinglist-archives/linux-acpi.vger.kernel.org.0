Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9559B30A926
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 14:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBAN4P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 08:56:15 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42061 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhBAN4O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 08:56:14 -0500
Received: by mail-ot1-f53.google.com with SMTP id f6so16255918ots.9;
        Mon, 01 Feb 2021 05:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTKR2kmhuBWrBGz+V3z5044ANL/eZ8DSg0xWaoeiBD0=;
        b=OEHdeAEmOw8IWYEvV4dzo4Wz/sW+c9qqEiyYNt0WVroVIdaEvaiwKbqgyRM2IVsP35
         63ZQrFKHJuAF4STYsu+I5H7LUB2JMSzaJcMdjytR7zVKDwTs/TOut8HpRqj+AHOKeiTR
         oXHgb8sciakvirMN4g1cIUpQpzm9eRZ7XPrqSMP3uTx0yrOCCTUf8EkG7lMdmgj2J8uL
         DWXax6jXx6KEBQEamI9tcJ0qIazn4dhay8j9pe87uQ7La7FltMEL0WqPQeoZ3NCIbd01
         JaaqLiBpb03S/AmpkSvqCfNBJE/n2qtLL5p5w34KBRQsSgGLQWvRtYoxKJxaG4E990Wv
         0+aA==
X-Gm-Message-State: AOAM531Zwgh9KfhT0oB2qdLHZo4p9tABjE1TW6OFZv+XSrMNPWil4ouv
        0alnsv7OLigGpjHR954CYVINZgpF93CBRebmzp0=
X-Google-Smtp-Source: ABdhPJzDm2YvxWjVDH9fGdHmK/DlgeIeOT7GYG4PTpY0QlPnHWerNbzAeOQ+DJRhdCRdQcNwZmRD2q/LCF6UUlWX+W8=
X-Received: by 2002:a9d:6acf:: with SMTP id m15mr11691953otq.260.1612187733540;
 Mon, 01 Feb 2021 05:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20210125115957.3292-1-hdegoede@redhat.com> <20210125115957.3292-3-hdegoede@redhat.com>
 <CAJZ5v0iVGpUxUVMAO4R9bz8dogFRoYun-9-4G_Mgzq0_WP305Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0iVGpUxUVMAO4R9bz8dogFRoYun-9-4G_Mgzq0_WP305Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Feb 2021 14:55:22 +0100
Message-ID: <CAJZ5v0iCWXmtAApSvVwmWT_p8QXoK9oivTFkxynf3LPEjCE7+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: platform-profile: Introduce object pointers
 to callbacks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 27, 2021 at 6:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 26, 2021 at 6:58 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >
> > Add an object pointer to handler callbacks to avoid the need for
> > drivers to have a global variable to get to their driver-data
> > struct.
> >
> > Link: https://lore.kernel.org/linux-acpi/6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com/
> > Link: https://lore.kernel.org/r/20210114073429.176462-3-jiaxun.yang@flygoat.com
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Applied on top of the previous platform-profile patches, thanks!

And the entire acpi-platform-profile material is now available for you
to pull in the git branch at:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-platform

which is not going to be rebased going forward.

Thanks!
