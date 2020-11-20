Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3626D2BA68C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Nov 2020 10:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKTJtx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 04:49:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgKTJtw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Nov 2020 04:49:52 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F74204EF;
        Fri, 20 Nov 2020 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605865792;
        bh=qKccB098mAm5w/p7q6BC7LJEV+f2/iZ7mmRnARRYYyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Rcc4IIPYstEoDx1kd4aoWSdpqskcu/T2mLE+C39hGUC51zGEo45Gh6qQjhIOMyqy
         2yAxbwrKuNyrHH4++zbD5UKKa++dEga2PmuwrtCv1ACUz64Rea17+O5Aef/YiM7P8p
         GEqeRrPLmlr7f1fkWEjE6kSCtm9vwiTsIUEzHvLE=
Date:   Fri, 20 Nov 2020 09:49:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>, mark.rutland@arm.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH 1/1] ACPI/IORT: Fix doc warnings in iort.c
Message-ID: <20201120094946.GA6033@willie-the-truck>
References: <20201014093139.1580-1-shiju.jose@huawei.com>
 <20201119180120.GA25142@e121166-lin.cambridge.arm.com>
 <20201119180346.GI4376@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119180346.GI4376@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 19, 2020 at 06:03:47PM +0000, Catalin Marinas wrote:
> On Thu, Nov 19, 2020 at 06:01:20PM +0000, Lorenzo Pieralisi wrote:
> > [+Catalin - I hope it can go via arm64 tree, trivial doc fixup]
> 
> Or Will if you want it in 5.10, otherwise I can pick it up for 5.11.

I can pick this up for 5.10, but I won't be sending a pull request until
next week, since I'm waiting for Mark's irq tracing fixes to appear and I
don't have anything else queued atm.

Will
