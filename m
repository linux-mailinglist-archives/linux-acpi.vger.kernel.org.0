Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B72459470
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 18:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhKVSCV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 13:02:21 -0500
Received: from foss.arm.com ([217.140.110.172]:43874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239764AbhKVSCT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 13:02:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 465811042;
        Mon, 22 Nov 2021 09:59:12 -0800 (PST)
Received: from bogus (unknown [10.57.46.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4833A3F73B;
        Mon, 22 Nov 2021 09:59:11 -0800 (PST)
Date:   Mon, 22 Nov 2021 17:59:08 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: [PATCH 0/3] ACPI: Add support for PCC Operation Region
Message-ID: <20211122175908.uprdvok2kruj4qko@bogus>
References: <20211102182542.3460787-1-sudeep.holla@arm.com>
 <CAJZ5v0jL2+1rzqB2aAJ0T6w3md2dyuHWZNKOk+AbioeD-4ccDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jL2+1rzqB2aAJ0T6w3md2dyuHWZNKOk+AbioeD-4ccDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,


Thanks for the response, sorry for the delay as I was away.

On Fri, Nov 05, 2021 at 03:58:14PM +0100, Rafael J. Wysocki wrote:
> Hi Sudeep,
> 
> On Tue, Nov 2, 2021 at 7:26 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Hi,
> >
> > This series adds support for ACPI PCC OpRegion added in ACPI 6.3
> > I understand that the ACPICA changes need to go via different route,
> > but I am posting it together to give complete narative/picture for
> > the review/discussion.
> >
> > Regards,
> > Sudeep
> >
> > Sudeep Holla (3):
> >   ACPICA: Fix wrong interpretation of PCC address
> >   ACPICA: Add support for PCC Opregion special context data
> 
> The above two need to be submitted to the upstream project via GitHub
> at https://github.com/acpica/acpica
> 

Thanks for the info, I had a rough idea but posted these for reference here
anyways.

> The will be applicable to the Linux code base only after they have
> been accepted by the upstream.
>

Sure, I have now sent the pull request(https://github.com/acpica/acpica/pull/735)

> >   ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype
> 
> And this one will be applied when the above happens.
>

Make sense.

-- 
Regards,
Sudeep
