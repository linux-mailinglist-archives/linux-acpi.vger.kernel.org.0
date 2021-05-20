Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EE238A07C
	for <lists+linux-acpi@lfdr.de>; Thu, 20 May 2021 10:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhETJAg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 May 2021 05:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231538AbhETJAf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 May 2021 05:00:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08B6661261;
        Thu, 20 May 2021 08:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621501154;
        bh=U8Jt/5l9BQ/i5KXdhQ9sblIOPEL/EfnvLscCxujqLi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XoEsUbaF6f7KzQrmHHWhIAxSKhG3J/4b/nYvpz53F+FbBCF5QJiiUaIN5Ik137VUK
         LQvMGt+V2fg75ifpY3bxSwNSqv/1navyfBu63Eqwt4MgdtkRPoFXHdpV9hLSzsaxKN
         +z37e22iVyPYCpnVrD5/+pJXFdv7Eyd2Q4/8jzXs=
Date:   Thu, 20 May 2021 10:59:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Casey G Bowman <casey.g.bowman@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/9] thunderbolt: Offline on-board retimer NVM upgrade
 support
Message-ID: <YKYk4LqriOskFCP4@kroah.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 19, 2021 at 05:12:50PM +0300, Mika Westerberg wrote:
> Hi all,
> 
> USB4 retimers are only accessible when the USB4 is up. However, sometimes
> it may be useful to be able to upgrade on-board retimers even if the link
> is not up. For instance if the user simply does not have any USB4 devices.
> 
> Making retimers accessible in "offline" mode requires some help from the
> platform firmware (ACPI in our case) to turn on power to the retimers and
> cycle them through different modes to get the sideband link up. This may
> also involve other firmwares such as Embedded Controller (as it is the case
> with recent Chromebooks).
> 
> This series adds support for "offline" retimer NVM upgrade so that it first
> exposes each USB4 port to the userspace. If the platform firmware provides
> a special _DSM-method (Device Specific Method) under the USB4 port ACPI
> description, we expose two attributes under the port that the userspace can
> use to put the port to offline mode and rescan for the retimers. Otherwise
> the NVM upgrade works the same way than with the online mode. We also add
> documentation to the admin-guide how this can be done.
> 
> In addition to this, at least Intel USB4 devices (and retimers) allow
> running NVM authenticate (upgrade) separately from write so we make it
> possible for the userspace to run the write and authenticate in two steps.
> This allows userspace to trigger the authentication at later time, like
> when the user logs out.
> 
> Mika Westerberg (4):
>   thunderbolt: Log the link as TBT instead of TBT3
>   thunderbolt: Add USB4 port devices
>   thunderbolt: Allow router NVM authenticate separately
>   thunderbolt: Check for NVM authentication status after the operation started
> 
> Rajmohan Mani (5):
>   thunderbolt: Add support for ACPI _DSM to power on/off retimers
>   thunderbolt: Add additional USB4 port operations for retimer access
>   thunderbolt: Add support for retimer NVM upgrade when there is no link
>   thunderbolt: Move nvm_write_ops to tb.h
>   thunderbolt: Add WRITE_ONLY and AUTHENTICATE_ONLY NVM operations for retimers

Looks good:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
