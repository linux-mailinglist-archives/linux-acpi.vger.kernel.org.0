Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC7C213D63
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jul 2020 18:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGCQQe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jul 2020 12:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgGCQQd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Jul 2020 12:16:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2284C20884;
        Fri,  3 Jul 2020 16:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593792993;
        bh=bcCqWKhO1eod5uVd0pvGzOy2B4jq7cJ/KO64kFKi5zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMngjesKjraQ4+whMJCBKz84JD49c6POw0yboJIvh3D580dsKin7ypugXnrf4LGTr
         teRdjCRVEmsFqcYF0hG0PcaLMbGDUGCTC3O8uHPG+GI4uvUwDzi3Xvl0RbE+VQJy5G
         btneIHC5KV7aKVZbpcnDBKgNSlmKPIA8KwS9OpQA=
Date:   Fri, 3 Jul 2020 17:16:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC PATCH v2] arm64/acpi: disallow AML memory opregions to
 access kernel memory
Message-ID: <20200703161628.GB19595@willie-the-truck>
References: <20200623093755.1534006-1-ardb@kernel.org>
 <20200623162655.GA22650@red-moon.cambridge.arm.com>
 <CAMj1kXEwnDGV=J7kdtzrPY9hT=Bp6XRCw85urK2MLXsZG3zdMw@mail.gmail.com>
 <20200703161429.GA19595@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703161429.GA19595@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 03, 2020 at 05:14:29PM +0100, Will Deacon wrote:
> Is this 5.9 material, or do you want it to go in as a fix?

Sorry, just spotted the v3, but the same question applies there!

Will
