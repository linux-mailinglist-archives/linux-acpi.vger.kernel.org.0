Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67855286384
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Oct 2020 18:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgJGQST (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 12:18:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:60617 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbgJGQSN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Oct 2020 12:18:13 -0400
IronPort-SDR: IXoxLzbKuwPKyBX01ZrQqeuxDJDVDXRGNOQ9tm7DbEsRtCsHbmrTKCr8DSIYHm58b3PYdpBMma
 daz58R+3LXjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="144390652"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="144390652"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:18:09 -0700
IronPort-SDR: CPbeOcxXqJOW+DucWkloH/7RCdkTYebRQnWrHY/dw+r2kJTvfvRDc5hZLISSfFQMKzVQyujhen
 XA21YPwo/MWA==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="528032448"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.145.6]) ([10.249.145.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:18:05 -0700
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Berman <stephen.berman@gmx.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
References: <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
 <20200714141135.47adndrsdgpiqfy4@linutronix.de> <87blkbx1gt.fsf@gmx.net>
 <87imdp5r80.fsf@rub.de> <20200811132955.wbt55ns7bu5mxouq@linutronix.de>
 <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
 <20200811152551.dmfw46urecbmeklr@linutronix.de> <87ft8tayic.fsf@gmx.net>
 <20200811184902.2fm4eyprmpkfon2j@linutronix.de>
 <20201006214927.4nsqtfji4fdv3oed@linutronix.de>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <3fc9074b-c153-8446-0289-1e4dfab395eb@intel.com>
Date:   Wed, 7 Oct 2020 18:18:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201006214927.4nsqtfji4fdv3oed@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/6/2020 11:49 PM, Sebastian Andrzej Siewior wrote:
> On 2020-08-11 20:49:05 [+0200], To Stephen Berman wrote:
>> On 2020-08-11 19:22:19 [+0200], Stephen Berman wrote:
>>> Attached.
>> ssdt6.dsl:
>> |  ThermalZone (TZ10)
>> |  {
>> …
>> |      Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
>> |      {
>> |          Return (0x0A)
>> |      }
>> |
>> |      Method (_TZP, 0, Serialized)  // _TZP: Thermal Zone Polling
>> |      {
>> |          Return (0x0A)
>> |      }
>> |
>> |      Method (_TMP, 0, Serialized)  // _TMP: Temperature
>> |      {
>> |          \GSA1.ZRC3 ()
>> |          Sleep (0x03E8)
>> |          Notify (\_TZ.TZ10, 0x81) // Thermal Trip Point Change
>> |          Return (0x0B54)
>> |      }
>>
>> So if I read this correctly then TZ10 should be polled every second
>> (check) and the temperature function contains a `sleep(1 second)' (which
>> explains the mysteries delay) followed by the Notify() (which schedules
>> the worker).
>>
>>> Done as Bug 208877.
> Rafael, do you have any suggestions?
>   

I've lost track of this sorry.

I have ideas, let me get back to this next week.

Cheers!


