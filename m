Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA7529977E
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Oct 2020 20:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgJZTzY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Oct 2020 15:55:24 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.5]:44711 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728416AbgJZTzY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Oct 2020 15:55:24 -0400
Received: from [100.112.3.43] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-east-1.aws.symcld.net id F3/E1-29526-9A9279F5; Mon, 26 Oct 2020 19:55:21 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRWlGSWpSXmKPExsWSLveKTXel5vR
  4g/ZPghb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o8XlXXPYLD73HmG0aOpsArI6JrNY
  rN7zgtmB22PSzBnMHjtn3WX3+LVtDYvH5hVaHvNOBnq833eVzePzJrkA9ijWzLyk/IoE1ozLt
  9qYCh7KVjw/uoK5gfGZeBcjF4eQwH9GiRlrNrJCOC8YJaa0zGPsYmTnEBYokTiY1MXIySEioC
  4xtaOHDaSEWWA6k8TN/T+ZIeo7GSVevepnAqliE9CW2LLlFxuIzStgK/Fmxhd2EJtFQFWice4
  sRhBbVCBcouPGDiaIGkGJkzOfsIDYnAJ2Et1Hb4D1MgtYSMycf54RwhaXuPVkPhOELS+x/e0c
  ZhBbQkBBYs2Da1B2gsSyl3eYJzAKzkIydhaSUbOQjJqFZNQCRpZVjGZJRZnpGSW5iZk5uoYGB
  rqGhka6BrpGRkZ6iVW6SXqlxbqpicUluoZ6ieXFesWVuck5KXp5qSWbGIExmFLAcG8H45/XH/
  QOMUpyMCmJ8lqrT48X4kvKT6nMSCzOiC8qzUktPsQow8GhJMGbrQaUEyxKTU+tSMvMAaYDmLQ
  EB4+SCO9qkFbe4oLE3OLMdIjUKUZFKXHeayAJAZBERmkeXBssBV1ilJUS5mVkYGAQ4ilILcrN
  LEGVf8UozsGoJMxbogE0hSczrwRu+iugxUxAi9sqpoAsLklESEk1MCmFrX8X9Wu3agavRdLn5
  kfPcq25FLYtt7DIC2ydqCyZUqNR63dz9dnq6TI7rdJOOr3fvDhIY8GiHOfMg2ZbOC6zyMc4Nv
  y9Jl31USKBe65ZXHb6zxbfXMYN19QFClrF5le//LYrff7bBSUiv1Ut7u/lu8Acs589sKrf9YJ
  0wvJVHz9xfr90jfOtdFr11Jpz0yQXHZ2391nLZOcutz9xXl1G2QGW0gei5au3NApYefDnBgno
  MKfOrPyeWXlWIvy6q15xxux7G9jU1vKYcS94sSuHkXmGmL9cbab0TtPD16dP2RncymhjyhASs
  2nNVTcv195X92foBZQnKX2MienTy3l366GGUt3Ro41s1upKLMUZiYZazEXFiQBHfUfmvAMAAA
  ==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-9.tower-396.messagelabs.com!1603742118!31055!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21077 invoked from network); 26 Oct 2020 19:55:21 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-9.tower-396.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Oct 2020 19:55:21 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 23629BD59B767E1DC4A9;
        Tue, 27 Oct 2020 03:55:15 +0800 (CST)
Received: from localhost.localdomain (10.46.57.204) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 26 Oct
 2020 12:55:12 -0700
Subject: Re: [External] Re: [PATCH] [RFC] Documentation: Add documentation for
 new platform_profile sysfs attribute
To:     Hans de Goede <hdegoede@redhat.com>
CC:     <dvhart@infradead.org>, <mgross@linux.intel.com>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <hadess@hadess.net>, <bberg@redhat.com>,
        <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <markpearson@lenovo.com>
 <20201026174444.866545-1-markpearson@lenovo.com>
 <3c850d5a-75e6-4238-74fe-610ed9860abc@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <ef9b93a0-636f-9b96-9d5b-fee1e5738af7@lenovo.com>
