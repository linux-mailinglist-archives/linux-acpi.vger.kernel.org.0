Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7A02EC7F9
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 03:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbhAGCO1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jan 2021 21:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAGCO0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2021 21:14:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3463BC0612EF;
        Wed,  6 Jan 2021 18:13:46 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d26so4095997wrb.12;
        Wed, 06 Jan 2021 18:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bJDw9JDYbmOYtzTxqCVs0wTxFfjfaWDxhSvBrZylkBw=;
        b=VUH1J2ZcGu38nWhZo9cmG7Sfq824N015IUNJy5FdqcMPS3HA+508M6evzsWAblY8oP
         qPmYVMnQGxH0+W+Y7oSCd4+dtXyPOUOxXayQf3iqNfdOnU1ivrk39Ny6zU5gBXxcgA7O
         ODK729Xa9OboVkhYrW/mrkdcmBoUKaSFeM2OsR95uDJpFtTrnAsY/Lo0rKrt61JTttLS
         BLOk3r7pWQJ0HbOY09Qn+zGSUiAoeb6I1blKRZFhduafh1drVT72anOLjIAGsZxUCejd
         XeMBhrBza7VTAmB8pdNsI9OOQTzKelzAVM2nI+jt4SsyUT/j5m07qOfcIkOVc+dNIDXc
         GhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bJDw9JDYbmOYtzTxqCVs0wTxFfjfaWDxhSvBrZylkBw=;
        b=c6xSuRMRXLXKoWjxSvbGVES1vyHtypqyFOBD2vXqgor9D+t/TFZHj6RiRg3OnU7Z7W
         pi+on22C+BTk8LtopMk54Xo/opMR02fUNrNNpjV7yyW13V4dZD9vRG53ymCzV5MoC2WW
         tiFhbIwoDHvQJEHPi7QSC6v+luMMrzZVCBwatIoKS4q+1fS4DLvSs5pVAbLR7DDFD7K8
         TL8cO2iIa7+rkSZKpwbmz3pUOX698TLOHjMoatUML+Jqkh28Y6tOPsgcn0X0YLbqDJJk
         s/6m3SM0FGv9QXzMVo8dXr9Wqws+TYsJtJ84768BMvMkfY/S3QnWE9rDWiab2B41P1iR
         PlNA==
X-Gm-Message-State: AOAM531Lz8EnaIIqWk+GWOU8jow2JZvGdiUu0QaLRIakKNO/3rLwkcTJ
        KKpr2Xt4dPXLeO3WrGUrQKWKO7MUIH8F5Vmk
X-Google-Smtp-Source: ABdhPJxmvVq4g5gSzyRvr97AmGj8vLy4drCgPYmoKISNVC12hT94oR+GEI5AxCUlrTw+rzmqRtGoww==
X-Received: by 2002:adf:c449:: with SMTP id a9mr6679455wrg.281.1609985624443;
        Wed, 06 Jan 2021 18:13:44 -0800 (PST)
