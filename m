Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D478E14D7
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 10:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390358AbfJWI5y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 04:57:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34333 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbfJWI5y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 04:57:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id 83so16738849oii.1;
        Wed, 23 Oct 2019 01:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SgWDtx0/EohgvsL2Dr3cG8xzUVsn7JdTYAZdxeMPfg=;
        b=oUfJ2mjhJFMJ60ad42Y7nlf1r6nSXrvD5lljqYgL9u8G3krMTGB7+C3ia2n22l/v8K
         bO7b8vMvnuGbWp2O2VnqFxYZJ7fLdGZzBtMMpfsAkK9leOfVRuPTtke8+brgcdp/YfVs
         gZCPD0U4iXlZ0e6+UHhLiMmusBL+c7a89Fk7pOOnnPNIERdEZR53qPQvuUaNAdbiGhXu
         9mIb2/CErKNHqvXCgl2Cv0S2JrXfrV5afUN8v6SQdNFZ+ywKShSsKtXSShkkBwLfskp6
         yU7iOwnMTtpVwsiUswSIfUgzCpwM8e82RIZLcdq06QYo2gzBCej/DxNLNcr6FZfoKaIW
         SiHw==
X-Gm-Message-State: APjAAAVY41Y5Onz21QCpt1vg91fwXnholWOvwApFFC5zLnqyntRq6R+a
        osaBjr2/7IN98Ht3wSJ31/Ix0s/gsJjUq0h8qYo=
X-Google-Smtp-Source: APXvYqwhTBg9vuA1Oqj9UiGYZuKXA2wZzV8vgNARWImcMs2DbYEml/kicZIjjXGr2bCaenXjJbEL488WLAVz7xersw0=
X-Received: by 2002:aca:d706:: with SMTP id o6mr6916124oig.57.1571821072330;
 Wed, 23 Oct 2019 01:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0g-hTOhVJOz28CGmpcxUiiTrYyV=ARwNCN9w4doeRcCRw@mail.gmail.com>
 <VI1PR04MB7023808153A1FD2740FACF01EE6B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0gWdFVbvPobLic7F+bRrz-QUoV3GPhpawdFT0MVjAhuOQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gWdFVbvPobLic7F+bRrz-QUoV3GPhpawdFT0MVjAhuOQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Oct 2019 10:57:41 +0200
Message-ID: <CAJZ5v0gpbkHP5c4eN1s+gqueiSniZC6_o0GXuBcuzDLrVmt+=Q@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 23, 2019 at 10:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Oct 23, 2019 at 4:20 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >
> > On 2019-10-23 1:48 AM, Rafael J. Wysocki wrote:
> > > On Wed, Oct 23, 2019 at 12:06 AM Leonard Crestez
> > > <leonard.crestez@nxp.com> wrote:
> > >> I've been working on a series which add DEV_PM_QOS support to devfreq,
> > >> now at v9:
> > >>
> > >> Your third patch removes DEV_PM_QOS_FREQUENCY_MIN/MAX that my series
> > >> depends upon. I found the email on patchwork, hopefully the in-reply-to
> > >> header is OK?
> > >>
> > >> As far as I can tell the replacement ("frequency qos") needs constraints
> > >> to be managed outside the device infrastructure and it's not obviously
> > >> usable a generic mechanism for making "min_freq/max_freq" requests to a
> > >> specific device.
> > >
> > > You can add a struct freq_constrants pointer to struct dev_pm_info and
> > > use it just fine.  It doesn't have to be bolted into struct
> > > dev_pm_qos.
> >
> > I'm not sure what you mean by this? min/max_freq was already available
> > in dev_pm_qos so it's not clear why it would be moved somewhere else.
> > What I'm looking for is a mechanism to make min/max_freq requests on a
> > per-device basis and DEV_PM_QOS_MIN_FREQUENCY already did that.
> >
> > Reuse is good, right?
>
> But they go away in patch 3 of this series as there are no users in
> the tree.  Sorry about that.
>
> > >> I've read a bit through your emails and it seems the problem is that
> > >> you're dealing with dev_pm_qos on per-policy basis but each "struct
> > >> cpufreq_policy" can cover multiple CPU devices.
> > >>
> > >> An alternative solution which follows dev_pm_qos would be to add
> > >> notifiers for each CPU inside cpufreq_online and cpufreq_offline. This
> > >> makes quite a bit of sense because each CPU is a separate "device" with
> > >> a possibly distinct list of qos requests.
> > >
> > > But combining the lists of requests for all the CPUs in a policy
> > > defeats the idea of automatic aggregation of requests which really is
> > > what PM QoS is about.
> >
> > My primary interest is the "dev" part of dev_pm_qos: making pm_qos
> > requests tied to a specific device.
>
> The list of requests needs to be associated with the user of the
> effective constraint.  If that is the device, it is all good.
>
> > > There have to be two lists of requests per policy, one for the max and
> > > one for the min frequency >
> > >> If cpufreq needs a group of CPUs to run at the same frequency then it
> > >> should deal with this by doing dev_pm_qos_read_frequency on each CPU
> > >> device and picking a frequency that attempts to satisfy all constraints.
> > >
> > > No, that would be combining the requests by hand.
> >
> > It's just a loop though.
>
> Yes, it is, and needs to be run on every change of an effective
> constraint for any CPU even if the total effective constraint doesn't
> change.  And, of course, the per-policy user space limits would need
> to be combined with that by hand.
>
> Not particularly straightforward if you asked me.
>
> Not to mention the fact that, say, cpu_cooling, has a per-policy list
> of requests anyway.

A per-policy request, not a list of them.  Sorry.
