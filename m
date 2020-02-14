Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3864815D67D
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 12:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgBNLWe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 06:22:34 -0500
Received: from foss.arm.com ([217.140.110.172]:59958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgBNLWe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 06:22:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 047F51FB;
        Fri, 14 Feb 2020 03:22:34 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDC923F68F;
        Fri, 14 Feb 2020 03:22:32 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:22:30 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: About PPTT find_acpi_cpu_topology_package()
Message-ID: <20200214112230.GB31055@bogus>
References: <20200212135551.GB36981@bogus>
 <1a04ddf8-4903-2986-a94e-c070dc2c2160@huawei.com>
 <3c15a54a-18ac-265e-c16c-272577b9dead@arm.com>
 <bfc39a01-419a-9358-fd6d-c73fdcb9c881@huawei.com>
 <eedbafc2-019c-517f-4623-4b6ad80f5438@arm.com>
 <b9ca7718-3834-b42d-a36e-63c81f677a78@huawei.com>
 <20200213140006.GB31787@bogus>
 <76c2c4fa-3466-171b-3538-9a7374f4baae@huawei.com>
 <2feeb7aa-465c-6d40-920b-2c1aa25fbed6@arm.com>
 <bf130dcb-73b5-7173-7111-f513e73fd12b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf130dcb-73b5-7173-7111-f513e73fd12b@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 14, 2020 at 10:35:03AM +0000, John Garry wrote:

[...]

>
> So you have something newer than
> https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf?
>

No, I too refer the same.

> > .
>
> So my FW colleague tells me that they tried adding processor containers for
> hierarchy components, but the kernel complained. I don't know the specifics.
> I need to follow up on that.
>
> Do I see this, which we could refer to:
>
> https://github.com/tianocore/edk2-platforms/blob/master/Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl#L36
>

OK, if anything is wrong there, I am the person to blame. I must say that
this was added pre-PPTT dates for LPI. So I expect things may not be up
to date TBH.

> Any more pointers as references would be appreciated.
>

Nothing more than above sole reference.

--
Regards,
Sudeep
