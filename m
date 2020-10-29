Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4230029EC49
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 13:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgJ2Mur (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 08:50:47 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:55154 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2Mur (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 08:50:47 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id DBA2F3B68CE;
        Thu, 29 Oct 2020 12:33:55 +0000 (UTC)
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B56F5C0010;
        Thu, 29 Oct 2020 12:33:29 +0000 (UTC)
Message-ID: <08e3a1d264016aed93aca8632ee42637dc00d238.camel@hadess.net>
Subject: Re: [PATCH] Documentation: Add documentation for new
 platform_profile sysfs attribute
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, eliadevito@gmail.com, bberg@redhat.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Oct 2020 13:33:28 +0100
In-Reply-To: <d5f0bcba-5366-87da-d199-a85d59ba6c1c@redhat.com>
References: <markpearson@lenovo.com>
         <20201027164219.868839-1-markpearson@lenovo.com>
         <5ca1ae238b23a611b8a490c244fd93cdcc36ef79.camel@hadess.net>
         <d5f0bcba-5366-87da-d199-a85d59ba6c1c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2020-10-28 at 18:23 +0100, Hans de Goede wrote:
> 
> > It's not meaningless, but rather ambiguous. For a range of 1 to 5,
> > is 1
> > high performance, and 5 low power, or vice-versa?
> 
> It is meaningless because the space we are trying to describe with
> the
> profile-names is not 1 dimensional. E.g. as discussed before cool and
> low-power are not necessarily the same thing. If you have a better
> way
> to word this I'm definitely in favor of improving the text here.

What do you think of:

> +Since numbers are a rather meaningless way to describe platform-
profiles

"Since numbers on their own cannot represent the multiple variables
that a profile will adjust (power consumption, heat generation, etc.)
..."

> +this API uses strings to describe the various profiles. To make sure that
> +userspace gets a consistent experience when using this API this API
> +document defines a fixed set of profile-names. Drivers *must* map their
> +internal profile representation/names onto this fixed set.

