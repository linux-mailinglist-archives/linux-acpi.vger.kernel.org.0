Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E1945AAD8
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbhKWSKN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:10:13 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:43658 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239713AbhKWSKM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 13:10:12 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AN6osxY017977;
        Tue, 23 Nov 2021 12:05:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=6gSWvozBqN0ZbLTsSNcyVmRfNtwK0xzP5jEqM1vSJ+A=;
 b=lFtM5YPsXw00qcrRm8spyUnIqoT3ZfqObN7GLyqyT8nkinP/uDFXogiHGe+UgX+cEWev
 L7aOtNbuBnfy+z5vRNZIj/UKrpwwl8rQm74nHv73DuDYuM4IynfEt+M9QQ9Z2aU3uU8O
 sEgPXwl8La0TCcC0QQeKRT6coesCtzXetoG4pncdXjbO/m1f7VCpdB1LpAleHdU2wvFf
 lxQJFK/rUj9RBVJeKD3CrwE2uxbutIkoZd0ynNsuQL1LAYE4WRNHdybvbOzToH6aeuTx
 +499//1qAh1MPOAJJlA0a+3OCD0ahiszgxDEh0OkefaTo1ReFzzbLp+VREjxnP68xcG2 xA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cg3v7a5qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 12:05:56 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 18:05:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 18:05:54 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 33C80B06;
        Tue, 23 Nov 2021 18:05:54 +0000 (UTC)
Date:   Tue, 23 Nov 2021 18:05:54 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Sami Loone <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jack Yu <jack.yu@realtek.com>, "Arnd Bergmann" <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/11] ASoC: cs35l41: Convert tables to shared source code
Message-ID: <20211123180554.GG18506@ediswmail.ad.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-3-tanureal@opensource.cirrus.com>
 <YZ0qgjJnoljpmc9s@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YZ0qgjJnoljpmc9s@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: bsCgKBoG4TH8rZmypNK8_d58F7k35PpN
X-Proofpoint-ORIG-GUID: bsCgKBoG4TH8rZmypNK8_d58F7k35PpN
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 23, 2021 at 05:53:06PM +0000, Mark Brown wrote:
> On Tue, Nov 23, 2021 at 04:31:40PM +0000, Lucas Tanure wrote:
> > --- a/sound/soc/codecs/Makefile
> > +++ b/sound/soc/codecs/Makefile
> > @@ -54,8 +54,8 @@ snd-soc-cs35l33-objs := cs35l33.o
> >  snd-soc-cs35l34-objs := cs35l34.o
> >  snd-soc-cs35l35-objs := cs35l35.o
> >  snd-soc-cs35l36-objs := cs35l36.o
> > -snd-soc-cs35l41-spi-objs := cs35l41-spi.o cs35l41.o cs35l41-tables.o
> > -snd-soc-cs35l41-i2c-objs := cs35l41-i2c.o cs35l41.o cs35l41-tables.o
> > +snd-soc-cs35l41-spi-objs := cs35l41-spi.o cs35l41.o cs35l41-lib.o
> > +snd-soc-cs35l41-i2c-objs := cs35l41-i2c.o cs35l41.o cs35l41-lib.o
> >  snd-soc-cs42l42-objs := cs42l42.o
> >  snd-soc-cs42l51-objs := cs42l51.o
> >  snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o
> 
> As was already called out on the HDA part of this patch I was expecting
> this to be more like how we handle sharing the PXA2xx driver code
> between the ASoC and AC'97 implementations - making it a library rather
> than linking the object files directly into both drivers.  I'm not sure
> that the current approach would DTRT if one or both of the drivers is
> built in.

Yeah looking closer the Prince driver itself is kinda weird here
since it is building separate modules for SPI and I2C but
including cs25l41.o into both, rather than the more normal 3
modules approach.

I will have a look at doing a patch to fix that up, separately
from Lucas's series here.

Thanks,
Charles
