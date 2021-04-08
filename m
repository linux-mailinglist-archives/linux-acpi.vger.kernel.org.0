Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88055358810
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Apr 2021 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhDHPUO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Apr 2021 11:20:14 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35365 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhDHPUN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Apr 2021 11:20:13 -0400
Received: by mail-ot1-f50.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so2659702oto.2;
        Thu, 08 Apr 2021 08:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1l55izRQ8nY+x+SOR4VHV/Ao5jxbNbjMrx+sLpOPjK4=;
        b=C/Kn71JmLdyyBkzm3e3O8lWwiXV086yiusM7P4Sct0QvdYGto2uthly5S9TRBps6tf
         QfhXJq30s4vUOIrxzxIlgYKS3dH0wjgTmJE3i8YGjSbdh+C2o/e5RAjY24nogAQqvC4h
         r0ErSIqtFOSGXkeR485VdFcyjVCfKUuYefSbxSmOjpkKaN9m6oiqC+507pw8FlERbZnb
         DHn0PZJeKte2MxUUz1mLGajjJeSAVVnVvczKEXRZyHiNwKe/8crqzN12AFp4YCX/Tn5R
         AyO/0haN4h9rE1YVMY6ofVO3QNNcoJDMWUrpDxEAx3rMLy0Ccms1VeQK4y0yAXQLtXkv
         3G9A==
X-Gm-Message-State: AOAM531ASOKpR2LimvjoIbzJm0O7/axoeKjA1c+dCWk73zC5E0QHkNLQ
        vYxzK3syVnwS+kefrT7mguCWtdMB4P3sOlBZKoo=
X-Google-Smtp-Source: ABdhPJzXTh1xK/TXuaFzcfuDiP0bRY81Ch5oD1yLb+clFYHQuyc9IeAmu6+se8lJ0br1jyreWUfN8c4PgxAA/bj3kzM=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr8347014otf.206.1617895202303;
 Thu, 08 Apr 2021 08:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
 <YGRXmOMfCTxy31Rj@kuha.fi.intel.com> <CAJZ5v0jJCYD9+j57-CL-OqiZKL7bBQ7NetcewE_37wODOG_Jkg@mail.gmail.com>
 <YG8YSPHMBbBJadvp@smile.fi.intel.com> <CAJZ5v0j0XpD6mbaCxAjBARsiScSG2T0v_2m8NdrnoQVmsqDDXQ@mail.gmail.com>
 <YG8evZfHNyBmTJu7@smile.fi.intel.com>
In-Reply-To: <YG8evZfHNyBmTJu7@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 17:19:51 +0200
Message-ID: <CAJZ5v0g32KqeyWM-pzXj6hvD1EixAuz9_QgYXBYZTQC+z2DKyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] software node: Free resources explicitly when
 swnode_register() fails
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 8, 2021 at 5:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 08, 2021 at 05:04:32PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 8, 2021 at 4:50 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Apr 08, 2021 at 04:15:37PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 31, 2021 at 1:06 PM Heikki Krogerus
> > > > <heikki.krogerus@linux.intel.com> wrote:
> > > > >
> > > > > On Mon, Mar 29, 2021 at 06:12:02PM +0300, Andy Shevchenko wrote:
> > > > > > Currently we have a slightly twisted logic in swnode_register().
> > > > > > It frees resources that it doesn't allocate on error path and
> > > > > > in once case it relies on the ->release() implementation.
> > > > > >
> > > > > > Untwist the logic by freeing resources explicitly when swnode_register()
> > > > > > fails. Currently it happens only in fwnode_create_software_node().
> > > > > >
> > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > >
> > > > > It all looks OK to me. FWIW, for the whole series:
> > > > >
> > > > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > >
> > > > Whole series applied (with some minor changelog edits) as 5.13 material, thanks!
> > >
> > > It seems Greg applied it already. Was it dropped there?
> >
> > Did he?
> >
> > OK, so please let me know if it's still there in the Greg's tree.
>
> Here [1] what I see. Seems still there.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=6e11b376fd74356e32d842be588e12dc9bf6e197

I will not be applying it then, sorry for the confusion.
