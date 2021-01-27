Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124E130620E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 18:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbhA0Rbk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 12:31:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:25776 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234279AbhA0RaP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Jan 2021 12:30:15 -0500
IronPort-SDR: GINBAH5giFuh/dER7syXuX3j2t2mq/14E1uF8NsF/yF25/y9yAn1tilKe9vrZIkni7QN76tJYz
 Hm9duBUT7TXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="180182874"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="180182874"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 09:28:27 -0800
IronPort-SDR: hqDu3WS98TI7yoUuuPLr0IGqC4vI5OKQ7KDoEZ5zKepMYEJUbi+SCSgN8H+T+Y0GJ4Se7+wqZW
 RYnh0wazBLIA==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="388402900"
Received: from susiezhx-mobl.amr.corp.intel.com (HELO [10.213.180.238]) ([10.213.180.238])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 09:28:27 -0800
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux
 5.10
To:     =?UTF-8?Q?Marcin_=c5=9alusarz?= <marcin.slusarz@gmail.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
 <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com>
Date:   Wed, 27 Jan 2021 11:28:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org




> Weird, I can't reproduce this problem with my self-compiled kernel :/
> I don't even see soundwire modules loaded in. Manually loading them of course
> doesn't do much.
> 
> Previously I could boot into the "faulty" kernel by using "recovery mode", but
> I can't do that anymore - it crashes too.
> 
> Maybe there's some kind of race and this bug depends on some specific
> ordering of events?

missing Kconfig?
You need CONFIG_SOUNDWIRE and CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE 
selected to enter this sdw_intel_acpi_scan() routine.

