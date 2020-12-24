Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6DF2E26B1
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 13:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgLXMOK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 07:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbgLXMOK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 07:14:10 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64CAC061794;
        Thu, 24 Dec 2020 04:13:29 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l23so1101023pjg.1;
        Thu, 24 Dec 2020 04:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UALr9ym4hsAZyiPOgyH1YaE+cu2KjtwJLBwTVvlB5/k=;
        b=Mg+X4meLskIl4Y4m1FU2Bpwk0/eLPjYsQ1bc2nFbH5sa/Fymch56YfhLwLr2zHgu6+
         cHXDlkz0qPSrqikN8Kqss93Mb9vkwRYAKrpeV4/VhA5jIXmnM+r+mKthrMlJia4csbNU
         GRDdpX/FxssQBT5uUJNC0sqPiujRKyronrpH5ErzdcNk3jPAHK54x+IRg0kaYgGnaNVy
         qTTbaS8J8yo0mFvCaCaf05Nm5opZPixYbnD4EmO26MGunXN7ttnNV+X4MkiC9+PJ7RdU
         EKMl7kCTVAMhsNNJhptfAavOs4Thf1sP50uNALVbuHt6x76qWZvvSKKA3Ltv+UiORG2x
         9whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UALr9ym4hsAZyiPOgyH1YaE+cu2KjtwJLBwTVvlB5/k=;
        b=DOewvRm9Y/J2OsO6wMhI56oBcWF2vLVpNt7+0kuTstgUPBYz+YZ3QzQgsicipL8liY
         St7NGRW/f8qIeL+fDsmsxUdjMrXKjobTd1nLrPiU58Xxxwg+EnCJps3aMxfTAT20MI0I
         klXwo1CiPLCYCC7K55NIr9EuIYebJzZeKVseZTEg8gEJZqBRhICvCVW0KLz988t845yg
         amVNkBvhAU9QtXwS8iyn+V/3KDuIpeOsTb3VGCdYbnX3LQ75yWEC7s/UHhhUBWNYWrj/
         fkFuw19ljJ9i44KqWEgiiAYi13psnharc8dVS1X4RAQQg79xq/kNaYdju2jLR5QKxkg9
         Y8yw==
X-Gm-Message-State: AOAM533+OMPivAPNV2jZ0Cg64UkOi3NfNn13xgpUbWs80hSNdm0i5WeG
        it+HthvmytjSND5afaOsNmJjh3KhVb7n+Uiz0Dg=
X-Google-Smtp-Source: ABdhPJzFIC1SAIBCVWCBrnBnewdPpuCRgYW7JPpjkgyIwp7BAN66+GZ8WvhceftHJu5SPnS3x8pknFhFVqKS3VtWvWc=
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id
 f12-20020a170902e98cb02900dacb88f11dmr8616930plb.17.1608812009413; Thu, 24
 Dec 2020 04:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20201224010907.263125-1-djrscally@gmail.com> <20201224010907.263125-6-djrscally@gmail.com>
In-Reply-To: <20201224010907.263125-6-djrscally@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Dec 2020 14:13:13 +0200
Message-ID: <CAHp75VdF5NdjrSxcOafh7KNNDteYEUDk9otA0HKX-iks7G0D4g@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] software_node: unregister software_nodes in
 reverse order
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 24, 2020 at 3:12 AM Daniel Scally <djrscally@gmail.com> wrote:
>
> To maintain consistency with software_node_unregister_nodes(), reverse
> the order in which the software_node_unregister_node_group() function
> unregisters nodes.

...

> - * Unregister multiple software nodes at once.
> + * Unregister multiple software nodes at once. The array will be unwound in
> + * reverse order (i.e. last entry first) and thus if any member of the array
> + * has its .parent member set then they should appear later in the array such
> + * that they are unregistered first.

I'm, as being not a native speaker, a bit confused by this comment.
The idea is that children are unregistered first. Can you try to make
it more clear maybe?

>   */


-- 
With Best Regards,
Andy Shevchenko