Received: from [10.19.0.3] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id i16sm5403605wrx.89.2021.01.06.18.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 18:13:43 -0800 (PST)
Subject: Re: [PATCH v3 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201221183959.1186143-1-luzmaximilian@gmail.com>
 <a47f9739-0d6f-4e1d-c436-3ec272144d87@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <f2d63f35-e4cc-e365-1b81-a7d1f35f0cd3@gmail.com>
Date:   Thu, 7 Jan 2021 03:13:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a47f9739-0d6f-4e1d-c436-3ec272144d87@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 1/7/21 12:40 AM, Hans de Goede wrote:
> Hi,
> 
> On 12/21/20 7:39 PM, Maximilian Luz wrote:
>> Hello,
>>
>> Here is version three of the Surface System Aggregator Module (SAM/SSAM)
>> driver series, adding initial support for the embedded controller on 5th
>> and later generation Microsoft Surface devices. Initial support includes
>> the ACPI interface to the controller, via which battery and thermal
>> information is provided on some of these devices.
>>
>> The first version and cover letter detailing what this series is about
>> can be found at
>>
>>    https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
>>
>> the previous version (v2) at
>>
>>    https://lore.kernel.org/platform-driver-x86/20201203212640.663931-1-luzmaximilian@gmail.com/
>>
>> This patch-set can also be found at the following repository and
>> reference, if you prefer to look at a kernel tree instead of these
>> emails:
>>
>>    https://github.com/linux-surface/kernel tags/s/surface-aggregator/v3
>>
>> Thank you all for the feedback to and reviews of the previous versions,
>> I hope I have addressed all comments.
> 
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> This has been applied on top of:
> "platform/surface: SURFACE_PLATFORMS should depend on ACPI"
> 
> As requested. Since my review-hans branch has been fast-forwarded to 5.11-rc1
> there where some conflicts:
> 
> 6/9 "platform/surface: aggregator: Add dedicated bus and device type" had conflicts in:
> scripts/mod/devicetable-offsets.c
> scripts/mod/file2alias.c
> 
> 8/9 "platform/surface: Add Surface Aggregator user-space interface" had a conflict in:
> Documentation/userspace-api/ioctl/ioctl-number.rst
> 
> This conflict was caused by the addition of documentation of the sgx ioctls, these use
> 0xA4 as "Code" byte (shared with uapi/linux/tee.h), so the 0xA5 code for the sam cdev
> ioctl is still unique.
> 
> I'm pretty sure that I've properly resolved the conflicts, but please double-check.

Everything looks good to me. I'll compile your branch and run some tests
just in case, but I really don't expect there to be any problems. In the
unlikely event that I find anything, I'll submit a patch.

> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

Thank you (and all others involved in reviewing this).

Regards,
Max
  
> Regards,
> 
> Hans
> 
> 
> 
> 
>> Note: In v3, I have dropped the explicit dependency of the core module
>> and driver on CONFIG_ACPI due to the incoming
>>
>>    [PATCH] platform/surface: SURFACE_PLATFORMS should depend on ACPI
>>
>> Thus, this series depends on said patch. This patch can be found at
>>
>>    https://www.spinics.net/lists/platform-driver-x86/msg23929.html
>>
>>
>> Changes in v1 (from RFC, overview):
>>   - move to platform/surface
>>   - add copyright lines
>>   - change SPDX identifier to GPL-2.0+ (was GPL-2.0-or-later)
>>   - change user-space interface from debugfs to misc-device
>>   - address issues in user-space interface
>>   - fix typos in commit messages and documentation
>>   - fix some bugs, address other issues
>>
>> Changes in v2 (overview):
>>   - simplify some code, mostly with regards to concurrency
>>   - add architectural overview to documentation
>>   - improve comments for documentation
>>   - use printk specifier for hex prefix instead of hard-coding it
>>   - spell check comments and strings, fix typos
>>   - unify comment style
>>   - run checkpatch --strict, fix these and other style issues
>>
>> Changes in v3 (overview):
>>   - remove explicit dependency on ACPI as this is going to be covered by
>>     CONFIG_SURFACE_PLATFORMS
>>   - simplify locking requirements
>>   - help enforce locking requirements via lockdep assertions
>>   - fix false-positive lockdep warning
>>   - warn on event enablement reference counter exhaustion
>>   - don't warn about unhandled event if event handling failed
>>   - validate flags on request initialization
>>   - improve documentation/add comments
>>   - replace 'iff' with 'if' in documentation and comments
>>
>> Changes regarding specific patches (and more details) can be found on
>> the individual patch.
>>
>>
>> Maximilian Luz (9):
>>    platform/surface: Add Surface Aggregator subsystem
>>    platform/surface: aggregator: Add control packet allocation caching
>>    platform/surface: aggregator: Add event item allocation caching
>>    platform/surface: aggregator: Add trace points
>>    platform/surface: aggregator: Add error injection capabilities
>>    platform/surface: aggregator: Add dedicated bus and device type
>>    docs: driver-api: Add Surface Aggregator subsystem documentation
>>    platform/surface: Add Surface Aggregator user-space interface
>>    platform/surface: Add Surface ACPI Notify driver
>>
>>   Documentation/driver-api/index.rst            |    1 +
>>   .../surface_aggregator/client-api.rst         |   38 +
>>   .../driver-api/surface_aggregator/client.rst  |  393 +++
>>   .../surface_aggregator/clients/cdev.rst       |   87 +
>>   .../surface_aggregator/clients/index.rst      |   21 +
>>   .../surface_aggregator/clients/san.rst        |   44 +
>>   .../driver-api/surface_aggregator/index.rst   |   21 +
>>   .../surface_aggregator/internal-api.rst       |   67 +
>>   .../surface_aggregator/internal.rst           |  577 ++++
>>   .../surface_aggregator/overview.rst           |   77 +
>>   .../driver-api/surface_aggregator/ssh.rst     |  344 +++
>>   .../userspace-api/ioctl/ioctl-number.rst      |    2 +
>>   MAINTAINERS                                   |   13 +
>>   drivers/platform/surface/Kconfig              |   38 +
>>   drivers/platform/surface/Makefile             |    3 +
>>   drivers/platform/surface/aggregator/Kconfig   |   68 +
>>   drivers/platform/surface/aggregator/Makefile  |   17 +
>>   drivers/platform/surface/aggregator/bus.c     |  415 +++
>>   drivers/platform/surface/aggregator/bus.h     |   27 +
>>   .../platform/surface/aggregator/controller.c  | 2579 +++++++++++++++++
>>   .../platform/surface/aggregator/controller.h  |  285 ++
>>   drivers/platform/surface/aggregator/core.c    |  839 ++++++
>>   .../platform/surface/aggregator/ssh_msgb.h    |  205 ++
>>   .../surface/aggregator/ssh_packet_layer.c     | 2057 +++++++++++++
>>   .../surface/aggregator/ssh_packet_layer.h     |  190 ++
>>   .../platform/surface/aggregator/ssh_parser.c  |  228 ++
>>   .../platform/surface/aggregator/ssh_parser.h  |  154 +
>>   .../surface/aggregator/ssh_request_layer.c    | 1264 ++++++++
>>   .../surface/aggregator/ssh_request_layer.h    |  143 +
>>   drivers/platform/surface/aggregator/trace.h   |  632 ++++
>>   .../platform/surface/surface_acpi_notify.c    |  886 ++++++
>>   .../surface/surface_aggregator_cdev.c         |  303 ++
>>   include/linux/mod_devicetable.h               |   18 +
>>   include/linux/surface_acpi_notify.h           |   39 +
>>   include/linux/surface_aggregator/controller.h |  824 ++++++
>>   include/linux/surface_aggregator/device.h     |  423 +++
>>   include/linux/surface_aggregator/serial_hub.h |  672 +++++
>>   include/uapi/linux/surface_aggregator/cdev.h  |   78 +
>>   scripts/mod/devicetable-offsets.c             |    8 +
>>   scripts/mod/file2alias.c                      |   23 +
>>   40 files changed, 14103 insertions(+)
>>   create mode 100644 Documentation/driver-api/surface_aggregator/client-api.rst
>>   create mode 100644 Documentation/driver-api/surface_aggregator/client.rst
>>   create mode 100644 Documentation/driver-api/surface_aggregator/clients/cdev.rst
>>   create mode 100644 Documentation/driver-api/surface_aggregator/clients/index.rst
>>   create mode 100644 Documentation/driver-api/surface_aggregator/clients/san.rst
>>   create mode 100644 Documentation/driver-api/surface_aggregator/index.rst
>>   create mode 100644 Documentation/driver-api/surface_aggregator/internal-api.rst
>>   create mode 100644 Documentation/driver-api/surface_aggregator/internal.rst
>>   create mode 100644 Documentation/driver-api/surface_aggregator/overview.rst
>>   create mode 100644 Documentation/driver-api/surface_aggregator/ssh.rst
>>   create mode 100644 drivers/platform/surface/aggregator/Kconfig
>>   create mode 100644 drivers/platform/surface/aggregator/Makefile
>>   create mode 100644 drivers/platform/surface/aggregator/bus.c
>>   create mode 100644 drivers/platform/surface/aggregator/bus.h
>>   create mode 100644 drivers/platform/surface/aggregator/controller.c
>>   create mode 100644 drivers/platform/surface/aggregator/controller.h
>>   create mode 100644 drivers/platform/surface/aggregator/core.c
>>   create mode 100644 drivers/platform/surface/aggregator/ssh_msgb.h
>>   create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.c
>>   create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.h
>>   create mode 100644 drivers/platform/surface/aggregator/ssh_parser.c
>>   create mode 100644 drivers/platform/surface/aggregator/ssh_parser.h
>>   create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.c
>>   create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.h
>>   create mode 100644 drivers/platform/surface/aggregator/trace.h
>>   create mode 100644 drivers/platform/surface/surface_acpi_notify.c
>>   create mode 100644 drivers/platform/surface/surface_aggregator_cdev.c
>>   create mode 100644 include/linux/surface_acpi_notify.h
>>   create mode 100644 include/linux/surface_aggregator/controller.h
>>   create mode 100644 include/linux/surface_aggregator/device.h
>>   create mode 100644 include/linux/surface_aggregator/serial_hub.h
>>   create mode 100644 include/uapi/linux/surface_aggregator/cdev.h
>>
> 
