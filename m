Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C481915BFE6
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2020 15:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgBMOAL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Feb 2020 09:00:11 -0500
Received: from foss.arm.com ([217.140.110.172]:46962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbgBMOAK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Feb 2020 09:00:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2909F1FB;
        Thu, 13 Feb 2020 06:00:10 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4C03F68F;
        Thu, 13 Feb 2020 06:00:08 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:00:06 +0000
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
Message-ID: <20200213140006.GB31787@bogus>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
 <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
 <20200212135551.GB36981@bogus>
 <1a04ddf8-4903-2986-a94e-c070dc2c2160@huawei.com>
 <3c15a54a-18ac-265e-c16c-272577b9dead@arm.com>
 <bfc39a01-419a-9358-fd6d-c73fdcb9c881@huawei.com>
 <eedbafc2-019c-517f-4623-4b6ad80f5438@arm.com>
 <b9ca7718-3834-b42d-a36e-63c81f677a78@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9ca7718-3834-b42d-a36e-63c81f677a78@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 13, 2020 at 11:52:09AM +0000, John Garry wrote:

[...]

>
> As for when it's not set, it's unclear. My understanding is that the ACPI
> processor id should still be used as the non-leaf node identifier, but it
> would not match a UID for a processor container (as it may not exist).
>

I can't infer anything that matches your understanding from the spec in
this regard. If it's not set, then it is left to OSPM.

> The kernel does have behave according to this.
>

According to what in the specification ?

> So how I am misinterpreting this?
>

May be you are not, it is just ambiguous in the spec, worth checking and
fixing if it is an issue. I reiterate we don't want to generate anything
in the OS for this purpose.

--
Regards,
Sudeep
