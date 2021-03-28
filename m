Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3834BC73
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Mar 2021 14:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhC1M5H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Mar 2021 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1M4n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Mar 2021 08:56:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56432C061762;
        Sun, 28 Mar 2021 05:56:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso4632552pjb.4;
        Sun, 28 Mar 2021 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1/uzyA6pOZdXeSGhWpWxUqNW6ImJob8Xs5Y1LIUHB4=;
        b=ZmnxaWCFRLQNuORE+CiqHdSKgtBFDVCOXTV97sbfSZ6MKnuZLc0Bl6aWX6HzgBQGqi
         iwcC/C1sTgXzUDTWFONn/1xmSTnfjTPCJy0XO0t8OfMI19HlugXbQ5o5vpK81JtgpVry
         zgvlpQmmOpjs+1ycYK4YyjIdbeTRAazsFgUlobpBuz4m45+HjsP9f25wgNIfgJwpSUfk
         m3WA8nLXQ95LHyFwluu92fY24GZqRUqyiq5rtG9mHxKIQyRewqZIOc2lpHEmTQ/AmMYI
         iPw8wOUzw1F2i3lPGR4peG5CZid0DcZG3LiMUDOpBUe26iJsFW1eBiIJ/6OikfgjEUH3
         wIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1/uzyA6pOZdXeSGhWpWxUqNW6ImJob8Xs5Y1LIUHB4=;
        b=nyrjQN9HjnJ5mbgWg5wDL/ZysAkeVRHE//1GBokSDyPAxkjPEMPV2qjOxdyVkWj1CC
         fW6MKYTycgOOvbjG5QmNVHx4pPykbXMSubBMUVmk86EarksBux7Xqw144uFN887e6zIl
         3CiJRCBvueeTuRrxTtScNnb4wTjlFe1P1anM6F79g8z/d0NS4HJQqmov/TsqY8BmUEC8
         AtKhVN94KFN7j8oY0N1NjDCTSXHbHvN9i2coN3Ya1BZ7wo1rG3Ytbp0hDeSfvPuSVd9r
         1MoFjNMxF6qE00KgwyiJfkD+puBXiReiLZEPeFHvDyRKAwO6TW5yYjTjKPyXy0KuEcbN
         LIRg==
X-Gm-Message-State: AOAM5326MiY30TEhP8W2LVROMSWtk7SCsDTeBbx/R9042W7SqElLpxYW
        auS+7sR00XBMH23/6L6I3yOydlRdhp8zzYAe90w=
X-Google-Smtp-Source: ABdhPJyU9Hy3d1197aDUhlttjiGcwGkNFX4GQCuCMDvaNr68A8LQuVQ530N59OuIntaX43Oo9olLQgL8kya8YgibJtQ=
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr22663294pjr.228.1616936202828;
 Sun, 28 Mar 2021 05:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-3-andriy.shevchenko@linux.intel.com> <YGAmB2Nwph6pArXc@kroah.com>
In-Reply-To: <YGAmB2Nwph6pArXc@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 28 Mar 2021 15:56:26 +0300
Message-ID: <CAHp75VfFzqpdR+6p9vQww-ujQcw3L-V_N7ezUTGhcRmvwvqMZg@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] software node: Show properties and their values in sysfs
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

On Sun, Mar 28, 2021 at 9:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Mar 28, 2021 at 12:20:07AM +0200, Andy Shevchenko wrote:
> > It's very convenient to see what properties and their values
> > are currently being assigned in the registered software nodes.
> >
> > Show properties and their values in sysfs.

...

> > +             for (i = 0; i < prop->length / sizeof(u8); i++)
> > +                     len += sysfs_emit_at(buf, len, "%u,", ((u8 *)pointer)[i]);
>
> No, sysfs is "one value per file", and that is not what you are showing
> here at all :(

It is following: it's a "one value" for property in question,

As we may read in [1]: "...so it is socially acceptable to express an
array of values of the same type."

And here is exactly the case: *values of the same type*.

> Also, there is no Documentation/ABI/ entries for your new sysfs files,
> so that means we couldn't take this patcheset anyway :(

True, I'll fix this, thanks!

[1]: https://www.kernel.org/doc/html/latest/filesystems/sysfs.html

-- 
With Best Regards,
Andy Shevchenko
