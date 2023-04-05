Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5182A6D8539
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Apr 2023 19:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDERvK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Apr 2023 13:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDERvJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Apr 2023 13:51:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5DA4ED2;
        Wed,  5 Apr 2023 10:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF07063EF2;
        Wed,  5 Apr 2023 17:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA45CC433EF;
        Wed,  5 Apr 2023 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680717067;
        bh=XqEBg36D7MQGhRTugpz7Q4hNT4P3WsJ6RihjTc0nG6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yALAChB9dSICV8ph9tMdaw9m/X01UEC3G6eUi5Smf3rrYcLwrPIAUvMvWNVzCK0q8
         gKnvNtbozGt6J+CxiwAZhfrbFXid0nIot5wJw4tzHEabWGTjYPhs/ltX2ogUVf4UWH
         m8hiAntRq6nxTwnN8ci0E3kBHAymg8C/X/Yn44cs=
Date:   Wed, 5 Apr 2023 19:51:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 6/7] net: dsa: mv88e6xxx: provide software
 node for default settings
Message-ID: <2023040527-atop-talcum-46e3@gregkh>
References: <ZCF2BLvGoaD/RGCS@shell.armlinux.org.uk>
 <ZCGkhUh20OK6rEck@kuha.fi.intel.com>
 <ZCGpDlaJ7+HmPQiB@shell.armlinux.org.uk>
 <ZCG6D7KV/0W0FUoI@shell.armlinux.org.uk>
 <ZCLZFA964zu/otQJ@kuha.fi.intel.com>
 <ZCLqXRKHh+VjCg8v@shell.armlinux.org.uk>
 <ZCRGHlERlLNuPHgE@kuha.fi.intel.com>
 <ZCRMTP1QJ0deQhOH@shell.armlinux.org.uk>
 <ZCWUq3yEn74JRW0w@kuha.fi.intel.com>
 <ZCrOeC+tYfQiBuoY@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCrOeC+tYfQiBuoY@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 03, 2023 at 02:02:48PM +0100, Russell King (Oracle) wrote:
