Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7B62A15D
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Nov 2022 19:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKOSdV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Nov 2022 13:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiKOSdS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2022 13:33:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A12FFE2;
        Tue, 15 Nov 2022 10:33:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6408061999;
        Tue, 15 Nov 2022 18:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C6BC433B5;
        Tue, 15 Nov 2022 18:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668537185;
        bh=ID/TkfhvqQbmMbP2RQpeZzpQCLv173RpYxcmeuuVeV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxvH/d/ye3gti+cGFmyQAyV4jxqVAh/tsYANnyPe9IRkQzuC4DiSMDdc3PFOJ8Z4U
         qi8XVux50UfHRG4sAG3uu21Y/OMEo6QdBIW/I5kmI9dy7C77FcSH+0RHtwujj/q7z/
         JiJHouS34xJ15gEwqb1iWuLQqtdllC8XEVz8PfpdevZIVkHduolbLZwlAIp1H6nhEq
         vkRxati/1rVZmteuComOmEEYNnIiet/nb62qRJnIhNqxrFbI2mDKTZwhnB3KTpuyJf
         vgxpsV/68rQzeGVD6wIrpV+E9oS3PPyxULN6sg3FB24vHMvq2X4b2EXRqtmpQ6gW2J
         hg3VpGO4DPBgQ==
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-acpi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vsethi@nvidia.com, jonathanh@nvidia.com, treding@nvidia.com
Subject: Re: [PATCH] ACPI: APMT: Fix kerneldoc and indentation
Date:   Tue, 15 Nov 2022 18:32:52 +0000
Message-Id: <166851774505.1276710.18258492960725102184.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221111234323.16182-1-bwicaksono@nvidia.com>
References: <20221111234323.16182-1-bwicaksono@nvidia.com>
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

On Fri, 11 Nov 2022 17:43:23 -0600, Besar Wicaksono wrote:
> Add missing kerneldoc and fix alignment on one of the arguments of
> apmt_add_platform_device function.
> 
> 

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: APMT: Fix kerneldoc and indentation
      https://git.kernel.org/arm64/c/39522031798d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
