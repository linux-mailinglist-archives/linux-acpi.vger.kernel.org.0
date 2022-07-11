Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC7755FBCB
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jun 2022 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiF2JW4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Jun 2022 05:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiF2JWx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2022 05:22:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16065377F2;
        Wed, 29 Jun 2022 02:22:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97EE41477;
        Wed, 29 Jun 2022 02:22:50 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE5C23F792;
        Wed, 29 Jun 2022 02:22:48 -0700 (PDT)
Date:   Wed, 29 Jun 2022 10:21:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 0/4] ACPI: Enable Platform Runtime Mechanism(PRM)
 support on ARM64
Message-ID: <20220629092137.a5fl33recfds7bq3@bogus>
References: <20220628125346.693304-1-sudeep.holla@arm.com>
 <20220629090635.6kf7thawc4qc4zi2@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629090635.6kf7thawc4qc4zi2@bogus>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 29, 2022 at 10:06:35AM +0100, Sudeep Holla wrote:
> Hi Rafael,
> 
> On Tue, Jun 28, 2022 at 01:53:42PM +0100, Sudeep Holla wrote:
> > Hi,
> > 
> > This tiny series is to enable Platform Runtime Mechanism(PRM) support on
> > ARM64. Not much changes. Just enabling the build and moving the config
> > option so that it is not listed under the topmost menu for ARM64.
> > 
> 
> Ard has slightly modified version of patch 2/4 which updates few other
> arch code. Since the PRMT driver build is dependent on that, is it OK
> for you to ACK if you agree with other 3 patches(1,3,4) so that it can
> be routed via efi tree. Alternatively, Ard has offered to provide a stable
> branch if needed.

Sorry pressed enter too early. I wanted to add reference to the commit in
Ard's efi queue I was referring[1] and the email where we discussed how
to deal with these PRMT patches[2]

-- 
Regards,
Sudeep

[1] https://git.kernel.org/efi/efi/c/8add9a3a2243
[2] https://lore.kernel.org/r/CAMj1kXFc7CaTV3vhJrskL+VZS2rAdb320Be1mhwX4VW=pSsdJA@mail.gmail.com