> On Thu, Mar 30, 2023 at 04:54:51PM +0300, Heikki Krogerus wrote:
> > On Wed, Mar 29, 2023 at 03:33:48PM +0100, Russell King (Oracle) wrote:
> > > On Wed, Mar 29, 2023 at 05:07:26PM +0300, Heikki Krogerus wrote:
> > > > On Tue, Mar 28, 2023 at 02:23:41PM +0100, Russell King (Oracle) wrote:
> > > > > On Tue, Mar 28, 2023 at 03:09:56PM +0300, Heikki Krogerus wrote:
> > > > > > The problem is that the function you are proposing will be exploited
> > > > > > silently - people will use NULL as the parent without anybody
> > > > > > noticing. Everything will work for a while, because everybody will
> > > > > > first only have a single device for that driver. But as time goes by
> > > > > > and new hardware appears, suddenly there are multiple devices for
> > > > > > those drivers, and the conflict start to appear.
> > > > > 
> > > > > So, an easy solution would be to reject a call to
> > > > > fwnode_create_named_software_node() when parent is NULL, thereby
> > > > > preventing named nodes at the root level.
> > > > > 
> > > > > > At that point the changes that added the function call will have
> > > > > > trickled down to the stable trees, so the distros are affected. Now we
> > > > > > are no longer talking about a simple cleanup that fixes the issue. In
> > > > > > the unlikely, but possible case, this will turn into ABI problem if
> > > > > 
> > > > > There is no such thing as stable APIs for internal kernel interfaces.
> > > > > 
> > > > > Documentation/process/stable-api-nonsense.rst
> > > > > 
> > > > > > As you pointed out, this kind of risks we have to live with kbojects,
> > > > > > struct device stuff and many others, but the thing is, with the
> > > > > > software node and device property APIs right now we don't. So the fact
> > > > > > that a risk exists in one place just isn't justification to accept the
> > > > > > same risk absolutely everywhere.
> > > > > 
> > > > > Meanwhile, firmware descriptions explicitly permit looking up nodes by
> > > > > their names, but here we are, with the software node maintainers
> > > > > basically stating that they don't wish to support creating software
> > > > > nodes with explicit names.
> > > > 
> > > > If you want to name the nodes then you just go ahead and name them,
> > > > nobody is preventing you and you can already do that, but if you do
> > > > so, then you will take full responsibility of the entire software node
> > > > - that is what you are naming here - instead of just the fwnode that
> > > > it contains. The users of the node can deal with the fwnode alone, but
> > > > you as the creator of the software node have to take proper ownership
> > > > of it.
> > > > 
> > > > > > Russell, if you have some good arguments for accepting your proposal,
> > > > > > I assure you I will agree with you, but so far all you have given are
> > > > > > attacks on a sketch details and statements like that "I think you're
> > > > > > making a mountain out of a mole". Those just are not good enough.
> > > > > 
> > > > > Basically, I think you are outright wrong for all the reasons I have
> > > > > given in all my emails on this subject.
> > > > > 
> > > > > Yes, I accept there is a *slight* risk of abuse, but I see it as no
> > > > > different from the risk from incorrect usage of any other kernel
> > > > > internal interface. Therefore I just do not accept your argument
> > > > > that we should not have this function, and I do not accept your
> > > > > reasoning.
> > > > 
> > > > I would not be so against the function if there wasn't any other way
> > > > to handle your case, but there is.
> > > > 
> > > > You really can not claim that the existing API is in any way inferior,
> > > > or even more complex, compared to your function before you actually
> > > > try it. You simply can not make judgement based on a sketch that is
> > > > basically just showing you the functions and structures that you need.
> > > > 
> > > > If there are issues with the API, then we need to of course fix those
> > > > issues, but please keep in mind that still does not mean we have any
> > > > need for the function you are proposing.
> > > > 
> > > > Please also note that helpers are welcome if you feel we need them. If
> > > > you want to add for example an allocation routine that duplicates also
> > > > the properties in one go, then that alone would reduce the complexity
> > > > needed in the drivers that create the nodes. I think in most cases,
> > > > possibly also in yours, that alone would allow most stuff to be
> > > > handled from stack memory.
> > > > 
> > > > fwnode_create_software_node() is there just to support the legacy
> > > > device properties. You really should not be using even that. If you
> > > > need to deal with software nodes then you deal with them with struct
> > > > software_node.
> > > 
> > > You forgot to explain how to free them once they're done, because
> > > struct swnode will contain a pointer to the struct software_node
> > > which can be a dangling stale reference - and there's no way for
> > > code outside swnode.c to know when that reference has gone.
> > > 
> > > That is another reason why I prefer my existing solution. That
> > > problem is taken care of already by the existing code - and as
> > > it's taken care of there, and properly, there's less possibilities
> > > for users of swnode to get it wrong.
> > 
> > We need an improved release mechanism, yes.
> > 
> > My idea with the new dynamic allocation routine was that it could be
> > introduced together with a release callback that we add to the struct
> > software_node.
> > 
> > The idea of adding the release callback to the structure was actually
> > considered already some time ago - I think it was discussed at least
> > shortly also on the public ACPI mailing list. The idea back then
> > included a default release function that simply frees the struct
> > software_node instance. That default release function we could then
> > assign to the release callback in that new software node
> > allocation/creation routine. That way the drivers should be able to
> > continue to rely on the underlying code to take care of freeing the
> > node instance.
> > 
> > Back then there was nobody who really needed that functionality, so
> > nobody even tried to implement it. Now we of course clearly do need
> > something like it.
> > 
> > I think the release callback together with the default release
> > function should work. Let me know what you guys think.
> 
> Thinking about this more, no. This is utterly vile, and I will not
> create code that is vile.
> 
> Greg, please can you take a look at this, and give your opinion on
> how named software nodes (which are required to describe things in
> specific ways by firmware descriptions) should be handled? Is my
> proposal reasonable in your eyes? Thanks.

I'm lost, sorry, this thread is crazy long and I do not have the
bandwidth to try to dig through it.  I think you two need to work it out
together please.

thanks,

greg k-h

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
