Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A2283CC0
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgJEQsO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 12:48:14 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.115]:44786 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726772AbgJEQsO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 12:48:14 -0400
Received: from [100.112.4.31] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.us-east-1.aws.symcld.net id 4C/B1-22503-B4E4B7F5; Mon, 05 Oct 2020 16:48:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRWlGSWpSXmKPExsWSLveKTdfbrzr
  e4MlebYtJM/4zW+y/LmHRtdDAYuH9U6wWX7/dZrd4c3w6k8Xyff2MFpd3zWGz+Nx7hNGiqbMJ
  yOqYzGKxes8LZou1X+axOfB6TJo5g9lj56y77B6/tq1h8di8Qstj3slAj562TUwe7/ddZfP4v
  EkugCOKNTMvKb8igTXjy5pV7AWXOCtmz/jO0sD4ib2LkYtDSOA/o8TDi92sEM5zRolPL1czdT
  FycAgLZEtMeynXxcjJISJQLLF30hWwBmaBlSwSl/o/MkE0tDNLbGiaww5SxSagLbFlyy82EJt
  XwFai894aVhCbRUBFYsK3b4wgtqhAhMSa4xOZIGoEJU7OfMICYnMKxEr09R8Fq2EWsJCYOf88
  lC0ucevJfCYIW15i+9s5zCC2hICCxKz2newQdoLEspd3mCcwCs5CMnYWklGzkIyahWTUAkaWV
  YymSUWZ6RkluYmZObqGBga6hoZGuma6ZhZ6iVW6yXqlxbqpicUluoZ6ieXFesWVuck5KXp5qS
  WbGIERmlLA5rKDccmbD3qHGCU5mJREebV8quOF+JLyUyozEosz4otKc1KLDzFqcHAIXDl4ZDa
  jFEtefl6qkgTvVJA6waLU9NSKtMwcYBKBKZXg4FES4a0DSfMWFyTmFmemQ6ROMSpKifMeBUkI
  gCQySvPg2mCJ6xKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd633kBTeDLzSuCmvwJazAS0+
  PbRCpDFJYkIKakGpn25tw8sXFR2KkDBVnDzFf7Fkz3U9yVPfLnhp7lPk1+K3CvGtgelKV5izK
  n2Xhv+X6vuv5JUk+rqxbfsmdvdcxN6LD4q6h47O6M3OemNzRSvDKVYXdY7KTYKF/ar7L9i21S
  yOud055ZF8eam215m7VvzRW/PkfM23VeldT4frJp9ruzpZE6D6t986w+X8ISr5Pr/jnkz+eK9
  uc//XPvE8mflixBL9mzb5SfKhGU97EvL53ywuXNpQk3wB8HJTu5VLkxH1zkYzq9htjZKj72lN
  /H4QY9jNjuWs59yZRWZ6idYqXB2CXuDG0tRR/vZt3YxAV7aV9OWmtnX8qtue5086Y/08w9nHp
  w8a7I2+v21NUosxRmJhlrMRcWJAKLfq7/XAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-54.tower-406.messagelabs.com!1601916489!1091018!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22615 invoked from network); 5 Oct 2020 16:48:11 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-54.tower-406.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Oct 2020 16:48:11 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id A167F9EC14C539EDC414;
        Tue,  6 Oct 2020 00:48:06 +0800 (CST)
Received: from localhost.localdomain (10.46.54.144) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 5 Oct 2020
 09:47:58 -0700
Subject: Re: [External] RE: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201003131938.9426-1-hdegoede@redhat.com>
 <20201003131938.9426-2-hdegoede@redhat.com>
 <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <Mz2G7glm3yMTniKA6SHM011dDkTFF4_otICrMQfVLheopX8JMGSupPleyjyK8OY0tyUazu09nX7XhleBVdl4ozTCWXCPGyvV58Qc-UUTvig=@protonmail.com>
 <DM6PR19MB26369E7468931E63B69A0604FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <91a9bb74-49e7-0a8d-cbc1-3f1907293fa4@lenovo.com>
Date:   Mon, 5 Oct 2020 12:47:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB26369E7468931E63B69A0604FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.54.144]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2020-10-05 12:11 p.m., Limonciello, Mario wrote:
>>
>> Excuse my ignorance, but I don't really see why this interface would be tied
>> to
>> ACPI devices? Why is it not possible to write a driver that implements this
>> interface
>> and directly modifies device registers? Am I missing something obvious here?
>>
> 
> When implemented for the two vendors mentioned here, it would be using a
> proprietary "firmware API" implemented by those two vendors.  For example write
> arguments (0x1, 0x2) to ACPI-WMI method WMFT and it will cause firmware to coordinate
> using undisclosed protocol to affect the platform changes desirable.
> 
> This is different in my mind from "kernel writes to a specific register" to set
> power properties of a specific device.
> 

Just curious on this point - isn't that (mostly) what all hardware does? 
You write to it and the device does "stuff" to achieve the required 
effect. Yes this is in proprietary firmware, but from my experience with 
hardware devices that's not uncommon these days anyway.

Let me know if I'm misunderstanding something here. I couldn't see the 
difference between a register written to via ACPI and one written to via 
some other protocol (SMBUS? or whatever)

Mark


