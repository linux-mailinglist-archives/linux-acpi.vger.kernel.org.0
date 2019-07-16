Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C805B6A685
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfGPK17 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 06:27:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33134 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732319AbfGPK17 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 06:27:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so20470120otl.0;
        Tue, 16 Jul 2019 03:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InV49k/g4n8kkX89qOOPmJMNqj/Q2fuW/aBD6hhUrXA=;
        b=LP9UCFk/txz+8PX9fFtv/tFMlGmWO8p/SA855m/EOd/YAEFUGuqISAykuCTSFZjPWr
         eyb4/WBRLWZytdBG90l4K5smP29fTIINGjnQCE8qD9v8khA6CuYYnHyA8lYpRMwjYZOi
         L+lJzASL07W2Ko9IolEPteOZqGDXKrVhyBHxViB1aKO+lvViVtXKUEdsf313850UosI3
         FvWzz79zOo06xaLvaUwqQ4t4HU9d2alXcgK11I/eWak+k/qWRLCwfwCUX+AI2XJVDpZ8
         QQaLzvh7DPqpkJKskGCC2UbPYLxDsNSDckCmd5yWo58q7MK5TgXumw74lcSqmyNnH0wL
         7Apg==
X-Gm-Message-State: APjAAAVOs1jCA+1qM2yVYeNozrlAU4wThENjruPto7PDM9QAnPCuX3t7
        An4o2h11KWH5DMji4D6pk9XQMf/V3L/yaXef1NY=
X-Google-Smtp-Source: APXvYqwNxa4ESy69KwPnztnMj6Vvcz27ajFqshxcVQs8WVfJTe1ykblJ31kt949Zta05jFdEjaTLyPSqql/gvXR4C4Y=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr18446800oto.167.1563272877613;
 Tue, 16 Jul 2019 03:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563269894.git.viresh.kumar@linaro.org> <CAJZ5v0iqYHNt6NQy3Fi1B=XtjNOm2x0mX3+7eWBREgFZRpUS+w@mail.gmail.com>
 <20190716101416.ntk353cfnrcykoek@vireshk-i7>
In-Reply-To: <20190716101416.ntk353cfnrcykoek@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Jul 2019 12:27:46 +0200
Message-ID: <CAJZ5v0jZfmXN=juHX11vmSFj=vxS2Mu_b-OZprB9S+3LJjDb+g@mail.gmail.com>
Subject: Re: [PATCH 00/10] cpufreq: Migrate users of policy notifiers to QoS requests
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javi Merino <javi.merino@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 16, 2019 at 12:14 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-07-19, 12:06, Rafael J. Wysocki wrote:
> > On Tue, Jul 16, 2019 at 11:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Hello,
> > >
> > > Now that cpufreq core supports taking QoS requests for min/max cpu
> > > frequencies, lets migrate rest of the users to using them instead of the
> > > policy notifiers.
> >
> > Technically, this still is linux-next only. :-)
>
> True :)
>
> > > The CPUFREQ_NOTIFY and CPUFREQ_ADJUST events of the policy notifiers are
> > > removed as a result, but we have to add CPUFREQ_CREATE_POLICY and
> > > CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically. So
> > > the policy notifiers aren't completely removed.
> >
> > That's not entirely accurate, because arch_topology is going to use
> > CPUFREQ_CREATE_POLICY now too.
>
> Yeah, I thought about that while writing this patchset and
> coverletter. But had it not been required for ACPI, I would have done
> it differently for the arch-topology code. Maybe direct calling of
> arch-topology routine from cpufreq core. I wanted to get rid of the
> policy notifiers completely but I couldn't find a better way of doing
> it for ACPI stuff.
>
> > > Boot tested on my x86 PC and ARM hikey board. Nothing looked broken :)
> > >
> > > This has already gone through build bot for a few days now.
> >
> > So I'd prefer patches [5-8] to go right after the first one and then
> > do the cleanups on top of that, as somebody may want to backport the
> > essential changes without the cleanups.
>
> In the exceptional case where nobody finds anything wrong with the
> patches (highly unlikely), do you want me to resend with reordering or
> you can reorder them while applying? There are no dependencies between
> those patches anyway.

Please resend the reordered set when the merge window closes.
