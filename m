Return-Path: <linux-acpi+bounces-5982-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55138CF7EB
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 05:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF491F20F4A
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 03:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996EA523A;
	Mon, 27 May 2024 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLwAnQh9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD379E1;
	Mon, 27 May 2024 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779226; cv=none; b=bvc9+lTHmB756ghHlz60I+i0u//2iaP6Hp66xmV5UU7mjzOB9YI5l1veOY18CcI70ZeJKowpnm05CqsLuAlBE989IfUeAZ+/RjCJW6v0gmV6AFXhIJuIHUhJ3Rq9Z2Lye2YmMELEqDW1gjpfISGmQSctvsANasDP3SOFEu9CGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779226; c=relaxed/simple;
	bh=C33d2bsfpP85hL2H7m104ihPh1qEsm4+V/IrMSXkFww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pOafTilqeztJzLAhF3aTaUPRyTVUqrTj1EtywS4EC53nq5F9rDDqJaY9HCDxYiSAArA0GukH3O+aZigbU3xXXF7dnftYpJYR/T3+NLHavqDWw5yPuaVgclnunhOEVSJLUCjy4e+5tgxTEnzQVJ708yAGsj4tKvm0UQnO1mA3J5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLwAnQh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6F49C4AF07;
	Mon, 27 May 2024 03:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716779226;
	bh=C33d2bsfpP85hL2H7m104ihPh1qEsm4+V/IrMSXkFww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZLwAnQh9aenvjcS4zJK+gncNSAqPF7Fotx1ZAW/toTfPv8ziUn9JTznwRKzKn0AMU
	 NIKDoKB3+KPoCpFuuZHoXlYss4UxhbX5UKtkyD7FCRTfsPrIlazfbjb46ORKEiAeBn
	 tTIAo4OM885XqO1JZUXwYHXwgRlCapLmIJxNyWpQ/h+YlafQEtrHHwJ7RfAfsu7/du
	 4Ynt+TWRlUrwopJDAlI+9Lp+sPw8J+OccLEmdCoKE9dwF90LPK3+94zYrvJy/AIviV
	 aFL2XskCy7W3CyIchVkCyFC6IUWG7iAf0fdhDyfWpBuTN7jII2DTO37wgINKxnLknZ
	 TqSJ+GPIIMkkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB932CF21E0;
	Mon, 27 May 2024 03:07:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/19] ACPI: store owner from modules with
 acpi_bus_register_driver()
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171677922582.1901.13180698074566654987.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 03:07:05 +0000
References: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
In-Reply-To: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
 dmitry.torokhov@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bleung@chromium.org, tzungbi@kernel.org,
 corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, cascardo@holoscopio.com, pali@kernel.org,
 matan@svgalib.org, malattia@linux.it, coproscefalo@gmail.com,
 akaher@vmware.com, amakhalov@vmware.com, pv-drivers@vmware.com,
 richardcochran@gmail.com, tytso@mit.edu, Jason@zx2c4.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org,
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, rafael.j.wysocki@intel.com

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Rafael J. Wysocki <rafael.j.wysocki@intel.com>:

On Thu, 28 Mar 2024 20:49:10 +0100 you wrote:
> Changes in v2:
> - Correct input and platform/chrome subjects.
> - Add acks.
> - Link to v1: https://lore.kernel.org/r/20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org
> 
> Merging
> =======
> All further patches depend on the first amba patch, therefore one way is
> to ack and take it via one tree, e.g. ACPI.
> 
> [...]

Here is the summary with links:
  - [v2,01/19] ACPI: store owner from modules with acpi_bus_register_driver()
    https://git.kernel.org/chrome-platform/c/48b9c4862bd3
  - [v2,02/19] Input: atlas - drop owner assignment
    https://git.kernel.org/chrome-platform/c/726c149e0798
  - [v2,03/19] net: fjes: drop owner assignment
    https://git.kernel.org/chrome-platform/c/3bdef399d00e
  - [v2,04/19] platform/chrome: wilco_ec: drop owner assignment
    https://git.kernel.org/chrome-platform/c/245d97ff3473
  - [v2,05/19] platform: asus-laptop: drop owner assignment
    https://git.kernel.org/chrome-platform/c/eda8304c74f0
  - [v2,06/19] platform: classmate-laptop: drop owner assignment
    https://git.kernel.org/chrome-platform/c/be24e9a09337
  - [v2,07/19] platform/x86/dell: drop owner assignment
    https://git.kernel.org/chrome-platform/c/1baad72e9026
  - [v2,08/19] platform/x86/eeepc: drop owner assignment
    https://git.kernel.org/chrome-platform/c/4313188f8128
  - [v2,09/19] platform/x86/intel/rst: drop owner assignment
    https://git.kernel.org/chrome-platform/c/68370cc2e32a
  - [v2,10/19] platform/x86/intel/smartconnect: drop owner assignment
    https://git.kernel.org/chrome-platform/c/e84a761f1215
  - [v2,11/19] platform/x86/lg-laptop: drop owner assignment
    https://git.kernel.org/chrome-platform/c/2929a735d92e
  - [v2,12/19] platform/x86/sony-laptop: drop owner assignment
    https://git.kernel.org/chrome-platform/c/562231f34cea
  - [v2,13/19] platform/x86/toshiba_acpi: drop owner assignment
    https://git.kernel.org/chrome-platform/c/b655cda9f089
  - [v2,14/19] platform/x86/toshiba_bluetooth: drop owner assignment
    https://git.kernel.org/chrome-platform/c/ce69eeb2ccb7
  - [v2,15/19] platform/x86/toshiba_haps: drop owner assignment
    https://git.kernel.org/chrome-platform/c/eb22f3ba0c2e
  - [v2,16/19] platform/x86/wireless-hotkey: drop owner assignment
    https://git.kernel.org/chrome-platform/c/d49c09ddfbd5
  - [v2,17/19] ptp: vmw: drop owner assignment
    https://git.kernel.org/chrome-platform/c/cd3eda2e3508
  - [v2,18/19] virt: vmgenid: drop owner assignment
    https://git.kernel.org/chrome-platform/c/00e8b52bf9f9
  - [v2,19/19] ACPI: drop redundant owner from acpi_driver
    https://git.kernel.org/chrome-platform/c/cc85f9c05bba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



