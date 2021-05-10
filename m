Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138DC37956B
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhEJRYr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 13:24:47 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41478 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhEJRYU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2021 13:24:20 -0400
Received: by mail-ot1-f42.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so8797821oth.8;
        Mon, 10 May 2021 10:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYGVy1dBjcY+gobayJq/B1W7IwBp6P5SIbqRmJkMD80=;
        b=niaDWqWKFas1GwpIPTLZAdbqAs1bUF7VzwmJ+Q447EaxxnLWInU9kv6vhZ2N5RBRJh
         hFSox+jCfVte0+smm5RM+2fjMNqNIkO/befsfGum6BB5wpgNGBdtlqeJlnom8CenMS4M
         qr7s/VSzGkqNhqm2S4dmcV/9M0e8GlYnKR8BAMyzpT5C2Lb0r+wZ+hWyEFeDB0bjgNXs
         5/sqvO7THu7a8WCvOd2fe3otg6qqXGPqkFx2kblbfKHMKHqfXVoWnmeLRcoRlCK57tFY
         9nHtq+VoNmZr/cHLg0wnuNsfg0fVrRLfzI4vgYI1KxhOsIhzRE3R4fgCAafj8zUFUD2g
         opgQ==
X-Gm-Message-State: AOAM530p4LM6NIO33EgUcoj8SeH6v8xOJ/SW+6hRQ3lk1PJfgKytemnj
        4Pc0lTs2luAcXiclJ+uUZe6aSZ4HQIHDnDrpoHE=
X-Google-Smtp-Source: ABdhPJxbzEB1QZKZbR1O/LrXJZYYXc+/vJ4XxWgcDzo62GrJqXnyD1XoUJeYeVZmodAXbzZu4T6aRLhP7s3RqSYSh70=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr22485830otd.321.1620667393829;
 Mon, 10 May 2021 10:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210426023941.729334-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <97e14cdc-ea98-18b8-0c89-db52440a7716@linux.intel.com> <CAJZ5v0gsqyXSr+Kw603333PZ=gnsBizNhyLAcu588OChEHT=AQ@mail.gmail.com>
 <4fa40e7a-bcb2-db0f-8dc5-28728b14377d@linux.intel.com>
In-Reply-To: <4fa40e7a-bcb2-db0f-8dc5-28728b14377d@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 19:23:02 +0200
Message-ID: <CAJZ5v0jMo9+ohUJ_=KHL_QwEo5GmAn_fMkng==Zmy-AJ=MPRog@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up support
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 10, 2021 at 7:10 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 5/10/21 9:55 AM, Rafael J. Wysocki wrote:
> > I'm not sure how my comment regarding the fact that for a given CPU
> > this function is only usable once has been addressed.
> >
> > While it may not be a practical concern in the use case that you are
> > after (TDX), this is a generic mechanism and it needs to cover other
> > possible usage scenarios.
>
> For the same CPU, if we try to use mailbox again, firmware will not
> respond to it.

Well, theoretically, but what if it checks the mailbox every time for
all CPUs?  Or similar?

> So the command will timeout and return error.

If the firmware behaves as expected, but what if it doesn't?
