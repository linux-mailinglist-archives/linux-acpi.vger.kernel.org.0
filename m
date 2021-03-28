Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9116434BC6A
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Mar 2021 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhC1Mu6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Mar 2021 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1Muu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Mar 2021 08:50:50 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C7BC061762;
        Sun, 28 Mar 2021 05:50:50 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id p12so3037596pgj.10;
        Sun, 28 Mar 2021 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/f6JcSAxpYcQMaAnW5qhIERWhNfQqqFaf/lVQHff/0=;
        b=R9F2oyHJuKHCiCMbvDBSiCGciPYeXBLxw/cGofmCcHz2QUFhmdPGv7qkdtdii5cUyk
         Af9ggEX9DREMPgGHAMYVThJLSTuOAc+u/JYn812eHYAA56LUxTgnn8+/n9ScuEuxo5Kr
         c+3DZJQl4ynMmZQoFXo/odaaAlmhaM0a172km0naKrn+BtATaBVetwowih9GshmTHMRg
         oNXlNm03OAuTNF5llOZmBPlPp3l9VRTjmM03Eqt3EU3u2P26SeVXoKPdnIH3cUErmmO0
         CRsUvSs1/CAsvu1k5uX9zmMdqiEcq2Qj62pwDv3kuG+rZCi10m4h8csQ6+rvLpao6Ljx
         O/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/f6JcSAxpYcQMaAnW5qhIERWhNfQqqFaf/lVQHff/0=;
        b=HlQjWc8Tbc/5dIYndqHdVmhgF645IlIrWbWzCmrX4DpuAEdAJIdrZBL4rHiq2hxh/V
         WhvvKhZiSLtj4VnJ0HiFu6juwgsLbuKPEiNIygquFCICuNIRu3RE2fBzYOMKBtP2TYYB
         jvQkFwnBwdOFRuCpnd20xa5+jkkbSHoYBfer/R+HAeXYE/c90iv9Mv0GQyxQVptAo15H
         jIbtlSuxd4SowUBe6UuOoGjvmRcQVwY4UeMXJW1dpKUqkoeMRdfznd38hmrj8j1hgwur
         az326WiT3/phy0lckJhsFx/t68D9/UAXL4yEMpyC5mQNhIPhB3LHXeDOvRf47wO1GNFf
         Nkpg==
X-Gm-Message-State: AOAM533PKMCM+trEmOrz7X7ghOg5KuQoAMqWHB8IJa8k/CeCiQabgD+U
        itKtTMCQpSkAdRhOxXcXRK9XYocGdCjkMxBkwmfhDHyyejs=
X-Google-Smtp-Source: ABdhPJwyVengmsYTLXT8Ek198TXirsG56lWDdJccyVIjngZL5NxLnvSor4kK/J8s3OsZtzdVAMQSu5o7/qLLs6VKLNw=
X-Received: by 2002:a65:4c08:: with SMTP id u8mr19616609pgq.203.1616935850229;
 Sun, 28 Mar 2021 05:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-6-andriy.shevchenko@linux.intel.com> <YGBB7D98tNxYsTXo@kroah.com>
In-Reply-To: <YGBB7D98tNxYsTXo@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 28 Mar 2021 15:50:34 +0300
Message-ID: <CAHp75VcuAs_n+g4Cy7Sj99hZLavWBEJrW3xgXCwHaN_GkB-K8g@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] software node: Simplify swnode_register() a bit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 28, 2021 at 11:48 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Mar 28, 2021 at 12:20:10AM +0200, Andy Shevchenko wrote:
> > By introducing two temporary variables simplify swnode_register() a bit.
> > No functional change intended.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/base/swnode.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index ae53c48f84b1..1e81aaf5f6a1 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -894,6 +894,8 @@ static struct fwnode_handle *
> >  swnode_register(const struct software_node *node, struct swnode *parent,
> >               unsigned int allocated)
> >  {
> > +     struct ida *ids = parent ? &parent->child_ids : &swnode_root_ids;
> > +     struct kobject *kobj_parent = parent ? &parent->kobj : NULL;
>
> ?: operations are horrid.  Please spell this out in real if statements
> so that we can properly understand and maintain them for the next 20+
> years.

Will do, thanks!

--
With Best Regards,
Andy Shevchenko
