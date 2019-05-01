Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5044D105F8
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2019 09:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfEAH7h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 May 2019 03:59:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39564 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfEAH7h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 May 2019 03:59:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id n187so13331388oih.6;
        Wed, 01 May 2019 00:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxgDmRsn1/IVmGuf5U9azTe0s7v3EA8DrDT/1fTHG9Q=;
        b=PUj7w7vy+5nCWP5ihcrknRU1Akta81PiptNrPSNTlAKjEYcyOgLzzUX1i0TbcL1BMw
         CXT+BI7QjJlxZgZz7eNF/mfKLil/g4EAXvUxFUZdGR41ozghtAZU7cWJR/xfrKwp6EeO
         JotsYfril4ff8GgGGXEvqdZQZjxxNQMCR1VjbiMWtSsMjwQbof7xxJXbOYcME3lfolMl
         2fpPx30QUwuK7Zytuw91mMj4dV4IcfPvz//cXez+JQexLyHn4uOPR5K5/6DWByTkXw8/
         6I5pCjQROJR7ZBLvXSNasZum9K5nLu9J1FrCSA7wp5cdDnw/3jS73tef72/MOywvGQme
         7zgA==
X-Gm-Message-State: APjAAAWFY9Ic/74mtbnmlDhRus1PKbVD+uGU69QQIrpR2Hpk1yoohtXj
        0ORSr+x7GbvYEArdbxZSYYGxsmjCTIWqAv5f04U=
X-Google-Smtp-Source: APXvYqwRucsn2ORnmZzJM80aybzIMoVJlKVHwZ0llOPopwmEQAxBSBA2QxPX+O9LwH4uQ12+7ADgZSOR7ZOcJJsf2+o=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr6169480oif.110.1556697576304;
 Wed, 01 May 2019 00:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190415151857.25531-1-pierre-louis.bossart@linux.intel.com>
 <20190416032923.GQ28103@vkoul-mobl> <CAJZ5v0jOkQ7aWn6B_yVTYd7y+78mpGSzBoGuWe3uCdzDRNE94Q@mail.gmail.com>
 <eda0ed4e-fc36-a53a-225f-e7d54bb73413@linux.intel.com>
In-Reply-To: <eda0ed4e-fc36-a53a-225f-e7d54bb73413@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 May 2019 09:59:25 +0200
Message-ID: <CAJZ5v0iwm5tLRy2mLX6_uTk2wh+1Y4VaEcqDx5Z1WDLZHMnpEg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ACPI / device_sysfs: change _ADR
 representation to 64 bits
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        jank@cadence.com, Joe Perches <joe@perches.com>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 30, 2019 at 8:23 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 4/16/19 3:09 AM, Rafael J. Wysocki wrote:
> > On Tue, Apr 16, 2019 at 5:29 AM Vinod Koul <vkoul@kernel.org> wrote:
> >>
> >> On 15-04-19, 10:18, Pierre-Louis Bossart wrote:
> >>> Standards such as the MIPI DisCo for SoundWire 1.0 specification
> >>> assume the _ADR field is 64 bits.
> >>>
> >>> _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
> >>> released in 2002. The low levels already use _ADR as 64 bits, e.g. in
> >>> struct acpi_device_info.
> >>>
> >>> This patch bumps the representation used for sysfs to 64 bits.
> >>>
> >>> Example with a SoundWire device, the results show the complete
> >>> vendorID and linkID which were omitted before:
> >>>
> >>> Before:
> >>> $ more /sys/bus/acpi/devices/device\:38/adr
> >>> 0x5d070000
> >>> After:
> >>> $ more /sys/bus/acpi/devices/device\:38/adr
> >>> 0x000010025d070000
> >>
> >> This looks fine but the sysfs file is an ABI. Not sure if we can modify
> >> the value returned this way.. Though it should not cause userspace
> >> reading 32bits to break...
> >
> > Well, IIRC using "08" instead of "016" in the format field would
> > preserve the existing behavior for 32-bit values, wouldn't it?
>
> yes, but it makes the 64-bit address not aligned depending on the number
> of leading zeroes, see below. I get a migraine just looking at the results.

Well, scripts reading them won't get that, but fair enough.

> Maybe add a test to use 08 for values that are below 0xFFFFFFFF and 16
> for addresses who really need the full range, typically because of an
> encoding?

That would be fine by me.
