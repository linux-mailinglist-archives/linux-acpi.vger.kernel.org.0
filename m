Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230D9DAFA2
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfJQOQz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 10:16:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42042 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfJQOQz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2019 10:16:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so2005874otd.9;
        Thu, 17 Oct 2019 07:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONhbG1YIvRehChglKAzYSee1XpDEhwyMKjBcNaf717M=;
        b=izYqhpkanZhv6t0j6kpBClORLQTasyQsD+0Gzo76AmET09Nwz3oCwVeKVvCnWqcK3E
         TyNOXkW5dT3P6CGt/Rx+x8sB1Ik3a4xLeZxeJ4iothxjWl1AZzK4fOylTazICZ6zKUf8
         aNBuum4P1RUU3bwxE7c5fd37wXj5rq9hNiUlNyDy5ygC2p10LL8nAoNPbMfqPWMIenHM
         baUab7D5jGKyK8itXAroeTcFaJO7fVzcKzHRWvIg9h6oWQY4M30FiSKKRfmhXAkuMIlO
         zPlxiix8uiprFHAQTLcWR7KUHqBkxfMy+eliO50LAOeCbyf73Jfhr277xi1qg8xmaudT
         edSQ==
X-Gm-Message-State: APjAAAUnML6+NPnhv4RauepLt73ZKemZOIaPGtPZrT5Um9P/0GMzRlCy
        LQP/KMTVXoJC39QM0VEkM/pNzkvkmeVdIVr/XYA=
X-Google-Smtp-Source: APXvYqzlXzT4lVsF0ANUd+lX83vr0WuCNqKjpz6umKGU8BvwxubmHWkCKI4rEx3LdKJ9XXFDb/fKsYOCW85mZdBE59w=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr3351385oth.266.1571321813586;
 Thu, 17 Oct 2019 07:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <2811202.iOFZ6YHztY@kreacher> <4551555.oysnf1Sd0E@kreacher> <20191017094143.fhmhgltv6ujccxlp@vireshk-i7>
