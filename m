Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1D2DD332
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 15:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgLQOoR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 09:44:17 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.115]:9391 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728111AbgLQOoR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Dec 2020 09:44:17 -0500
Received: from [100.112.5.40] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.us-east-1.aws.symcld.net id 1F/62-56876-87D6BDF5; Thu, 17 Dec 2020 14:38:48 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRWlGSWpSXmKPExsWS8eIhj25F7u1
  4g99b1S32X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWyx9ss8
  Nou5X6YyW5w5fYnVgcdj0swZzB47Z91l9/i1bQ2Lx+YVWh6bVnWyecw7GejR07aJyeP9vqtsH
  luutrN4fN4kF8AVxZqZl5RfkcCaMan/PHPBDPmKve+uMzcwTpDqYuTiEBL4zyjx8dlxNgjnBa
  PEhlvHWbsYOTmEBRIkjpxZxAhiiwhoSyxZdJUZpIhZoI1F4sX9d+wQHa2sEttuzgCrYgOq2rL
  lFxuIzStgK3G6cRs7iM0ioCrx8no/E4gtKhAusX7JSkaIGkGJkzOfsIDYnAKBEusOLgPawAG0
  QVNi/S59kDCzgLjErSfzmSBseYnmrbOZQWwJAQWJv7+uskDYCRLLXt5hnsAoOAvJ1FkIk2Yhm
  TQLyaQFjCyrGM2SijLTM0pyEzNzdA0NDHQNDY10zYAsE73EKt1kvdJi3dTE4hJdQ73E8mK94s
  rc5JwUvbzUkk2MwFhNKWDL2MHY/uaD3iFGSQ4mJVHeRw6344X4kvJTKjMSizPii0pzUosPMcp
  wcChJ8LZlA+UEi1LTUyvSMnOAaQMmLcHBoyTCuwckzVtckJhbnJkOkTrFqCglznsGJCEAksgo
  zYNrg6WqS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeVtBpvBk5pXATX8FtJgJaPHqPddBF
  pckIqSkGpgmcz67xbxl2Y2OCRrmz+Yb8Px9Lq64Re3elzC3tXe9LrhU3kvb9fuCrl/y6gqWbf
  4PqwR2aq3aVjKzf8OUz/lTl/WWBEVsqcu5smr6mnVPmuUsVsZNTlNYUeIb5q60tD3sDfcOJ1G
  Xj84T1E85BU7VeL9tigxr1fMjKpcU15YtKVrbGGpzPvbPnw6RTSt2Lkm/q1HjWFxVWybLOmVd
  a2ElRybTvQ+NmytzrT6Y/lx5vtZmg9AE9mjNYxOX7PhbkXH5MPucya3zLTlD715OiTmzNL6Xz
  059u5dIW9Tm6FsXD/+fo3rQft26M0afFmoq9JY2KpzdeC35nensBxJXn99ZNmX6svc3EzJnlm
  k4T52ZpsRSnJFoqMVcVJwIAOctBSzQAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-7.tower-415.messagelabs.com!1608215928!82129!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17866 invoked from network); 17 Dec 2020 14:38:48 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-7.tower-415.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Dec 2020 14:38:48 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 67C58B2667BEB6B8A082;
        Thu, 17 Dec 2020 09:38:48 -0500 (EST)
Received: from localhost.localdomain (10.38.108.33) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Thu, 17 Dec
 2020 06:38:47 -0800
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
        Nitin Joshi1 <njoshi1@lenovo.com>
References: <markpearson@lenovo.com>
 <20201211020630.305905-1-markpearson@lenovo.com>
 <20201211020630.305905-2-markpearson@lenovo.com>
 <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com>
 <l-Nzteqdz9SbINiwW0w4kFnKwknGoh5DH7VXqvkb23SZPwhvNyna0FRV9z2IZ18T0S9-a4n3LGBR1pMZYKX4FcxNTOma7vIuya66CY_Mkpc=@protonmail.com>
 <CAJZ5v0hHoScy18FE_Aj+zoWpr-vUhGq-vO+8AjO7RxmOvZBYMA@mail.gmail.com>
 <00993237-eb24-6038-3a85-bb76f96f679d@lenovo.com>
 <CAJZ5v0ji_+BbCrJo=3TB1Cytb8eV-tGE_m6R35UYfwmpUs6MAg@mail.gmail.com>
 <e682cdbd-41fe-065e-5912-d0fb94879dc9@lenovo.com>
 <CAJZ5v0gMo_22OJvjrufJy6uQsMjh+AT_mYQyFD-LpNzAwhkimA@mail.gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <4727e1ba-fab5-a051-a803-ea465e7877fa@lenovo.com>
