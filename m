Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336BA2D65A3
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 19:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393149AbgLJSz2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 13:55:28 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37464 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393138AbgLJSz0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 13:55:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id l207so6904618oib.4;
        Thu, 10 Dec 2020 10:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twsPwbVO8yn8zyqZUdboWjPQ7cI0ykoSS/wwbkutNEI=;
        b=WK5LbfxAs06m91B7c1sJE4alF1KAfiCPw/lwyICalBrZFPaPi64xZAT5qT2swj0dnX
         UbO8tONF4nZVbiBp5r/86RmlA/sX9o/qFjllCbZNJVkyjGfPLpai9i+rD+6Nw1gflcm/
         GeolyZ3crbw1nzo2wHZPD+wdJpq4FHmFel36Uw5tpZ4eXNL6uYZrxi25JFIxv/HVK0yy
         ERqnLi3G9MfyZ8HmtwSJU/NGgAjRWCc+9cNAqAnHNvkt2xI6YiDovOX/E7mX4vybbqB9
         6dsUZM71i/animyxqJuehdNf9nAHvxoG0F4waqTxBBC0Qn6e0uhZVkODXnVVUUgaimN4
         /Kpg==
X-Gm-Message-State: AOAM532NBKI2A8Q5omc3Q3OwahsT+TN9FkguZit3IJFl3Mhg0ZROK5+u
        P0R7lIHe/CFsi7IZtEuPGpYctUifoY3igRumvzU=
X-Google-Smtp-Source: ABdhPJxLClO2crsAIA3P40gP2Nb793PFJLMAKdyrDqX8zhIEkjenPnNDK1rWmD8vPcW48zPM+UzHKVaWiHz5yaKb0uc=
X-Received: by 2002:aca:cf4a:: with SMTP id f71mr6681750oig.157.1607626485427;
 Thu, 10 Dec 2020 10:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20201210142139.20490-1-yousaf.kaukab@suse.com>
 <CAJZ5v0hWxLrXCS+X15hnLZ2enBsSJ0aEfnxK2kL+n9k4gkg17Q@mail.gmail.com>
 <20201210150417.GA24136@suse.de> <1916679.syIRshJoYJ@kreacher> <20201210172339.GA2828@arm.com>
In-Reply-To: <20201210172339.GA2828@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Dec 2020 19:54:34 +0100
Message-ID: <CAJZ5v0hx46VUj+FueGKLDNtn-H9Mk9vFSa5RXv6KrpPwcsD=cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi: cppc: add cpufreq device
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Petr Cervinka <pcervinka@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 10, 2020 at 6:23 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi Rafael,
>
> On Thursday 10 Dec 2020 at 17:55:56 (+0100), Rafael J. Wysocki wrote:
> > On Thursday, December 10, 2020 4:04:40 PM CET Mian Yousaf Kaukab wrote:
> > > On Thu, Dec 10, 2020 at 03:32:09PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Dec 10, 2020 at 3:23 PM Mian Yousaf Kaukab
> > > > <yousaf.kaukab@suse.com> wrote:
> > > > >
> > > > > Convert cppc-cpufreq driver to a platform driver (done in a separate patch)
> > > > > and add cppc-cpufreq device when acpi_cppc_processor_probe() succeeds.
> > > >
> > > > Honestly, I prefer to drop 28f06f770454 (along with its follower)
> > > > instead of making this change.
> > > >
> > > Even if we revert 28f06f770454 there is still one more small issue that these
> > > patches fix. Currently, ACPI_PROCESSOR_DEVICE_HID is used to load cppc-cpufreq
> > > module. In case when CPPC is disabled, some cycles will be wasted in loading
> > > cppc-cpufreq module. The module will return error from the init call though
> > > so no memory is wasted.
> > >
> > > After converting to platform-driver, cppc-cpufreq module will only be loaded
> > > when the platform-device is available.
> >
> > Even so, that issue is low-impact AFAICS and may be addressed later and I'd
> > rather not let known breakage go into the mainline.
> >
> > I'm going to do drop the problematic commit now and please work with Ionela
> > to produce a clean series of patches in the right order to avoid introducing
> > issues between them.
> >
>
> The following commit will be easy to drop:
> a37afa60de38  cppc_cpufreq: optimise memory allocation for HW and NONE coordination (2 weeks ago)
>
> 28f06f770454  will be more difficult to drop as it's embedded in the
> series, and removing that one will produce conflicts in the patches
> that follow it:
>
> f9f5baa8b2a8  ACPI: processor: fix NONE coordination for domain mapping failure (3 weeks ago)
> cdb4ae5de6f7  cppc_cpufreq: expose information on frequency domains (3 weeks ago)
> c783a4d94848  cppc_cpufreq: clarify support for coordination types (3 weeks ago)
> 3bd412fb2c7f  cppc_cpufreq: use policy->cpu as driver of frequency setting (3 weeks ago)
> 28f06f770454  cppc_cpufreq: replace per-cpu structures with lists (3 weeks ago)

I dropped the commits above along with a37afa60de38 (and regenerated
my pm-cpufreq branch).

> bb025fb6c276  cppc_cpufreq: simplify use of performance capabilities (3 weeks ago)
> 48ad8dc94032  cppc_cpufreq: clean up cpu, cpu_num and cpunum variable use (3 weeks ago)
> 63087265c288  cppc_cpufreq: fix misspelling, code style and readability issues (3 weeks ago)
>
> Let me know how you want to proceed and I can either send a replacement
> series or reverts with conflicts fixed.

Please feel free to resubmit with the issue at hand addressed.

Thanks!
