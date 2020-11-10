Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8A12AD903
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 15:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgKJOln (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 09:41:43 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.113]:40599 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730059AbgKJOln (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 09:41:43 -0500
Received: from [100.112.7.7] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.us-east-1.aws.symcld.net id 9D/7F-01462-0A6AAAF5; Tue, 10 Nov 2020 14:41:36 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRWlGSWpSXmKPExsWS8eIhr+78Zav
  iDRY2GFm8nHCY0WL/dQmLroUGFgvvn2K1+PrtNrvFm+PTmSyW7+tntGjqbGKz+NwxmcVi9Z4X
  zBZnTl9ideD2mDRzBrPHzll32T1+bVvD4rF5hZbHvJOBHu/3XWXz2HK1ncXj8ya5AI4o1sy8p
  PyKBNaM6R1PmQo2s1Vcev+YtYGxhbWLkYtDSOA/o8S5ac/ZIZznjBINr1cxdzFycggLJEl8Xv
  +LpYuRnUNEQF9ifxlICbPAEmaJu8t2MELUn2KUmPnlATtIPZuAtsSWLb/YQGxeAVuJtpX/weI
  sAqoSU74/A4uLCoRLdNzYwQRRIyhxcuYTFhCbUyBQYt+/x4wgNrOAhcTM+eehbHGJW0/mM0HY
  8hLb384Bu00CyH79rh3KTpBY9vIO8wRGwVlIxs5CMmoWklGzkIxawMiyitEsqSgzPaMkNzEzR
  9fQwEDX0NBI11zX0MJYL7FKN1mvtFg3NbG4RNdQL7G8WK+4Mjc5J0UvL7VkEyMwGlMK2LfvYF
  z45oPeIUZJDiYlUd4/c1fFC/El5adUZiQWZ8QXleakFh9ilOHgUJLgTVwKlBMsSk1PrUjLzAE
  mBpi0BAePkghvB0iat7ggMbc4Mx0idYpRUUqcN3AJUEIAJJFRmgfXBktGlxhlpYR5GRkYGIR4
  ClKLcjNLUOVfMYpzMCoJ8yaAjOfJzCuBm/4KaDET0OIAxxUgi0sSEVJSDUwZhgz1v1ZEsc5Pi
  eWZL7Zz791j1jW+Gvaffn4/YHTinJF3ydQfrzY7z9odr1ZrGm95WTOnxcRN5d6m+kvX1iXszV
  7Nnlie1dVj9KtG29D5RF9M6eZ3geV8eVLlpwxVH9/U/L2CT/OvPmNo9MKUhwyvzmwKmVK+4eL
  WjthN6l+PFfXEPPlTx2ZjUjM/WMh1pVLbtdBWjQVipW5vD7o/UngsvjNdbfoqSQGPp5NvGehK
  3X/r//ro739sdtMY98/b6pL1ms2sN+ePYEaQK6vGb3+Gv6bxC/4/2fDm4TG2tXvfi9+vCmw8s
  GrrHJWrLjcvmSTIvlk2b9lrKY1KDfk//Tse6S59yHLjvXJ+SqTh+UQlluKMREMt5qLiRABnev
  S4wQMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-11.tower-416.messagelabs.com!1605019295!293079!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29394 invoked from network); 10 Nov 2020 14:41:35 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-11.tower-416.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Nov 2020 14:41:35 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 901013DC6869963E10A8;
        Tue, 10 Nov 2020 09:41:35 -0500 (EST)
Received: from localhost.localdomain (10.46.61.15) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 10 Nov
 2020 06:41:30 -0800
Subject: Re: [External] Re: [PATCH 3/3] platform/x86: thinkpad_acpi: Add
 platform profile support
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
 <20201110033124.3211-4-markpearson@lenovo.com>
 <CAHp75VePnNAmiOHKpLui3J_nh6_qVsbEGB4rjEAnFVhxkxbGsg@mail.gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <e823b5cd-d050-0748-ebee-0d26f7ebec4f@lenovo.com>
Date:   Tue, 10 Nov 2020 09:41:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VePnNAmiOHKpLui3J_nh6_qVsbEGB4rjEAnFVhxkxbGsg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.61.15]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On 10/11/2020 05:06, Andy Shevchenko wrote:
> On Tue, Nov 10, 2020 at 5:34 AM Mark Pearson <markpearson@lenovo.com> wrote:
>>
>> Add support to thinkpad_acpi for Lenovo platforms that have DYTC
>> version 5 support or newer to use the platform profile feature.
>>
>> This will allow users to determine and control the platform modes
>> between low-power, balanced operation and performance modes.
> 
> ...
> 
>> +#if defined(CONFIG_ACPI_PLATFORM_PROFILE)
>> +               platform_profile_unregister();
>> +#endif
>> +               dytc_available = false;
> 
>> +#if defined(CONFIG_ACPI_PLATFORM_PROFILE)
>> +                       dytc_profile_refresh();
>> +#endif
> 
> Better to use (e.g. test coverage) if (IS_BUILTIN()) / if (IS_ENABLE()) / etc.
> 
Thanks - I wasn't aware of those. I'll update

Mark
