Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17C12D5F04
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbgLJPFk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 10:05:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:39082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388977AbgLJPFb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Dec 2020 10:05:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0DEFADCD;
        Thu, 10 Dec 2020 15:04:46 +0000 (UTC)
Date:   Thu, 10 Dec 2020 16:04:40 +0100
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Petr Cervinka <pcervinka@suse.com>
Subject: Re: [PATCH 1/2] acpi: cppc: add cpufreq device
Message-ID: <20201210150417.GA24136@suse.de>
References: <20201210142139.20490-1-yousaf.kaukab@suse.com>
 <CAJZ5v0hWxLrXCS+X15hnLZ2enBsSJ0aEfnxK2kL+n9k4gkg17Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hWxLrXCS+X15hnLZ2enBsSJ0aEfnxK2kL+n9k4gkg17Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 10, 2020 at 03:32:09PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 10, 2020 at 3:23 PM Mian Yousaf Kaukab
> <yousaf.kaukab@suse.com> wrote:
> >
> > Convert cppc-cpufreq driver to a platform driver (done in a separate patch)
> > and add cppc-cpufreq device when acpi_cppc_processor_probe() succeeds.
> 
> Honestly, I prefer to drop 28f06f770454 (along with its follower)
> instead of making this change.
> 
Even if we revert 28f06f770454 there is still one more small issue that these
patches fix. Currently, ACPI_PROCESSOR_DEVICE_HID is used to load cppc-cpufreq
module. In case when CPPC is disabled, some cycles will be wasted in loading
cppc-cpufreq module. The module will return error from the init call though
so no memory is wasted.

After converting to platform-driver, cppc-cpufreq module will only be loaded
when the platform-device is available.

BR,
Yousaf
