Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB512DC701
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Dec 2020 20:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgLPTXp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Dec 2020 14:23:45 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.2]:16996 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388166AbgLPTXo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Dec 2020 14:23:44 -0500
Received: from [100.112.131.75] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.us-west-2.aws.symcld.net id F7/9A-16145-9AD5ADF5; Wed, 16 Dec 2020 19:19:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRWlGSWpSXmKPExsWSLveKTXdF7K1
  4g5+9xhb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o0VTZxObxeeOySwWq/e8YLZY+2Ue
  m8XcL1OZLc6cvsTqwOMxaeYMZo+ds+6ye/zatobFY/MKLY9NqzrZPOadDPToadvE5PF+31U2j
  y1X21k8Pm+SC+CKYs3MS8qvSGDNODxtPWPBLaGKlj9aDYwH+bsYuTiEBP4zShxe0M8E4bxglD
  j9op29i5GTQ1ggQeLImUWMILaIQKbEx+ObwIqYBc4xS6x6OJ0ZomMys8SHg0/ZQKrYBLQltmz
  5BWbzCthKHO57B2azCKhKbOvfxQxiiwqES6xfspIRokZQ4uTMJywgNqdAoMS3w7eANnMAbdCU
  WL9LHyTMLCAucevJfCYIW16ieetssDESAgoSf39dZYGwEySWvbzDPIFRcBaSqbMQJs1CMmkWk
  kkLGFlWMVokFWWmZ5TkJmbm6BoaGOgaGhrpGhob6hoZm+olVukm6pUW65anFpfoGukllhfrFV
  fmJuek6OWllmxiBEZrSkHz6x2MG9580DvEKMnBpCTKW+R9K16ILyk/pTIjsTgjvqg0J7X4EKM
  MB4eSBC9HDFBOsCg1PbUiLTMHmDhg0hIcPEoivMuigdK8xQWJucWZ6RCpU4yKUuK8jSAJAZBE
  RmkeXBssWV1ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMzbALKdJzOvBG76K6DFTECLV++5D
  rK4JBEhJdXAJJPH+NTjCOu3E0Iqzxdd9NK7GsnSxe2vLPC6amm30NZH+W7e548EvtkUm+B+WT
  5X2XHViUnHtfYIXz1XO+2hIhf3xIAwLu7Z8/5ZZ5RPDlpR/tyn5smWZJUvmvFlhw5wJy+ftPu
  kbrBQE3/VS/vQFg7xR/xzebetuiKisv1Gid9CLe+rxw3TpxsZcq1Ti0hxsJF0tvhq89ZW1OE1
  43qLiISfnbsOe615onJw66Me/sw1pxcm7+wql7l2V3yeAec8w4y3kXwM9lZvzfaaSnBIll4XC
  Z/PMn2i647uI3MXCU9ucN30jNnm2DJrG0+W+XGvgtnqrojy9q5om/W58ozSqbzK/sumq7ocZ6
  txbfqvxFKckWioxVxUnAgAPFnH3dEDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-4.tower-335.messagelabs.com!1608146342!19428!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26587 invoked from network); 16 Dec 2020 19:19:04 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-4.tower-335.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Dec 2020 19:19:04 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id E8EF0AF7645A70388E5B;
        Thu, 17 Dec 2020 03:18:59 +0800 (CST)
Received: from localhost.localdomain (10.38.108.33) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 16 Dec
 2020 11:18:57 -0800
Subject: Re: [External] Re: [PATCH v6 2/3] ACPI: platform-profile: Add
 platform profile support
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
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
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <00993237-eb24-6038-3a85-bb76f96f679d@lenovo.com>
Date:   Wed, 16 Dec 2020 14:18:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hHoScy18FE_Aj+zoWpr-vUhGq-vO+8AjO7RxmOvZBYMA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.108.33]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 16/12/2020 13:47, Rafael J. Wysocki wrote:
> On Wed, Dec 16, 2020 at 7:42 PM Barnabás Pőcze <pobrn@protonmail.com> wrote:
>>
>> 2020. december 16., szerda 19:13 keltezéssel, Rafael J. Wysocki írta:
>>
>>> On Fri, Dec 11, 2020 at 3:15 AM Mark Pearson <markpearson@lenovo.com> wrote:
>>>>
>>>> This is the initial implementation of the platform-profile feature.
>>>> It provides the details discussed and outlined in the
>>>> sysfs-platform_profile document.
>>>>
>>>> Many modern systems have the ability to modify the operating profile to
>>>> control aspects like fan speed, temperature and power levels. This
>>>> module provides a common sysfs interface that platform modules can register
>>>> against to control their individual profile options.
>>>>
>>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>>> [...]
>>>> +enum platform_profile_option {
>>>> +       PLATFORM_PROFILE_LOW,
>>>> +       PLATFORM_PROFILE_COOL,
>>>> +       PLATFORM_PROFILE_QUIET,
>>>> +       PLATFORM_PROFILE_BALANCED,
>>>> +       PLATFORM_PROFILE_PERFORM,
>>>> +       PLATFORM_PROFILE_LAST, /*must always be last */
>>>> +};
>>>> +
>>>> +struct platform_profile_handler {
>>>> +       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>>> +       int (*profile_get)(enum platform_profile_option *profile);
>>>
>>> I'm not sure why this callback is necessary and, provided that there
>>> is a good enough reason, why it cannot return an enum
>>> platform_profile_option value.
>>>
>>> In principle, if ->profile_set() returns 0, the requested profile can
>>> be saved in a static var and then returned by subsequent "read"
>>> operations.
>>>
>>
>> It is possible that the platform profile can be changed with (e.g.) a dedicated
>> button (commonly found on laptops), in which case there needs to be a mechanism
>> to retrieve the new profile, which would not be possible without introducing
>> something else in place of that getter - unless I'm missing something obvious.
> 
> Fair enough.
> 
> The other question remains, then.
> 
My thinking here that I shouldn't make assumptions for future platform
implementations - there may be valid cases in the future where being
able to return an error condition if there was an error would be useful.

Just trying to keep this somewhat future proof. Returning an error
condition seemed a useful thing to have available.

Mark
