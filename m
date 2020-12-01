Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62B32CA4CA
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403888AbgLAOAR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 09:00:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403876AbgLAOAQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Dec 2020 09:00:16 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1EA32220B;
        Tue,  1 Dec 2020 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831176;
        bh=jbJA4PPu8cTtkIjIyFrCElyBbE/n6qgOGGszsOTDGbM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=L7kryru9I2WHmXO6Ag+CJ/POwl3d7w2rsdp9F4A5+Dt3Awi8KlUB0zmUt8gllXtgp
         60qYJrbteS4K6n4nb3iRGII2bRgMICd/de60/3h2d4b2WQa3qR2kq8A49PYkzE8Wfx
         F9FFaGQNFSNR+uLmZrcku13bvbxmqtVBvbnyralg=
From:   Mark Brown <broonie@kernel.org>
To:     Jie Yang <yang.jie@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
In-Reply-To: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
References: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of resource_intersection()
Message-Id: <160683107676.35139.9521964646147921378.b4-ty@kernel.org>
Date:   Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 24 Nov 2020 11:56:28 +0200, Andy Shevchenko wrote:
> Since we have resource_intersection() helper, let's utilize it here.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: catpt: Replace open coded variant of resource_intersection()
      (no commit info)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
