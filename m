Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6766E4C52
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Apr 2023 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjDQPDX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Apr 2023 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjDQPDT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Apr 2023 11:03:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F69610D1
        for <linux-acpi@vger.kernel.org>; Mon, 17 Apr 2023 08:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E13F96269E
        for <linux-acpi@vger.kernel.org>; Mon, 17 Apr 2023 15:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283B7C4339B;
        Mon, 17 Apr 2023 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681743796;
        bh=kWHpiwD8xunqRAaRi4kWw+LZqZ1I/IzV1v4i3W6VoQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ts+o9lqo1Ms5fZgT5TvAmwxz6rpeT+BVHX9KY+yOFYHKpFoJh2OfU+hhw/yVeOB1t
         V9c768hWsHscOKyemy9cHXo+DpCUrK8IGXHCyCaBcqYWDsspWxHGqRRwUqjmhmKrbk
         aVKAiDbIDvri6FH4a+YUbYBk2ImpGQWpQ2lpC2J9t7cnjZKFeXZRYpwuHeJfqVFgRQ
         nUO0dieZKcUenyZUhF1hBolGNu8R1rzV5VhYKJbJLMmgTTLMRhYqB2bn1BP4qpxexF
         PsUcT1d9wVDifxppb6KvqWRYdpyQOhqkRj2kuN5J+w13SW9z3epvhzNWtkb3fDEOOT
         CpziCnPAGyF0Q==
From:   Will Deacon <will@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: AGDI: Improve error reporting for problems during .remove()
Date:   Mon, 17 Apr 2023 16:03:04 +0100
Message-Id: <168173076341.2850238.5382648418786496787.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
References: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 14 Oct 2022 18:06:23 +0200, Uwe Kleine-König wrote:
> Returning an error value in a platform driver's remove callback results in
> a generic error message being emitted by the driver core, but otherwise it
> doesn't make a difference. The device goes away anyhow.
> 
> So instead of triggering the generic platform error message, emit a more
> helpful message if a problem occurs and return 0 to suppress the generic
> message.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: AGDI: Improve error reporting for problems during .remove()
      https://git.kernel.org/arm64/c/858a56630a84

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
