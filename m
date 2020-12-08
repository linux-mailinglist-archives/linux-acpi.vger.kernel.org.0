Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48B42D2C80
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Dec 2020 15:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgLHOCn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 09:02:43 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45209 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgLHOCn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 09:02:43 -0500
Received: by mail-oi1-f196.google.com with SMTP id f132so5005897oib.12
        for <linux-acpi@vger.kernel.org>; Tue, 08 Dec 2020 06:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSwxlrV7qQpMJpm+mHmE+RXNeYSwozbYs6lfIL7Jw+Q=;
        b=VjKnrSoY+SBz/T92QlnEYrNTz5NZDQwGwVQnxWECEUI41/Pypq52ZUP2ibuH5+i7Xd
         0ZsYn1CIUwDfL5fi3KnLh3Gi7+2dk9N8Nccn6NlpwsYFmr6akD5EeTOLl/bHRQqMje77
         uUVYkR5e5B3B41nB5GXzQcVj29GulhBrPTQ6sSL2RhtZjlY16zg3o6hkGYsqTCWMsHJP
         nHAUHr61VuZsAWjJvfaJhwehpN4w54iw+3eSXhSmcg091RfZIQ/6G0y8zutRXeew2iGA
         xiTPvESKVDGJK+upAiAilw6nGqOFUEThpXV5RufUgOvHmSmN2VU3keBzv1aR+hI4VqxK
         xchg==
X-Gm-Message-State: AOAM533iN8d90b7M4a/aXrBypyYoNrFskC08RUZ5Ettl/Q4yi4cBnEIO
        NQyP9l+iFbzTSzwt7PA+1lUaWmkHWwCqjU7kF1I=
X-Google-Smtp-Source: ABdhPJy7PljTXTCDKqGwytAYJc4VIQfuRWU381HKkMv7u8kf3OnqQng1eEIdlG16o0RT5TBPIJrQuwwC4fNP3k99HhQ=
X-Received: by 2002:aca:cf4a:: with SMTP id f71mr2854280oig.157.1607436123092;
 Tue, 08 Dec 2020 06:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20201204075041.44339-1-hui.wang@canonical.com>
 <CAJZ5v0jnVoo_heYUAfbt4t6xFAOqq+dGus1LCZP_-5Q8o8cpQQ@mail.gmail.com> <27211ea4-a691-ae96-4fed-6bb8f214963d@canonical.com>
In-Reply-To: <27211ea4-a691-ae96-4fed-6bb8f214963d@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Dec 2020 15:01:50 +0100
Message-ID: <CAJZ5v0gx4u9mWKxbe4kX2YRZsWFRt-x3DGTJMS2npRiyq2aCNQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / bus: skip the primary physical pnp device in companion_match
To:     Hui Wang <hui.wang@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 8, 2020 at 3:02 AM Hui Wang <hui.wang@canonical.com> wrote:
>
>
> On 12/7/20 9:11 PM, Rafael J. Wysocki wrote:
> > On Fri, Dec 4, 2020 at 8:51 AM Hui Wang <hui.wang@canonical.com> wrote:

[cut]

> >
> > Would dropping the device ID in question from acpi_pnp_device_ids[]
> > make the problem go away?
> >
> > If so, why don't you do just that?
>
> Yes, if remove "WACFXXX" from acpi_pnp_device_ids[], could fix this
> issue. I planned to do so, but I found the pnp_driver in the
> drivers/tty/serial/8250/8250_pnp.c still handle this ID, maybe it could
> introduce regression on old machines if removing it.

Well, "WACFXXX" is not a proper device ID, it is a wild card possibly
matching too many devices.

What device ID specifically is used in the ACPI tables for the device
in question?
