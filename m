Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0A2AD8FD
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 15:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgKJOlG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 09:41:06 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.3]:54928 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730059AbgKJOlG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 09:41:06 -0500
Received: from [100.112.131.148] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.us-west-2.aws.symcld.net id E4/B2-32453-F76AAAF5; Tue, 10 Nov 2020 14:41:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRWlGSWpSXmKPExsWSLveKXbd+2ap
  4gz1TFCz2X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWwx98tU
  Zoszpy+xOnB7TJo5g9lj56y77B6/tq1h8di8Qstj06pONo95JwM93u+7yuax5Wo7i8fnTXIBn
  FGsmXlJ+RUJrBnz1v5lLnjHV3GsbTtzA+Nf7i5GLg4hgf+MEuc+zWSBcJ4zSlzYuIS5i5GTQ1
  ggVqKrbQsbiC0ioC2xZNFVZpAiZoElzBJ3l+1ghOg4xSjReP87I0gVG1DVli2/wDp4BWwlHq7
  dBTaJRUBVonneCRYQW1QgXKLjxg4miBpBiZMzn4DFOQUCJSbsXAE2h1nAQmLm/PNQtrjErSfz
  mSBseYntb+eAzZQAsl+/a4eyEySWvbzDPIFRcBaSsbOQjJqFZNQsJKMWMLKsYrRIKspMzyjJT
  czM0TU0MNA1NDTSNTSy0DW0MNdLrNJN1Cst1i1PLS7RNdJLLC/WK67MTc5J0ctLLdnECIzPlI
  KG3TsYX77+oHeIUZKDSUmU98/cVfFCfEn5KZUZicUZ8UWlOanFhxhlODiUJHgTlwLlBItS01M
  r0jJzgKkCJi3BwaMkwtsBkuYtLkjMLc5Mh0idYlSUEucNXAKUEABJZJTmwbXB0tMlRlkpYV5G
  BgYGIZ6C1KLczBJU+VeM4hyMSsK8CSDjeTLzSuCmvwJazAS0OMBxBcjikkSElFQDU7aM1ez79
  zbKnf5c8HuW9p2Qi1naVbH6a67ZpnhUH//UnCj789r/s45/pG/f9Ld748BxfX1E8v+Jt41lP9
  QHOFj7Pu3wN5w2ZXF3XkRrTGRhceqF2MM7nlz+kbK0d4Gm5bMTh49OWfxoaYyZf+VhzxMGQat
  s1qUk6FhO6JS58kHEdJOMw+eQuwWioXfOCycaHJbpPXlpXU/DwX7XoPPzosOKuZYZ+3Bc2lrd
  M+eH8pbEZVP/eRVMyP2fEM+ruTDuhcutG4WzJt7xPuJuvYIjZcKBJ7p+H4PmB+qrNpwxdP08c
  avhjarlyrfYPPdP6Vt3N7mzrNSQMfrDhmnZTyxmfpXe8eFF9gaWD2YtB8PFTiqxFGckGmoxFx
  UnAgAk/tGRygMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-31.tower-336.messagelabs.com!1605019260!3208!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29330 invoked from network); 10 Nov 2020 14:41:03 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-31.tower-336.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Nov 2020 14:41:03 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 2530C640E975DEA78B1E;
        Tue, 10 Nov 2020 22:40:57 +0800 (CST)
Received: from localhost.localdomain (10.46.61.15) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 10 Nov
 2020 06:40:53 -0800
Subject: Re: [External] Re: [PATCH 2/3] ACPI: platform-profile: Add platform
 profile support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201110033124.3211-1-markpearson@lenovo.com>
 <20201110033124.3211-3-markpearson@lenovo.com>
 <CAJZ5v0jbnjf3vU7qmHjOrdNoki5A2wrTH2uLxQAzi3s6xScrvw@mail.gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <56f8aa7c-de06-1332-ef0f-196361003347@lenovo.com>
Date:   Tue, 10 Nov 2020 09:40:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jbnjf3vU7qmHjOrdNoki5A2wrTH2uLxQAzi3s6xScrvw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.61.15]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael

On 10/11/2020 07:53, Rafael J. Wysocki wrote:
> On Tue, Nov 10, 2020 at 4:32 AM Mark Pearson <markpearson@lenovo.com> wrote:
>>
>> This is the initial implementation of the platform-profile feature.
>> It provides the details discussed and outlined in the
>> sysfs-platform_profile document.
>>
>> Many modern systems have the ability to modify the operating profile to
>> control aspects like fan speed, temperature and power levels. This
>> module provides a common sysfs interface that platform modules can register
>> against to control their individual profile options.
>>
>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>> ---
>>   MAINTAINERS                      |   8 ++
>>   drivers/acpi/Kconfig             |  19 ++++
>>   drivers/acpi/Makefile            |   1 +
>>   drivers/acpi/platform_profile.c  | 172 +++++++++++++++++++++++++++++++
>>   include/linux/platform_profile.h |  36 +++++++
>>   5 files changed, 236 insertions(+)
>>   create mode 100644 drivers/acpi/platform_profile.c
>>   create mode 100644 include/linux/platform_profile.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9a54806ebf02..e731ac1c4447 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -436,6 +436,14 @@ S: Orphan
>>   F:     drivers/platform/x86/wmi.c
>>   F:     include/uapi/linux/wmi.h
>>
>> +ACPI PLATFORM PROFILE DRIVER
>> +M:     Mark Pearson <markpearons@lenovo.com>
>> +L:     linux-acpi@vger.kernel.org
>> +S:     Supported
>> +W:     https://01.org/linux-acpi
>> +B:     https://bugzilla.kernel.org
>> +F:     drivers/acpi/platform_profile.c
> 
> IMO it is premature to add a MAINTAINERS entry for this until it turns
> out to be really necessary.
> 
Not a problem - I'll remove this. I wasn't particularly sure about the 
etiquette here and I ran checkpatch and it suggested it.

I'm obviously happy to help with fixes etc. My plan is not to dump and 
run :)

Mark
