Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3948E2FBBD4
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jan 2021 17:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391411AbhASQAH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jan 2021 11:00:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:45397 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391250AbhASP6a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Jan 2021 10:58:30 -0500
IronPort-SDR: kETkxxOfwU6NumB5wTzdTxyV8RvVv69fVoNZOTIWTSg/9WVOmJQRpD2Z9QR08UGAb8dCdY6amJ
 9hTerus4fFbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="179034593"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="179034593"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 07:56:28 -0800
IronPort-SDR: s7GAsS7n8NRpZRDihC3Atq1gRwOLrFrqGf0XS4gOY2MoXPF743yfLct4y1xllTYIQjDG7Ahyib
 MH0fzXLH83eA==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="500975803"
Received: from kxu2-mobl.amr.corp.intel.com (HELO [10.212.225.199]) ([10.212.225.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 07:56:27 -0800
Subject: Re: [PATCH] ACPI: scan: Make acpi_bus_get_device() clear the adev ptr
 on error
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210115215752.389656-1-hdegoede@redhat.com>
 <CAJZ5v0gk0ninRntm508SAgzSrRe5gjZ+-e5ac1h-Cx2reVOSfg@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e825c859-e885-c02c-43b4-3e6f2277e120@linux.intel.com>
Date:   Tue, 19 Jan 2021 09:41:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gk0ninRntm508SAgzSrRe5gjZ+-e5ac1h-Cx2reVOSfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 1/18/21 7:58 AM, Rafael J. Wysocki wrote:
> On Fri, Jan 15, 2021 at 10:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Set the acpi_device pointer which acpi_bus_get_device()
>> returns-by-reference to NULL on error.
>>
>> We've recently had 2 cases where callers of acpi_bus_get_device()
>> did not properly error check the return value, using the
>> returned-by-reference acpi_device pointer blindly, set it to NULL
>> so that this will lead to an immediate oops, rather then following
>> a pointer to who knows what.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> This should fix the crash reported by Pierre-Louis, so let me apply it
> instead of the two debug changes posted by me
> (https://lore.kernel.org/linux-acpi/98e6ed8e-884e-adb4-a146-a66daefa94a7@redhat.com/T/#md5add2fe554a30e3a929d87a66b435f4cc8bf628).
> 
> Pierre-Louis, can you please double check that the issue goes away
> with this patch applied?

yep, tested twice

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Hans and Rafael for your work, much appreciated.

>> ---
>>   drivers/acpi/scan.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index c575c9b67f76..c53e88deee1d 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -585,6 +585,8 @@ static int acpi_get_device_data(acpi_handle handle, struct acpi_device **device,
>>          if (!device)
>>                  return -EINVAL;
>>
>> +       *device = NULL;
>> +
>>          status = acpi_get_data_full(handle, acpi_scan_drop_device,
>>                                      (void **)device, callback);
>>          if (ACPI_FAILURE(status) || !*device) {
>> --
>> 2.28.0
>>
