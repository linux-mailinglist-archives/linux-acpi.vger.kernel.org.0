Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E72F4A8B
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 12:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbhAMLop (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jan 2021 06:44:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:46382 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbhAMLop (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Jan 2021 06:44:45 -0500
IronPort-SDR: zC01mtUVWzx73an9c/JECTfkjAKfH8ThYl9ijoadwQ+FDbomASpLtAVtBRMRXdDqmpIpxsQ4iq
 dXCkfHXB28gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="239730876"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="239730876"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 03:42:58 -0800
IronPort-SDR: 3j4F2y6/OhnLLUOBPzJpyD0dxEd60lDhOHaARqoH8x51OwEvrtKe6yicEftyL/Mx02PchFGn6g
 Bj1OUHfslcFA==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="404798865"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 03:42:52 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 4AD23207BF; Wed, 13 Jan 2021 13:42:50 +0200 (EET)
Date:   Wed, 13 Jan 2021 13:42:50 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        yong.zhi@intel.com, Bingbu Cao <bingbu.cao@intel.com>,
        tian.shu.qiu@intel.com, Robert Moore <robert.moore@intel.com>,
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
Subject: Re: [PATCH v5 00/15] Add functionality to ipu3-cio2 driver allowing
 software_node connections to sensors on platforms designed for Windows
Message-ID: <20210113114250.GH11878@paasikivi.fi.intel.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <CAJZ5v0gb9c-kWM4aAKm6UqbVKt7dyp6xJS5E=7yoPRnPP+msbw@mail.gmail.com>
 <9c451747-410e-3c99-c1a5-87336b71aa7b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c451747-410e-3c99-c1a5-87336b71aa7b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

On Tue, Jan 12, 2021 at 11:35:37PM +0000, Daniel Scally wrote:
> Hi Rafael, Sakari
> 
> On 12/01/2021 19:34, Rafael J. Wysocki wrote:
> > <snip>
> >> I'm hopeful that most or all of this series could get picked up for 5.12.
> >> We touch a few different areas (listed below), but I think the easiest
> >> approach would be to merge everything through media tree. Rafael, Greg,
> >> Mauro and Sergey; are you ok with that plan, or would you prefer a
> >> different approach? Mauro; if that plan is ok (and of course assuming that
> >> the rest of the patches are acked by their respective maintainers) could
> >> we get a dedicated feature branch just in case the following series ends
> >> up being ready in time too?
> >>
> >> <snip>
> > Please feel free to add
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > to all of the device properties patches in this series if that helps.
> >
> > Thanks!
> 
> Thanks very much (and Greg too).
> 
> 
> Sakari; unless I'm misunderstanding something, I think this series could
> be picked up now, right? Would it be ok to do that through your tree? I
> think the idea of a dedicated feature branch can be dropped, I won't
> have the second series ready in time for this round anyway.
> 
> 
> First time doing this, so if I've missed something please let me know!

I think it's ready, indeed. I'll let you know if there are any issues.

-- 
Kind regards,

Sakari Ailus
