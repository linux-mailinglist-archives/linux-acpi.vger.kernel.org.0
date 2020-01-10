Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B466136B33
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2020 11:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgAJKj5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Jan 2020 05:39:57 -0500
Received: from foss.arm.com ([217.140.110.172]:42180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbgAJKj5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Jan 2020 05:39:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AC6E1396;
        Fri, 10 Jan 2020 02:39:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669B93F703;
        Fri, 10 Jan 2020 02:39:55 -0800 (PST)
Date:   Fri, 10 Jan 2020 10:39:24 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        linux-acpi@vger.kernel.org, John Garry <john.garry@huawei.com>,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] ACPI/IORT: Workaround for IORT ID count "minus one"
 issue
Message-ID: <20200110103924.GA15314@e121166-lin.cambridge.arm.com>
References: <1577708824-4873-1-git-send-email-guohanjun@huawei.com>
 <2ce224b2-d926-67b0-f9dd-85ac53d967c5@arm.com>
 <20200109160220.GA27079@e121166-lin.cambridge.arm.com>
 <4cee4a91-6459-819b-d4d4-f5e8899103b9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cee4a91-6459-819b-d4d4-f5e8899103b9@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 10, 2020 at 02:22:22PM +0800, Hanjun Guo wrote:

[...]

> > I am fine either way. We need test coverage since I feel this may
> > break a number of systems (ie I don't think it should be merged as
> > a fix).
> 
> Will you resend this patch with commit log and the updated code? or
> let me do that? Both are ok to me, let's get it tested for longer time
> if we merge it ASAP.

I will write the commit log in reply to the original patch, please
update the code and repost the whole thing (it is better you
repost it to avoid confusing Catalin and Will).

This technically is not a fix; we can try to get it into v5.6 but
I am a bit nervous since it can break other platforms, we have to
fix it though so better sooner than later.

Thanks,
Lorenzo
