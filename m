Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285BA45AAC1
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbhKWSHb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:07:31 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39934 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229674AbhKWSHb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 13:07:31 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AN7jAQ0031806;
        Tue, 23 Nov 2021 12:02:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Jx26KMJht9GZbSLMdhodk+RkXN+RoA34x0E33gX19jI=;
 b=fYhyJHYCK+IhoR9CnzIHTqLvCAi8bbkafekt9sFaGkiO/k4iOIAp0p8Js9WuDef+wEGB
 ACy8eUGbKvRd7opzFtaC/7Y/gwk01lniSVfRHpQqhIRlebZFHHBGkA3RFLU1D194w2Yt
 dh97KVFOonclatmBG/7osKfHmLaq9Cwbcr/BYlc2DRp41ZDCGVcpl0CTj6t3mnya5nbU
 feqbmaOdaZdz/ERG40qw6/psuds9GeUmy02sQ3qksU3Rqn4tRYmX/jkiYF6bcULd3wpw
 g0Hkm4/oAynx/D5TC7TINfCVGxXEX8bIXwUKtovcaMxAYiZglI2ySDSYhVNEQVQORenZ mw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cg5ms25bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 12:02:56 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 18:02:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 18:02:53 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A4B49B06;
        Tue, 23 Nov 2021 18:02:53 +0000 (UTC)
Date:   Tue, 23 Nov 2021 18:02:53 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
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
Subject: Re: [PATCH 01/11] ASoC: cs35l41: Set the max SPI speed for the whole
 device
Message-ID: <20211123180253.GF18506@ediswmail.ad.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-2-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211123163149.1530535-2-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: QxsPUmA4dig9wQgfRRekjSQno3if7DLV
X-Proofpoint-ORIG-GUID: QxsPUmA4dig9wQgfRRekjSQno3if7DLV
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 23, 2021 at 04:31:39PM +0000, Lucas Tanure wrote:
> Higher speeds are only supported when PLL is enabled, but
> the current driver doesn't enable PLL outside of stream
> use cases, so better to set the lowest SPI speed accepted
> by the entire device.
> 
> Move the current frequency set to the spi sub-driver so
> the whole device can benefit from that speed.
> 
> spi-max-frequency property could be used, but ACPI systems don't
> support it, so by setting it in the spi sub-driver probe
> both Device Trees and ACPI systems are supported.
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
