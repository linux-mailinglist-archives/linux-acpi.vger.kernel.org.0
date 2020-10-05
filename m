Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F965283DB6
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgJERrC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 13:47:02 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.5]:19570 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727344AbgJERrC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 13:47:02 -0400
Received: from [100.112.130.136] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.us-west-2.aws.symcld.net id 47/26-10948-E0C5B7F5; Mon, 05 Oct 2020 17:46:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRWlGSWpSXmKPExsWS8eIhjy5vTHW
  8waFH+haTZvxntth/XcKia6GBxcL7p1gtvn67zW7x5vh0Jovl+/oZLS7vmsNm8bn3CKNFU2cT
  kNUxmcVi9Z4XzBZrv8xjc+D1mDRzBrPHzll32T1+bVvD4rF5hZbHvJOBHj1tm5g83u+7yubxe
  ZNcAEcUa2ZeUn5FAmvGrln9zAUL+Cu2rDjA1MC4jaeLkYtDSOA/o8SG6V+ZIJznjBLzX91h7m
  Lk4BAWyJaY9lKui5GTQ0SgWGLvpCvsIDXMAitZJC71f4Rq6GGRaJnayQpSxSagLbFlyy82kGZ
  eAVuJic+NQUwWARWJ1vlcIBWiAhESa45PZAKxeQUEJU7OfMICYnMKxEp0fTgFNoVZwEJi5vzz
  jBC2uMStJ/OZIGx5ie1v5zCD2BICChKz2neyQ9gJEste3mGewCg4C8nYWUhGzUIyahaSUQsYW
  VYxmicVZaZnlOQmZuboGhoY6BoaGukaGlnqmhroJVbpJuqVFuuWpxaX6BrpJZYX6xVX5ibnpO
  jlpZZsYgRGaEpBo9EOxr+vP+gdYpTkYFIS5XUOrY4X4kvKT6nMSCzOiC8qzUktPsSowcEhcOX
  gkdmMUix5+XmpShK8eVFAdYJFqempFWmZOcAkAlMqwcGjJMJbC5LmLS5IzC3OTIdInWJUlBLn
  fQmSEABJZJTmwbXBEtclRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8eiBTeDLzSuCmvwJaz
  AS0+PbRCpDFJYkIKakGpgalxQuCU/tfWapdjLywiz1n/hOmbXXru/ziI94wq2yb65fAsVrW5a
  pa9LJ3Rc9UXdwuTP7ySTXumk9r4/szXPNnxRc//r6JxZ2FSbG1+eALMwN2ng2Fl69er2J1f1f
  mamIt3l5hrnorf33j6+YVfhYeIrn7OJpKYv6wzHXmiarwMGBu0+ZuWiytqeR7YbOseN32gDkL
  Y1o8V0hy2ytWcUx7I3D6l1jEzh8lMUu7F3vrVW3f2KGXYDM1JOvO7aMqTt/yVJnK+IMn9jGZv
  f5680LjkkpjpftBk3pm12us6cvW4J3W6L83dPIs1h/RUi0RQt/XX2ZrfyyYqbCn/0iYvVHBod
  mKn8S9zaS9fZRYijMSDbWYi4oTAQ5trVfXAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-21.tower-335.messagelabs.com!1601920012!3362!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13372 invoked from network); 5 Oct 2020 17:46:53 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-21.tower-335.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Oct 2020 17:46:53 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 3E43A34616AD7D75D0E8;
        Mon,  5 Oct 2020 13:46:52 -0400 (EDT)
Received: from localhost.localdomain (10.46.54.144) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 5 Oct 2020
 10:46:49 -0700
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
 <91a9bb74-49e7-0a8d-cbc1-3f1907293fa4@lenovo.com>
 <DM6PR19MB263622BBE4B699A0AA49977DFA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <26662fd8-1bd8-94b9-2fa6-6b1c1c96481d@lenovo.com>
Date:   Mon, 5 Oct 2020 13:46:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB263622BBE4B699A0AA49977DFA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.54.144]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2020-10-05 12:56 p.m., Limonciello, Mario wrote:
>>>
>>> When implemented for the two vendors mentioned here, it would be using a
>>> proprietary "firmware API" implemented by those two vendors.  For example
>> write
>>> arguments (0x1, 0x2) to ACPI-WMI method WMFT and it will cause firmware to
>> coordinate
>>> using undisclosed protocol to affect the platform changes desirable.
>>>
>>> This is different in my mind from "kernel writes to a specific register" to
>> set
>>> power properties of a specific device.
>>>
>>
>> Just curious on this point - isn't that (mostly) what all hardware does?
>> You write to it and the device does "stuff" to achieve the required
>> effect. Yes this is in proprietary firmware, but from my experience with
>> hardware devices that's not uncommon these days anyway.
>>
> 
> Yes I agree.  Even "register" writes to a device are actually an API and
> something in the hardware monitors those registers and does something as a
> result.
> 
>> Let me know if I'm misunderstanding something here. I couldn't see the
>> difference between a register written to via ACPI and one written to via
>> some other protocol (SMBUS? or whatever)
>>
>> Mark
>>
> 
> The reason I'm calling out a distinction here is that "platform" and "device"
> can cover a lot more things.  In this case it's an API provided by the platform's
> firmware, not an individual device's firmware.  So you can't actually guarantee
> what the platform's firmware did.  It could have sent any number of sideband
> commands to devices that it controls.  The "platform" could have potentially
> told the GPU to turn up its fans, or lower it's clock as a result of this, but you
> can't possibly know.
> 
> However if we go the GPU example alone, it's a specific single device you're
> controlling.  You put the GPU into the characterization that you expected and it
> operates that way.
> 
Got it - fair enough :) Thanks for the explain.
Thanks
Mark
