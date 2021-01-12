Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0A2F3A9F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436508AbhALTbd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 14:31:33 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45418 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406789AbhALTbb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2021 14:31:31 -0500
Received: by mail-ot1-f45.google.com with SMTP id n42so3351644ota.12;
        Tue, 12 Jan 2021 11:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=579ECh+/HPGB6zPxi5v2gvgBTd45mQ9S7oiP7Tpxxs0=;
        b=boTBcaMQ9a7BZoFetO214WHPKE46bWyHllWGC+m1TiSot4CsMzyif7sCOGRGy8gvHc
         TvbbKKnjbEO10oyUspEfZTQY/CA59tNKSVISXbG70Mn7lo1zi1u7N9/n4AbbXiy9Q6jz
         cxY4e9875LLKQdL9lY17Yqi06Lzx2WXQMIcvySDD/inqueVMNDXzNVyPbRkrYIxkmBtV
         QJ8wINdRo8OVVPo//grmSKOTaeFIaKlojR81QdivIyq7zUTnUlYphXLC7bmRTHYjI3KJ
         miUI+ZMRxL4c6KLMjJcGfvjLgmVAUOXVv0762Zga4tzcpHRHLmIXTcJt0vUf4CRflXOX
         wRzA==
X-Gm-Message-State: AOAM530npBbYJXLiTBdLsxGEIVmRBrXnJCvHlurYbDShw8NOLSsTPAff
        Pa2LrqGPV2+LspekoMuUyZajaWKTpQA4GO+oZ5Q=
X-Google-Smtp-Source: ABdhPJxGA5IXl+9x5eDMWOnGLjUhZhSzMHVZQan/08pLnADl6k3O6Pp4B7jpWz37P7At+vFZy8gXnHqGI5YooREy480=
X-Received: by 2002:a05:6830:4b5:: with SMTP id l21mr530252otd.321.1610479850617;
 Tue, 12 Jan 2021 11:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20210107132838.396641-1-djrscally@gmail.com> <20210107132838.396641-8-djrscally@gmail.com>
 <X/kPck60UO/NYuRa@pendragon.ideasonboard.com>
In-Reply-To: <X/kPck60UO/NYuRa@pendragon.ideasonboard.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 20:30:39 +0100
Message-ID: <CAJZ5v0jH3vXwqAh4qqhTVmAoYxrY=S0GDST1kdkfwhQxbFv58Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/15] device property: Define format macros for ports
 and endpoints
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 9, 2021 at 3:06 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rafael,
>
> Could you please let us know with an Acked-by

Done, sorry for the delay.

> if this patch can be merged through the linux-media tree for v5.12 ?

Yes, it can.

Thanks!
