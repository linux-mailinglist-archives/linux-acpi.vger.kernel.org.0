Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9515645CB1E
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Nov 2021 18:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhKXRjr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Nov 2021 12:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhKXRjq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Nov 2021 12:39:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D46D760FE3;
        Wed, 24 Nov 2021 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637775396;
        bh=HmpZ/PgUokyQPcT3gkW2G68BXXRTTkFFIjflrvUeDeg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dZ2UsOvQoRZrv0cH6UL+Xr4aUgGtGWoib5B1mgMftX6fEQTp29HHNQZwr7AzrHWkM
         qxiobFcepuKJIdMWgAjbXBwS11s3tbpXjJRqzqUgHfJNt1zNTtKmhk9K+qg6jOq40v
         2vQvSKw3M8jb39mnaN3paQo8SXtyg7k6SW6xXOKn+cb3o09bJ1fqroDIBEeP5F0nhK
         IW+8XLI1fYeEBcwuoCPYSMr30CeHUDLpTENtPq4VF/5CHBMAqL6N2hzyAxM4cH7JHc
         R9yG9Eg1241pw4sOK9YGRVoFKxiDcXFSx1hqPsnLs0usjbj5m/GeYZbD049HxsZTuR
         FiQ0J7cvlgeSQ==
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Kailang Yang <kailang@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Shuming Fan <shumingf@realtek.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        platform-driver-x86@vger.kernel.org,
        Jeremy Szu <jeremy.szu@canonical.com>,
        alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Loone <sami@loone.fi>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Elia Devito <eliadevito@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jack Yu <jack.yu@realtek.com>, patches@opensource.cirrus.com
In-Reply-To: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v3 00/11] Add support for Legion 7 16ACHg6 laptop
Message-Id: <163777539060.2712035.8727444012645430033.b4-ty@kernel.org>
Date:   Wed, 24 Nov 2021 17:36:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 23 Nov 2021 16:31:38 +0000, Lucas Tanure wrote:
> Add support for laptops that have CS35L41 connected to an
> HDA codec by I2S and direct I2C/SPI connection to the CPU
> 
> Hardware:
>  - The 16ACHg6 laptop has two CS35L41 amplifiers, connected
> to Realtek ALC287 by an I2S bus and by and direct I2C to the CPU.
>  - The ALC287 codec is connected to the CPU by an HDA bus.
>  - The CS35L41 has a DSP which will require firmware to be loaded.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[01/11] ASoC: cs35l41: Set the max SPI speed for the whole device
        commit: 872fc0b6bde8b2dd6891c740cd792d214255dca3

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
