Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292DF29B4B5
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 16:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789322AbgJ0PBy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 11:01:54 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.116]:43674 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1789270AbgJ0PBx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Oct 2020 11:01:53 -0400
Received: from [100.112.135.1] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-west-2.aws.symcld.net id 70/E8-42875-956389F5; Tue, 27 Oct 2020 15:01:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRWlGSWpSXmKPExsWS8eIhr66p2Yx
  4g9uzFS32X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RovLu+awWXzuPcJo0dTZBGR1TGax
  WL3nBbMDt8ekmTOYPXbOusvu8WvbGhaPzSu0POadDPR4v+8qm8fnTXIB7FGsmXlJ+RUJrBkLN
  mxlKTjCU9H/p421gfEvZxcjF4eQwH9GiZZvt1kgnBeMEnNvN7J3MbJzCAuUSBxM6mLk5BAR8J
  Y4vnUFWAkzSH3vlilsIAkhgS4mif2b6kFsNgFtiS1bfoHFeQVsJZ4deswCYrMIqEqsO/KVGcQ
  WFQiX6LixgwmiRlDi5MwnYDWcAnYSb7edZwexmQUsJGbOP88IYYtL3HoynwnClpdo3jobbI6E
  gILEncM32CHsBIllL+8wT2AUnIVk7Cwko2YhGTULyagFjCyrGC2SijLTM0pyEzNzdA0NDHQND
  Y10DY1NdA3NTPQSq3ST9EqLdctTi0t0jfQSy4v1iitzk3NS9PJSSzYxAqMwpaBtyQ7GXW8+6B
  1ilORgUhLlXb9rerwQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd4DJjPihQSLUtNTK9Iyc4AJASY
  twcGjJMK7DyTNW1yQmFucmQ6ROsWoKCXOq2UKlBAASWSU5sG1wZLQJUZZKWFeRgYGBiGegtSi
  3MwSVPlXjOIcjErCvJUg43ky80rgpr8CWswEtLitYgrI4pJEhJRUA1O+14vVawqXPjhWk7JlX
  eYOfbeUMnNe2RU+/gwHpx+tyl20/+IPMyvtlDifV2E2oQ351R/Xr8z58nzP2+ybj8w6f9zVnL
  PQqDXq33pfkRM7XmQbn1P/9euZ7wfPrN9Xbgdc2mj95EDQ1CtZiqwrdf3s9941VV3SYbrB4VN
  bzPkw+V0/viZEs99OfFJRJf58ldp67/wFc2MfO/tr/8la59V67+zXDanmLH/ez1Qp6clxvSZx
  V+Hp0q1Xsv4cPmr6NdW4NG3yv2tBQTkHXU7wp/tZNHgpiN41fbl/z6ngaZt/TuDdqJx52Lydd
  19nYHyQRpm4Bdffuxczb2a/ezPv7a9lXk+572yO3ukb/PEIb4mtEktxRqKhFnNRcSIABCslsr
  0DAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-26.tower-355.messagelabs.com!1603810868!1936!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22287 invoked from network); 27 Oct 2020 15:01:09 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-26.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Oct 2020 15:01:09 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 165E9F4B40D3F6AD8445;
        Tue, 27 Oct 2020 11:01:08 -0400 (EDT)
Received: from localhost.localdomain (10.46.59.124) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 27 Oct
 2020 08:01:06 -0700
Subject: Re: [External] Re: [PATCH] [RFC] Documentation: Add documentation for
 new platform_profile sysfs attribute
To:     Hans de Goede <hdegoede@redhat.com>,
        Elia Devito <eliadevito@gmail.com>
CC:     <dvhart@infradead.org>, <mgross@linux.intel.com>,
        <mario.limonciello@dell.com>, <hadess@hadess.net>,
        <bberg@redhat.com>, <linux-pm@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <markpearson@lenovo.com>
 <ef9b93a0-636f-9b96-9d5b-fee1e5738af7@lenovo.com>
 <1fbaf1fa-47c6-afe7-ca9e-41b3ad6a4556@redhat.com> <12633630.uLZWGnKmhe@pce>
 <1bddcede-5e12-6089-8920-26dd5f534b44@lenovo.com>
 <255af791-e456-7299-d355-fe4f3cea7d63@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <c40d0916-a61b-3376-fedd-de815f501827@lenovo.com>
Date:   Tue, 27 Oct 2020 11:01:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <255af791-e456-7299-d355-fe4f3cea7d63@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.46.59.124]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 27/10/2020 09:41, Hans de Goede wrote:
> Hi Mark,
> 
> On 10/27/20 1:28 PM, Mark Pearson wrote:
>> Hi Elia
>>
>> On 27/10/2020 05:19, Elia Devito wrote:
>>> Hi to all,
>>>
>>> In data martedì 27 ottobre 2020 08:54:44 CET, Hans de Goede ha scritto:
<snip>
>>>
>>> This look good,
>>> only thing is that hp-wmi driver need a cool profile (Emphasises the computer
>>> cool to touch), if you can add it would be perfect.
>>>
>>> Regards
>>> Elia
>>>
>>>
>>>
>> Is low-power is different to cool? I figured low-power was going to be cool so combined them.
>> I could call it low-power-cool if that helps? It seems a little clunky but not too bad. I'm sure the user space folks can put sunglasses on it or something ;)
> 
> IIRC we already had this discussion, cool means cool-to-touch, so could be done by
> e.g. extra aggressive ramping up of the fans, so this is not necessarily the same
> as low-power.
> 
> Yes this is all somewhat confusing. Luckily (for us kernel folks) we have already
> sorta decided to just use the profile-names from the vendors more or less as is and
> leave figuring this out further to userspace.
> 
> The reason to use the enum + try to have a fixed list of choices is to try and
> limit the proliferation of profile-names to keep things somewhat manageable.
> 
> But as I discussed previously with Elia (*) we really need all 3 of low-power
> cool and quiet.
> 
> Regards,
> 
> Hans
> 
> 
> 
> *) I was coming at this discussion from the same angle you (Mark) are
> 
OK, I can add a cool option.

I'll get that out later today (unless Elia corrects me :))

Thanks all
Mark
