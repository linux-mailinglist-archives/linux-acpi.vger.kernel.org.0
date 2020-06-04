Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B221EE448
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 14:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgFDMPs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jun 2020 08:15:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24689 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727944AbgFDMPs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2020 08:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591272946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfxVNbryX4wqobrXfDFSJ/UxsktGybKS+BC33DeIRsY=;
        b=GL/yKe9WJoJzwXrLOBcik3PbdpQxesya+sqQ+ZtIOIRNtIedJq4ldMlgKb3vA0f6G7EJaG
        cqFo3HBERydjKslYZESPs2pDvzQdsrqX6UtXTQ8dXFyw1kujSmC7uHT+Kjt8VmHp5a9PxN
        lljCf/piIw3jN65PIUbey+Y2ldTdJ1U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-VcNbNmFONb2KlGn0cfc3TA-1; Thu, 04 Jun 2020 08:15:44 -0400
X-MC-Unique: VcNbNmFONb2KlGn0cfc3TA-1
Received: by mail-ed1-f71.google.com with SMTP id y9so2555211edr.22
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jun 2020 05:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DfxVNbryX4wqobrXfDFSJ/UxsktGybKS+BC33DeIRsY=;
        b=Lyg30eQn9Z1kXg0CLYKCwM050BJZsnHUqnc0/gCJRdUTf4zPkDMzDLKCI8sbW7T7Rk
         PBUWxVrzbRfi5Tb1DBXLsExglErgx8CEbiv2EGmtMUCBV660uYSF8I9pDgvE7+4G4hnP
         4upwl8/pETWiPxv669bb/eI+nW7djq3zw+zdSFTbGOrm/U2BibeLyHoWVaLD//PQ5CzJ
         UZzTxpiHCtF25AKpHY84WhIQ6B62Vhu1GHvOf55sU9fQz6Kn/bXGNVzKF/VtabqgQvsD
         ZJkP/1nVpXJ35DJFse8OtPHl5+aN3IapbDW1NwevfaTmsrlS/n3BKTFXsGw55CFWUwcP
         OR0w==
X-Gm-Message-State: AOAM530NI/CH3dRftK8DIjQ/Ok02lQQX/E0lHnko0uNMByT7k37Oud7V
        vYGF5Z6zanvl39Vs8opnIku4vHjdhu4WH0FfewJOgXY6TYItYlx6v9ipTAxt4R4RqyNL9lCbM47
        GaxG3PxdYkh2kSvcfNk5YQw==
X-Received: by 2002:a17:906:7746:: with SMTP id o6mr3733582ejn.75.1591272942931;
        Thu, 04 Jun 2020 05:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEqlrcNhE1aRfiTNVpQPgjJ1sVKq72/Sj3BF97YzIy9sLyRcWiLaJkfTPVxXUmcD5X9d6IVw==
X-Received: by 2002:a17:906:7746:: with SMTP id o6mr3733561ejn.75.1591272942651;
        Thu, 04 Jun 2020 05:15:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i21sm2258997edr.68.2020.06.04.05.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 05:15:41 -0700 (PDT)
Subject: Re: [PATCH] ACPI / PM: Do not infer power-state if there are no D0
 power-resources
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        youling257@gmail.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20200603194659.185757-1-hdegoede@redhat.com>
 <CAJZ5v0g7rhiWs0ZeGGS5OoSMH7DiVT1D-EUgX5HFXYkcvXcm2Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d084b424-a340-a24a-d681-c92d80d8421d@redhat.com>
Date:   Thu, 4 Jun 2020 14:15:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g7rhiWs0ZeGGS5OoSMH7DiVT1D-EUgX5HFXYkcvXcm2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/4/20 1:22 PM, Rafael J. Wysocki wrote:
> On Wed, Jun 3, 2020 at 9:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Some devices do not have a power-resource-list for D0, but do have a
>> power-resource-lists for e.g. D3 (_PR3).
> 
> This looks like a bug in the firmware.

The DSDT for these devices definitely has somw warts, see
below.

