Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA844940
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfFMRQE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 13:16:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47002 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfFLVon (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2019 17:44:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so16924778ote.13;
        Wed, 12 Jun 2019 14:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/4G9x4zsQuQK8+ToSt6QVbv5k7TYmTi2yAsofevHsY=;
        b=YpKmT0+C2griVMmGw+n8I8gmxAGOjAW393yFX50SzCt8ExJDah1r2ImJwJOnIyxpHH
         z/enpeUDMhm3A1q80aj1qAJ+A1zWd0Uj3ZRQ2ltJz6LWbgAW1H9VaeRmcpq2Y0RdJ9nt
         xNyQTrv+ICjrVYBkrAdGvLuvRfeEowzaMV1EcNyrGSnvUyId+g+S2PUIf7JSMlWZnDur
         YXKN6b1gD6vceR//bU9kH3tmJLPeOTewGz4q8J+LdwMSHyoiqrgx4Uoguwt0JyCvKW2b
         ZriYTfGZNiCjft+toKKp7HkSd7IKKDEPrK8Uo8wGGuBZmU7LhTm7mFr3wKnGSUvV30Ik
         OQRA==
X-Gm-Message-State: APjAAAWMxxdwGKVK6aCOc8sa8MFXbfr3IPYTvFMA32cqOavCZ4yGB3qd
        VEejyqgoHm77v6FlCoCSKFFCoHnT/vyBoUnde/8=
X-Google-Smtp-Source: APXvYqxN1bHJmkJ+vh40QbfdXCtjCs4vHEb7WPek5QJRj8zdUZWlSjKRNzigkiS5uP3LHGJ4wWz6y073BK1+jYoNW44=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr18511958oto.118.1560375882780;
 Wed, 12 Jun 2019 14:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190609111732.GA2885@amd> <007701d520c7$c397bda0$4ac738e0$@net>
In-Reply-To: <007701d520c7$c397bda0$4ac738e0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Jun 2019 23:44:30 +0200
Message-ID: <CAJZ5v0j2pb2WxSA+S44Mr-6bpOx-P9A_T2-sDG3CiWSqLMg3sA@mail.gmail.com>
Subject: Re: 5.2-rc2: low framerate in flightgear, cpu not running at full
 speed, thermal related?
To:     Doug Smythies <dsmythies@telus.net>, Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 12, 2019 at 4:45 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi,
>
> So, currently there seems to be 3 issues in this thread
> (and I am guessing a little, without definitive data):
>
> 1.) On your system Kernel 5.4-rc2 (or 4) defaults to the intel_pstate CPU frequency
> scaling driver and the powersave governor, but kernel 4.6 defaults to the
> acpi-cpufreq CPU frequency scaling driver and the ondemand governor.

Which means that intel_pstate works in the active mode by default and
so it uses its internal governor.

That governor is more performance-oriented than ondemand and it very
well may cause more power to be allocated for the processor - at the
expense of the GPU.

The lower-than-expected frame rate may result from that, in principle.

One way to mitigate that might be to use intel_pstate in the passive
mode (pass intel_pstate=passive to the kernel in the command line)
along with either ondemand or schedutil as the governor.
