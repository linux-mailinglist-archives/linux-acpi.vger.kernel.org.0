Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D05D2DC86B
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Dec 2020 22:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgLPVlz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Dec 2020 16:41:55 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.1]:30753 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgLPVlz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Dec 2020 16:41:55 -0500
Received: from [100.112.2.115] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-east-1.aws.symcld.net id F9/33-44756-ADD7ADF5; Wed, 16 Dec 2020 21:36:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRWlGSWpSXmKPExsWSLveKXfdW7a1
  4g3Pd/Bb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o0VTZxObxeeOySwWq/e8YLZY+2Ue
  m8XcL1OZLc6cvsTqwOMxaeYMZo+ds+6ye/zatobFY/MKLY9NqzrZPOadDPToadvE5PF+31U2j
  y1X21k8Pm+SC+CKYs3MS8qvSGDNWPswrGCbZEX/2tuMDYzTRbsYuTiEBP4zSqxq+80I4bxglL
  izvoe1i5GTQ1ggQeLImUWMILaIgLbEkkVXmUGKmAV6WCQebr7NCtEB5Fz91gHWwQZUtWXLLzY
  Qm1fAVmLN5PVMIDaLgKrEsi3PwGpEBcIl1i9ZyQhRIyhxcuYTFhCbUyBQ4v/haUD1HEAbNCXW
  79IHCTMLiEvcejKfCcKWl2jeOpsZxJYQUJD4++sqC4SdILHs5R3mCYyCs5BMnYUwaRaSSbOQT
  FrAyLKK0SypKDM9oyQ3MTNH19DAQNfQ0EjXWNfIwFgvsUo3Sa+0WDc1sbhE11AvsbxYr7gyNz
  knRS8vtWQTIzBSUwqYT+9gXPrmg94hRkkOJiVR3iLvW/FCfEn5KZUZicUZ8UWlOanFhxhlODi
  UJHirqoBygkWp6akVaZk5wKQBk5bg4FES4X1fDZTmLS5IzC3OTIdInWJUlBLnvQ2SEABJZJTm
  wbXBEtUlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8x2uApvBk5pXATX8FtJgJaPHqPddBF
  pckIqSkGpgcRNcKHp11fd+9Ql2nvlsfPrDmaogyq1506LISlf3Invk444fm+39msw22yR1dW8
  XV8CdJzsbCpfFSxJS8946+1UIZ4k957WZmREftYLU+lX9IqzTye+Hhzc6BLx9JOb+ZNE1BdtK
  Ks3HTT3/IENn5+7ZJUG/rm9we0+O3KnWPuIhuK14yIXyG6Fzl57vLp6tm3bt7Ylu05Ls7QRqh
  c39InnJoW3hLfm7vj/T1EvHfL71wbNDWZe8Q12u/eyvycs2W1a+9bp3++PGncPPEQ/vmS27e9
  Km1VlJnA3tc4Q2VGsGF7NfCeXQYnqa/qbE9HDNny/kz/G6SB6W7lLgVpu846XSw9+Zy2Tt6zG
  aiRROVWIozEg21mIuKEwHnc5LhzwMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-23.tower-395.messagelabs.com!1608154584!26216!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13275 invoked from network); 16 Dec 2020 21:36:26 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-23.tower-395.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Dec 2020 21:36:26 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id A602C3DEC105BA942B96;
        Thu, 17 Dec 2020 05:36:20 +0800 (CST)
Received: from localhost.localdomain (10.38.108.33) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 16 Dec
 2020 13:36:17 -0800
Subject: Re: [External] Re: [PATCH v6 2/3] ACPI: platform-profile: Add
 platform profile support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        "njosh1@lenovo.com" <njosh1@lenovo.com>
