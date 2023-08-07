Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AC37718B7
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 05:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjHGDKY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Aug 2023 23:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHGDKX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Aug 2023 23:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869AE10F4
        for <linux-acpi@vger.kernel.org>; Sun,  6 Aug 2023 20:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EC8B60AF3
        for <linux-acpi@vger.kernel.org>; Mon,  7 Aug 2023 03:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61FEEC433C9;
        Mon,  7 Aug 2023 03:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691377821;
        bh=mGgf2F0PdoAu01r3Q8tJAt7qo0xuhEP8Y43j4ySUSEU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ObJVWqjJax0qCB7Zqguj/MHJRSa2ZUa9mSN1qoUef7jDwP09bBvWmiTpZlVv4E6Yc
         wXtni5d+Ioy5fKsOjhmRqB63wgQ+YLah2YLOPYMbucFb9RbN5Dtb4xaM5qeyIKX57t
         togNAZMq2K4wPJB5TKsVxY3Iyt/UdL2l9Ni0XIuffYrdeMjSEQwgKA/RgGV0svL44J
         ee3kuOzGNROslf4kNNuOswi9blvdK3DK5PGvC5IGZkUkaBP+bgfQen6EBJ+KVG4A4O
         SstCA174WEH7LfAxNOXH1x5vdZnqHS1BorxaZsTMZMPVCqg11tsKrdzQuxb5dLeL4s
         f0m8f1HiSqcoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47749E505D4;
        Mon,  7 Aug 2023 03:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] platform/chrome: chromeos_acpi: support official HID
 GOOG0016
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169137782128.31484.565951557345548988.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 03:10:21 +0000
References: <20230731024214.908235-1-tzungbi@kernel.org>
In-Reply-To: <20230731024214.908235-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, rafael@kernel.org,
        lenb@kernel.org, guillaume.tucker@collabora.com,
        denys.f@collabora.com, ricardo.canuelo@collabora.com,
        usama.anjum@collabora.com, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon, 31 Jul 2023 10:42:14 +0800 you wrote:
> Support official HID GOOG0016 for ChromeOS ACPI (see [1]).
> 
> [1]: https://crrev.com/c/2266713
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Changes from v2[2]:
> - Instead of replacing, appending "GOOG0016" in sysfs-driver-chromeos-acpi.
> 
> [...]

Here is the summary with links:
  - [v3] platform/chrome: chromeos_acpi: support official HID GOOG0016
    https://git.kernel.org/chrome-platform/c/703e77134ebf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


