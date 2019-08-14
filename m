Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803D48DDA2
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 21:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfHNTE4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 15:04:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47101 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHNTE4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 15:04:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so19185pgt.13;
        Wed, 14 Aug 2019 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vseqSnSbN0/CqanKomWBzaCIiF5jTd1dDC+ZOTFJoRU=;
        b=NIUd46jprVTVWb3fgGd29jnISTwMC3sQLMBzqbzBx5/C/GbBaRyCyZuIZG4f8Uch80
         XGuLIqfmPvQ6z82mGFrCsuSFrROVu1t9z3XyMwxTEMjTlKIV5FkXdjanZh7Dd0POtN+S
         BwA9JU2VOATUXFcUNJCTHbhzp1EW/NnqqUw7VjKYbTpSAYfCV4lvoYfL37oM4x5RCCMG
         dgbSOh5K2P9x6Kw3+5rYztkqapb02op3DEUgrh3ZanrRGjq8F7MZomVPda30Ty7lY3/N
         Cl3ePLIn0U+V3+NOqwAJ1FHRAHOL21IJvANqGqrKfbgscg2sJCL035S3EbBpdmHZQxNX
         8NFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vseqSnSbN0/CqanKomWBzaCIiF5jTd1dDC+ZOTFJoRU=;
        b=kBaaWnSuMBAkP4iBSxWC/2x419kfy356vwy7Js0ke8F5eC3+S0x5PIRzaQGqFhnN9v
         5SaDNOFgyc3cRTyc7PMsljMrH2bBBgs/7Y27vlEeH2lEET7F1dkxXw9CzfJ8ZzZ3xRwT
         kNUeuK29pz2l4z4GKwlCLPhxqtYElvU/hfDfM5qKOfM0Vnk1wP4MSUjYrE/Tpg2BnEbZ
         fauEEbV2cwMKGKQM6U61y+fK9+fzKleseYKFZZ9fKCKnlVxQ26qbMn71QvIuOIOAboOY
         sZWioBxHI2KOpAfvERcFSvC2gZ/SjXymdImc1lpe5adf/P1nbOzksVsgh03fTkXhXnq6
         TSyg==
X-Gm-Message-State: APjAAAVgOaG1JWFnANpcCLeWsfb1/R7oQ0J06VgmjO9nK/+FlQV52xsT
        neCmtB3FA4NVpIGTkbIoij0=
X-Google-Smtp-Source: APXvYqxPvTpGzpOkdo/g/K4RNLCTrEvQmHU4pCu/ZH1U09LHKXfy4gAnJ648mZN9j/inAzh8Er9WwQ==
X-Received: by 2002:a17:90a:cc13:: with SMTP id b19mr1108603pju.117.1565809495303;
        Wed, 14 Aug 2019 12:04:55 -0700 (PDT)
Received: from [172.30.88.90] (sjewanfw1-nat.mentorg.com. [139.181.7.34])
        by smtp.gmail.com with ESMTPSA id t15sm702679pfc.47.2019.08.14.12.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 12:04:54 -0700 (PDT)
Subject: Re: [PATCH 04/22] media: Move v4l2_fwnode_parse_link from v4l2 to
 driver base
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Enrico Weigelt <info@metux.net>
References: <20190805233505.21167-1-slongerbeam@gmail.com>
 <20190805233505.21167-5-slongerbeam@gmail.com>
 <CAHp75VcOh8bOf_s6t0ehwGtcYn64QFGj303SVvpHrztEOhTRgg@mail.gmail.com>
 <4750b347-b421-6569-600f-0ced8406460e@gmail.com>
 <20190814103054.GI13294@shell.armlinux.org.uk>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <e0a19469-af9d-d9de-499f-4ffbf04542b3@gmail.com>
Date:   Wed, 14 Aug 2019 12:04:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814103054.GI13294@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 8/14/19 3:30 AM, Russell King - ARM Linux admin wrote:
> On Tue, Aug 06, 2019 at 09:53:41AM -0700, Steve Longerbeam wrote:
>> The full patchset doesn't seem to be up yet, but see [1] for the cover
>> letter.
> Was the entire series copied to the mailing lists, or just selected
> patches?  I only saw 4, 9, 11 and 13-22 via lakml.

The whole series was posted to the linux-media ML, see [1]. At the time, 
none of the linux-media ML archives had the whole series.

> In the absence of the other patches, will this solve imx-media binding
> the internal subdevs of sensor devices to the CSI2 interface?

"internal subdevs of sensor devices" ?? That doesn't make any sense.

Sensors are external to the SoC, there are no "internal" sensor devices.

Not sure what you mean by "binding" either in this context, but external 
sensors can connect via fwnode endpoint, and later translated to media 
link, to the receiver CSI-2 sink.

Steve

[1] https://www.spinics.net/lists/linux-media/msg155160.html