In-Reply-To: <20191017094143.fhmhgltv6ujccxlp@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Oct 2019 16:16:40 +0200
Message-ID: <CAJZ5v0hDhJrCWnPxbV54yWAB=DKCLz33Sq8J4kXtqH4+mJn2eQ@mail.gmail.com>
Subject: Re: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 17, 2019 at 11:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-10-19, 12:41, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Introduce frequency QoS, based on the "raw" low-level PM QoS, to
> > represent min and max frequency requests and aggregate constraints.
> >
> > The min and max frequency requests are to be represented by
> > struct freq_qos_request objects and the aggregate constraints are to
> > be represented by struct freq_constraints objects.  The latter are
> > expected to be initialized with the help of freq_constraints_init().
> >
> > The freq_qos_read_value() helper is defined to retrieve the aggregate
> > constraints values from a given struct freq_constraints object and
> > there are the freq_qos_add_request(), freq_qos_update_request() and
> > freq_qos_remove_request() helpers to manipulate the min and max
> > frequency requests.  It is assumed that the the helpers will not
> > run concurrently with each other for the same struct freq_qos_request
> > object, so if that may be the case, their uses must ensure proper
> > synchronization between them (e.g. through locking).
> >
> > In addition, freq_qos_add_notifier() and freq_qos_remove_notifier()
> > are provided to add and remove notifiers that will trigger on aggregate
> > constraint changes to and from a given struct freq_constraints object,
> > respectively.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  include/linux/pm_qos.h |   44 ++++++++
> >  kernel/power/qos.c     |  240 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 284 insertions(+)
> >
> > Index: linux-pm/include/linux/pm_qos.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/pm_qos.h
> > +++ linux-pm/include/linux/pm_qos.h
> > @@ -267,4 +267,48 @@ static inline s32 dev_pm_qos_raw_resume_
> >  }
> >  #endif
> >
> > +#define FREQ_QOS_MIN_DEFAULT_VALUE   0
> > +#define FREQ_QOS_MAX_DEFAULT_VALUE   (-1)
> > +
> > +enum freq_qos_req_type {
> > +     FREQ_QOS_MIN = 1,
> > +     FREQ_QOS_MAX,
> > +};
> > +
> > +struct freq_constraints {
> > +     struct pm_qos_constraints min_freq;
> > +     struct blocking_notifier_head min_freq_notifiers;
> > +     struct pm_qos_constraints max_freq;
> > +     struct blocking_notifier_head max_freq_notifiers;
> > +};
> > +
> > +struct freq_qos_request {
> > +     enum freq_qos_req_type type;
> > +     struct plist_node pnode;
> > +     struct freq_constraints *qos;
> > +};
> > +
> > +static inline int freq_qos_request_active(struct freq_qos_request *req)
> > +{
> > +     return !IS_ERR_OR_NULL(req->qos);
> > +}
> > +
> > +void freq_constraints_init(struct freq_constraints *qos);
> > +
> > +s32 freq_qos_read_value(struct freq_constraints *qos,
> > +                     enum freq_qos_req_type type);
> > +
> > +int freq_qos_add_request(struct freq_constraints *qos,
> > +                      struct freq_qos_request *req,
> > +                      enum freq_qos_req_type type, s32 value);
> > +int freq_qos_update_request(struct freq_qos_request *req, s32 new_value);
> > +int freq_qos_remove_request(struct freq_qos_request *req);
> > +
> > +int freq_qos_add_notifier(struct freq_constraints *qos,
> > +                       enum freq_qos_req_type type,
> > +                       struct notifier_block *notifier);
> > +int freq_qos_remove_notifier(struct freq_constraints *qos,
> > +                          enum freq_qos_req_type type,
> > +                          struct notifier_block *notifier);
> > +
> >  #endif
> > Index: linux-pm/kernel/power/qos.c
> > ===================================================================
> > --- linux-pm.orig/kernel/power/qos.c
> > +++ linux-pm/kernel/power/qos.c
> > @@ -650,3 +650,243 @@ static int __init pm_qos_power_init(void
> >  }
> >
> >  late_initcall(pm_qos_power_init);
> > +
> > +/* Definitions related to the frequency QoS below. */
> > +
> > +/**
> > + * freq_constraints_init - Initialize frequency QoS constraints.
> > + * @qos: Frequency QoS constraints to initialize.
> > + */
> > +void freq_constraints_init(struct freq_constraints *qos)
> > +{
> > +     struct pm_qos_constraints *c;
> > +
> > +     c = &qos->min_freq;
> > +     plist_head_init(&c->list);
> > +     c->target_value = FREQ_QOS_MIN_DEFAULT_VALUE;
> > +     c->default_value = FREQ_QOS_MIN_DEFAULT_VALUE;
> > +     c->no_constraint_value = FREQ_QOS_MIN_DEFAULT_VALUE;
> > +     c->type = PM_QOS_MAX;
>
> should this be MIN ?

No, it shouldn't.

For the min frequency, the effective constraint needs to be the
maximum of all requests, because that satisfies all of them (each
request means "the frequency cannot be less than this").

> > +     c->notifiers = &qos->min_freq_notifiers;
> > +     BLOCKING_INIT_NOTIFIER_HEAD(c->notifiers);
> > +
> > +     c = &qos->max_freq;
> > +     plist_head_init(&c->list);
> > +     c->target_value = FREQ_QOS_MAX_DEFAULT_VALUE;
> > +     c->default_value = FREQ_QOS_MAX_DEFAULT_VALUE;
> > +     c->no_constraint_value = FREQ_QOS_MAX_DEFAULT_VALUE;
> > +     c->type = PM_QOS_MIN;
>
> and this MAX ?

Likewise, for the max frequency, the effective constraint needs to be
the minimum of all requests, as each of them means "the frequency
cannot be more than this").

[Also note that the current code in device PM QoS uses MIN and MAX
here in the same way. :-)]
