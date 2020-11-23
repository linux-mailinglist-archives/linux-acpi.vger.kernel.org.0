Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709572C0C0B
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 14:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgKWNl2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 08:41:28 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:41123 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgKWNl2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 08:41:28 -0500
Received: by mail-oo1-f66.google.com with SMTP id o20so1266969oor.8
        for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2020 05:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uzg2CWacu4W4GlJ6NBVFRFXDacRPVqyu89NGY2akLvw=;
        b=aO81D1ecEAkS4h+uqSvK8WEkGWNF+1efmPM7igTq9AEArwgpEMUgzdc3an4eb3JxGJ
         roHplcQULr0n5KX8h0zAn7616dRTYUnEXdntoJIyEZEynXRqEZ9JWs2T4VVz3JHbTohs
         uclhZ2B6AciwfZNIqoeVhUZ+hC9dP3IqjJA1XBaMzL3dcb//KcNL6SRR/wnCDIpDDbuJ
         rfauYOAJDwJDycJhDxaBjxVLzFhAgmUq7d0Frt9PZTuwpef+qZplMzXwvy2gwp7csdjg
         lyc6OdwTkkxz7qr/D9MOz0OBd9owWUt69lo6D9/HOEh3+2VuI9+oSV/KBB5nbq9v6aNA
         IgxA==
X-Gm-Message-State: AOAM531vDdsdaRW3nntDSh7ct5lqQiqqiwAOUTCjnxRBfWJiBJfBNg/d
        LJK0NVa4n9PhsmSA1r7gBJh+lJNmYcmRh4thzgA=
X-Google-Smtp-Source: ABdhPJyHwPjFVmaQhJGxWaY8WxHE4CJyzXYWxLmBB3p57jqGuAJUtGxGbWV4zuLprnIIjQhekAjUXlR21ZPn+l05fMs=
X-Received: by 2002:a4a:aac4:: with SMTP id e4mr16385022oon.2.1606138886999;
 Mon, 23 Nov 2020 05:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20201121203040.146252-1-hdegoede@redhat.com> <20201121203040.146252-6-hdegoede@redhat.com>
 <CAJZ5v0i+Oz4meRo+YQw_LRZXReo9APh4kpqAP4Nby8_HExrrJg@mail.gmail.com> <f43be417-8919-6b4b-f554-32d71d81f8c0@redhat.com>
In-Reply-To: <f43be417-8919-6b4b-f554-32d71d81f8c0@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 13:41:09 +0100
Message-ID: <CAJZ5v0irXOGXr0R5xKudAJpBa1iFis3MwsPmAXJAVPBEGDRn3g@mail.gmail.com>
Subject: Re: [PATCH 5/7] ACPI: scan: Add support for deferring adding devices
 to the second scan phase based on the _DEP list
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 23, 2020 at 2:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/23/20 1:17 PM, Rafael J. Wysocki wrote:
> > On Sat, Nov 21, 2020 at 9:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> The current solution, of deferring adding of some devices because they
> >> need access during the OpRegions of other devices while they are added,
> >> is not very generic.
> >>
> >> And support for making the decision to defer adding a device based on
> >> its _DEP list, instead of the device's HID being in a fixed list of HIDs
> >> to defer, which should be a more generic way to deal with this.
> >
> > Thanks a lot for working on this!
>
> You're welcome.
>
> > I'll have a more thorough look at the series later this week, stay tuned.
>
> Ok.
>
> >> Since this is likely to cause issues on some hardware, this new method will
> >> only be used if the new acpi.defer_scan_based_on_dep kernel commandline
> >> option is set to 1.
> >
> > However, I already can say that I don't like the new command line option.
>
> You don't like the name, or you don't like having a commandline option for this?

The latter.

> Anyways I'll wait till you have taken a closer look.

OK, thanks!
