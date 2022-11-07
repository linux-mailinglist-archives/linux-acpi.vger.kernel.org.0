Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6AD61FE37
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Nov 2022 20:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKGTJc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Nov 2022 14:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiKGTI7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Nov 2022 14:08:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA66A24BDD
        for <linux-acpi@vger.kernel.org>; Mon,  7 Nov 2022 11:08:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 656C361290
        for <linux-acpi@vger.kernel.org>; Mon,  7 Nov 2022 19:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAF5C433B5;
        Mon,  7 Nov 2022 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667848137;
        bh=2SNSQEs+6pZ1IIKlS94kFNpgSNonP39J6z3hPrh59DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rzyrk/qP9Mk+zQjiahLLf4GYx3pWGHmmxrxbtvgN5J1XPIZC/X2OtLcY94FGbXvDL
         wZMfvg8rxGhPz5RMMMYEHUfVPJvzK7hfxjQm5hU6SfjRACNiCcBZmGsQnVMPgQsm1v
         6tNgoSxj4UGq0xjg/Q3xC9uBYaa+kdHBhwJl5yV3YmjN1CdQ9FiI/A4s0sq5p9cR0U
         KEZusb+tPykBcbh/udVnoHKjNu8gLBDPCjISqDY6itLmHwbYqorOQw8BxbCdPsoeqJ
         54+fdg6BORhKYng8TfCCq2Sz+RS/5f3gFnuJZbduVlVChUBchxoRHNK4CLNSQCTWTz
         J07t+wzsjw4EA==
From:   Will Deacon <will@kernel.org>
To:     lpieralisi@kernel.org, sudeep.holla@arm.com, guohanjun@huawei.com,
        Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, nicolinc@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI/IORT: Update SMMUv3 DeviceID support
Date:   Mon,  7 Nov 2022 19:08:38 +0000
Message-Id: <166783554364.29371.14948432358850683973.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <4b3e2ead4f392d1a47a7528da119d57918e5d806.1664392886.git.robin.murphy@arm.com>
References: <4b3e2ead4f392d1a47a7528da119d57918e5d806.1664392886.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 28 Sep 2022 20:21:26 +0100, Robin Murphy wrote:
> IORT E.e now allows SMMUv3 nodes to describe the DeviceID for MSIs
> independently of wired GSIVs, where the previous oddly-restrictive
> definition meant that an SMMU without PRI support had to provide a
> DeviceID even if it didn't support MSIs either. Support this, with
> the usual temporary flag definition while the real one is making
> its way through ACPICA.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI/IORT: Update SMMUv3 DeviceID support
      https://git.kernel.org/arm64/c/05da178ce0aa

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