Date:   Mon, 26 Oct 2020 15:55:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3c850d5a-75e6-4238-74fe-610ed9860abc@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.57.204]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Hans

On 26/10/2020 14:33, Hans de Goede wrote:
> Hi Mark,
> 
> Thank you for this new version.
> 
> On 10/26/20 6:44 PM, Mark Pearson wrote:
>> From: Hans de Goede <hdegoede@redhat.com>
>>
<snip>

>> +
>> +If for some reason there is no good match when mapping then a new profile-name
>> +may be added. Drivers which wish to introduce new profile-names must:
>> +1. Have very good reasons to do so.
>> +2. Add the new profile-name to this document, so that future drivers which also
>> +   have a similar problem can use the same new.
> 
> s/same new/same name/
I've read this document so many times...I'm not sure how I missed that 
one. Thanks.
> 
>> + Usually new profile-names will
>> +   be added to the "extra profile-names" section of this document. But in some
>> +   cases the set of standard profile-names may be extended.
> 
> With the change from a more generic API to this new one more targeted towards DPTF
> I would drop this part.
OK - I have some questions then related to this change, below
> 
> 
>> +
>> +What:		/sys/firmware/acpi/platform_profile_choices
>> +Date:		October 2020
>> +Contact:	Hans de Goede <hdegoede@redhat.com>
>> +Description:
>> +		Reading this file gives a space separated list of profiles
>> +		supported for this device.
>> +
>> +		Drivers must use the following standard profile-names whenever
>> +		possible:
>> +
>> +		low-power:		Emphasises low power consumption
>> +		quiet:			Offers quieter operation (lower fan
>> +					speed but with higher performance and
>> +					temperatures then seen in low-power
> 
> I think the description here is a bit too specific, this may cause userspace
> to have expectations which are not necessary true. I would describe this as
> just:
> 
> 		quiet:			Emphasises quieter operation
> 
Agreed. I'll update

>> +		balanced:		Balance between low power consumption
>> +					and performance
>> +		performance:		Emphasises performance (and may lead to
>> +					higher temperatures and fan speeds)
>> +
>> +		Userspace may expect drivers to offer at least several of these
>> +		standard profile-names! If none of the above are a good match
>> +		for some of the drivers profiles, then drivers may use one of
>> +		these extra profile-names:
>> +		<reserved for future use>
>> +
If we remove the extra profile-names section above then I think it 
should be removed here too. If someone wants to add a new 'mode' then it 
would be added to the list of 'standard names', and becomes a new 
option. Wanted to check I'm not missing something important.

>> +What:		/sys/firmware/acpi/platform_profile
>> +Date:		October 2020
>> +Contact:	Hans de Goede <hdegoede@redhat.com>
>> +Description:
>> +		Reading this file gives the current selected profile for this
>> +		device. Writing this file with one of the strings from
>> +		available_profiles changes the profile to the new value.
> 
> The part about custom profiles below may be dropped. That was intended for use
> with e.g. GPUs but since this now strictly is a system-level profile API, the
> part below can be dropped now.
Agreed
> 
> 
>> +
>> +		Reading this file may also return "custom". This is intended for
>> +		drivers which have and export multiple knobs. Such drivers may
>> +		very well still want to offer a set of profiles for easy of use
>> +		and to be able to offer a consistent standard API (this API) to
>> +		userspace for configuring their performance. The "custom" value
>> +		is intended for when ai user has directly configured the knobs
>> +		(through e.g. some advanced control-panel for a GPU) and the
>> +		knob values do not match any of the presets represented by the
>> +		platform-profiles. In this case writing this file will
>> +		override the modifications and restore the selected presets.
>> +
>>
> 
> Regards,
> 
> Hans
> 
Thanks!
mark
