Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8C2E9FD0
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 23:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbhADWEX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 17:04:23 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.112]:26589 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726608AbhADWEX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 17:04:23 -0500
Received: from [100.112.7.19] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-east-1.aws.symcld.net id 7E/90-29370-E9F83FF5; Mon, 04 Jan 2021 21:58:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRWlGSWpSXmKPExsWS8eIhr+68/s/
  xBhf3Mlu8OT6dyeLIqZNsFlMP1FjsfPiWzWL5vn5Gi8u75rBZfO6YzGKxes8LZou5X6YyW5w5
  fYnVgctjVkMvm8e7U1vYPDat6mTzmHcy0OP9vqtsHluutrN4fN4kF8AexZqZl5RfkcCasWVWS
  cEjgYoNUztZGhi383YxcnEICfxnlDjxdysbhPOMUWLyk3fMXYycHMICHhJbN25iBbFFBAIlvj
  6+A1bELPCISWLKjJ+MEB0vGCVOXT7LDlLFJqAtsWXLLzYQm1fAVuL58YNgk1gEVCS6N+9mAbF
  FBcIl1i9ZyQhRIyhxcuYTsDingJ3ErJ2rgeZwAG3QlFi/Sx8kzCwgLnHryXwmCFteYvvbOcwg
  JRJAds9DWZCwhECCxLKXd5gnMArOQjJ0FsKgWUgGzUIyaAEjyypG06SizPSMktzEzBxdQwMDX
  UNDI11zXRNLvcQq3WS90mLd1MTiEl1DvcTyYr3iytzknBS9vNSSTYzAuEspYDfcwbj4zQe9Q4
  ySHExKorwefZ/jhfiS8lMqMxKLM+KLSnNSiw8xynBwKEnwyvYA5QSLUtNTK9Iyc4ApACYtwcG
  jJML7H6SVt7ggMbc4Mx0idYpRUUqc9w5IQgAkkVGaB9cGSzuXGGWlhHkZGRgYhHgKUotyM0tQ
  5V8xinMwKgnz7usFmsKTmVcCN/0V0GImoMWHQ8EWlyQipKQamLZ6d67Tvhew07j22XXrDYqd0
  ZUcq99fZWw3tRCtFdi/6rYa+4YjOcGsJsaFvsZy25KaMsz4JerEX515bFmuyRPw1G7WJsXlzV
  kPpHa5r7x//vAGJ9nVThwyZVcvvg7aKhS36MHsb5a/53qkqh2JPRuZ+zH1U+nqW4zpzpPOzlz
  SPL3+VqOp3DNu7vyrvWf+cOXL77r6zz5R5uUD7x17Q3d3NDw8pV3gqXkzOU+1VjPQzfTzIcvK
  GTd/+xdIPhO/ISj0VORLeb+G2WydHfKLOU5P+7H5xdPJLhyvc/6q92fd4O4JnlYUaZnw71FPv
  F8Xs0L+Z4VNr2ykdC3LtEz+1Spn1T9Q9wm/l75yh0SBEktxRqKhFnNRcSIA/G2/5rYDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-3.tower-416.messagelabs.com!1609797533!966805!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1410 invoked from network); 4 Jan 2021 21:58:54 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-3.tower-416.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Jan 2021 21:58:54 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id CDF5549D335A48744C5A;
        Mon,  4 Jan 2021 16:58:53 -0500 (EST)
Received: from localhost.localdomain (10.38.54.96) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 4 Jan 2021
 13:58:52 -0800
Subject: Re: [External] Re: [PATCH 0/2] IdeaPad platform profile support
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
 <35ac853a-266c-6944-6e5e-6286456865e3@redhat.com>
 <CAJZ5v0jcCD3qWUJQcS+nFVJWSCQEbq2eN3i07mN8yFr3WZD9dg@mail.gmail.com>
 <6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <2eefa5ec-4f09-eabd-2c20-f217fa084dfc@lenovo.com>
Date:   Mon, 4 Jan 2021 16:58:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.54.96]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 04/01/2021 15:58, Hans de Goede wrote:
> Hi,
> 
> On 1/4/21 9:33 PM, Rafael J. Wysocki wrote:
>> On Mon, Jan 4, 2021 at 3:36 PM Hans de Goede <hdegoede@redhat.com>
>>  wrote:
>>> 
>>> Hi,
>>> 
>>> On 1/1/21 1:56 PM, Jiaxun Yang wrote:
>>>> Tested on Lenovo Yoga-14SARE Chinese Edition.
>>>> 
<snip>
> 
>> Also, on a somewhat related note, I'm afraid that it may not be a 
>> good idea to push this series for 5.11-rc in the face of recent 
>> objections against new material going in after the merge window.
> 
> That is fine with me, since this did not make rc1 (nor rc2) I'm not 
> entirely comfortable with sending out a late pull-req for the pdx86 
> side of this either, so lets postpone this to 5.12 (sorry Mark).
It is what it is.

> 
> Rafael, once we have the discussion with the passing a pointer back 
> to the drivers data thing resolved (and a patch merged for that if we
> go that route) can you provide me with an immutable branch to merge
> into pdx86/for-next so that I can then merge the pdx86 bits on top ?
> 
> Note this does not need to be done right now around say rc4 would be
>  fine, so that we have some time for the patches currently in 
> bleeding-edge to settle a bit.
> 
Just for my understanding of what happens next....please correct me if I
have anything wrong:

 - platform_profile gets pulled from ACPI for 5.11

 - platform_profile gets updated to add this data/pointer implementation
and goes into 5.12. Jiaxun, let me know if you're happy with following
up on that based on Hans suggestions, If you are pushed for time let me
know and I'll happily help out/implement/test as required. I sadly don't
have any ideapads but very happy to support your efforts any way I can.

 - Can we get the x86 portion done at the same time or does that end up
going to 5.13? I had been looking at the ideapad_laptop.c patch and have
some concerns there as Jiaxun's patch is essentially a duplicate of what
I implemented in thinkpad_acpi.c which doesn't seem to be ideal
(especially as there is a V6 version of DYTC coming out this year). I
haven't had time to look at code to consider better alternatives though...

Mark
