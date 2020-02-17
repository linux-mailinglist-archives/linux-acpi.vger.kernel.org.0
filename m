Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E63161C45
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Feb 2020 21:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgBQUYH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Feb 2020 15:24:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42135 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgBQUYH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Feb 2020 15:24:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so17328386otd.9
        for <linux-acpi@vger.kernel.org>; Mon, 17 Feb 2020 12:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akysGxdKhK3MYsMhEZi1oop0cwtFYm4rxc0Zw7OEjBs=;
        b=jhoS/6AVWc2VYaUndWOMyXK9frtkMXXGW8Tow9el7tQpmOtpzzMZoFJoap/v9PJ4on
         b3sdju5PZRyIcrBPWnEszhgWd6vUa11A6yhBwz3sG2bwvk5xahYJbi0dxZw/bgyzUlME
         5HkbsJGEBeXa1ky5osXV70Thm7olVxY/GZHRVy/5td9MdFcn4bPKNbXP3f68gmoua0Db
         P5TVrGcX/RiSASMMJUorGdvks7KEfjTHMKJt+S4+Q6moTVdNO2gdMMwDC/Rt5qVKvsP9
         2EfUH6jsnttXPz9wD0RfrEDDKDgrS5xzqQQSMGbTaZykbBi34oSHShmPj3NiwBriepxV
         D+AQ==
X-Gm-Message-State: APjAAAVjY71mN/Zc+MUPDnA+1BnuCNz08GBf9/agD5MshfD4q3T4zMlP
        eNmz7t4mbzf3yDtecz/qVdnxBKbX0QZ4W12NK04=
X-Google-Smtp-Source: APXvYqzbYnQ6BX3cPDGz0UfkI6gdrjr79lNPgymVxAU7DhHRo5Ad2p8k5EHzKawd8hF2sI/xJCq9PGT6mWYu5PbWyV8=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr13463986otn.262.1581971046393;
 Mon, 17 Feb 2020 12:24:06 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2002141734590.24119@n3.vanv.qr>
 <CAJZ5v0jesX_fz6-1wnNqYqtVE1qtjZhMsq2OW2L6EGvcpLPtsg@mail.gmail.com>
 <nycvar.YFH.7.76.2002161038370.4312@n3.vanv.qr> <CAJZ5v0jOOi0SjZ+SUv8L8f6z2uxu40Q7AP_q9XKVEOePxwBHfg@mail.gmail.com>
 <nycvar.YFH.7.76.2002170109040.8537@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.76.2002170109040.8537@n3.vanv.qr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Feb 2020 21:23:55 +0100
Message-ID: <CAJZ5v0g+xnQb7t_d5dqMaPUDhSXiGVNri+kc75Tj5fjCgith3A@mail.gmail.com>
Subject: Re: Linux hangs at ACPI init on Medion P15648 MD63490
To:     Jan Engelhardt <jengelh@inai.de>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 17, 2020 at 1:10 AM Jan Engelhardt <jengelh@inai.de> wrote:
>
>
> On Sunday 2020-02-16 21:49, Rafael J. Wysocki wrote:
>
> >> I thus went back to 5.6-rc and enabled full ACPI tracing
> >> (layer=0xffffffff/level=0xffffffff) starting from
> >>
> >> nsinit.c:213    /* Walk namespace to execute all _INIs on present devices */
> >>
> >> onwards. That log output is at http://inai.de/files/m923.mp4 [53MB].
> >
> >If that is the case, then AFAICS the issue may not be directly related
> >to the EC at all.  This output only means that the system has an ECDT,
> >but that should not be a problem by itself.
> >
> >The system appears to hang somewhere in acpi_ns_initialize_devices()
> >and it is hard to say where exactly.
>
> I had an exact stack trace. (Stashed in all those videos - now extracted and
> posted to the bug)
>
> >I would suggest creating a BZ entry at bugzilla.kernel.org for this
> >issue and attaching the output of acpidump from the affected system in
> >there.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=206553

Erik, Bob, can you please have a look at this BZ?  It looks like there
is a deadlock on the global lock while processing some AML during
acpi_ns_initialize_devices() execution.
