Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990DC29EE1C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 15:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgJ2OXa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 10:23:30 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42195 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgJ2OWf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 10:22:35 -0400
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A47666000A;
        Thu, 29 Oct 2020 14:21:43 +0000 (UTC)
Message-ID: <fb95dc5b8d9cee5a66759adc268e284cb1f1a3bd.camel@hadess.net>
Subject: Re: [External] Re: [PATCH] Documentation: Add documentation for new
 platform_profile sysfs attribute
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, eliadevito@gmail.com, bberg@redhat.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Oct 2020 15:21:43 +0100
In-Reply-To: <ebeec472-3310-c560-e8bf-2b33c480333b@redhat.com>
References: <markpearson@lenovo.com>
         <20201027164219.868839-1-markpearson@lenovo.com>
         <5ca1ae238b23a611b8a490c244fd93cdcc36ef79.camel@hadess.net>
         <d5f0bcba-5366-87da-d199-a85d59ba6c1c@redhat.com>
         <b3e61ee4-3fca-ce06-2216-977586baae4e@lenovo.com>
         <ebeec472-3310-c560-e8bf-2b33c480333b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2020-10-29 at 10:46 +0100, Hans de Goede wrote:
> <
> <snip>

> IMHO it does not belong in the sysfs API docs for the
> platform_profile
> stuff. But I guess it would be good to document it somewhere in some
> generic syfs API rules/expectations document (with a note that their
> might be exceptions).
> 
> Ideally we would already have such a file somewhere, but I don't know
> if we do (I did not look). So if you feel like it (and such a file
> does
> not exist yet) then I guess a patch adding such a doc file would be
> good.

I don't know enough about the helpers and the code around it to know
whether documenting this would be needed, but I'm fine with knowing
that we're not breaking new ground here.