Date:   Thu, 17 Dec 2020 09:38:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gMo_22OJvjrufJy6uQsMjh+AT_mYQyFD-LpNzAwhkimA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.108.33]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 17/12/2020 08:36, Rafael J. Wysocki wrote:
> On Wed, Dec 16, 2020 at 10:36 PM Mark Pearson <markpearson@lenovo.com> wrote:
>>
>>
>> On 16/12/2020 14:50, Rafael J. Wysocki wrote:
>>> On Wed, Dec 16, 2020 at 8:19 PM Mark Pearson <markpearson@lenovo.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> On 16/12/2020 13:47, Rafael J. Wysocki wrote:
>>>>> On Wed, Dec 16, 2020 at 7:42 PM Barnabás Pőcze <pobrn@protonmail.com> wrote:
>>>>>>
>>>>>> 2020. december 16., szerda 19:13 keltezéssel, Rafael J. Wysocki írta:
>>>>>>
>>>>>>> On Fri, Dec 11, 2020 at 3:15 AM Mark Pearson <markpearson@lenovo.com> wrote:
>>>>>>>>
>>>>>>>> This is the initial implementation of the platform-profile feature.
>>>>>>>> It provides the details discussed and outlined in the
>>>>>>>> sysfs-platform_profile document.
>>>>>>>>
>>>>>>>> Many modern systems have the ability to modify the operating profile to
>>>>>>>> control aspects like fan speed, temperature and power levels. This
>>>>>>>> module provides a common sysfs interface that platform modules can register
>>>>>>>> against to control their individual profile options.
>>>>>>>>
>>>>>>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>>>>>>> [...]
>>>>>>>> +enum platform_profile_option {
>>>>>>>> +       PLATFORM_PROFILE_LOW,
>>>>>>>> +       PLATFORM_PROFILE_COOL,
>>>>>>>> +       PLATFORM_PROFILE_QUIET,
>>>>>>>> +       PLATFORM_PROFILE_BALANCED,
>>>>>>>> +       PLATFORM_PROFILE_PERFORM,
>>>>>>>> +       PLATFORM_PROFILE_LAST, /*must always be last */
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +struct platform_profile_handler {
>>>>>>>> +       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>>>>>>> +       int (*profile_get)(enum platform_profile_option *profile);
>>>>>>>
>>>>>>> I'm not sure why this callback is necessary and, provided that there
>>>>>>> is a good enough reason, why it cannot return an enum
>>>>>>> platform_profile_option value.
>>>>>>>
>>>>>>> In principle, if ->profile_set() returns 0, the requested profile can
>>>>>>> be saved in a static var and then returned by subsequent "read"
>>>>>>> operations.
>>>>>>>
>>>>>>
>>>>>> It is possible that the platform profile can be changed with (e.g.) a dedicated
>>>>>> button (commonly found on laptops), in which case there needs to be a mechanism
>>>>>> to retrieve the new profile, which would not be possible without introducing
>>>>>> something else in place of that getter - unless I'm missing something obvious.
>>>>>
>>>>> Fair enough.
>>>>>
>>>>> The other question remains, then.
>>>>>
>>>> My thinking here that I shouldn't make assumptions for future platform
>>>> implementations - there may be valid cases in the future where being
>>>> able to return an error condition if there was an error would be useful.
>>>>
>>>> Just trying to keep this somewhat future proof. Returning an error
>>>> condition seemed a useful thing to have available.
>>>
>>> You can still return an error while returning a platform_profile_option value.
>>>
>>> Just add a special value representing an error to that set.
>>>
>> I'd like to understand what is better about that approach than having an
>> error and a returnable parameter?
>>
>> I'm probably missing something obvious but if I add an extra
>> platform_profile option (e.g PLATFORM_PROFILE_ERROR) to be used in an
>> error case (and return just an enum platform_profile_option) it seems I
>> lose the granularity of being able to return a specific error condition.
>> It doesn't feel like an improvement.
> 
> And what's the user expected to do about the different error codes
> that can be returned?
> 

From my experiences when something fails I would rather have more
information than less. I'm probably over thinking it though.

Looking at it again, from my Lenovo platform profile implementation
perspective I have no objections. It's hard to argue a point without
having a hard requirement or example :) I'll go ahead with your
suggestion of just returning the profile.

Thank you for the review
Mark
