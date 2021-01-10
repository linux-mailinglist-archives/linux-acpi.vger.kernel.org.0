Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C42F0828
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Jan 2021 16:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhAJPjB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Jan 2021 10:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbhAJPjB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Jan 2021 10:39:01 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74FC061786;
        Sun, 10 Jan 2021 07:38:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f14so6262198pju.4;
        Sun, 10 Jan 2021 07:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqJS1ALYitmlc/SXec/egkB5H4wvJXw7RLjKoxmCYoc=;
        b=YgzSxaczo22CRZ0KG6AP6Z5ygHckUCV4hqfj6vZ5rBDGuDWf6lwFwQ1BQDWCgW69Ff
         wM+1PCEXBIWcN7AQ8B5pJ2Yo3rWvotC5xz5Cq/W6Iu/6o0m17mkpWppQ1kAUJwblkCWM
         hSGJ2gnXsYz5wS6TzyAcU91q52lKgjGOxmK33whULeTBR1MN2/Fp+wnXiQQDIB6JNMMJ
         ZI1PuY/BqBtCUFOszLO9pWeGHsrSOXHbJcgihIudwgmsg3Xe5d2tBz/aEBo1+nfpUljo
         PPHyjdS95lQODAck5Rik6VrEm8xaViYeKW7HDRtuhfNnN6iynssE3UkdmYQHpV1mgYcX
         zCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqJS1ALYitmlc/SXec/egkB5H4wvJXw7RLjKoxmCYoc=;
        b=StRHxo/x2HNMwKA9oEKVaY5bTH1q/H2RrLptOa6gZbZbKfWYgxBcb4ZJ0eG+Y7+4D3
         htu0n2ehC8asmd3JUwhGcjStGF3nR1Lobb47pEBFTQTpjy282JOWpEqlXCmEx125mjSy
         2QuMTJIU0O6WGYyx/B+sy3EMMVaRwTuG6CfTQ7H1iULbGCQy5Jx1EqHkq9vFyfpqMR1d
         yc+mbqtIoX/lIDOGPySRk6kZinVPZwKAYvT+bqszHslXHLmDj/59i41Pt/mgQlXgCM27
         P/EaMOUxvR59LcXHxEKZqe7b2rRW8hPbRf9T/fK0auLPIqPL5Fed5rRLc9w0tIr6pssM
         BQkA==
X-Gm-Message-State: AOAM530UlV6nqicFk8ujObBlpc7eUA8WQAcNlO3okxYE58NXmZrzRT4W
        Fxtvj5sdYdGJkicpDOaZd7sODwV8Ad9APA9dWpg=
X-Google-Smtp-Source: ABdhPJxcnfPIa3G0X8KNjVdup+JX/ToKTrqeSsR95jz+WVG6BkBEkRN4DAtYTrjraNdR8yQsyTldwj5nhUzyafAX8ss=
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr13606980pjt.228.1610293099487;
 Sun, 10 Jan 2021 07:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20210107132838.396641-1-djrscally@gmail.com> <20210107132838.396641-10-djrscally@gmail.com>
 <X/kOYeZtkCspoAC5@pendragon.ideasonboard.com> <CAHp75VeLiMdzXL3Awhco-w6JwJhZNVao_uj7F6bmuty_aW0SNQ@mail.gmail.com>
 <X/riDXHahRAXCQXC@pendragon.ideasonboard.com>
In-Reply-To: <X/riDXHahRAXCQXC@pendragon.ideasonboard.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Jan 2021 17:38:03 +0200
Message-ID: <CAHp75VcntC5O8v8Q40Vw1oh9c-2eaq_ZRtjFLo1OFrwfku90Pw@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] lib/test_printf.c: Use helper function to unwind
 array of software_nodes
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "yong.zhi@intel.com" <yong.zhi@intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "bingbu.cao@intel.com" <bingbu.cao@intel.com>,
        "tian.shu.qiu@intel.com" <tian.shu.qiu@intel.com>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "laurent.pinchart+renesas@ideasonboard.com" 
        <laurent.pinchart+renesas@ideasonboard.com>,
        "jacopo+renesas@jmondi.org" <jacopo+renesas@jmondi.org>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "niklas.soderlund+renesas@ragnatech.se" 
        <niklas.soderlund+renesas@ragnatech.se>,
        "prabhakar.mahadev-lad.rj@bp.renesas.com" 
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 10, 2021 at 1:16 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Sat, Jan 09, 2021 at 11:07:33AM +0200, Andy Shevchenko wrote:
> > On Saturday, January 9, 2021, Laurent Pinchart wrote:
> > > Could you please let us know if you're fine with this patch getting
> > > merged in v5.12 through the linux-media tree ? The cover letter contains
> > > additional details (in a nutshell, this is a cross-tree series and we
> > > would like to avoid topic branches if possible).
> >
> > There is already a tag by Petr.
>
> I saw that, but looking at the corresponding e-mail, there was no clear
> acknowledgement that we could merge this patch through a different tree.

Fair point.

One question though, what so wrong with topic branches.

-- 
With Best Regards,
Andy Shevchenko
