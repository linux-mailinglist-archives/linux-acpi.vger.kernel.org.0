Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2415A874
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 12:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgBLL7y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 06:59:54 -0500
Received: from foss.arm.com ([217.140.110.172]:60098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgBLL7y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 06:59:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C20A31B;
        Wed, 12 Feb 2020 03:59:52 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 280993F6CF;
        Wed, 12 Feb 2020 03:59:51 -0800 (PST)
Date:   Wed, 12 Feb 2020 11:59:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: About PPTT find_acpi_cpu_topology_package()
Message-ID: <20200212115945.GA36981@bogus>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 12, 2020 at 11:20:12AM +0000, John Garry wrote:
> Hi Jeremy,
>
> I have a question about $subject for you, since you wrote the code.
>
> This function returns a unique identifier for the package, but would not be
> the logically indexed package id we would expect, like 0, 1, 2, ...
>

Firstly, it must be physical socket number and not logical id.

> It returns of the offset in the PPTT of the topology physical CPU node.
>

Yes, intentionally. We don't want to generate a logical index for this.
Simply not going to happen as we can't guarantee unique number always.
We need to get that uniqueness from the firmware and hence the choice of
offset. Remember that the offset is used only if firmware conveniently
ignored all the optional properties including UID in the processor
container representing the physical socket.

> So I may get something like this:
>
> john@ubuntu:~$ more
> /sys/devices/system/cpu/cpu80/topology/physical_package_id
> 5418
>

Good, now the platform have a reason to fix it in the firmware if it is
very hard to see and understand the above value.

> For sure, this does not violate the ABI in
> Documentation/ABI/testing/sysfs-devices-system-cpu:
>

Very good to see you are not disagreeing with that :)

> "physical_package_id: physical package id of cpu#. Typically	 corresponds to
> a physical socket number, but the actual value is architecture and platform
> dependent."
>
> Question: Is there any reason for which we cannot assign an indexed package
> id to each package node?
>

Yes, as mentioned above. We are not going to do extra work for lazy firmware.
Linux also will be lazy on such platform and provide weird unique numbers
like in the above case you have mentioned.

> Some userspace tools rely on a sane meaningful package id, like perf:
>

Good that you mention now. Time to update the firmware then.


[...]

>
> This can only deal with a socket id which fits in a byte. I'd rather not
> change this code if possible.
>

Agreed, add UID to the processor container, job done.

--
Regards,
Sudeep
