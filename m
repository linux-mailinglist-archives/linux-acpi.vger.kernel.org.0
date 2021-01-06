Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE12EC703
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 00:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbhAFXm3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jan 2021 18:42:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbhAFXm3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2021 18:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609976461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gg1abwP+BqeCY//k62aX3KXyaRI5IScydAPs2iM5zX8=;
        b=DwxC2fpZD2T05sOMvqbsGOSwnFYMMhUQHX9GsUAwlLTzNR/W0PNVxG69mHENNrEmvm9WrN
        GxFT0mCeNdDpiyxrRR1CmM3qoCMPh7/p8pI/BnFSNlgL/tvygZWFexlORGwa6va6f2HHwt
        +Q9U9zfvkCE8PCeE7oKnpE/ucWmL/yI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-AGvAhT4SN0ujC_Pi6ESxOw-1; Wed, 06 Jan 2021 18:40:59 -0500
X-MC-Unique: AGvAhT4SN0ujC_Pi6ESxOw-1
Received: by mail-ed1-f71.google.com with SMTP id x13so2517975edi.7
        for <linux-acpi@vger.kernel.org>; Wed, 06 Jan 2021 15:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gg1abwP+BqeCY//k62aX3KXyaRI5IScydAPs2iM5zX8=;
        b=dbA/yEHDwedKv8Ccp1l4au+QVzqaWaVa0INQXUJSTDTcdjE0GHAbxCZlGjIrRx94OB
         DhSsdAxMS3ppPmUwHKfXl8TV7xfu1PfZEn/UbY6BTlME1/NOqUH7Ek21pEYHGEluPy0O
         xu99c1UEA7VJ7zueAfXui6+ZbKhvyJyFGJimYYPES5LggGQZTCEeoIXXIx076QYuAEAa
         VpRzDs/HrOo16/4KQCG4K+wf6FntxivJeuBJh2OHstWTYdnzhZk5MNxBLGkjdffDRLtp
         uQmtYG6caR8xc6h7dsZemoHoNHq7i6mfDlCcVELTZsFc7S2du90IZWtjwXb4Ca18e5UO
         HHPQ==
X-Gm-Message-State: AOAM530dX1kmeApDbbpckUsPqAl7iMeYr9vVDkXmORiq8ToFUKKnL4lZ
        N1oeBSUX4f10p/UfjdOMgcYhotgNU8mcVq0jmQZu67rIPTDj9Kf6abraIFKqgFGQ4XO0xlDrRsw
        +7WbSX0ZI6mUGkDbkYppMcQ==
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr4492492ejd.374.1609976457902;
        Wed, 06 Jan 2021 15:40:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2qqa4NVTN8YKqNbKoZ88bAEZVXKvFTJDmjmRqxRyBEdOQ49LBm88dohdusRjKj+Cjy/ppIQ==
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr4492475ejd.374.1609976457686;
        Wed, 06 Jan 2021 15:40:57 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id be6sm1960700edb.29.2021.01.06.15.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 15:40:56 -0800 (PST)
