Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AE62F0838
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Jan 2021 16:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhAJPxt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Jan 2021 10:53:49 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36128 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJPxt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Jan 2021 10:53:49 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1BB2DA;
        Sun, 10 Jan 2021 16:53:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1610293986;
        bh=mdp/42K9ju2NRuvkRPWyCbi9pUrRQdaXR83ukN6BuR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMfhimpuuC7SP/wI7LlPTD3bHKeXEmS/cbmxHGPjZ2rAxeSMC+O4MIykKQlGnvoMU
         JTQUO005IfZxaEQ5jJR7xcvCJqFdgWEkX0SNOb+huNeu4OXsbit3or9Smd2I5qFwWT
         kfW8ZFdH5VyHZPARmUtGIXp/FXQJd6w6pkUenk40=
Date:   Sun, 10 Jan 2021 17:52:52 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v5 09/15] lib/test_printf.c: Use helper function to
 unwind array of software_nodes
Message-ID: <X/si1LAnrY1YpKWa@pendragon.ideasonboard.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-10-djrscally@gmail.com>
 <X/kOYeZtkCspoAC5@pendragon.ideasonboard.com>
 <CAHp75VeLiMdzXL3Awhco-w6JwJhZNVao_uj7F6bmuty_aW0SNQ@mail.gmail.com>
 <X/riDXHahRAXCQXC@pendragon.ideasonboard.com>
 <CAHp75VcntC5O8v8Q40Vw1oh9c-2eaq_ZRtjFLo1OFrwfku90Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VcntC5O8v8Q40Vw1oh9c-2eaq_ZRtjFLo1OFrwfku90Pw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 10, 2021 at 05:38:03PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 10, 2021 at 1:16 PM Laurent Pinchart wrote:
> > On Sat, Jan 09, 2021 at 11:07:33AM +0200, Andy Shevchenko wrote:
> > > On Saturday, January 9, 2021, Laurent Pinchart wrote:
> > > > Could you please let us know if you're fine with this patch getting
> > > > merged in v5.12 through the linux-media tree ? The cover letter contains
> > > > additional details (in a nutshell, this is a cross-tree series and we
> > > > would like to avoid topic branches if possible).
> > >
> > > There is already a tag by Petr.
> >
> > I saw that, but looking at the corresponding e-mail, there was no clear
> > acknowledgement that we could merge this patch through a different tree.
> 
> Fair point.
> 
> One question though, what so wrong with topic branches.

They're not wrong, they just add more complexity as all maintainers
involved would need to create a topic branch based on v5.11-rc1 and
merge it in their respective tree. It's certainly doable, but when
there's no risk of conflict, merging the whole series through a single
tree is just easier.

-- 
Regards,

Laurent Pinchart
