Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5382C772B
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Nov 2020 02:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgK2BZV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Nov 2020 20:25:21 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.2]:61882 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgK2BZU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 28 Nov 2020 20:25:20 -0500
Received: from [100.112.1.203] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-east-1.aws.symcld.net id D5/35-00973-837F2CF5; Sun, 29 Nov 2020 01:19:52 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRWlGSWpSXmKPExsWS8eIhj67F90P
  xBvs2CVjsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBYfl3FYfO6YzGKxes8LZou1X+ax
  WZw5fYnVgdtj0swZzB47Z91l9/i1bQ2Lx+YVWh7zTgZ69LRtYvJ4v+8qm8eWq+0sHp83yQVwR
  rFm5iXlVySwZky98Iq9oIut4vDMe4wNjA2sXYxcHEIC/xklth5dzwbhvGCUuNJ3nr2LkZNDWC
  BB4lDzNVYQW0QgVWJvYx87SBGzwDVmicX3f7NAdOxgknj64yozSBWbgLbEli2/2EBsXgFbidu
  NJ1hAbBYBVYneuRfBpooKhEusX7KSEaJGUOLkzCdggzgFuhglnv9fB9bMLGAhMXP+eUYIW1zi
  1pP5TBC2vETz1tlgyyQEFCRW3jnMBmEnSCx7eYd5AqPgLCRzZyEZNQvJqFlIRi1gZFnFaJpUl
  JmeUZKbmJmja2hgoGtoaKRrqGtioJdYpZukV1qsm5pYXKJrqJdYXqxXXJmbnJOil5dasokRGJ
  kpBYwaOxg733zQO8QoycGkJMrrdf1QvBBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3l+fgXKCRan
  pqRVpmTnAJAGTluDgURLhtfwKlOYtLkjMLc5Mh0idYlSUEudVAkkIgCQySvPg2mCJ6RKjrJQw
  LyMDA4MQT0FqUW5mCar8K0ZxDkYlYV7Fb0BTeDLzSuCmvwJazAS02OX/fpDFJYkIKakGJokgd
  zWHHpkJM1kS8tPS/u0XEzELu8Ck8jjTpkUzK09Hquq6wFKrp4e1JzOdr/TPP/pkv9vFw21mEk
  uOmni/S0qpijl1ieVQvcqRdIZ1j3/+3P7803v3n0WPry+dczF3cwzLW5s3k0on7jGaY+j+MiZ
  2gdjGa0k2vx3n3FlQbz/lflL87IdbH8qKbPK8Lmz/X+3IydzLM5+v5UuU/smiWft846ed9398
  vXMzavJXgbiaDuaM+55r7P52mbXNzPJZ+mXKgasC1879nCia4tUjsD9g8p2bAZt/blprqJvX6
  nR/UtvMzGuFmrk9RwsjIwqkt7HoZ1kYpX83d4l6zPEutf69XMDxX7YZDHMnqapL1SqxFGckGm
  oxFxUnAgDkbneZxwMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-2.tower-395.messagelabs.com!1606612792!441030!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15382 invoked from network); 29 Nov 2020 01:19:52 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-2.tower-395.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Nov 2020 01:19:52 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 101AEEB9B28131BB86ED;
        Sat, 28 Nov 2020 20:19:52 -0500 (EST)
Received: from localhost.localdomain (10.64.84.236) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Sat, 28 Nov
 2020 17:19:49 -0800
Subject: Re: [External] Re: [PATCH v4 2/3] ACPI: platform-profile: Add
 platform profile support
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "mario.limnociello@dell.com" <mario.limnociello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
 <20201126165143.32776-2-markpearson@lenovo.com>
 <faa32924-f53f-b3fd-3f24-3848f45b67e1@redhat.com>
 <tvhsHrDOOP32PZfdoiajK4HUiE7pV3yfxAjHkied_GvQd3tPUQXxfPAI0P84ovCJjmNYib68twP2_ESRc-fyoUzUAJkTvWsobXdWfJGW74s=@protonmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <79f67d13-0422-d9f0-3014-a6339f591a25@lenovo.com>
Date:   Sat, 28 Nov 2020 20:19:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <tvhsHrDOOP32PZfdoiajK4HUiE7pV3yfxAjHkied_GvQd3tPUQXxfPAI0P84ovCJjmNYib68twP2_ESRc-fyoUzUAJkTvWsobXdWfJGW74s=@protonmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.64.84.236]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2020-11-28 10:37 a.m., Barnabás Pőcze wrote:
> Hi
> 
> 
> 2020. november 28., szombat 15:08 keltezéssel, Hans de Goede írta:
> 
>> [...]
>>> +static_assert(ARRAY_SIZE(profile_names) == platform_profile_perform+1);
>>
>> It would be better to add an extra member/entry at the end of the enum
>> named platform_profile_no_profiles; and then use that instead of
>> platform_profile_perform+1. Also see below where I use this too.
>>
> 
> I'm not sure if it's just me, but when I read "no_profiles", then "number of probiles"
> is not the first thing that comes to mind, maybe _end, _last, _max, etc.
> would be harder to mistake for something else? What do you think?
> 
FWIW - my vote would be platform_profile_last, it just seems to fit well 
when reading the code.

Mark
