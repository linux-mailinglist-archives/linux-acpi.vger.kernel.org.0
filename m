Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E4314EBA5
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2020 12:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgAaLXh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jan 2020 06:23:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39968 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgAaLXh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jan 2020 06:23:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id i6so6221175otr.7;
        Fri, 31 Jan 2020 03:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfiTN0BJfOgrv7nAN5xoTlpf87oyILezQoBQLhz/u3Y=;
        b=aA9rJUaOiED0pd1EuPZ5MqGHzsiGGgv3JmPGFnT4P0UOZgXhM7OQS7ZUigjUa2XCX8
         HG5UsWXl7bcPIzKpgK4Jso4mc605SkT0+c885RVNVA3KnwXWFaDwqcLFzpPQMJq6P3sB
         kb28nTXW+mAiiLafXg+2iXbTkU25gmnuosdL5GvCtZTYjWZX1WTK+yjQqNzmpfJU+03x
         wgltHZFrydRHXf9DMX7dkuEa7+6EhlnOlD1I7GuYQ2wHVPerGEAebrClKA/e3VZVsjxZ
         rYG5NRjArHw4cpDt3VDlGFXGIIG9/YE2lNSdd+Ikf8quzGDV8y1LOA1T7caAOPbS3r4O
         cx6g==
X-Gm-Message-State: APjAAAUhpqxw1Tt+3SzO3oFTeQUppwnCNbSqFon/UO9s1DptTcOsgWOh
        0HRrA1g9Xdv3faazVTTX6x70jeNjqssq2vpi2/0=
X-Google-Smtp-Source: APXvYqx0XF6foKWBfZ7QulrPIN7OzTtyFfuhASg9UWXoSCV0aiXAl+pvhHh42NXB9G8AheBfxsxdbAoIHuxXsY/dsNM=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr7388808otn.262.1580469816212;
 Fri, 31 Jan 2020 03:23:36 -0800 (PST)
MIME-Version: 1.0
References: <1720216.0Jr2BLnqKp@kreacher> <16995896.bQtfYxEEOs@kreacher> <86fb1cd10e344f76a3e96c4b6c722680@AcuMS.aculab.com>
In-Reply-To: <86fb1cd10e344f76a3e96c4b6c722680@AcuMS.aculab.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Jan 2020 12:23:25 +0100
Message-ID: <CAJZ5v0g3zJvjAwX0AU3wYL-VTL6_JZSGGG2HJKa5P2wqE3RGJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] intel_idle: Introduce 'states_off' module parameter
To:     David Laight <David.Laight@aculab.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 31, 2020 at 12:07 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Rafael J. Wysocki
> > Sent: 30 January 2020 14:47
> >
> > In certain system configurations it may not be desirable to use some
> > C-states assumed to be available by intel_idle and the driver needs
> > to be prevented from using them even before the cpuidle sysfs
> > interface becomes accessible to user space.  Currently, the only way
> > to achieve that is by setting the 'max_cstate' module parameter to a
> > value lower than the index of the shallowest of the C-states in
> > question, but that may be overly intrusive, because it effectively
> > makes all of the idle states deeper than the 'max_cstate' one go
> > away (and the C-state to avoid may be in the middle of the range
> > normally regarded as available).
> >
> > To allow that limitation to be overcome, introduce a new module
> > parameter called 'states_off' to represent a list of idle states to
> > be disabled by default in the form of a bitmask and update the
> > documentation to cover it.
>
> The problem I see is that there are (at least) 3 different ways of
> referring to the C-States:

So the mask is not referring to the C-states in the first place.

> 1) The state names, C1, C1E, C3, C7 etc.
>    I'm not sure these are visible outside intel_idle.c.

Yes, they are, in sysfs.

> 2) The maximum allowed latency in us.
> 3) The index into the cpu-dependant tables in intel_idle.c.
>
> Boot parameters that set 3 are completely hopeless for normal
> users. The C-state names might be - but they aren't documented.
>
> Unless you know exactly which cpu table is being used the
> only constraint a user can request is the latency.

So this mask refers to the idle states numbering in sysfs, as stated
in the documentation update.  That covers state0 which is not a
C-state too.

> (I've had the misfortune to read intel_idle.c in the last week.
> Almost impenetrable TLA ridden uncommented code.)

I have some patches to improve that, will post them after this is settled.

> ...
> > + * The positions of the bits that are set in the two's complement representation
> > + * of this value are the indices of the idle states to be disabled by default
> > + * (as reflected by the names of the corresponding idle state directories in
> > + * sysfs, "state0", "state1" ... "state<i>" ..., where <i> is the index of the
> > + * given state).
>
> What has 'two's complement' got to do with anything?

Well, it is the representation in which bits are used.  Kind of as
opposed to decimal or hex digits.  But I can replace that phrase with
"bits that are set in this number" easily enough.

> ...
> > +The value of the ``states_off`` module parameter (0 by default) represents a
> > +list of idle states to be disabled by default in the form of a bitmask.  Namely,
> > +the positions of the bits that are set in the two's complement representation of
> > +that value are the indices of idle states to be disabled by default (as
> > +reflected by the names of the corresponding idle state directories in ``sysfs``,
> > +:file:`state0`, :file:`state1` ... :file:`state<i>` ..., where ``<i>`` is the
> > +index of the given idle state; see :ref:`idle-states-representation` in
> > +:doc:`cpuidle`).  For example, if ``states_off`` is equal to 3, the driver will
> > +disable idle states 0 and 1 by default, and if it is equal to 8, idle state 3
> > +will be disabled by default and so on (bit positions beyond the maximum idle
> > +state index are ignored).  The idle states disabled this way can be enabled (on
> > +a per-CPU basis) from user space via ``sysfs``.
>
> A few line breaks would make that easier to read.

Fair enough.

Thanks!
