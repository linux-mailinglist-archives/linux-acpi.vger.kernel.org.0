Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B104E1D149
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2019 23:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfENV3W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 May 2019 17:29:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42388 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENV3V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 May 2019 17:29:21 -0400
Received: from 79.184.255.148.ipv4.supernova.orange.pl (79.184.255.148) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id bc0f4377005ba3a1; Tue, 14 May 2019 23:29:19 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        jank@cadence.com, Joe Perches <joe@perches.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: [PATCH v2] ACPI / device_sysfs: change _ADR representation to 64 bits
Date:   Tue, 14 May 2019 23:29:18 +0200
Message-ID: <1683867.ro8ObbCUgW@kreacher>
In-Reply-To: <CAJZ5v0i+M8y3ddr+Z5o5af8OatMXq3xqCF5CUg5PjnANrTOSHw@mail.gmail.com>
References: <20190501125322.23791-1-pierre-louis.bossart@linux.intel.com> <20190502045817.GZ3845@vkoul-mobl.Dlink> <CAJZ5v0i+M8y3ddr+Z5o5af8OatMXq3xqCF5CUg5PjnANrTOSHw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, May 6, 2019 10:36:22 AM CEST Rafael J. Wysocki wrote:
> On Thu, May 2, 2019 at 6:58 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 01-05-19, 07:53, Pierre-Louis Bossart wrote:
> > > Standards such as the MIPI DisCo for SoundWire 1.0 specification
> > > assume the _ADR field is 64 bits.
> > >
> > > _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
> > > released in 2002. The low levels already use _ADR as 64 bits, e.g. in
> > > struct acpi_device_info.
> > >
> > > This patch bumps the representation used for sysfs to 64 bits. To
> > > avoid any compatibility/ABI issues, the printf format is only extended
> > > to 16 characters when the actual _ADR value exceeds the 32 bit
> > > maximum.
> > >
> > > Example with a SoundWire device, the results show the complete
> > > vendorID and linkID which were omitted before:
> > >
> > > Before:
> > > $ more /sys/bus/acpi/devices/device\:38/adr
> > > 0x5d070000
> > > After:
> > > $ more /sys/bus/acpi/devices/device\:38/adr
> > > 0x000010025d070000
> > >
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > > v2: only use 64 bits when required to avoid compatibility issues
> > > (feedback from Vinod and Rafael)
> > >
> > >  drivers/acpi/device_sysfs.c | 6 ++++--
> > >  include/acpi/acpi_bus.h     | 2 +-
> > >  2 files changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > > index 8940054d6250..7dda0ee05cd1 100644
> > > --- a/drivers/acpi/device_sysfs.c
> > > +++ b/drivers/acpi/device_sysfs.c
> > > @@ -428,8 +428,10 @@ static ssize_t acpi_device_adr_show(struct device *dev,
> > >  {
> > >       struct acpi_device *acpi_dev = to_acpi_device(dev);
> > >
> > > -     return sprintf(buf, "0x%08x\n",
> > > -                    (unsigned int)(acpi_dev->pnp.bus_address));
> > > +     if (acpi_dev->pnp.bus_address > 0xFFFFFFFF)
> >
> > Would prefer to use U32_MAX instead of 0xFFFFFFFF
> 
> I would.
> 

I have made that change manually and applied the patch.

Thanks!



