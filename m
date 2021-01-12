Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8962F3A4D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 20:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406760AbhALT04 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 14:26:56 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40409 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406739AbhALT04 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2021 14:26:56 -0500
Received: by mail-ot1-f53.google.com with SMTP id j12so3376815ota.7;
        Tue, 12 Jan 2021 11:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9SIIDDFT9uls6UTDADwMgAnAVzHFxFMS60aJmoylv4=;
        b=fihmoa59glxRbjZIkWqvGW74upYGB5OuG5yI7TSPbcPU7FOcMLfqCln+/m2Y97miM0
         smat0nuU656VhBB4QRv9wr/Ss3QfBwEkcRxopTc2+kuiRKJUaig/VVD0AQ1USJehiWLS
         CrGp/GJHCJac99EoM1y0K6tEVGrf5Oc/c0aX/W26in4HXrQUEkDvc0F68lwKh8PVYddz
         mIts2mOqbtu/YnfExaDmYHMBUn0Wvk2k0LjDBzrWsOJhYNukq6P/Rjm48oSigSYzaaX5
         /AJDe07NMpKLhIVU16L/rR9S/DeRKgKA7AT0AnJKYIcvtwetIyPFR9xrYg5Eit/FVc3D
         h51g==
X-Gm-Message-State: AOAM532VSbKy4p3gwYpTLQC05q7fvESTWra3A03drCBOCPgQl9Y1yMOb
        qyY4P7I6pMGc+gcDQ/7Z8seKHXTbQmMpgUbBIA8=
X-Google-Smtp-Source: ABdhPJz458Q3yIYCQLLO3wiyAkdrn7qtpOJu0L7VRbx+Ri8t+mFlajZ+pI4GOy165xcTN3VR/23Te58mQc00vbLW0KE=
X-Received: by 2002:a05:6830:4b5:: with SMTP id l21mr518934otd.321.1610479575262;
 Tue, 12 Jan 2021 11:26:15 -0800 (PST)
MIME-Version: 1.0
References: <20210107132838.396641-1-djrscally@gmail.com> <20210107132838.396641-14-djrscally@gmail.com>
 <X/kM0wWEInPhz3mz@pendragon.ideasonboard.com>
In-Reply-To: <X/kM0wWEInPhz3mz@pendragon.ideasonboard.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 20:26:04 +0100
Message-ID: <CAJZ5v0i_TH2yqnPs8CWmMZC-DznkWdvYPM1vshvxZhFajwp-cQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] ACPI / bus: Add acpi_dev_get_next_match_dev()
 and helper macro
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        yong.zhi@intel.com, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, tian.shu.qiu@intel.com,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Sat, Jan 9, 2021 at 2:55 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rafael,
>
> Could you please review this patch, and let us know (see question in the
> cover letter)

Done, sorry for the delay.

> if it can be merged through the linux-media tree for v5.12
> ?

Yes, it can.

Thanks!
