Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002D02C4898
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 20:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgKYTlU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 14:41:20 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.3]:21381 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729696AbgKYTlU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Nov 2020 14:41:20 -0500
Received: from [100.112.3.43] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-east-1.aws.symcld.net id 36/68-29643-D53BEBF5; Wed, 25 Nov 2020 19:41:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRWlGSWpSXmKPExsWSLveKXTd2875
  4g+a34hb7r0tYdC00sFh4/xSrxddvt9kt3hyfzmSxfF8/o0VTZxObxeeOySwWq/e8YLZY+2Ue
  m8WZ05dYHbg9Js2cweyxc9Zddo9f29aweGxeoeUx72SgR0/bJiaP9/uusnlsudrO4vF5k1wAZ
  xRrZl5SfkUCa0bLSe+CXt6Kvb17mRoYj3F1MXJxCAn8Z5Q4Ofs5I4TzglFi1dK/zF2MnBzCAj
  ESP/ZOZgFJiAh0Mkp8vbyFHcRhFljDLDHhWxsTRMsPJon294/AWtgEtCW2bPnFBmLzCthKzN7
  YygRiswioSlz42QcWFxUIl1i/ZCUjRI2gxMmZT1hAbE4BO4nlyzaD1TALWEjMnH+eEcIWl7j1
  ZD4ThC0v0bx1NtAuDg4JAQWJ1xM8QcISAgkSy17eYZ7AKDgLydRZSCbNQjJpFpJJCxhZVjGaJ
  hVlpmeU5CZm5ugaGhjoGhoa6RrpGlvqJVbpJumVFuumJhaX6BrqJZYX6xVX5ibnpOjlpZZsYg
  TGZUoBk/oOxsuvP+gdYpTkYFIS5W2fuS9eiC8pP6UyI7E4I76oNCe1+BCjDAeHkgTvlY1AOcG
  i1PTUirTMHGCKgElLcPAoifD2bQJK8xYXJOYWZ6ZDpE4xKkqJ8waAJARAEhmleXBtsLR0iVFW
  SpiXkYGBQYinILUoN7MEVf4VozgHo5IwbxHIFJ7MvBK46a+AFjMBLZ7OuQdkcUkiQkqqgckzf
  ZdKjMyxCVq6ia9s3k78c7bwo9HNKo5JXxc5/K3l6NO90hld/D/0yivFDxUHPHoUchtr8p99e1
  n+UCFouqvvnMDe6T+fvj7zejJv5yLD5/9qOqcFHfr4kvnLnd8LNRYJqpyePlP90O2X9evWRt+
  9Z5rsuXxdRcSLg9aV/PLT/kRM2lD2rb3R0CwxeanYpSvzcqt/eO267uFRFH37fFxIrdaROPXz
  r9lUTrxUTdgaOlfVn2/x7OnqCrY/rA42r1H4defN5HLFtvIDLOHTTV7Ke3/aHLY0cHf/UnuuF
  J1zW3QV0/W/djxdaeHu5NL40SSv+tfVRoVr+7MjWpZOn8lrkLui+buyf0ZEtK66+l8lluKMRE
  Mt5qLiRAC1svg2xgMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-5.tower-396.messagelabs.com!1606333275!1195891!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20935 invoked from network); 25 Nov 2020 19:41:17 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-5.tower-396.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Nov 2020 19:41:17 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 62399DDFE75BB47CDDE2;
        Thu, 26 Nov 2020 03:41:12 +0800 (CST)
Received: from localhost.localdomain (10.38.110.35) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 25 Nov
 2020 11:41:09 -0800
Subject: Re: [External] Re: [PATCH v3] ACPI: platform-profile: Add platform
 profile support
To:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201115004402.342838-1-markpearson@lenovo.com>
 <nRyY5CKaU6WrkbMiM25gTT_bJlrQjTY_UCcQkj8ty-2mPEMVZd4BB9KwrRp7z4GaE3TTOFCXuXnt0_7J_Tj50syusBxTmS5yNZAvYX02X74=@protonmail.com>
 <761671b3-ad26-230b-e709-05ce3bd69498@redhat.com>
 <27a41e3d678f9d7fc889a3a77df87f9ed408887d.camel@hadess.net>
 <92a564fa-686f-455d-a0cb-962d4d87a8c7@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <4e82d54f-33c2-e880-c5f8-beb9d3460cdb@lenovo.com>
Date:   Wed, 25 Nov 2020 14:41:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <92a564fa-686f-455d-a0cb-962d4d87a8c7@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.110.35]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 25/11/2020 11:42, Hans de Goede wrote:
> Hi,
> 
> On 11/24/20 4:30 PM, Bastien Nocera wrote:
>> On Sat, 2020-11-21 at 15:27 +0100, Hans de Goede wrote:
>>> Hi,
>>> On 11/20/20 8:50 PM, Barnabás Pőcze wrote:
>>>> Hi
>>>> 2020. november 15., vasárnap 1:44 keltezéssel, Mark Pearson
>>>> írta:
>>>> 
>>> Bastien, what do you think about Barnabás' suggestion to always
>>> have the files present and use poll (POLL_PRI) on it to see when
>>> it changes, listing maybe "none" as available profiles when there
>>> is no provider?
>> 
>> Whether the file exists or doesn't, we have ways to monitor it 
>> appearing or disappearing. I can monitor the directory with inotify
>> to see the file appearing or disappearing, or I can monitor the
>> file with inotify to see whether it changes.
> 
> Ok, do you have a preference either way? I personally think having
> the file only appear if its functional is a bit cleaner. So if it
> does not matter much for userspace either way then I suggest we go
> that route.
> 
My (limited) vote is having the file appear when the profile is loaded 
seems nicer (and to disappear if the profile is unloaded). No profile, 
no interface just seems elegant.

I pretty much have v4 of the patches ready to go (I wanted to rebase on 
the update for the palm sensor and finished that today). I'm happy to 
hold off on them until we're ready if that helps. Bastien - let me know 
if it would be useful to have a version to test against to see what will 
work best for you, or if you need something different. Definitely want 
to make sure user space gets the best option as my understanding is 
changing this later becomes a pain :)

Thanks
Mark
