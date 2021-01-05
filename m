Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4001A2EB0BD
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 17:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbhAEQ6X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 11:58:23 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.115]:7793 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729248AbhAEQ6W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 11:58:22 -0500
Received: from [100.112.132.72] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-west-2.aws.symcld.net id CE/76-61492-D9994FF5; Tue, 05 Jan 2021 16:53:49 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRWlGSWpSXmKPExsWSLveKXXfuzC/
  xBrPnMVq8OT6dyeLIqZNsFlMP1FjsfPiWzWL5vn5Gi8u75rBZfO6YzGKxes8LZou5X6YyW5w5
  fYnVgctjVkMvm8e7U1vYPDat6mTzmHcy0OP9vqtsHluutrN4fN4kF8AexZqZl5RfkcCaMfHlH
  eaCbeIVdy5eYGlgfC/UxcjFISTwn1Gi/+sjNgjnGaPExZ/fGbsYOTmEBTwktm7cxApiiwhUSG
  yevJsVpIhZYBeTxMuWJVAd55kkDr5tBetgE9CW2LLlFxuIzStgKzFjTQsziM0ioCKxrnM6O4g
  tKhAusX7JSkaIGkGJkzOfsIDYnAL2EhO23ASKcwBt0JRYv0sfJMwsIC5x68l8JghbXqJ562xm
  kBIJILvnoSxIWEIgQWIZ0GcTGAVnIRk6C2HQLCSDZiEZtICRZRWjRVJRZnpGSW5iZo6uoYGBr
  qGhka6hsQkQm+klVukm6ZUW65anFpfoGukllhfrFVfmJuek6OWllmxiBMZfSkFbxw7G6W8+6B
  1ilORgUhLlnRb9JV6ILyk/pTIjsTgjvqg0J7X4EKMMB4eSBC8XMKKFBItS01Mr0jJzgKkAJi3
  BwaMkwis0HSjNW1yQmFucmQ6ROsWoy7Hy4JJFzEIsefl5qVLivFdBigRAijJK8+BGwNLSJUZZ
  KWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvKdnAE3hycwrgdv0CugIJqAjDod+BjmiJBEhJdXAZ
  Hph9sWoZf+LFqaucnFiSHf61HqpaN6vXRsL+zsbo07z3HXOnfylcOstvvvtHbuurL29K/aJ86
  a7rtrOZnmTLxr6BW8Vr7Cz3l/3dbGdJd8LD854r92beqaFzVm7ftHrPNYq8VfG+Q/4ks7W5on
  bchR0228szF6r/0V+voZnm4ndW84esfbQC3yZt7ObSyxehpbysP30iX1oc/7JufO6k5aLq0av
  94jiS5G9GxU424+jfWrMvl+CX+2WnmBNXiNkxnKqJUD1ouChnX+lbBuvvW35tWPTqRr+dXqGu
  gGV8eI7ZB+ZNbZa2c5+w5MV+pz5U9yuQPvZR88YGW+Yxqn+5cjMCRq911ITQy7lzVdXYinOSD
  TUYi4qTgQAL8xcMcYDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-24.tower-356.messagelabs.com!1609865626!4995!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31544 invoked from network); 5 Jan 2021 16:53:48 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-24.tower-356.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Jan 2021 16:53:48 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 3AD635DA9918C07D62E6;
        Wed,  6 Jan 2021 00:53:44 +0800 (CST)
Received: from localhost.localdomain (10.38.54.96) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 5 Jan 2021
 08:53:42 -0800
Subject: Re: [External] Re: [PATCH 0/2] IdeaPad platform profile support
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Platform Driver <platform-driver-x86@vger.kernel.org>,
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
 <2eefa5ec-4f09-eabd-2c20-f217fa084dfc@lenovo.com>
 <75952842-3ee3-82a2-7809-66e2d5263c73@flygoat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <f53cd0dc-17b4-6410-02f9-526e67c7132c@lenovo.com>
Date:   Tue, 5 Jan 2021 11:53:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <75952842-3ee3-82a2-7809-66e2d5263c73@flygoat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.54.96]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jiaxun,

On 05/01/2021 01:24, Jiaxun Yang wrote:
> 在 2021/1/5 上午5:58, Mark Pearson 写道:
>> On 04/01/2021 15:58, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 1/4/21 9:33 PM, Rafael J. Wysocki wrote:
>>>> On Mon, Jan 4, 2021 at 3:36 PM Hans de Goede <hdegoede@redhat.com>
>>>>   wrote:
>>>>> Hi,
>>>>>
>>>>> On 1/1/21 1:56 PM, Jiaxun Yang wrote:
>>>>>> Tested on Lenovo Yoga-14SARE Chinese Edition.
>>>>>>
> [...]
>> Just for my understanding of what happens next....please correct me if I
>> have anything wrong:
>>
>>   - platform_profile gets pulled from ACPI for 5.11
>>
>>   - platform_profile gets updated to add this data/pointer implementation
>> and goes into 5.12.
> Hi all,
> 
> Another approach could be just let all the patch go through pdx86 tree
> and with
> pointer part acked by Rafael as it's unlikely to have merge conflicts.
> 
>> Jiaxun, let me know if you're happy with following
>> up on that based on Hans suggestions, If you are pushed for time let me
>> know and I'll happily help out/implement/test as required. I sadly don't
>> have any ideapads but very happy to support your efforts any way I can.
> 
> 
> I'm happy with Hans suggestion, will send v2 for it later.
> 
> I've been ask Lenovo engineers about DYTC and other ideapad ACPI
> stuff on Lenovo China forum[1], but moderator here told me Lenovo won't
> invest any Linux effort on their consumer product line :-(
> 
> Is it possible to publish a DYTC specification or documents to help us
> further
> understand these mechanisms?
> 
> I'm tired of reading disassembly AML and code to figure out these
> internals.
> 
I hear you :)

Afraid I'm not allowed to publish the full DYTC spec - but I make public
the bits that I can.

I don't have many hooks into the ideapad team as it's not in the Linux
plan - so I can't answer your questions with confidence. I am going to
ask the firmware team if they can confirm if ideapad is using the same
spec - it would make sense if they are.
Feel free to bug me off mailing list and I'll happily help out with any
debugging issues.

I'm also not allowed to confirm or deny future plans but my personal
hope is that the Linux project in Lenovo grows. Fingers crossed for the
future.

>>
>>   - Can we get the x86 portion done at the same time or does that end up
>> going to 5.13? I had been looking at the ideapad_laptop.c patch and have
>> some concerns there as Jiaxun's patch is essentially a duplicate of what
>> I implemented in thinkpad_acpi.c which doesn't seem to be ideal
>> (especially as there is a V6 version of DYTC coming out this year). I
>> haven't had time to look at code to consider better alternatives
>> though...
> 
> It may be worthy to share these code but I'm comfort to have this
> duplication as I'm
> unsure about the future of DYTC. Will DYTC for thinkpads always coherent
> with DYTC
> for ideapads?
I'll see if I can find out.

> 
> Thanks.
> 
> [1]: https://club.lenovo.com.cn/thread-5980431-1-1.html
> 
> - Jiaxun
> 
>>
>> Mark
> 
