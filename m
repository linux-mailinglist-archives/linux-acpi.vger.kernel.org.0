Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0995031A1C3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 16:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhBLPen (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 10:34:43 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.2]:58162 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232270AbhBLPed (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 10:34:33 -0500
Received: from [100.112.3.43] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-east-1.aws.symcld.net id 32/66-00973-1CE96206; Fri, 12 Feb 2021 15:29:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRWlGSWpSXmKPExsWS8eIhj+7BeWo
  JBlM6+C3eHJ/OZDH1QI3Fzodv2SyW7+tntLi8aw6bRfvG2awWnzsms1is3vOC2eLM6UusDpwe
  705tYfPYOesuu8emVZ1sHvNOBnq833eVzWPL1XYWj8+b5ALYo1gz85LyKxJYM+7+WcNe8EWgo
  vubQANjP28XIxeHkMB/Romvhw+zQzjPGSVOf1zF3MXIySEskCkxad5UMFtEoFqi8fwvVpAiZo
  FLjBKvpq1lB0kICdhK3F9yHqyITUBbYsuWX2wgNi9Q/OPMVlYQm0VAVWLqtM8sILaoQLjE602
  fGSFqBCVOznwCFucUsJO4smoWUxcjB9ACTYn1u/RBwswC4hK3nsxngrDlJba/nQO2SgLI/vHo
  FjuEnSDR8+8R2wRGwVlIps5CmDQLyaRZSCYtYGRZxWiWVJSZnlGSm5iZo2toYKBraGika6BrZ
  GSkl1ilm6RXWqybmlhcomuol1herFdcmZuck6KXl1qyiREYbykFDPd2MP55/UHvEKMkB5OSKO
  +ZGWoJQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4VWcD5QSLUtNTK9Iyc4CxD5OW4OBREuHNmgu
  U5i0uSMwtzkyHSJ1iVJQS590JkhAASWSU5sG1wdLNJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIc
  jErCvEfmAE3hycwrgZv+CmgxE9Dimi6wxSWJCCmpBqaiJQ31JTUCDCqfU9xfn/gnce6sUscxF
  ZnWTbcWHPCNrZ8zmSlhGofSFMf2FxsZly45M0NhldmPTZIfQyZNNunqjQ5j+cRetGby1pQjx2
  Z7npmwepkze/9/SQtjhramBYe5vns8s62QMZrkkS7az+ZycmKmF/PU6gd2b7TfTHTvfXYuU0Y
  y913KvqPVSXUch32mxnz/+GNp7c4ONa9J0fPqeQ22zzjPW+xkwj3rl12lT5hegOkT+e1HOhZt
  /ZejU1y55L5sh/pk75IZHIYbGZ9OY/+4wtTQ8HSDhI0nr/UPy4dzbzydKVXPHOF3TnV+fPORz
  7XO/797xh59c+fxF1ulyq1litaLp0XVcuqI8CqxFGckGmoxFxUnAgCPf1JPsgMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-31.tower-395.messagelabs.com!1613143745!262690!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28115 invoked from network); 12 Feb 2021 15:29:05 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-31.tower-395.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Feb 2021 15:29:05 -0000
Received: from reswpmail01.lenovo.com (unknown [10.62.32.20])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 0B0FDB4F202F52A5DBA3;
        Fri, 12 Feb 2021 10:29:05 -0500 (EST)
Received: from localhost.localdomain (10.46.53.63) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Fri, 12 Feb
 2021 10:28:27 -0500
Subject: Re: [External] [PATCH v2 0/4] platform/surface: Add platform profile
 driver for Surface devices
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Mark Gross <mgross@linux.intel.com>, Len Brown <lenb@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210211201703.658240-1-luzmaximilian@gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <5133800c-e7e4-034a-d646-de1411065fac@lenovo.com>
Date:   Fri, 12 Feb 2021 10:29:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210211201703.658240-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.53.63]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/02/2021 15:16, Maximilian Luz wrote:
> This series adds a driver to provide platform profile support on 5th-
> and later generation Microsoft Surface devices with a Surface System
> Aggregator Module. On those devices, the platform profile can be used to
> influence cooling behavior and power consumption.
> 
> To achieve this, a new platform profile is introduced: the
> 'balanced-performance' profile.
> 
> In addition, a couple of fix-ups are performed:
> - Hide CONFIG_ACPI_PLATFORM_PROFILE and change drivers so that it is
>   selected instead of depended on.
> - Fix some references to documentation in a comment.
> 
> Note: This series (or more specifically "platform/surface: Add platform
> profile driver") depends on the "platform/surface: Add Surface
> Aggregator device registry" series.
> 
> Changes in v2:
>  - Introduce new 'balanced-performance' platform profile and change
>    profile mapping in driver.
>  - Perform some fix-ups for the ACPI platform profile implementation:
>    - Fix some references to documentation in a comment.
>    - Hide CONFIG_ACPI_PLATFORM_PROFILE
> 
> Maximilian Luz (4):
>   ACPI: platform: Hide ACPI_PLATFORM_PROFILE option
>   ACPI: platform: Fix file references in comment
>   ACPI: platform: Add balanced-performance platform profile
>   platform/surface: Add platform profile driver
> 
>  .../ABI/testing/sysfs-platform_profile        |  18 +-
>  MAINTAINERS                                   |   6 +
>  drivers/acpi/Kconfig                          |  16 +-
>  drivers/acpi/platform_profile.c               |   1 +
>  drivers/platform/surface/Kconfig              |  22 ++
>  drivers/platform/surface/Makefile             |   1 +
>  .../surface/surface_platform_profile.c        | 190 ++++++++++++++++++
>  drivers/platform/x86/Kconfig                  |   4 +-
>  include/linux/platform_profile.h              |   6 +-
>  9 files changed, 237 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/platform/surface/surface_platform_profile.c
> 
I looked through the patch series and it all looked good to me.
Glad the platform profile implementation is getting used in more places :)

Thanks
Mark
