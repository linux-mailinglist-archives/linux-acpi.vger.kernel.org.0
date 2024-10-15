Return-Path: <linux-acpi+bounces-8806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8563D99F878
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 23:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063BEB20AA2
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 21:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BB01FBF42;
	Tue, 15 Oct 2024 21:01:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C61F9ED8;
	Tue, 15 Oct 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026086; cv=none; b=kvBpcqDoYI8Nvw7oHQ38ajeW06Cga+Muu1ihBuzv5xe8OTo80H+0sNP+/AeIkpggBIHeZmnMRVEQPKxG3d5jD3E0V5VlCn+tZj5DptMMDNX/+HdHCeOCMFEKlxZM5/ssULwB7nwSgRMSUrQcNA1t+/xKPmAB41Xr/a9jJBNjoSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026086; c=relaxed/simple;
	bh=N1hEchc/2XTzoorfyS2708tEKgnm+DrlsQ7RPL4btDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=glF+xJxRuOaPqODuqSmod+3ntUkI+Ahjp5FSAWs0zI0LnFQhMaWk9iquBat5kUPL5/FJhIzPepSNnIvLWBVZYZ2zZ4VDnZEuLuGWtffHOzQbdDdVADms9g8A21FBfb5jC47Se6M88CSmcM3PVbJ+BsI6gPm0xqh35j3kP72Yxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C205CC4CEC6;
	Tue, 15 Oct 2024 21:01:25 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 6BFDE1060437; Tue, 15 Oct 2024 23:01:23 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, chrome-platform@lists.linux.dev
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
Subject: Re: [PATCH 0/8] power: supply: core: remove
 {,devm_}power_supply_register_no_ws()
Message-Id: <172902608343.467915.12779076525660728753.b4-ty@collabora.com>
Date: Tue, 15 Oct 2024 23:01:23 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Sat, 05 Oct 2024 12:05:02 +0200, Thomas Weißschuh wrote:
> The meaning of the _no_ws() suffix is not immediately clear when reading
> the code. Furthermore there is already a dedicated API to configure the
> details of the created power supply in "struct power_supply_config".
> Migrate the functionality to "struct power_supply_config" and remove the
> special functions.
> 
> 
> [...]

Applied, thanks!

[1/8] power: supply: core: add wakeup source inhibit by power_supply_config
      commit: 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
[2/8] ACPI: battery: Register power supply with power_supply_register()
      commit: 2de244e91ddf5cfcf7d88275ad2dbe7f0367e57e
[3/8] power: supply: acer_a500_battery: register power supply with devm_power_supply_register()
      commit: 8c3985bb4e78fb487621dce733fae387fce174a8
[4/8] power: supply: bq27xxx_battery: register power supply with power_supply_register()
      commit: 1011646d4bd6c2eedb68d131ba7ddaf9ecd2aa9e
[5/8] power: supply: cros_usbpd-charger: register power supply with devm_power_supply_register()
      commit: e8d2dfa6d246b2b879287c79098a1960b3856533
[6/8] power: supply: lenovo_yoga_c630_battery: register power supplies with power_supply_register()
      commit: 705833305a7a68d6ff163626abd81735940b7751
[7/8] power: supply: max77976_charger: register power supply with devm_power_supply_register()
      commit: 79b9630e6fc80f225e1564b42cae154970f31136
[8/8] power: supply: core: remove {,devm_}power_supply_register_no_ws()
      commit: 85d319e14f301e1c68131b74c1dceabae73d1e81

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


