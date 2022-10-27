Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0052460F360
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Oct 2022 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiJ0JNA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Oct 2022 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiJ0JMm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Oct 2022 05:12:42 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6116D551;
        Thu, 27 Oct 2022 02:11:25 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 780B740A8B; Thu, 27 Oct 2022 10:11:23 +0100 (BST)
Date:   Thu, 27 Oct 2022 10:11:23 +0100
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
Message-ID: <20221027091123.GA28089@srcf.ucam.org>
References: <20221024203057.GA28675@srcf.ucam.org>
 <8f53b8b6-ead2-22f5-16f7-65b31f7cc05c@redhat.com>
 <20221025193248.GA21457@srcf.ucam.org>
 <144cd47e-42dc-2b84-1a90-ea5e080e08a3@redhat.com>
 <20221025204043.GA23306@srcf.ucam.org>
 <cb5add36-c13c-ccd5-1b4b-71b45163a170@redhat.com>
 <20221025234040.GA27673@srcf.ucam.org>
 <fa6cc1d9-6740-b495-2c72-cae18c429ca6@redhat.com>
 <20221026204920.GA15326@srcf.ucam.org>
 <099dee98-8aeb-af36-828c-110f5ac6e9a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <099dee98-8aeb-af36-828c-110f5ac6e9a3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 27, 2022 at 10:51:45AM +0200, Hans de Goede wrote:

> In their backlight register paths and this has been present since
> circa 2015.
> 
> So both before and after my 6.1 refactor vendor is only preferred
> on devices which don't implement the ACPI video bus control method.

Sorry, yes, that's the case I meant.

> Just because a vendor interface is present does not mean that it will
> work. Unfortunately for none of the 3 main native/acpi_video/vendor
> backlight control methods the control method being present also guarantees
> that it will work. Which completely sucks, but it is the reality we
> have to deal with.

But traditionally that's been logic that we've encoded into the vendor 
drivers, which can take other factors into account when determining 
whether the exposed interface works. You've now discarded that 
knowledge. The only way you can maintain the degree of functionality 
that 6.0 had is to move that determination into core code, or 
alternatively support dynamic reattachment of backlight interfaces based 
on vendor drivers loading later. An alternative would be to just revert 
all of this, and instead only use this logic for the output property 
interface (which would still result in different outcomes, but only for 
userland that's choosing to use the new interface, so that's a different 
problem).
