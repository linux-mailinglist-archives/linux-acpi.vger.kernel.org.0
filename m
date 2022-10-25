Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F12260D4B8
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Oct 2022 21:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiJYTdE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Oct 2022 15:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiJYTdE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2022 15:33:04 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1944DBE77;
        Tue, 25 Oct 2022 12:32:51 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 6C71B4245C; Tue, 25 Oct 2022 20:32:48 +0100 (BST)
Date:   Tue, 25 Oct 2022 20:32:48 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>, Lyude <lyude@redhat.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Pan@freedesktop.org, Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        Jani Nikula <jani.nikula@intel.com>,
        nouveau@lists.freedesktop.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v5 02/31] drm/i915: Don't register backlight when another
 backlight should be used (v2)
Message-ID: <20221025193248.GA21457@srcf.ucam.org>
References: <20220825143726.269890-1-hdegoede@redhat.com>
 <20220825143726.269890-3-hdegoede@redhat.com>
 <f914ceb3-94bd-743c-f8b6-0334086e731a@gmail.com>
 <42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com>
 <20221024203057.GA28675@srcf.ucam.org>
 <8f53b8b6-ead2-22f5-16f7-65b31f7cc05c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f53b8b6-ead2-22f5-16f7-65b31f7cc05c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 25, 2022 at 08:50:54PM +0200, Hans de Goede wrote:

> That is a valid point, but keep in mind that this is only used on ACPI
> platforms and then only on devices with a builtin LCD panel and then
> only by GPU drivers which actually call acpi_video_get_backlight_type(),
> so e.g. not by all the ARM specific display drivers.
> 
> So I believe that Chromebooks quite likely are the only devices with
> this issue.

My laptop is, uh, weird, but it falls into this category.
 
> > I think for this to work correctly you need to have 
> > the infrastructure be aware of whether or not a vendor interface exists, 
> > which means having to handle cleanup if a vendor-specific module gets 
> > loaded later.
> 
> Getting rid of the whole ping-ponging of which backlight drivers
> get loaded during boot was actually one of the goals of the rework
> which landed in 6.1 this actually allowed us to remove some quirks
> because some hw/firmware did not like us changing our mind and
> switching backlight interfaces after first poking another one.
> So we definitely don't want to go back to the ping-pong thing.

Defaulting to native but then having a vendor driver be able to disable 
native drivers seems easiest? It shouldn't be a regression over the 
previous state of affairs since both drivers were being loaded already.
