Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7757E45A9E5
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 18:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhKWRZN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 12:25:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:43321 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhKWRZM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:25:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="215778929"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="215778929"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 09:16:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="497349857"
Received: from markmu6x-mobl.amr.corp.intel.com (HELO [10.213.168.54]) ([10.213.168.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 09:16:39 -0800
Subject: Re: [PATCH 10/11] hda: cs35l41: Add support for CS35L41 in HDA
 systems
To:     tanureal@opensource.cirrus.com,
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
        Jack Yu <jack.yu@realtek.com>, Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org,
        patches@opensource.cirrus.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-11-tanureal@opensource.cirrus.com>
 <d8fe13f2-ac84-51b6-8eb5-095176a65c39@linux.intel.com>
 <ebb877d5-e348-e5fe-a5cb-9ef579a312f5@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a2ef9f32-0a92-d8cc-8e4a-7d4d4abcc7e9@linux.intel.com>
Date:   Tue, 23 Nov 2021 11:16:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ebb877d5-e348-e5fe-a5cb-9ef579a312f5@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 11/23/21 11:06 AM, tanureal@opensource.cirrus.com wrote:
> On 11/23/21 4:59 PM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> > +#ifdef CONFIG_ACPI
>> > +static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
>> > +    {"CLSA0100", 0 },
>>
>> I could be wrong but this doesn't look like a legit ACPI _HID?
>>
>> Cirrus Logic can use 'CIR', "CLI", or 'CSC' PNP ID, or an PCI ID.
>>
>> in the past you used
>>
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id cs35l41_acpi_match[] = {
>> +    { "CSC3541", 0 }, /* Cirrus Logic PnP ID + part ID */
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_match);
>> +#endif
>>
>>
>>
> 
> This ACPI _HID is already released, there is nothing I can do about it.
> Future devices will use 'CSC' PnP ID.

ok, add a comment then that you're adding support for an
already-released value that's not compliant.
