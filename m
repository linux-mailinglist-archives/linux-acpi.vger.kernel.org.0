Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CAC2E68FF
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Dec 2020 17:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgL1Qm6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 11:42:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:42993 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441174AbgL1Qm4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Dec 2020 11:42:56 -0500
IronPort-SDR: BMKb+f/PkCwUNrptxiN4rAH+/3FQiD7FnfdjMo72ktot1KVoS7WDG35ekdtxO/GcHKIcITvQ45
 6bL/E4P+ZtGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="237954339"
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="237954339"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 08:41:09 -0800
IronPort-SDR: zhtrSmxO38BP8LFTDnbtKWbj9P2lMU+twqCBjYKfblBqDSJldD0w9bbqj8SzOvYoAIq5G8cI1E
 GyQzP8h07DFg==
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="562877701"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 08:41:03 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 2F443207BF; Mon, 28 Dec 2020 18:41:01 +0200 (EET)
Date:   Mon, 28 Dec 2020 18:41:01 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
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
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 07/14] software_node: Add support for fwnode_graph*()
 family of functions
Message-ID: <20201228164101.GY26370@paasikivi.fi.intel.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-8-djrscally@gmail.com>
 <CAHp75Vft7gg1AcKCEU+E74eB_ZMouHFd-8uZ7pcVj5CoJzZpvQ@mail.gmail.com>
 <X+SPsks5itN9OFqB@pendragon.ideasonboard.com>
 <CAHp75Ve6YHm-tdqFPvOhfJiT=uRK_dpKY3mnhQd6Mg3KkSuKqA@mail.gmail.com>
 <d47e0ccf-9def-e9c9-fdfb-390ad5d2ee5e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47e0ccf-9def-e9c9-fdfb-390ad5d2ee5e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

On Thu, Dec 24, 2020 at 02:21:15PM +0000, Daniel Scally wrote:
> Hi Andy, Laurent
> 
> > On Thu, Dec 24, 2020 at 2:55 PM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> >> On Thu, Dec 24, 2020 at 02:24:12PM +0200, Andy Shevchenko wrote:
> >>> On Thu, Dec 24, 2020 at 3:14 AM Daniel Scally wrote:
> > 
> > ...
> > 
> >>>> +               if (!strncmp(to_swnode(port)->node->name, "port@",
> >>>
> >>> You may use here corresponding _FMT macro.
> >>>
> >>>> +                            FWNODE_GRAPH_PORT_NAME_PREFIX_LEN))
> >>>> +                       return port;
> > 
> > ...
> > 
> >>>> +       /* Ports have naming style "port@n", we need to select the n */
> >>>
> >>>> +       ret = kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_PORT_NAME_PREFIX_LEN,
> >>>
> >>> Maybe a temporary variable?
> >>>
> >>>   unsigned int prefix_len = FWNODE_GRAPH_PORT_NAME_PREFIX_LEN;
> >>>   ...
> >>>   ret = kstrtou32(swnode->parent->node->name + prefix_len,
> >>
> >> Honestly I'm wondering if those macros don't hinder readability. I'd
> >> rather write
> >>
> >>         + strlen("port@")
> > 
> > Works for me, since the compiler optimizes this away to be a plain constant.
> 
> Well, how about instead of the LEN macro, we have:
> 
> #define FWNODE_GRAPH_PORT_NAME_PREFIX	"port@"
> #define FWNODE_GRAPH_PORT_NAME_FMT FWNODE_GRAPH_PORT_NAME_PREFIX "%u"
> 
> And then it's still maintainable in one place but (I think) slightly
> less clunky, since we can do strlen(FWNODE_GRAPH_PORT_NAME_PREFIX)
> 
> Or we can do strlen("port@"), I'm good either way :)

I'd be in favour of using strlen("port@") here.

At least for now. I think refactoring the use of such strings could be a
separate set at another time, if that's seen as the way to go.

-- 
Kind regards,

Sakari Ailus
