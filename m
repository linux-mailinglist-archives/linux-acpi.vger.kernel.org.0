Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19C545A9A6
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 18:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbhKWRKv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 12:10:51 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:49773 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234829AbhKWRKu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:10:50 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AN7k0DE013868;
        Tue, 23 Nov 2021 11:06:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : from : to : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=amQU7FZ/5g8QJDCHA86K0HOZeFaQBYccT1e3/wxVmZo=;
 b=d9ATGvqg538Vpg4nOsV8jFtKyuj/+QUi/oPnQKYM4FEtAnqyikfeJyXi7Fdx0JuuCjXn
 uSBbDQlfWDBhm77fbn6zkIkzB0sKN1WDaoBh3L0WQLeBVVkCS8j3GDoJ17gt3jMlY/7f
 7+RsPnwN+7OjmE87M1ZRA+0qiqA/pGj3UcWclyR//evlP554a1bPhS893LQnWRpdqidT
 V1YgKIwoG3pXFfE50PqzP0c84joCr6CEFCaoepst4dmyCVyepgXL5QX3axNHu9nqjFN2
 ZLiDCIeLXLCTj8TOFpd/yYsO38lxo8yvG/U9fzmcPzpESEmpZKmW93L/FSPyJMi4o2x2 6w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cg3v7a3ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 11:06:32 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 17:06:30 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 17:06:30 +0000
Received: from [198.61.65.11] (unknown [198.61.65.11])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5DFFB2A3;
        Tue, 23 Nov 2021 17:06:30 +0000 (UTC)
Message-ID: <ebb877d5-e348-e5fe-a5cb-9ef579a312f5@opensource.cirrus.com>
Date:   Tue, 23 Nov 2021 17:06:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   <tanureal@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
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
Subject: Re: [PATCH 10/11] hda: cs35l41: Add support for CS35L41 in HDA
 systems
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-11-tanureal@opensource.cirrus.com>
 <d8fe13f2-ac84-51b6-8eb5-095176a65c39@linux.intel.com>
In-Reply-To: <d8fe13f2-ac84-51b6-8eb5-095176a65c39@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jNP0KH8DmaKZaqeUPB5H2Q11BR3PWT0N
X-Proofpoint-ORIG-GUID: jNP0KH8DmaKZaqeUPB5H2Q11BR3PWT0N
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/23/21 4:59 PM, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
> 
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
> > +	{"CLSA0100", 0 },
> 
> I could be wrong but this doesn't look like a legit ACPI _HID?
> 
> Cirrus Logic can use 'CIR', "CLI", or 'CSC' PNP ID, or an PCI ID.
> 
> in the past you used
> 
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cs35l41_acpi_match[] = {
> +	{ "CSC3541", 0 }, /* Cirrus Logic PnP ID + part ID */
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_match);
> +#endif
> 
> 
> 

This ACPI _HID is already released, there is nothing I can do about it.
Future devices will use 'CSC' PnP ID.
