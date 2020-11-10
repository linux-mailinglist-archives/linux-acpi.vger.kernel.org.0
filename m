Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80762AD84C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 15:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgKJOKS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 09:10:18 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.114]:22267 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730097AbgKJOKS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 09:10:18 -0500
Received: from [100.112.4.31] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.us-east-1.aws.symcld.net id 71/82-08584-24F9AAF5; Tue, 10 Nov 2020 14:10:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRWlGSWpSXmKPExsWSLveKTddp/qp
  4g4c/xS1eTjjMaLH/uoRF10IDi4X3T7FafP12m93izfHpTBbL9/UzWjR1NrFZfO6YzGKxes8L
  Zoszpy+xOnB7TJo5g9lj56y77B6/tq1h8di8Qstj3slAj/f7rrJ5bLnazuLxeZNcAEcUa2ZeU
  n5FAmvGkWm9jAUNXBXbL09mb2BcydHFyMUhJPCfUWLG7VWMEM5zRomlB9rZuxg5OYQFiiT2N+
  8Gstk5RAT0JfaXgZQwCyxhlri7bAdU/SlGiaOvvzCC1LMJaEts2fKLDcTmFbCVWNm1CizOIqA
  qsfF4IyuILSoQLtFxYwcTRI2gxMmZT1hAbE6BQIkNmzeD1TMLWEjMnH8eyhaXuPVkPhOELS+x
  /e0cZhBbAsh+/a4dyk6QWPbyDvMERsFZSMbOQjJqFpJRs5CMWsDIsorRLKkoMz2jJDcxM0fX0
  MBA19DQSNdM19DCWC+xSjdZr7RYNzWxuETXUC+xvFivuDI3OSdFLy+1ZBMjMBpTCti272Dc+/
  qD3iFGSQ4mJVHeP3NXxQvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4J0/DygnWJSanlqRlpkDTAw
  waQkOHiUR3vMgad7igsTc4sx0iNQpRkUpcd5mkJkCIImM0jy4NlgyusQoKyXMy8jAwCDEU5Ba
  lJtZgir/ilGcg1FJmHcxyHiezLwSuOmvgBYzAS0OcFwBsrgkESEl1cCUOzFs2anorAOTrZwyV
  TID+YodWPc9SDOQuuZb4Cjyib9qqkHwC57OqdN6j2SI504/ns0Ut0u+/1/F8gnnS59LGh3n25
  LRuWFhRO9+e84/IlrMIil7K/bo75z22O6GxtpZa2a/mrXzsMMFXgXHkJ/aZeHzuKOmXA+yn3H
  1vt7yLtnJfBMWbNPovekhvfS/9KmJOtEbP6kG9e+P+9YQN9VnOsujoJ0Xbu2I2n1kn+hp8Wd7
  XOur6gvmv0qMeaE9da9wvW9Myg/nur91ATGt627MU9GbKlqePrGXW++G5erDp1Tb53E8PTnTx
  fEdQ0/ab8a04GPV673ttx2KEFtvG1ZQwjGtzdZnX4barY8PfvQrsRRnJBpqMRcVJwIA4EX5x8
  EDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-7.tower-415.messagelabs.com!1605017407!179737!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12458 invoked from network); 10 Nov 2020 14:10:10 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-7.tower-415.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Nov 2020 14:10:10 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id F35E35A74565FCF42ED8;
        Tue, 10 Nov 2020 22:10:04 +0800 (CST)
Received: from localhost.localdomain (10.46.61.15) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 10 Nov
 2020 06:10:01 -0800
Subject: Re: [External] Re: [PATCH 1/3] Documentation: Add documentation for
 new platform_profile sysfs attribute
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
 <20201110033124.3211-2-markpearson@lenovo.com>
 <CAHp75VfeE06S5M_GTFo3nKPdMeUJY-aLYfFmsFy7E2zv1fRvZw@mail.gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <2fe40ba1-8f2d-de46-49df-b8fee19fff3e@lenovo.com>
Date:   Tue, 10 Nov 2020 09:09:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfeE06S5M_GTFo3nKPdMeUJY-aLYfFmsFy7E2zv1fRvZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.61.15]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Andy

On 10/11/2020 05:03, Andy Shevchenko wrote:
> On Tue, Nov 10, 2020 at 5:35 AM Mark Pearson <markpearson@lenovo.com> wrote:
>>
>> On modern systems the platform performance, temperature, fan and other
>> hardware related characteristics are often dynamically configurable. The
>> profile is often automatically adjusted to the load by somei
>> automatic-mechanism (which may very well live outside the kernel).
>>
>> These auto platform-adjustment mechanisms often can be configured with
>> one of several 'platform-profiles', with either a bias towards low-power
>> consumption or towards performance (and higher power consumption and
>> thermals).
>>
>> Introduce a new platform_profile sysfs API which offers a generic API for
>> selecting the performance-profile of these automatic-mechanisms.
> 
>>   .../ABI/testing/sysfs-platform_profile        | 66 +++++++++++++++++++
> 
> Is this in reST format?
> Mauro have been converting ABI to be reST compatible (at least).
> 
I'm assuming reST is "reStructured Text"? (it's a new one for me)

I'll have a look and check it's compatible and see if I can fix up 
anything missing. If you have any pointers to a document that has 
already been updated and is a good reference point that would be appreciated

Thanks
Mark
