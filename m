Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33FE34225E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 17:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCSQo4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 12:44:56 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:45633 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCSQon (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 12:44:43 -0400
Received: by mail-oo1-f45.google.com with SMTP id n6-20020a4ac7060000b02901b50acc169fso2454340ooq.12;
        Fri, 19 Mar 2021 09:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWY5CCijnyjRQY4faBMER18CBDdc1TWI4GXSLY4NRN8=;
        b=E0/YVNY1NtKiyqfOFZEsnNCBsrFkPiYSr5QJkICUQAs01aQskR64wa+7VXeicxIHq/
         4Wc8aLvSJ5D+hwMnBD8Aa39PAd7pMMJABwX2ey8ysQKGdgYsHeXulxXMGRen2P89YvkZ
         Nsz5lS2xZh/nTqvsf7Xb6cihF6IFxaNRqihhQx4VK8uryf3DJ1SkBLcAGtLD2MwCZB64
         pHKMIIB5CRDulibgyCG3FrMIwFPQD8r71eXqDDmltgXZqxKAuCnu96UB7NVMliJom04p
         8LZ5t9Q41BXKzwCW2rGJ9THsfLQjIjE6JgRH015GLIJHX7pTQfv0R3akMqGRXK4xZLas
         bz1g==
X-Gm-Message-State: AOAM530Q6fa2JoERMCmrohr2eEMwXMOsuKcJrEqCE1w1culY11LglAyT
        CX32jYOiSA6VtwVLo/DowIrjdHwm1NOkwgK9pxpLpWQg
X-Google-Smtp-Source: ABdhPJxMqoI6Fku3UN9x3d6XB5wHx8C3IQU1LUTAcfF1mBuGY+HNMv4HBKU7nmulQr/P+jVQyXRNbHxPJNHD+Ygnjp0=
X-Received: by 2002:a4a:bb14:: with SMTP id f20mr2126956oop.1.1616172283014;
 Fri, 19 Mar 2021 09:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210312032430.13664-1-chris.chiu@canonical.com> <20210313102545.GB11435@duo.ucw.cz>
In-Reply-To: <20210313102545.GB11435@duo.ucw.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 17:44:32 +0100
Message-ID: <CAJZ5v0g7pEMA-QTonuVgMVmFCcHwnTtYYCaw7mVertPfhHNt8w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add missing callback back for Sony VPCEH3U1E
To:     Pavel Machek <pavel@ucw.cz>, chris.chiu@canonical.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Mar 13, 2021 at 11:27 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2021-03-12 11:24:30, chris.chiu@canonical.com wrote:
> > From: Chris Chiu <chris.chiu@canonical.com>
> >
> > The .callback of the quirk for Sony VPCEH3U1E was unintetionally
> > removed by the commit 25417185e9b5 ("ACPI: video: Add DMI quirk
> > for GIGABYTE GB-BXBT-2807"). Add it back to make sure the quirk
> > for Sony VPCEH3U1E works as expected.
> >
> > Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> > Reported-by: Pavel Machek <pavel@ucw.cz>
>
> Thanks for doing this.
>
> Reviewed-by: Pavel Machek (CIP) <pavel@denx.de>

Applied as 5.12-rc5 material, thanks!