TBH I'm not sure of the whole inferring state from
power-resource-lists is the best idea. I think just going
for UNKNOWN as initial state would be better. The issue is
that getting the initial state wrong will lead to either
skipping _PS3 (as is happening here) or _PS0 on the first
transition to the matching state which can have undesirable
side-effects, where as just running _PS0/PS3 for a second
time _usually_ should be fine.

Anyways I know we have the inferring code for a long time,
and I guess it mostly does its job fine...

> It is hard to imagine a design in which some power resources only need
> to be "on" in the D3hot power state of a device and not in D0 (which
> is implied by the lack of _PR0 and the presence of _PR3).

Right, except that the listed resource is a dummy power
resource, here is the AML for the USB power-resource which
is the only resource in the _PR3 list:

             PowerResource (USBC, 0x00, 0x0000)
             {
                 Method (_STA, 0, NotSerialized)  // _STA: Status
                 {
                     Return (0x0F)
                 }

                 Method (_ON, 0, NotSerialized)  // _ON_: Power On
                 {
                 }

                 Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                 {
                 }
             }

So not having this in _PR0 does not matter because the
whole thing is a dummy implementation.

If you want the whole DSDT, the DSDT of one of the affected devices
is attached here: https://bugzilla.kernel.org/show_bug.cgi?id=69011

Note it seems that pretty much any Bay Trail tablet version based
device suffers from this.

> So when the device goes from D0 to D3hot, we are expected to turn some
> power resources "on"?  What sense does this make?
> 
> I'm guessing that this only works at all, because we only use D0 and
> D3cold with the affected devices and _PS0 simply turns the power
> resource(s) in question on.
> 
>> On these devices the "if (device->power.flags.power_resources)" check
>> in acpi_device_get_power() succeeds because of the presence of the _PR3
>> resources, so the code used to try and infer the power-state.
>>
>> In this case since there is no power-resource-list for D0, we can never
>> infer that the device is in D0 even though it very well might be in D0.
>> This results in the code inferring that the device is in D3HOT and on
>> the first suspend acpi_device_set_power() skips calling _PS3 for the
>> device because it thinks the device is already in D3.
>>
>> An example of a family of devices which are affected by this are
>> Bay Trail based devices. The ACPI device for the XHCI controller on
>> these devices does not have a _PR0 method, but it does have a _PR3
>> method. The problem described above causes the XHCI controller's _PS3
>> method not getting called on the first suspend of the device, which
>> causes these devices to not reach the S0i3 power-state during suspend.
>>
>> Since we cannot infer if the device is in D0 or not when there is no
>> power-resource-list for D0, the best thing to do is to change
>> acpi_power_get_inferred_state() to return ACPI_STATE_UNKNOWN in this
>> case.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205057
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/acpi/power.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
>> index fe1e7bc91a5e..db54393a077b 100644
>> --- a/drivers/acpi/power.c
>> +++ b/drivers/acpi/power.c
>> @@ -807,6 +807,17 @@ int acpi_power_get_inferred_state(struct acpi_device *device, int *state)
>>          if (!device || !state)
>>                  return -EINVAL;
>>
>> +       /*
>> +        * Some devices do not have a power-resource-list for D0, but do
>> +        * have a power-resource-lists for e.g. D3 so we do end up here.
>> +        * In this case we can never infer that the device is in D0 even
>> +        * though it might very well be in D0, so return ACPI_STATE_UNKNOWN.
>> +        */
>> +       if (list_empty(&device->power.states[ACPI_STATE_D0].resources)) {
>> +               *state = ACPI_STATE_UNKNOWN;
>> +               return 0;
>> +       }
> 
> Well, this makes things work on the particular affected platform, but
> that seems to be just by accident, because _PS0 does something special
> on it.
> 
> IMO this needs to be addressed elsewhere and in a different way.
> 
> Namely, it looks like if _PR0 is not present (or its return package is
> empty), but _PR3 is present, we should use the _PR3 list of power
> resources for D0 as well as for D3hot.

That should work too.

> Let me cut a patch for that.

Ok, let me know when you have a patch ready then I will test it.

Regards,

Hans

