Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D9D3C13
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 11:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfJKJQr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 05:16:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57665 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfJKJQq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 05:16:46 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 2945faddd0b39e2b; Fri, 11 Oct 2019 11:16:43 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 0/6] ACPI / utils: add new helper for HID/UID match
Date:   Fri, 11 Oct 2019 11:16:43 +0200
Message-ID: <6926760.z8q4ev7VEa@kreacher>
In-Reply-To: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
References: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, October 1, 2019 4:27:19 PM CEST Andy Shevchenko wrote:
> There are few users outside of ACPI realm that re-introduce a custom
> solution to match ACPI device against HID/UID. Add a generic helper for
> them.
> 
> The series is supposed to go via linux-pm tree.
> 
> In v3:
> - correct logic in sdhci-acpi for qcom devices (Adrian)
> - add Mika's Ack
> 
> In v2:
> - add patch 2 due to latent issue in the header (lkp)
> - get rid of match_hid_uid() completely in patch 6
> 
> Andy Shevchenko (6):
>   ACPI / utils: Describe function parameters in kernel-doc
>   ACPI / utils: Move acpi_dev_get_first_match_dev() under CONFIG_ACPI
>   ACPI / utils: Introduce acpi_dev_hid_uid_match() helper
>   ACPI / LPSS: Switch to use acpi_dev_hid_uid_match()
>   mmc: sdhci-acpi: Switch to use acpi_dev_hid_uid_match()
>   iommu/amd: Switch to use acpi_dev_hid_uid_match()
> 
>  drivers/acpi/acpi_lpss.c      | 21 +++------------
>  drivers/acpi/utils.c          | 32 +++++++++++++++++++++++
>  drivers/iommu/amd_iommu.c     | 30 ++++-----------------
>  drivers/mmc/host/sdhci-acpi.c | 49 ++++++++++++-----------------------
>  include/acpi/acpi_bus.h       |  8 +++---
>  include/linux/acpi.h          |  6 +++++
>  6 files changed, 67 insertions(+), 79 deletions(-)
> 
> 

Applying the series (with the tags given so far) as 5.5 material, thanks!




