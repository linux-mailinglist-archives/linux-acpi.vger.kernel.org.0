Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2816514B438
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 13:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgA1MeT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 07:34:19 -0500
Received: from foss.arm.com ([217.140.110.172]:56188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgA1MeT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 07:34:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3346101E;
        Tue, 28 Jan 2020 04:34:18 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366903F52E;
        Tue, 28 Jan 2020 04:34:17 -0800 (PST)
Date:   Tue, 28 Jan 2020 12:34:15 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, jeremy.linton@arm.com,
        arnd@arndb.de, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, guohanjun@huawei.com,
        gregkh@linuxfoundation.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 1/2] ACPI/PPTT: Add acpi_pptt_get_package_info() API
Message-ID: <20200128123415.GB36168@bogus>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580210059-199540-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 28, 2020 at 07:14:18PM +0800, John Garry wrote:
> The ACPI PPTT ID structure (see 6.2 spec, section 5.2.29.3) allows the
> vendor to provide an identifier (or vendor specific part number) for a
> particular processor hierarchy node structure. That may be a processor
> identifier for a processor node, or some chip identifier for a processor
> package node.
>

Unfortunately, there were plans to deprecate this in favour of the new
SOC_ID SMCCC API[1]. I am not sure if you or anyone in your company have
access to UEFI ASWG mantis where you can look for the ECR for the PPTT
Type 2 deprecation. I understand it's not ideal, but we need to converge,
please take a look at both before further discussion.

I personally would not prefer to add the support when I know it is getting
deprecated. I am not sure on kernel community policy on the same.


[...]

>
> The ID structure table has a number of fields, which are left open to
> interpretation per implementation. However the spec does provide reference
> examples of how the fields could be used. As such, just provide the
> table fields directly in the API, which the caller may interpret (probably
> as per spec example).
>

The "open for interpretation" part is why it's not being favoured anymore
by silicon vendors as OEM/ODMs can override the same.

> https://lore.kernel.org/linux-arm-kernel/1579876505-113251-6-git-send-email-john.garry@huawei.com/
>
Ah, there's already quite a lot of dependency built for this feature :(

--
Regards,
Sudeep

[1] https://developer.arm.com/docs/den0028/c
