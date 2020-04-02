Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10E819C1BA
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Apr 2020 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbgDBNJA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Apr 2020 09:09:00 -0400
Received: from foss.arm.com ([217.140.110.172]:42614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387580AbgDBNJA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Apr 2020 09:09:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B39430E;
        Thu,  2 Apr 2020 06:08:59 -0700 (PDT)
Received: from bogus (unknown [10.37.12.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7AAE3F68F;
        Thu,  2 Apr 2020 06:08:57 -0700 (PDT)
Date:   Thu, 2 Apr 2020 14:08:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        linuxarm@huawei.com, wanghuiqiang@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ACPI: PPTT: Inform user that table offset used for
 Physical processor node ID
Message-ID: <20200402123501.GA26588@bogus>
References: <1585830145-208714-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585830145-208714-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

(I see 2 copies of this patch, replying on the latest)

On Thu, Apr 02, 2020 at 08:22:25PM +0800, John Garry wrote:
> If the the Processor ID valid is not set for a Physical Processor Package
> node, then the node table offset is used as a substitute. As such, we
> may get info like this from sysfs:
>
> root@(none)$ pwd
> /sys/devices/system/cpu/cpu0/topology
> root@(none)$ more physical_package_id
> 56
>
> Inform the user of this in the bootlog, as it is much less than ideal, and
> they can remedy this in their FW.
>
> This topic was originally discussed in:
> https://lore.kernel.org/linux-acpi/c325cfe2-7dbf-e341-7f0f-081b6545e890@huawei.com/T/#m0ec18637d8586f832084a8a6af22580e6174669a
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