Subject: Re: [PATCH v3 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a47f9739-0d6f-4e1d-c436-3ec272144d87@redhat.com>
Date:   Thu, 7 Jan 2021 00:40:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201221183959.1186143-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/21/20 7:39 PM, Maximilian Luz wrote:
> Hello,
> 
> Here is version three of the Surface System Aggregator Module (SAM/SSAM)
> driver series, adding initial support for the embedded controller on 5th
> and later generation Microsoft Surface devices. Initial support includes
> the ACPI interface to the controller, via which battery and thermal
> information is provided on some of these devices.
> 
> The first version and cover letter detailing what this series is about
> can be found at
> 
>   https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
> 
> the previous version (v2) at
> 
>   https://lore.kernel.org/platform-driver-x86/20201203212640.663931-1-luzmaximilian@gmail.com/
> 
> This patch-set can also be found at the following repository and
> reference, if you prefer to look at a kernel tree instead of these
> emails:
> 
>   https://github.com/linux-surface/kernel tags/s/surface-aggregator/v3
> 
> Thank you all for the feedback to and reviews of the previous versions,
> I hope I have addressed all comments.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

This has been applied on top of:
"platform/surface: SURFACE_PLATFORMS should depend on ACPI"

As requested. Since my review-hans branch has been fast-forwarded to 5.11-rc1
there where some conflicts:

6/9 "platform/surface: aggregator: Add dedicated bus and device type" had conflicts in:
scripts/mod/devicetable-offsets.c
scripts/mod/file2alias.c

8/9 "platform/surface: Add Surface Aggregator user-space interface" had a conflict in:
Documentation/userspace-api/ioctl/ioctl-number.rst

This conflict was caused by the addition of documentation of the sgx ioctls, these use
0xA4 as "Code" byte (shared with uapi/linux/tee.h), so the 0xA5 code for the sam cdev
ioctl is still unique.

I'm pretty sure that I've properly resolved the conflicts, but please double-check.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> Note: In v3, I have dropped the explicit dependency of the core module
> and driver on CONFIG_ACPI due to the incoming
> 
>   [PATCH] platform/surface: SURFACE_PLATFORMS should depend on ACPI
> 
> Thus, this series depends on said patch. This patch can be found at
> 
>   https://www.spinics.net/lists/platform-driver-x86/msg23929.html
> 
> 
> Changes in v1 (from RFC, overview):
>  - move to platform/surface
>  - add copyright lines
>  - change SPDX identifier to GPL-2.0+ (was GPL-2.0-or-later)
>  - change user-space interface from debugfs to misc-device
>  - address issues in user-space interface
>  - fix typos in commit messages and documentation
>  - fix some bugs, address other issues
> 
> Changes in v2 (overview):
>  - simplify some code, mostly with regards to concurrency
>  - add architectural overview to documentation
>  - improve comments for documentation
>  - use printk specifier for hex prefix instead of hard-coding it
>  - spell check comments and strings, fix typos
>  - unify comment style
>  - run checkpatch --strict, fix these and other style issues
> 
> Changes in v3 (overview):
>  - remove explicit dependency on ACPI as this is going to be covered by
>    CONFIG_SURFACE_PLATFORMS
>  - simplify locking requirements
>  - help enforce locking requirements via lockdep assertions
>  - fix false-positive lockdep warning
>  - warn on event enablement reference counter exhaustion
>  - don't warn about unhandled event if event handling failed
>  - validate flags on request initialization
>  - improve documentation/add comments
>  - replace 'iff' with 'if' in documentation and comments
> 
> Changes regarding specific patches (and more details) can be found on
> the individual patch.
> 
> 
> Maximilian Luz (9):
>   platform/surface: Add Surface Aggregator subsystem
>   platform/surface: aggregator: Add control packet allocation caching
>   platform/surface: aggregator: Add event item allocation caching
>   platform/surface: aggregator: Add trace points
>   platform/surface: aggregator: Add error injection capabilities
>   platform/surface: aggregator: Add dedicated bus and device type
>   docs: driver-api: Add Surface Aggregator subsystem documentation
>   platform/surface: Add Surface Aggregator user-space interface
>   platform/surface: Add Surface ACPI Notify driver
> 
>  Documentation/driver-api/index.rst            |    1 +
>  .../surface_aggregator/client-api.rst         |   38 +
>  .../driver-api/surface_aggregator/client.rst  |  393 +++
>  .../surface_aggregator/clients/cdev.rst       |   87 +
>  .../surface_aggregator/clients/index.rst      |   21 +
>  .../surface_aggregator/clients/san.rst        |   44 +
>  .../driver-api/surface_aggregator/index.rst   |   21 +
>  .../surface_aggregator/internal-api.rst       |   67 +
>  .../surface_aggregator/internal.rst           |  577 ++++
>  .../surface_aggregator/overview.rst           |   77 +
>  .../driver-api/surface_aggregator/ssh.rst     |  344 +++
>  .../userspace-api/ioctl/ioctl-number.rst      |    2 +
>  MAINTAINERS                                   |   13 +
>  drivers/platform/surface/Kconfig              |   38 +
>  drivers/platform/surface/Makefile             |    3 +
>  drivers/platform/surface/aggregator/Kconfig   |   68 +
>  drivers/platform/surface/aggregator/Makefile  |   17 +
>  drivers/platform/surface/aggregator/bus.c     |  415 +++
>  drivers/platform/surface/aggregator/bus.h     |   27 +
>  .../platform/surface/aggregator/controller.c  | 2579 +++++++++++++++++
>  .../platform/surface/aggregator/controller.h  |  285 ++
>  drivers/platform/surface/aggregator/core.c    |  839 ++++++
>  .../platform/surface/aggregator/ssh_msgb.h    |  205 ++
>  .../surface/aggregator/ssh_packet_layer.c     | 2057 +++++++++++++
>  .../surface/aggregator/ssh_packet_layer.h     |  190 ++
>  .../platform/surface/aggregator/ssh_parser.c  |  228 ++
>  .../platform/surface/aggregator/ssh_parser.h  |  154 +
>  .../surface/aggregator/ssh_request_layer.c    | 1264 ++++++++
>  .../surface/aggregator/ssh_request_layer.h    |  143 +
>  drivers/platform/surface/aggregator/trace.h   |  632 ++++
>  .../platform/surface/surface_acpi_notify.c    |  886 ++++++
>  .../surface/surface_aggregator_cdev.c         |  303 ++
>  include/linux/mod_devicetable.h               |   18 +
>  include/linux/surface_acpi_notify.h           |   39 +
>  include/linux/surface_aggregator/controller.h |  824 ++++++
>  include/linux/surface_aggregator/device.h     |  423 +++
>  include/linux/surface_aggregator/serial_hub.h |  672 +++++
>  include/uapi/linux/surface_aggregator/cdev.h  |   78 +
>  scripts/mod/devicetable-offsets.c             |    8 +
>  scripts/mod/file2alias.c                      |   23 +
>  40 files changed, 14103 insertions(+)
>  create mode 100644 Documentation/driver-api/surface_aggregator/client-api.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/client.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/clients/cdev.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/clients/index.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/clients/san.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/index.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/internal-api.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/internal.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/overview.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/ssh.rst
>  create mode 100644 drivers/platform/surface/aggregator/Kconfig
>  create mode 100644 drivers/platform/surface/aggregator/Makefile
>  create mode 100644 drivers/platform/surface/aggregator/bus.c
>  create mode 100644 drivers/platform/surface/aggregator/bus.h
>  create mode 100644 drivers/platform/surface/aggregator/controller.c
>  create mode 100644 drivers/platform/surface/aggregator/controller.h
>  create mode 100644 drivers/platform/surface/aggregator/core.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_msgb.h
>  create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.h
>  create mode 100644 drivers/platform/surface/aggregator/ssh_parser.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_parser.h
>  create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.h
>  create mode 100644 drivers/platform/surface/aggregator/trace.h
>  create mode 100644 drivers/platform/surface/surface_acpi_notify.c
>  create mode 100644 drivers/platform/surface/surface_aggregator_cdev.c
>  create mode 100644 include/linux/surface_acpi_notify.h
>  create mode 100644 include/linux/surface_aggregator/controller.h
>  create mode 100644 include/linux/surface_aggregator/device.h
>  create mode 100644 include/linux/surface_aggregator/serial_hub.h
>  create mode 100644 include/uapi/linux/surface_aggregator/cdev.h
> 

