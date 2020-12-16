Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904FA2DC71C
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Dec 2020 20:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbgLPTbK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Dec 2020 14:31:10 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.5]:49191 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388629AbgLPTbK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Dec 2020 14:31:10 -0500
Received: from [100.112.1.203] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-east-1.aws.symcld.net id F5/D8-54546-C6F5ADF5; Wed, 16 Dec 2020 19:26:36 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRWlGSWpSXmKPExsWSLveKXTcn/la
  8wYRH4hb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o0VTZxObxeeOySwWq/e8YLZY+2Ue
  m8XcL1OZLc6cvsTqwOMxaeYMZo+ds+6ye/zatobFY/MKLY9NqzrZPOadDPToadvE5PF+31U2j
  y1X21k8Pm+SC+CKYs3MS8qvSGDNeHpHs+CYVEX/16usDYzTRbsYuTiEBP4zSrze840JwnnBKD
  H37STmLkZODmGBUolVHR2sILaIgLbEkkVXmUGKmAV+M0sc/TQbqmMOo8TZ61fYQKrYgKq2bPk
  FZvMK2ErMWLsRrJtFQFWiu38aO4gtKhAusX7JSkaIGkGJkzOfsIDYnAKBEj8+LAaKcwBt0JRY
  v0sfJMwsIC5x68l8JghbXmL72zlgx0kIKEj8/XWVBcJOkFj28g7zBEbBWUimzkKYNAvJpFlIJ
  i1gZFnFaJZUlJmeUZKbmJmja2hgoGtoaKRrpGtobKqXWKWbpFdarJuaWFyia6iXWF6sV1yZm5
  yTopeXWrKJERipKQVM7TsYW9980DvEKMnBpCTKW+R9K16ILyk/pTIjsTgjvqg0J7X4EKMMB4e
  SBK9KHFBOsCg1PbUiLTMHmDRg0hIcPEoivMuigdK8xQWJucWZ6RCpU4yKUuK8MiB9AiCJjNI8
  uDZYorrEKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZj3fCzQFJ7MvBK46a+AFjMBLV695zrI4
  pJEhJRUA1P/+UXFm+rOmf5V3bCwaXK59acV907Om+B49sjkR4ceT1UIKfztna397pLLtr/HLn
  4riPkoa7I2M/aXmt/EHhXvi23WTPUuJ5QrbWcc+rLGsEKkwolBZ9LNh9O4FwvMmnhZU3nTFJd
  i1/uzjqwKf8P4yOxdGh9T4aSDAmm2VhNXF6YciZM9G9q9gD3geoQj68LqT5cMmPdtc0z06Exn
  S46Zt1q6t1lc/uVpz4NTfidoqJ5x/rbn4+aUpbLir3I2PVinuPjUep+EDsNJSddmZhlGGDDNW
  sDSXc5e+O9sv2rvnHDzaNvqZRtL1PYt9A88uNxI+a21fNEnD+Nb9y72qKfMXSa05sz92rgMe9
  21S8uVWIozEg21mIuKEwFfEkbAzwMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-6.tower-386.messagelabs.com!1608146794!15985!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29415 invoked from network); 16 Dec 2020 19:26:36 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-6.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Dec 2020 19:26:36 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 6C1C9BA671075723650B;
        Thu, 17 Dec 2020 03:26:31 +0800 (CST)
Received: from localhost.localdomain (10.38.108.33) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 16 Dec
 2020 11:26:28 -0800
Subject: Re: [External] Re: [PATCH v6 1/3] Documentation: Add documentation
 for new platform_profile sysfs attribute
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        "Mario Limonciello" <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>, <njoshi1@lenovo.com>
References: <markpearson@lenovo.com>
 <20201211020630.305905-1-markpearson@lenovo.com>
 <CAJZ5v0gZ72pPUjvWrMTVjgh3NWc2OCDWum+xV69dF05znuBL8A@mail.gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <f1f901d0-b952-062d-916c-f2fad31b5566@lenovo.com>
Date:   Wed, 16 Dec 2020 14:26:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gZ72pPUjvWrMTVjgh3NWc2OCDWum+xV69dF05znuBL8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.108.33]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 16/12/2020 13:34, Rafael J. Wysocki wrote:
> On Fri, Dec 11, 2020 at 3:15 AM Mark Pearson <markpearson@lenovo.com> wrote:
>>
<snip>
>>
>> diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
>> new file mode 100644
>> index 000000000000..5ac14268585f
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-platform_profile
>> @@ -0,0 +1,24 @@
>> +What:          /sys/firmware/acpi/platform_profile_choices
>> +Date:          October 2020
>> +Contact:       Hans de Goede <hdegoede@redhat.com>
>> +Description:   This file contains a space-separated list of profiles supported for this device.
>> +
>> +               Drivers must use the following standard profile-names:
>> +
>> +               ============    ============================================
>> +               low-power       Low power consumption
>> +               cool            Cooler operation
>> +               quiet           Quieter operation
>> +               balanced        Balance between low power consumption and performance
>> +               performance     High performance operation
>> +               ============    ============================================
>> +
>> +               Userspace may expect drivers to offer more than one of these
>> +               standard profile names.
>> +
>> +What:          /sys/firmware/acpi/platform_profile
>> +Date:          October 2020
>> +Contact:       Hans de Goede <hdegoede@redhat.com>
>> +Description:   Reading this file gives the current selected profile for this
>> +               device. Writing this file with one of the strings from
>> +               available_profiles changes the profile to the new value.
> 
> IIUC s/available_profiles/platform_profile_choices/
Yep - I missed this one. Thank you, I'll update
> 
>> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
>> index acd2cc2a538d..d29b020e5622 100644
>> --- a/Documentation/userspace-api/index.rst
>> +++ b/Documentation/userspace-api/index.rst
>> @@ -24,6 +24,7 @@ place where this information is gathered.
>>     ioctl/index
>>     iommu
>>     media/index
>> +   sysfs-platform_profile
>>
>>  .. only::  subproject and html
>>
>> diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
>> new file mode 100644
>> index 000000000000..56639d218003
>> --- /dev/null
>> +++ b/Documentation/userspace-api/sysfs-platform_profile.rst
>> @@ -0,0 +1,43 @@
>> +=====================================================================
>> +Platform Profile Selection (e.g. /sys/firmware/acpi/platform_profile)
>> +=====================================================================
>> +
>> +On modern systems the platform performance, temperature, fan and other
>> +hardware related characteristics are often dynamically configurable. The
>> +profile is often automatically adjusted to the load by some
> 
> After reading this one more time it looks to me like referring to the
> profile here is premature, it needs to be defined first.
> 
> Maybe say "The platform configuration is often ..."
> 
> Iit is also unclear what "the load" means here, so I would say
> something like "adjusted to the current conditions" to avoid using
> that term.
I'm good with both those suggestions. Thank you. I'll update

Mark
