Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2782514D99F
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2020 12:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgA3LXq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jan 2020 06:23:46 -0500
Received: from foss.arm.com ([217.140.110.172]:51236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3LXq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Jan 2020 06:23:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBFFB328;
        Thu, 30 Jan 2020 03:23:45 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8139E3F67D;
        Thu, 30 Jan 2020 03:23:44 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:23:38 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, jeremy.linton@arm.com,
        arnd@arndb.de, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, guohanjun@huawei.com,
        gregkh@linuxfoundation.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 1/2] ACPI/PPTT: Add acpi_pptt_get_package_info() API
Message-ID: <20200130112338.GA54532@bogus>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-2-git-send-email-john.garry@huawei.com>
 <20200128123415.GB36168@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128123415.GB36168@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 28, 2020 at 12:34:15PM +0000, Sudeep Holla wrote:
> On Tue, Jan 28, 2020 at 07:14:18PM +0800, John Garry wrote:
> > The ACPI PPTT ID structure (see 6.2 spec, section 5.2.29.3) allows the
> > vendor to provide an identifier (or vendor specific part number) for a
> > particular processor hierarchy node structure. That may be a processor
> > identifier for a processor node, or some chip identifier for a processor
> > package node.
> >
>
> Unfortunately, there were plans to deprecate this in favour of the new
> SOC_ID SMCCC API[1]. I am not sure if you or anyone in your company have
> access to UEFI ASWG mantis where you can look for the ECR for the PPTT
> Type 2 deprecation. I understand it's not ideal, but we need to converge,
> please take a look at both before further discussion.
>
> I personally would not prefer to add the support when I know it is getting
> deprecated. I am not sure on kernel community policy on the same.
>

OK, the details on the proposal to deprecate can be now found in UEFI
bugzilla [1]

--
Regards,
Sudeep

[1] https://bugzilla.tianocore.org/show_bug.cgi?id=2492
