Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51F126AC26
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgIORkS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 13:40:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39429 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgIORkD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 13:40:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id c13so4814319oiy.6;
        Tue, 15 Sep 2020 10:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgIuMsWuKwLw8HKrfM3Yi4VFysbOGkj72Chl+nIZli0=;
        b=I9tjUnqnJuwKijvQsV126O8Mtx3BuNYcy5r3+lJ9rRdiiQHoEqCYscfd3KDXpjIjAD
         O5Zjw95hY2LZAKugxI7+o8rnqebBh1Iakminxm6X6YM95Uu55rTMCk3XJIjHbDrdUL6m
         Oa5SAICa78VmEZbwlQTVvqrpB6qDbMP66ihubjzwDNwmQ9P81PJ2KD8/cWCJ5X9WKwHC
         2phe4nMNB1gSJP6MheOZexAVANsJnWE1oLQXGlaBU0U13k2fsCOY41rMpbhcDngllKgB
         tz/MtHpqJ+7NHRtCHfom4ORx5JvchlWMMw5vi8zlYFwYcAINhCe1GzjgjA355gOoA+1X
         priA==
X-Gm-Message-State: AOAM533a5VaLsNskPO5ri5McgN+MkmmEWR93Hd4dEb7AWssLzcsO96/n
        d38vGxV5LvvO5NsGm4Em4djykdD1RgbZybwNmwM=
X-Google-Smtp-Source: ABdhPJxTm261fqP6s7VUyOJQXiMU4X0GOiKkSTJ3sNxgOmXbn0mO9MLalI7UITQ64YpedQWLzF8Gls774vUxN4TYflI=
X-Received: by 2002:aca:fd95:: with SMTP id b143mr396668oii.68.1600191582446;
 Tue, 15 Sep 2020 10:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <1597286952-5706-1-git-send-email-wangqing@vivo.com>
 <CAJZ5v0h=UmD33X_i80X3ww7nC=xQL7V8XaoNq2XvU_XcdQGfZQ@mail.gmail.com> <4e23dc722419e82d13772afc8e060d3203fd5a86.camel@intel.com>
In-Reply-To: <4e23dc722419e82d13772afc8e060d3203fd5a86.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Sep 2020 19:39:31 +0200
Message-ID: <CAJZ5v0jG-8Cwi1TfVDfgu+=q1MT+aY+aG15cAuthK7AvS1vYuQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: Use kobj_to_dev() instead
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "wangqing@vivo.com" <wangqing@vivo.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Aug 15, 2020 at 12:52 AM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Fri, 2020-08-14 at 17:28 +0200, Rafael J. Wysocki wrote:
> > On Thu, Aug 13, 2020 at 4:54 AM Wang Qing <wangqing@vivo.com> wrote:
> > > Use kobj_to_dev() instead of container_of()
> > >
> > > Signed-off-by: Wang Qing <wangqing@vivo.com>
> >
> > LGTM
> >
> > Dan, any objections?
>
> Looks good to me - you can add:
> Acked-by: Vishal Verma <vishal.l.verma@intel.com>

Applied as 5.10 material, thanks!

> > > ---
> > >  drivers/acpi/nfit/core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > > index fa4500f..3bb350b
> > > --- a/drivers/acpi/nfit/core.c
> > > +++ b/drivers/acpi/nfit/core.c
> > > @@ -1382,7 +1382,7 @@ static bool ars_supported(struct nvdimm_bus *nvdimm_bus)
> > >
> > >  static umode_t nfit_visible(struct kobject *kobj, struct attribute *a, int n)
> > >  {
> > > -       struct device *dev = container_of(kobj, struct device, kobj);
> > > +       struct device *dev = kobj_to_dev(kobj);
> > >         struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
> > >
> > >         if (a == &dev_attr_scrub.attr && !ars_supported(nvdimm_bus))
> > > @@ -1667,7 +1667,7 @@ static struct attribute *acpi_nfit_dimm_attributes[] = {
> > >  static umode_t acpi_nfit_dimm_attr_visible(struct kobject *kobj,
> > >                 struct attribute *a, int n)
> > >  {
> > > -       struct device *dev = container_of(kobj, struct device, kobj);
> > > +       struct device *dev = kobj_to_dev(kobj);
> > >         struct nvdimm *nvdimm = to_nvdimm(dev);
> > >         struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> > >
> > > --
> > > 2.7.4
> > >
