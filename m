Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF9915AC10
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 16:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBLPgh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 10:36:37 -0500
Received: from foss.arm.com ([217.140.110.172]:34220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbgBLPgh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 10:36:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1F61FEC;
        Wed, 12 Feb 2020 07:36:36 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD3A13F68F;
        Wed, 12 Feb 2020 07:36:35 -0800 (PST)
Date:   Wed, 12 Feb 2020 15:36:33 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     John Garry <john.garry@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: About PPTT find_acpi_cpu_topology_package()
Message-ID: <20200212153633.GD36981@bogus>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
 <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
 <20200212135551.GB36981@bogus>
 <0edb6aa9-c96f-71c1-a3ab-a95df4c07317@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0edb6aa9-c96f-71c1-a3ab-a95df4c07317@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 11, 2020 at 12:49:17PM -0600, Jeremy Linton wrote:
> Hi,
> 
> On 2/12/20 7:55 AM, Sudeep Holla wrote:
> > On Wed, Feb 12, 2020 at 12:48:33PM +0000, John Garry wrote:
> > > On 12/02/2020 11:59, Sudeep Holla wrote:
> > 
> > [...]
> > 
> > > > Yes, as mentioned above. We are not going to do extra work for lazy firmware.
> > > 
> > > I don't think it's reasonable to just label this as lazy. The table may just
> > > not have the flag set unintentionally. FW and software guys make mistakes,
> > > like the mistakes in PPTT, itself.
> > > 
> > 
> > We are not talking about flags, it's UID and it is pretty important if
> > there are more than one objects of same time.
> 
> But, this hints at my reservations with this approach. If you wanted to have
> your processors numbered 0...x and your sockets numbered 0...y, there could
> be overlap in the processor container objects, which should also be avoided.
> 

Of course yes, UID needs to be unique at a given processor/container level.
Yes, it's more restricted in that way compared to objects of similar type.
Here they are all same processor containers, but need to enumerate from 0
at each level.

-- 
Regards,
Sudeep
