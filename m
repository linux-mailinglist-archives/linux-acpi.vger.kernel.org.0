Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F7414BD89
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1QR7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 11:17:59 -0500
Received: from foss.arm.com ([217.140.110.172]:60090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgA1QR6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 11:17:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D0F1FB;
        Tue, 28 Jan 2020 08:17:58 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DACAD3F68E;
        Tue, 28 Jan 2020 08:17:56 -0800 (PST)
Date:   Tue, 28 Jan 2020 16:17:51 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, jeremy.linton@arm.com,
        arnd@arndb.de, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, guohanjun@huawei.com,
        gregkh@linuxfoundation.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
Message-ID: <20200128161751.GA30489@bogus>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <20200128152040.GC47557@bogus>
 <ff2ebe43-639d-085b-d043-55c402513390@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2ebe43-639d-085b-d043-55c402513390@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 28, 2020 at 03:59:15PM +0000, John Garry wrote:
> On 28/01/2020 15:20, Sudeep Holla wrote:
>

[...]

> Hi Sudeep,
>
> > What do you want to match this ? The same silicon can end up with
> > different OEMs and this list just blows up soon for single SoC if
> > used by different OEM/ODMs. I assume we get all the required info
> > from the Type 2 table entry and hence can just rely on that. If
> > PPTT has type 2 entry, just initialise this soc driver and expose
> > the relevant information from the table entry.
>
> As before, the LEVEL_1_ID and LEVEL_2_ID table members are too open to
> interpretation in the spec to generate a consistent form soc_id and
> family_id for all platforms.
>

One of the argument I was making during evolution of SOC_ID is to have
IDs like LEVEL_1_ID and LEVEL_2_ID in PPTT as they are 8 bytes long and
can just be a string that is self-sufficient and can be exposed to user
space as is instead of having to do some interpretation in the kernel.
Remember this is ACPI table entry and is designed to work with multiple
OS, we can at-least expect the strings to be as self-explanatory and
need no further decoding in the kernel.

> As such, I was trying to limit to known PPTT implementations and how they
> should be interpreted. Obviously that's *far* from ideal.
>

I am saying not to take that path and just throw the strings as is at
the user. If OEM/ODMs are serious about suggesting user-space to make
use of it, they better put sane value there and don't expect kernel to
do interpretation for them.

> So what's your idea? Just always put LEVEL_1_ID and LEVEL_2_ID in soc driver
> family_id and soc_id fields, respectively?
>

Yes, that's my opinion. It gets messy soon if kernel tries to interpret
this for OEM/ODM, they must better get it right if they are serious about
it.

--
Regards,
Sudeep
