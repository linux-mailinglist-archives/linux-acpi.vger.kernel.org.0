Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5B3056EF
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 10:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhA0J3C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 04:29:02 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:37000 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhA0J1A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 04:27:00 -0500
Received: by mail-ot1-f54.google.com with SMTP id h14so1048068otr.4;
        Wed, 27 Jan 2021 01:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOR2jYarZAIULssGyJXJ6uS2/Gf8KvvXT6ay380s3Ag=;
        b=P3vODpL3LJy+mA7y7tvSnzL91S51TJDsZX6Keex3VquiVtO5/d0os510su+UFP3X/m
         b7oL3hJCx0ywu1ibTdrt80euywM3NW57YQxBTDkIqjtOW765grUee49wNaH9FVpMOWCs
         SxcvtMP6T6Ks/hr+J02LwNneP5wG50R3EaLzG6NmObg31n7GhriE7tFeukTbzSjVD/m9
         EqJW8387hRuGeoedfho/WKA37tb6QzAIx88DBQrnzFpByHEjuYin8l8XWQZm4f31YQs8
         CXXMYC+1Ojs+1WdebNt6tzcRT1cFVOYPhhY1kd3MGna1+odM4FbNAxRyZkmjVHf1jGbH
         Jq1g==
X-Gm-Message-State: AOAM532WBpj2OfXmq7WfjnOxGFmYYuj+ye15cffjTSnP9/3IvMQSGa8T
        5Hh01tHQLADKCamAC+HBOF4yCU8qdZR7B6veLeDHtNo6D/4=
X-Google-Smtp-Source: ABdhPJx9wJlEQ4bnaLtYPehzxPxnjlaJ6trXP1x3dKBZE4OYrUy+xad415g1cXWG3k2gGvossTKBceVLJwdKmFxzdJo=
X-Received: by 2002:a05:6830:1489:: with SMTP id s9mr6268270otq.250.1611739561257;
 Wed, 27 Jan 2021 01:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20210107132838.396641-1-djrscally@gmail.com> <20210107132838.396641-10-djrscally@gmail.com>
 <X/kOYeZtkCspoAC5@pendragon.ideasonboard.com> <20210113132309.GK11878@paasikivi.fi.intel.com>
In-Reply-To: <20210113132309.GK11878@paasikivi.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Jan 2021 10:25:50 +0100
Message-ID: <CAMuHMdWxjNcWqj_O1JyQb3Q0eAgYk1Ki3Ji6rs00Sk-YvfSm4g@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] lib/test_printf.c: Use helper function to unwind
 array of software_nodes
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, yong.zhi@intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari, Mauro,

On Wed, Jan 13, 2021 at 2:26 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> On Sat, Jan 09, 2021 at 04:01:05AM +0200, Laurent Pinchart wrote:
> > Could you please let us know if you're fine with this patch getting
> > merged in v5.12 through the linux-media tree ? The cover letter contains
> > additional details (in a nutshell, this is a cross-tree series and we
> > would like to avoid topic branches if possible).
>
> I'll proceed to merge this patch through the media tree.

Prefixing this patch with "media:"[1] when committing is confusing.

[1] commit f0328be57568c795 ("media: lib/test_printf.c: Use helper
function to unwind array of software_nodes").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
