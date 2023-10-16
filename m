Return-Path: <linux-acpi+bounces-675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2A57CB2C3
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 20:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9041C20950
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6E4339A7
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0988/uZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9F30FBA
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 17:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAF3C433C7;
	Mon, 16 Oct 2023 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697476780;
	bh=A+l5AGsWFvAwh5Ck0PIKp7u9WxupnnFBmOjdmaSf/xY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m0988/uZMwOxxrh5UofWNdMGE2dCFE6/wauhysHd8WQR9LFa7vw658CJLl+r2sibS
	 kD+/mekQPc4Hsk+ocBQ4H7C31pt6TtFDollYyd0C4o//UkyCfFhA65IjZirqHofArS
	 mYQlNtGFm4Xz9kfC6VT3hjBcaAmz7XNqRLhzgTP4Syg5o+Ltu7HA6TFLuw93ohJSj9
	 IB7UzzEkL1kWyc6WRKi2Oc7U5ibxfclH04cHZMUrIT3+XDbjMvIJvHgTyKJuN0iMps
	 6hd23cZJkq3NJDI0QdDMwStgjtUN3L8vBV/i6X6BI084x1ssA+HTNjiJ9Q1N4ioDlk
	 gpNw1f1DfTnqQ==
From: Mark Brown <broonie@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20231014205314.59333-1-hdegoede@redhat.com>
References: <20231014205314.59333-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH 0/4] spi/ACPI: Add support for SPI WM5102
 coded on Lenovo YT3-X90
Message-Id: <169747677888.71661.12773488493424407339.b4-ty@kernel.org>
Date: Mon, 16 Oct 2023 18:19:38 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Sat, 14 Oct 2023 22:53:10 +0200, Hans de Goede wrote:
> Here is a patch series to fix audio on the Lenovo YT3-X90 x86 Android
> tablet.
> 
> This series takes care of instantiating the SPI device for the codec,
> to make things fully work there also are some sound/soc/intel/boards
> changes necessary which I'm still working on.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: Export acpi_spi_find_controller_by_adev()
      commit: a8ecbc54165fca767e75a82372a7be3810c667cf

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


