Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEABF6A648
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 12:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfGPKOT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 06:14:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45594 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfGPKOT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 06:14:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so8866987pfq.12
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jul 2019 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tmWzuRj9Y8Rn/r16lIRyg5jwtGJ9nynfw0uohRu6k2o=;
        b=KAtOigf2Oc9xYw3+dOxD9HqWXPLvbyeFTY1yERB+lcTUiKxn0onhKAn2eSSU2evMlN
         DV/XVJTUAM2BITFnkKRi6xErSZxL3AAhkWKFiuzIHWL4/J2i7Nh1jey+y3wQ/TYWuF3c
         a+Eo2P1WXSxGFIfJYyvmhhbFEexNIUH1jCbpjXVqUvler8kfIxS2uFrBoDgmsyMMMTik
         rvcdKRYaz24FEbxamPrZHZWVWb76QRqv9Z+FTSi6uVo5dEYFer2trAUwlcsVqiJHrdZS
         hD0SM75lfUioSSdZ+vSrLrjq1YeShNB4AfsrJAcT8PjYY38sTfsBKUobjvkFsI4XYiN4
         DD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tmWzuRj9Y8Rn/r16lIRyg5jwtGJ9nynfw0uohRu6k2o=;
        b=o9dWUjgy+3PQ+sDNq67HHOj/0DFHt+Z5rR0q8aVl4F4pqsvXgiXkeT42yMrXfS9+zs
         AJIp+wi7goMrRY70x+n6yTcxct0zwjx5lMiJd0zANdQ9wZ1l8PRjzqhqqF8amQUn48QZ
         vNBAFQdBRjXvRLpH16jscaWCk916We3TPxSoSJFNba9hXnwyiB8hBwMX9/daIdCcCFGr
         fESdrpiIzVE9VHFpnNrdPt99Cg6ct91aXFy1dXJMUQQdO8MCk7Hn7P7wxRJmd60FLGV0
         RbjmQYh6P7Z9vFnJwMtl0OupJDgtPQvHa6WnwwjsK20ol2zwg1J8g+WVw1T04foyUr3W
         zteg==
X-Gm-Message-State: APjAAAVhNzP2+4cbMB5GjLZ2GP2iOB9+wp9fpMBb+RMc6zpKT3QyRDi6
        D1Kkb9v0G6OeoORvSuKyNUM3wQ==
X-Google-Smtp-Source: APXvYqzBphLPq84GuNMQq2Ypj7vpkoiFF0ipulNv01B65gbXobE3Luly7Rk6v8kET2o+vxGtcp0/UQ==
X-Received: by 2002:a63:e1e:: with SMTP id d30mr32421799pgl.100.1563272058631;
        Tue, 16 Jul 2019 03:14:18 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id f12sm17112423pgq.52.2019.07.16.03.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 03:14:18 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:44:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
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
Subject: Re: [PATCH 00/10] cpufreq: Migrate users of policy notifiers to QoS
 requests
Message-ID: <20190716101416.ntk353cfnrcykoek@vireshk-i7>
References: <cover.1563269894.git.viresh.kumar@linaro.org>
 <CAJZ5v0iqYHNt6NQy3Fi1B=XtjNOm2x0mX3+7eWBREgFZRpUS+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iqYHNt6NQy3Fi1B=XtjNOm2x0mX3+7eWBREgFZRpUS+w@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16-07-19, 12:06, Rafael J. Wysocki wrote:
> On Tue, Jul 16, 2019 at 11:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Hello,
> >
> > Now that cpufreq core supports taking QoS requests for min/max cpu
> > frequencies, lets migrate rest of the users to using them instead of the
> > policy notifiers.
> 
> Technically, this still is linux-next only. :-)

True :)

> > The CPUFREQ_NOTIFY and CPUFREQ_ADJUST events of the policy notifiers are
> > removed as a result, but we have to add CPUFREQ_CREATE_POLICY and
> > CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically. So
> > the policy notifiers aren't completely removed.
> 
> That's not entirely accurate, because arch_topology is going to use
> CPUFREQ_CREATE_POLICY now too.

Yeah, I thought about that while writing this patchset and
coverletter. But had it not been required for ACPI, I would have done
it differently for the arch-topology code. Maybe direct calling of
arch-topology routine from cpufreq core. I wanted to get rid of the
policy notifiers completely but I couldn't find a better way of doing
it for ACPI stuff.

> > Boot tested on my x86 PC and ARM hikey board. Nothing looked broken :)
> >
> > This has already gone through build bot for a few days now.
> 
> So I'd prefer patches [5-8] to go right after the first one and then
> do the cleanups on top of that, as somebody may want to backport the
> essential changes without the cleanups.

In the exceptional case where nobody finds anything wrong with the
patches (highly unlikely), do you want me to resend with reordering or
you can reorder them while applying? There are no dependencies between
those patches anyway.

--
viresh
