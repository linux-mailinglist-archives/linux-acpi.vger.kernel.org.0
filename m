Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55A23C9DCF
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbhGOLe5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 07:34:57 -0400
Received: from foss.arm.com ([217.140.110.172]:51430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241993AbhGOLe4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jul 2021 07:34:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AC4C31B;
        Thu, 15 Jul 2021 04:32:03 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A86BA3F694;
        Thu, 15 Jul 2021 04:32:01 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:31:02 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 12/13] mailbox: pcc: Add support for PCCT extended PCC
 subspaces(type 3/4)
Message-ID: <20210715113102.oww24dj73fq2imbl@bogus>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
 <20210708180851.2311192-13-sudeep.holla@arm.com>
 <20210714185216.GE49078@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714185216.GE49078@e120937-lin>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 14, 2021 at 07:52:16PM +0100, Cristian Marussi wrote:
> On Thu, Jul 08, 2021 at 07:08:50PM +0100, Sudeep Holla wrote:
> > With all the plumbing in place to avoid accessing PCCT type and other
> > fields directly from the PCCT table all the time, let us now add the
> > support for extended PCC subspaces(type 3 and 4).
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
>
> Hi Sudeep,
>
> just a few general observation on Type 3/4 subspaces from the spec
> Table 14.7:
>
> - "If a slave-subspace is present in the PCCT, then the platform interrupt flag must be set to 1." table 14.7
>
>   Maybe is worth to WARN on this if this assumption is violated by the
>   ACPI table we found.
>
> - "Note that if interrupts are edge triggered, then each subspace must have its own unique interrupt."
>
>   Same here, maybe it's worth also to check this, so that after all the
>   pchan->db_irq has been obtained no edge triggered irqs are duplicated
>   before requesting them.
>

Both valid points and in my TODO list, just forgot to address this as I
didn't have a setup to check/flag these up. I will address them in next
version.

Thanks for reviewing these patches.

--
Regards,
Sudeep
