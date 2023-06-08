Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7F672870A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jun 2023 20:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjFHSRd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jun 2023 14:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjFHSRd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jun 2023 14:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD31993
        for <linux-acpi@vger.kernel.org>; Thu,  8 Jun 2023 11:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED56065048
        for <linux-acpi@vger.kernel.org>; Thu,  8 Jun 2023 18:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F88C433D2;
        Thu,  8 Jun 2023 18:17:29 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2] ACPI: bus: Consolidate all arm specific initialisation into acpi_arm_init()
Date:   Thu,  8 Jun 2023 19:17:27 +0100
Message-Id: <168624824297.2144121.7604084247404819078.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606093531.2746732-1-sudeep.holla@arm.com>
References: <20230606093531.2746732-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 06 Jun 2023 10:35:31 +0100, Sudeep Holla wrote:
> Move all of the ARM-specific initialization into one function namely
> acpi_arm_init(), so it is not necessary to modify/update bus.c every
> time a new piece of it is added.
> 
> 

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: bus: Consolidate all arm specific initialisation into acpi_arm_init()
      https://git.kernel.org/arm64/c/fcea0ccf4fd7

-- 
Catalin

