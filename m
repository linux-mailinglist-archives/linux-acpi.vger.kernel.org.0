Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4680A561B73
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jun 2022 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiF3Nf3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jun 2022 09:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiF3Nf2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jun 2022 09:35:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15362871E
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jun 2022 06:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A9FB82AC5
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jun 2022 13:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA121C34115;
        Thu, 30 Jun 2022 13:35:23 +0000 (UTC)
Date:   Thu, 30 Jun 2022 14:35:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] arm64: Add architecture specific ACPI FFH Opregion
 callbacks
Message-ID: <Yr2ml0vMTgLi+EPZ@arm.com>
References: <20220616090106.2154906-1-sudeep.holla@arm.com>
 <20220616090106.2154906-4-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616090106.2154906-4-sudeep.holla@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 16, 2022 at 10:01:06AM +0100, Sudeep Holla wrote:
> FFH Operation Region space can be used to trigger SMC or HVC calls,
> using the Arm SMC Calling Convention (SMCCC). The choice of conduit
> (SMC or HVC) is based on what the kernel choose based on PSCI as with
> any other users of SMCCC within the kernel.
> 
> Function identifiers only the SMCCC SiP Service, OEM Service and FF-A
> specific call range.
> 
> Offset can be either 0(32 bit calling convention) or 1(64 bit calling
> convention). The length must be set with the range applicable based
> on the value of the offset.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
