Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0E103661
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2019 10:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfKTJJE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Nov 2019 04:09:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47095 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfKTJJD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2019 04:09:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id n14so21800353oie.13;
        Wed, 20 Nov 2019 01:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxjAZZwG5hIfrc3YBFvEHX0U8tqNbosfqpgXVFQpjTc=;
        b=dmCR20i9ljycuzcdpQ/+b/WzPGniZOP3/6mDPi8Lf2AIOn/ZMrlKNLkRzOyYvLfEbF
         k7RcT/zJpksB6x3YX4q6Pzry8vL61YqQ8mLEk9wjOY14zfyDHls6QQeB+IVrhh+Qaess
         5wAaaEGr3TNr2+1Np2IJlt+hp3Pg7JqHFcqv5svCoDEV7cWk/QbFDr9aSIQ0s4iQed3B
         m6Sh5WPOXyEo2VbsXThlgB55DAi/bUtCombh8WjA4zHLys/gPUhlqqO/rqz0EK0YksJP
         +HOSy2Kb3NFYa+EXH9awcsVtbc3cU9S7TNG9pbKKq8F9KwlbPO75LOh1+giw/ugacKTB
         nGUQ==
X-Gm-Message-State: APjAAAWYSGq45lA3bd6E63YBkYTvAJsx0lX5T/JZ+SxTmmAflbftLDS/
        bISBT2pmRrIemUy1Ss0PrK0dfsjyZANcPLL3AO0=
X-Google-Smtp-Source: APXvYqxQjCBlQqe/f/mECD0vZZyqUXnBDslf+mcXcDjZNftUBzoDIa8ouyVTVLVhR1a+rSsJzXW2qceRI7vfoJ5tp48=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr1897534oih.57.1574240942620;
 Wed, 20 Nov 2019 01:09:02 -0800 (PST)
MIME-Version: 1.0
References: <2811202.iOFZ6YHztY@kreacher> <000401d59ee6$959e3da0$c0dab8e0$@net>
 <CAJZ5v0i1iAjpWju6FiCjP3RvspKDRfSwz4=b_3qgGhhfz8sSrw@mail.gmail.com>
 <6710300.onecg0m5mP@kreacher> <002a01d59f6f$7f609540$7e21bfc0$@net>
In-Reply-To: <002a01d59f6f$7f609540$7e21bfc0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Nov 2019 10:08:50 +0100
Message-ID: <CAJZ5v0i1UqdQBvXm1cozOQeQ8YRdTxOAQPP9=RyZHHnsmuGHTw@mail.gmail.com>
Subject: Re: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 20, 2019 at 7:55 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.11.19 14:14 Rafael J. Wysocki wrote:
> > On Tuesday, November 19, 2019 8:17:05 PM CET Rafael J. Wysocki wrote:
>
> ...
>
> >> However, I now also see that freq_qos_remove_request() doesn't clear
> >> the qos field in req which is should do, so freq_qos_add_request()
> >> will complain and fail if the object pointed to by req is passed to it
> >> again.
> >>
> >> I'll send a patch to test for this later today.
> >>
> >
> > The patch is appended.  Please test it (on top of 5.4-rc8) and report back.
> >
> > ---
> > kernel/power/qos.c |    8 +++++++-
> > 1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/kernel/power/qos.c
> > ===================================================================
> > --- linux-pm.orig/kernel/power/qos.c
> > +++ linux-pm/kernel/power/qos.c
> > @@ -814,6 +814,8 @@ EXPORT_SYMBOL_GPL(freq_qos_update_reques
> >  */
> > int freq_qos_remove_request(struct freq_qos_request *req)
> > {
> > +     int ret;
> > +
> >       if (!req)
> >               return -EINVAL;
> >
> > @@ -821,7 +823,11 @@ int freq_qos_remove_request(struct freq_
> >                "%s() called for unknown object\n", __func__))
> >               return -EINVAL;
> >
> > -     return freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> > +     ret = freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> > +     req->qos = NULL;
> > +     req->type = 0;
> > +
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(freq_qos_remove_request);
>
> Yes the patch fixes the problem. Thanks.
>
> I tested several hundred times switching between
> passive and active modes with the intel_pstate driver,
> including with various CPUs disabled and re-enabled.

Thanks a lot!

Let me resend the patch with a changelog and tags.
