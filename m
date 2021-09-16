Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8548D40D6FC
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 12:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhIPKFp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 06:05:45 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37506 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhIPKFo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Sep 2021 06:05:44 -0400
Received: by mail-ot1-f42.google.com with SMTP id i3-20020a056830210300b0051af5666070so7647491otc.4;
        Thu, 16 Sep 2021 03:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXboLe7jV/T9ZwIpHPlMdYn8bDy/deTb5yXB9iBxj90=;
        b=VnlgAB5xDbqqeWTbmfzPUTqPxG1STwJFWh9UmKBVUFiAHzQwYyg1xbp3fXEDOcwGxU
         AeBxr+8pNLGAjQuvi2bcnxuj9fuqn2D5qCkn6tPW7thPb7LTuhBpVZK2A2VhV1IcVxEd
         nzbVbUWCj0b/dUaTPFjrfDQVUROMCI65coqHsMTREGZbLBCNgUnW2vZi0h+AIL/gL/WX
         8buzTkJlOS5CgyYW4IM4eA3ne2obUlsLkYNyT/tKi2ztp6GkAPPX5rXd/kP8MHwWhLmv
         yLXuYuVV272eIZl+1iW5fErDuqt4EA5YFYqLhKrXG+ox9Pie+3bA4jRkMWadJns9v8yB
         gIXw==
X-Gm-Message-State: AOAM530L8vdgR2l2TFMNNft0TsbNvajx0KcGof8hi8D1yh5NiET/nFP+
        b2/zRVofOhfnN8PUvo5fF/989xow1G0m0XEba8hphYC7
X-Google-Smtp-Source: ABdhPJxBB0Xwnx9NawGCWaepqPnYcPi5Bq9WcdHJgDpVXE6ei3zcoaUK3n+9QTFA40FFOX0KNdFIxuLz7hqRymSC2ng=
X-Received: by 2002:a9d:6945:: with SMTP id p5mr3965118oto.301.1631786663910;
 Thu, 16 Sep 2021 03:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <202109160821.skJVoHhq-lkp@intel.com> <YULrCIRyvuryjoGE@kuha.fi.intel.com>
In-Reply-To: <YULrCIRyvuryjoGE@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Sep 2021 12:04:12 +0200
Message-ID: <CAJZ5v0idEO8LUvh+yWCV-f7Ha37thLo5fhnypMRSwEXLRd4EYQ@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 6/11] drivers/base/swnode.c:1120:17:
 error: too many arguments to function 'software_node_notify'
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 16, 2021 at 8:58 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Sep 16, 2021 at 08:13:24AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> > head:   9808623e1bba7d929b50865d7e2d7042cd4e5e7b
> > commit: 810fc8571f8b70a4263266d979f97edec2804574 [6/11] software node: balance refcount for managed sw nodes
> > config: arc-randconfig-r001-20210916 (attached as .config)
> > compiler: arc-elf-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=810fc8571f8b70a4263266d979f97edec2804574
> >         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> >         git fetch --no-tags rafael-pm bleeding-edge
> >         git checkout 810fc8571f8b70a4263266d979f97edec2804574
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/base/swnode.c: In function 'device_create_managed_software_node':
> > >> drivers/base/swnode.c:1120:17: error: too many arguments to function 'software_node_notify'
> >     1120 |                 software_node_notify(dev, KOBJ_ADD);
> >          |                 ^~~~~~~~~~~~~~~~~~~~
> >    In file included from drivers/base/swnode.c:14:
> >    drivers/base/base.h:206:6: note: declared here
> >      206 | void software_node_notify(struct device *dev);
> >          |      ^~~~~~~~~~~~~~~~~~~~
>
> Ah, that was modified in commit 384f5a857bae ("software nodes: Split
> software_node_notify()").
>
> So the patch is OK for stable, but for v5.15-rc1 it has to be changed:
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 7bd0f3cfb7eb4..c46f6a8e14d23 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1116,6 +1116,9 @@ int device_create_managed_software_node(struct device *dev,
>         to_swnode(fwnode)->managed = true;
>         set_secondary_fwnode(dev, fwnode);
>
> +       if (device_is_registered(dev))
> +               software_node_notify(dev);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(device_create_managed_software_node);
>
>
> Rafael, how do want to handle this?

I'll fix up the commit, thanks!
