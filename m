Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF366A11F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jan 2023 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjAMRtj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Jan 2023 12:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjAMRs5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jan 2023 12:48:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA938F8C1;
        Fri, 13 Jan 2023 09:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673631636; x=1705167636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aOFHIYXUBrqr9+If/r9gCmOL5KeU2zlnO6suhhT47oc=;
  b=DpbO396DdHI5HlgDvDqfPK2KI6a0g1pjjkwQmY2vZtu1xtGrY3XNw2mY
   FtGXbtZ7FmFbZBB+wFWIeQ4JcNxNifrnGDRamfF9GO3pVLlgmWhoCL5Ar
   jvRDb6ngIYznciZGW47OXDjovlX5GfCOzMuTbSUjMoO8ebag6VR/6MQ1j
   bFkW/c9YZ1sfRcRuplcMZb7hba4iJUY+OmySx+sMUFarIZKLG+Kw+GYWk
   4Wa1Q7u4bdiOx31Auw2rcPFtFl33EAAkDuOafvv1ZQIbxDVZJ6Z3Sv2af
   hPcivWUJE78Br7WLo/J5oKodHVELbMaonoi5BlqRIIvAtG5/7UWDso69f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="386396069"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="386396069"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:40:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="658287535"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="658287535"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2023 09:40:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pGO2R-008jqV-0f;
        Fri, 13 Jan 2023 19:40:23 +0200
Date:   Fri, 13 Jan 2023 19:40:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, chrome-platform@lists.linux.dev,
        Xin Ji <xji@analogixsemi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v10 1/9] device property: Add remote endpoint to devcon
 matcher
Message-ID: <Y8GXhhYY9a7Z/t9H@smile.fi.intel.com>
References: <20230112042104.4107253-1-treapking@chromium.org>
 <20230112042104.4107253-2-treapking@chromium.org>
 <Y8AL8nTcNcl6zX7H@paasikivi.fi.intel.com>
 <CACeCKaeN7KBi30M1fRWhTPgMbxF6=B+KuAS7Ny7+i9qCx+=49Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaeN7KBi30M1fRWhTPgMbxF6=B+KuAS7Ny7+i9qCx+=49Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 12, 2023 at 02:31:45PM -0800, Prashant Malani wrote:
> On Thu, Jan 12, 2023 at 5:32 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > On Thu, Jan 12, 2023 at 12:20:56PM +0800, Pin-yen Lin wrote:
> > > From: Prashant Malani <pmalani@chromium.org>

...

> > > +             /*
> > > +              * Some drivers may register devices for endpoints. Check
> > > +              * the remote-endpoints for matches in addition to the remote
> > > +              * port parent.
> > > +              */
> > > +             node = fwnode_graph_get_remote_endpoint(ep);
> > > +             if (fwnode_device_is_available(node)) {
> > > +                     ret = match(node, con_id, data);
> > > +                     if (ret) {
> > > +                             if (matches)
> > > +                                     matches[count] = ret;
> > > +                             count++;
> > > +                     }
> > > +             }
> >
> > Aren't you missing fwnode_handle-put(node) here??
> 
> It shouldn't be necessary. We aren't break-ing/continue-ing here,
> and fwnode_handle_put(node) is called latter in the loop [1][2]
> 
> BR,
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/property.c#n1256
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/property.c#n1261

I'm really puzzled what do you mean by all this.
Sakari is right, btw.


-- 
With Best Regards,
Andy Shevchenko