References: <markpearson@lenovo.com>
 <20201211020630.305905-1-markpearson@lenovo.com>
 <20201211020630.305905-2-markpearson@lenovo.com>
 <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com>
 <l-Nzteqdz9SbINiwW0w4kFnKwknGoh5DH7VXqvkb23SZPwhvNyna0FRV9z2IZ18T0S9-a4n3LGBR1pMZYKX4FcxNTOma7vIuya66CY_Mkpc=@protonmail.com>
 <CAJZ5v0hHoScy18FE_Aj+zoWpr-vUhGq-vO+8AjO7RxmOvZBYMA@mail.gmail.com>
 <00993237-eb24-6038-3a85-bb76f96f679d@lenovo.com>
 <CAJZ5v0ji_+BbCrJo=3TB1Cytb8eV-tGE_m6R35UYfwmpUs6MAg@mail.gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <e682cdbd-41fe-065e-5912-d0fb94879dc9@lenovo.com>
Date:   Wed, 16 Dec 2020 16:36:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ji_+BbCrJo=3TB1Cytb8eV-tGE_m6R35UYfwmpUs6MAg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.108.33]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 16/12/2020 14:50, Rafael J. Wysocki wrote:
> On Wed, Dec 16, 2020 at 8:19 PM Mark Pearson <markpearson@lenovo.com> wrote:
>>
>> Hi Rafael,
>>
>> On 16/12/2020 13:47, Rafael J. Wysocki wrote:
>>> On Wed, Dec 16, 2020 at 7:42 PM Barnabás Pőcze <pobrn@protonmail.com> wrote:
>>>>
>>>> 2020. december 16., szerda 19:13 keltezéssel, Rafael J. Wysocki írta:
>>>>
>>>>> On Fri, Dec 11, 2020 at 3:15 AM Mark Pearson <markpearson@lenovo.com> wrote:
>>>>>>
>>>>>> This is the initial implementation of the platform-profile feature.
>>>>>> It provides the details discussed and outlined in the
>>>>>> sysfs-platform_profile document.
>>>>>>
>>>>>> Many modern systems have the ability to modify the operating profile to
>>>>>> control aspects like fan speed, temperature and power levels. This
>>>>>> module provides a common sysfs interface that platform modules can register
>>>>>> against to control their individual profile options.
>>>>>>
>>>>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>>>>> [...]
>>>>>> +enum platform_profile_option {
>>>>>> +       PLATFORM_PROFILE_LOW,
>>>>>> +       PLATFORM_PROFILE_COOL,
>>>>>> +       PLATFORM_PROFILE_QUIET,
>>>>>> +       PLATFORM_PROFILE_BALANCED,
>>>>>> +       PLATFORM_PROFILE_PERFORM,
>>>>>> +       PLATFORM_PROFILE_LAST, /*must always be last */
>>>>>> +};
>>>>>> +
>>>>>> +struct platform_profile_handler {
>>>>>> +       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>>>>> +       int (*profile_get)(enum platform_profile_option *profile);
>>>>>
>>>>> I'm not sure why this callback is necessary and, provided that there
>>>>> is a good enough reason, why it cannot return an enum
>>>>> platform_profile_option value.
>>>>>
>>>>> In principle, if ->profile_set() returns 0, the requested profile can
>>>>> be saved in a static var and then returned by subsequent "read"
>>>>> operations.
>>>>>
>>>>
>>>> It is possible that the platform profile can be changed with (e.g.) a dedicated
>>>> button (commonly found on laptops), in which case there needs to be a mechanism
>>>> to retrieve the new profile, which would not be possible without introducing
>>>> something else in place of that getter - unless I'm missing something obvious.
>>>
>>> Fair enough.
>>>
>>> The other question remains, then.
>>>
>> My thinking here that I shouldn't make assumptions for future platform
>> implementations - there may be valid cases in the future where being
>> able to return an error condition if there was an error would be useful.
>>
>> Just trying to keep this somewhat future proof. Returning an error
>> condition seemed a useful thing to have available.
> 
> You can still return an error while returning a platform_profile_option value.
> 
> Just add a special value representing an error to that set.
> 
I'd like to understand what is better about that approach than having an
error and a returnable parameter?

I'm probably missing something obvious but if I add an extra
platform_profile option (e.g PLATFORM_PROFILE_ERROR) to be used in an
error case (and return just an enum platform_profile_option) it seems I
lose the granularity of being able to return a specific error condition.
It doesn't feel like an improvement.

Let me know what I'm missing.

Thanks
Mark



