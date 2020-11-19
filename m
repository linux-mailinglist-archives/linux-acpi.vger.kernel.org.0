Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672A12B98A6
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgKSQzB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 11:55:01 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:37468 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgKSQzB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2020 11:55:01 -0500
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 1AA823A504B
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2020 16:38:20 +0000 (UTC)
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 312D71BF210;
        Thu, 19 Nov 2020 16:37:55 +0000 (UTC)
Message-ID: <c86f894d29189980709a905df0855fdf731ade29.camel@hadess.net>
Subject: Re: [PATCH 0/3] Platform Profile support
From:   Bastien Nocera <hadess@hadess.net>
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     rjw@rjwysocki.net, hdegoede@redhat.com, mgross@linux.intel.com,
        linux-acpi@vger.kernel.org, mario.limonciello@dell.com,
        eliadevito@gmail.com, bberg@redhat.com,
        platform-driver-x86@vger.kernel.org, dvhart@infradead.org
Date:   Thu, 19 Nov 2020 17:37:55 +0100
In-Reply-To: <20201110033124.3211-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
         <20201110033124.3211-1-markpearson@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2020-11-09 at 22:31 -0500, Mark Pearson wrote:
> This patch series is for the implementation of the platform-profile
> feature - the ability to determine which mode the platform is in and
> to change the mode using a sysfs entry.
> 
> The first patch is an update of the document I've been working on
> with
> review and help from the kernel community. Thank you to everybody for
> their input.
> 
> The second patch implements the platform-profile sysfs and API's
> needed.
> 
> The third patch has Lenovo specific changes in thinkpad_acpi.c to use
> the new platform-profile implementation and be able to switch between
> low, medium and high power modes.

I've implemented this in power-profiles-daemon:
https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/41

Was pretty straight forward to implement, so good job :)

