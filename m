Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4D42EC014
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jan 2021 16:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbhAFPE0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jan 2021 10:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbhAFPE0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2021 10:04:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF3CC06134C;
        Wed,  6 Jan 2021 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2xH4n0+DPDX1xCjbRVrpYtT6iFUotuIgJu3Q4iytG6g=; b=W1oj2v0l8bXWcdxYukktuLr15D
        6ch0CeOnruTmYlvqW1ETVK71J4WPlBMgRbfX7Sa2DXWZM+rjFwvXTUhPOtAK7obS6xKd1WR6Uxvsi
        xXdR23oJBKDh4T8g6iaJdnPEtuoQ15zzxfplWhk7j8J/H9mjV37Ol7/JhL0bHcu5B/rbt6JIfUAAk
        Ik6bvsyQHXnv0Hhquf8ZD54cSo4A73uG7Va62StF07KYDV/iWRHOqxrCKsnQ/gQpqEXPm6IytNL8D
        U6F2F4r5UFuZSg1DLsye8cLjh6UCnT1sxIC186tbUp44r2xuIb/frl9NnW28h74Ug/0dzzcbtQ/aV
        +iNKr2tQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxAHy-002RHW-NN; Wed, 06 Jan 2021 15:01:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 662523010D2;
        Wed,  6 Jan 2021 15:59:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54A83202A3CEE; Wed,  6 Jan 2021 15:59:54 +0100 (CET)
Date:   Wed, 6 Jan 2021 15:59:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org,
        x86@kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: How to detect Cherry Trail vs Brasswell inside the kernel ?
Message-ID: <X/XQak3+YtbyeAqM@hirez.programming.kicks-ass.net>
References: <37906985-e026-48d3-cda8-6e63696e72aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37906985-e026-48d3-cda8-6e63696e72aa@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 06, 2021 at 01:31:46PM +0100, Hans de Goede wrote:
> Hi All,
> 
> I've 2 different kernel bugs where the fix requires differentiating between
> Cherry Trail vs Brasswell, just checking the CPU model does not allow to
> differentiate between these 2 since they are both using Airmont cores.
> 
> I have the same issue with the Bay Trail laptop SoCs vs the
> Bay Trail-T tablet SoCs, but for now lets focus on
> Cherry Trail vs Brasswell since that is less confusing:
> 
> https://ark.intel.com/content/www/us/en/ark/products/codename/46629/cherry-trail.html
> https://ark.intel.com/content/www/us/en/ark/products/codename/66094/braswell.html
> 
> So I see a number of possible solutions here:
> 
> 1) Do a (substring) check on the CPU model-name checking for "x5-Z8" and "x7-Z8"
> 2) Check for presence of some embedded peripheral which is present on one but not the
> other. E.g. The Braswell devices have HDA audio where as the Cherry Trail devices
> use the "Low Power Engine (LPE) Audio Controller"
> 3) Check for acpi_gbl_reduced_hardware, but I'm not sure if that is a reliable
> indicator of running on the tablet versions of the SoCs.
> 
> 1 and 2 will work but neither is very pretty, I guess I could try to spend some
> more time investigating 3. But I only have limited access to the non tablet versions
> of the Bay Trail and I'm not sure if I have any Braswell devices at all. 
> 
> So I was wondering if anyone else has any better ideas here?

Does MSR_PLATFORM_ID (0x17) bits 50-52 work to differentiate these?
