Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1EA14675
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2019 10:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEFIge (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 May 2019 04:36:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39232 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfEFIge (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 May 2019 04:36:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id x16so3046701oic.6;
        Mon, 06 May 2019 01:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RI5tWDg9So1VuC7W9/kUG69QrGBsy3wNS2QspBOJr3w=;
        b=XbBzkcntIQ8KvmGHRNmMqBg7DNzXmU/7Xy2HR1LvaBM56eKmeIhF68IME/HdMknXnb
         eAfkHKq7rzRhaH7VbsGV+6VyKfdV228y27Y+IlxW2kVGJ2bRevVUza67cn4P6UhqsWIC
         xoUu00HdWF1+5+O4Sa1/qMgu+Ux+tRS1MFC0kdsj4zgV1q/fCE/5nT4vVFvJvnm+9LQ4
         z3rHUH7qJX/+qAw4b7B4kKyVG6yzu6XIz7hWsmXPJVFmrkdfhhB5q6SxvsSlkXjL9Czg
         hIYzZK99AOTq7Hj4uLc1kwN84KjtObZbV9shZibaJeVo189qzXefOxrTAKG3B5H0/WQo
         xvaw==
X-Gm-Message-State: APjAAAV+WIOtpiX1b9iW6NnyVMk6AeFVIKy3MbYRWpqYH7GLPpZ3TymM
        wmiNU8R4MrK2OHJCxTa8y7VVpykBax5b59aAO6Q=
X-Google-Smtp-Source: APXvYqwAJUUjNvKVg6KZ3xRKyBM0B1Mi/aBfBkvmIKfrou4l4YatPD9RnwfhnPr74P6+x5gOB/MDST+7GGsfyLwLVXk=
X-Received: by 2002:aca:f01:: with SMTP id 1mr387656oip.68.1557131793348; Mon,
 06 May 2019 01:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190501125322.23791-1-pierre-louis.bossart@linux.intel.com> <20190502045817.GZ3845@vkoul-mobl.Dlink>
In-Reply-To: <20190502045817.GZ3845@vkoul-mobl.Dlink>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 May 2019 10:36:22 +0200
Message-ID: <CAJZ5v0i+M8y3ddr+Z5o5af8OatMXq3xqCF5CUg5PjnANrTOSHw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / device_sysfs: change _ADR representation to 64 bits
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        jank@cadence.com, Joe Perches <joe@perches.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 2, 2019 at 6:58 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 01-05-19, 07:53, Pierre-Louis Bossart wrote:
> > Standards such as the MIPI DisCo for SoundWire 1.0 specification
> > assume the _ADR field is 64 bits.
> >
> > _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
> > released in 2002. The low levels already use _ADR as 64 bits, e.g. in
> > struct acpi_device_info.
> >
> > This patch bumps the representation used for sysfs to 64 bits. To
> > avoid any compatibility/ABI issues, the printf format is only extended
> > to 16 characters when the actual _ADR value exceeds the 32 bit
> > maximum.
> >
> > Example with a SoundWire device, the results show the complete
> > vendorID and linkID which were omitted before:
> >
> > Before:
> > $ more /sys/bus/acpi/devices/device\:38/adr
> > 0x5d070000
> > After:
> > $ more /sys/bus/acpi/devices/device\:38/adr
> > 0x000010025d070000
> >
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> > v2: only use 64 bits when required to avoid compatibility issues
> > (feedback from Vinod and Rafael)
> >
> >  drivers/acpi/device_sysfs.c | 6 ++++--
> >  include/acpi/acpi_bus.h     | 2 +-
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index 8940054d6250..7dda0ee05cd1 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -428,8 +428,10 @@ static ssize_t acpi_device_adr_show(struct device *dev,
> >  {
> >       struct acpi_device *acpi_dev = to_acpi_device(dev);
> >
> > -     return sprintf(buf, "0x%08x\n",
> > -                    (unsigned int)(acpi_dev->pnp.bus_address));
> > +     if (acpi_dev->pnp.bus_address > 0xFFFFFFFF)
>
> Would prefer to use U32_MAX instead of 0xFFFFFFFF

I would.
