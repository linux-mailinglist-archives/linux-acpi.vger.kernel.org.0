Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE2E6287D5
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Nov 2022 19:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbiKNSFa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Nov 2022 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbiKNSFN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2022 13:05:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C428E15
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 10:05:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E12ADB80E98
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 18:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71269C433D6;
        Mon, 14 Nov 2022 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668449100;
        bh=s719NopWNYNskNuv6HMDRVgljOwYq2eXiLfDU4n8Zn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJNX9ll3svfaDXA5B+PJ9ME2DdNzMeyYGVPg5YXro5kKV0ItTtJhuUfKLf8gSeMK+
         cX2vwF2DB5EFPJ+tJKlTHnR86R0IN/qvukvVQxN1Mh6+9FyQ9IlguMdKbXpIA7CYar
         SJQv+gMEQcEFdsdPdgh7OUl3AIkMkYPpI1iYd9jV1618wsxQA7kNnOCD+1TD7BOroG
         gBHRbwLct46HuvWQ2LvU0jmfjLmxAGIidfn8qGlnbxC6AMinNRZyIxM+82Y5WlDO/+
         HiqTk+yz6UIy229xocmDA3JUtCGpK88Z3NizibIy/00IvafiRcNR8KsrQdyZJTOic5
         B9lTNoVFsULFA==
Date:   Mon, 14 Nov 2022 18:04:55 +0000
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 2/2] arm64: Add architecture specific ACPI FFH
 Opregion callbacks
Message-ID: <20221114180454.GB31476@willie-the-truck>
References: <20221110134505.1375955-1-sudeep.holla@arm.com>
 <20221110134505.1375955-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110134505.1375955-3-sudeep.holla@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 10, 2022 at 01:45:05PM +0000, Sudeep Holla wrote:
> FFH Operation Region space can be used to trigger SMC or HVC calls,
> using the Arm SMC Calling Convention (SMCCC). The choice of conduit
> (SMC or HVC) is based on what the kernel choose based on PSCI as with
> any other users of SMCCC within the kernel.
> 
> Function identifiers only in the SMCCC SiP Service, OEM Service and FF-A
> specific call range are allowed in FFH Opregions.
> 
> Offset can be either 0(32 bit calling convention) or 1(64 bit calling
> convention). The length must be set with the range applicable based
> on the value of the offset.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Hi Will,
> 
> Catalin had acked the changes to be routed via PM tree for last or the
> one previous merge window. Since we were waiting for ACPICA changes, it
> was not merged. Now that ACPICA changes are queued(via PM tree), I will
> ask Rafael to take these patches now. Just thought I will let you know
> since you are handling upcoming merge window and I do see few ACPI related
> changes there. I don't see any conflict with this, so it should be fine.
> 
> Please let me know if you are fine with that and ack is an add-on :).

I'm happy either way, so I'll leave this for Rafael but just poke me if you
want me to queue them instead.

Will
