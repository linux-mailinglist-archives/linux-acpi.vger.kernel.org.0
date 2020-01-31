Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C80014EC2F
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2020 13:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgAaMDw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jan 2020 07:03:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40077 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgAaMDw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jan 2020 07:03:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so6311381otr.7;
        Fri, 31 Jan 2020 04:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqpET/J/MD20LaDgPuTRS5n8V9jD3XdrrukQnBqfyM4=;
        b=AP9QRkV/MnARxZfM7GWa1FizijRkVAZFh4wOJGFKRVbNueicbp8nrJj2Jua1rCQKjV
         lb95oCe2ZL3Jx9RRaF+prjgyrMUfi48MK5s8Bnt7ywnYhi3shnN6kcdgcrqmpV2IQCTh
         C8klCRPn55wgD8pkqyPg6Bc5FLho14rphHl4Yl7Q+iXLnxWLlJd5XWR/Q8j0oTIzD8Yv
         xT1vU4bOyuIl/zkWATUJr7708e4J10PeRq/8qgbZ4EEhcS85g7as0roRrHx1Z68uTVtt
         UsFGjPLEeA8NfqUCgqLT33/BsCHP6F8zNmadsNeUR0U73+CaCkeOnyowAM9XwKkfK0iz
         /ZWQ==
X-Gm-Message-State: APjAAAVQiSU83xReG1vYqEPWqmj7Ajv10pwlLunkqSKoDYpGzSa6Szon
        j/uOrewEC3aMG7y7x3iGaFLMJlBttyQ2ifyrRAs=
X-Google-Smtp-Source: APXvYqxT9W9aXcls0rTQrVm3MU+/BRRmIFYQzIWVLkdswfzn5wYstiWi45Z/4WGuoyhvxrq/TuDXhAg9vPWUdVdbPEE=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr7434450otd.266.1580472231259;
 Fri, 31 Jan 2020 04:03:51 -0800 (PST)
MIME-Version: 1.0
References: <1720216.0Jr2BLnqKp@kreacher> <16995896.bQtfYxEEOs@kreacher>
 <86fb1cd10e344f76a3e96c4b6c722680@AcuMS.aculab.com> <28a92577c83276baf355dc8de272a79dc854025a.camel@linux.intel.com>
 <6cf71f6964c6433abeaf445847c97611@AcuMS.aculab.com>
In-Reply-To: <6cf71f6964c6433abeaf445847c97611@AcuMS.aculab.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Jan 2020 13:03:40 +0100
Message-ID: <CAJZ5v0hT9=2S9fMNQYHC5sy3b3Z_pT304Mr2=QCQY_jxi2cozg@mail.gmail.com>
Subject: Re: [PATCH 2/2] intel_idle: Introduce 'states_off' module parameter
To:     David Laight <David.Laight@aculab.com>
Cc:     "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 31, 2020 at 12:54 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Artem Bityutskiy >
> > Sent: 31 January 2020 11:24
> > On Fri, 2020-01-31 at 11:07 +0000, David Laight wrote:
> > > Unless you know exactly which cpu table is being used the
> > > only constraint a user can request is the latency.
> >
> > Hi David,
> >
> > in all my use-cases I always know what is the CPU I am dealing with and
> > what are the C-states. Simply because in my view they are always CPU-
> > dependent in terms of what they do and how are they named.
> >
> > What you say sounds to me like you would want to disable some C-states
> > without knowing anything (or much) about the CPU you are dealing with
> > and the C-state names.
> >
> > If so, could you please share examples of such use-cases?
>
> Dunno, but clearly you want to disable (say) C3 while leaving C6
> enabled.
>
> I was trying to find why it was taking 600+us for a RT process
> to get rescheduled when it had only been sleeping for a few us.
>
> I found where it was sleeping, but that didn't help at all.
> Someone pointed me at a 'random' pdf that referred to /dev/cpu_dma_latency.
> Setting that to a small value (eg 20) helps no end.
> But there are no references in the code or man pages to that.

There is a piece of kernel documentation regarding it, however:

https://www.kernel.org/doc/html/latest/admin-guide/pm/cpuidle.html#cpu-pm-qos
