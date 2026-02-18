Return-Path: <linux-acpi+bounces-21007-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEfTMeAYlmkSaAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21007-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 20:54:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B4C1593D5
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 20:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8D3F3009082
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40E0348453;
	Wed, 18 Feb 2026 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbRhAkVm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21CF347BC6
	for <linux-acpi@vger.kernel.org>; Wed, 18 Feb 2026 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444443; cv=none; b=OwB9LxYVtAj9nOCtUx0gpNAU9rZ3khcII7tGOjOA+WUFZ8UbjQh0ieFC7KzlQaTLFBQEhpR7D72lyiyPMHwZ08NID1MpG1S1+hZueXyP7g8yyU2df2aCrL0QPXsQcCUh/3LXhBmKX3PRqAqiF97ASR41P7q4YlHd5enXoY9QyQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444443; c=relaxed/simple;
	bh=g8wFqdB+G/F5u2x9LDdb7/mOaybOMKosKCuSAMI1vbg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SuqW5HT8CZLURbWXE0Hd2GcJI7Dn0Mdd+mIBb+iJWZbHjse1D9KCbGd3ITe7LFKySLjYjC/1t3NByIbGY6zjQ/+PY2RJ32JFnlADUIJyU63/NHTCUWnbs5YT5+eUAtefV56/KT97drjt8RCkbDKczl4POh+LhFPFzzfRgeTTf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbRhAkVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0DAC2BCC4
	for <linux-acpi@vger.kernel.org>; Wed, 18 Feb 2026 19:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771444443;
	bh=g8wFqdB+G/F5u2x9LDdb7/mOaybOMKosKCuSAMI1vbg=;
	h=From:Date:Subject:To:Cc:From;
	b=UbRhAkVmWAhJl3AKnIrNjnj1TVPNYKJqs1sxQmEk/bSJ9Jh9u2hK97TbKFknRe6xU
	 RImSAYVSQmh4WmQNCbc8YOU/uaOtrs+oOi+mpD/+uHB+05jVqLjl5VkvLzlaOL0uyg
	 +fZqLQSS4JQ/IJ4LdNlP+Vjld9sGLpMoy7bTi2813b8gmvMmJ56mqZiDdxp3v6Lf2T
	 fT+sSASH3hB/TSMC+J02IJt+n1Vd69sbYXAotSunxw+wiv/k+GOxmafT403LwCHd4c
	 TvOzRlR79CzR/XNcNbMLwq2m0RDi6vDqYeP78BjEdZo0LCrAUiKUKegEMfv0Tzhl4w
	 dn3k1GuLMBXBA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-46390d4ac7bso123124b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Feb 2026 11:54:03 -0800 (PST)
X-Gm-Message-State: AOJu0Yy5gfCBIsjGtQ1d9pvqx0Xpc5ghLxslGjS2ClOxa3KIRecoTFMw
	mxpL6AGtygVt/2NGnaigm7sotTMAG5+X/Tzmsq43+BGjJn+KLyEE7iuSzAnm6oUt5obdXL8jfXG
	yAxCLfcVFHCjkvT3ly20llqxawThYbKg=
X-Received: by 2002:a05:6808:4fd4:b0:441:8f74:fcc with SMTP id
 5614622812f47-46410d0cbf1mr1710296b6e.57.1771444442615; Wed, 18 Feb 2026
 11:54:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Feb 2026 20:53:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hz6b7Dtr_Q40y8yqQ+iOrzcobuALzSM+p7tyTKZaKScw@mail.gmail.com>
X-Gm-Features: AaiRm52yXzyU7MXoArnkWsHsR3-W4TKb8p_JMyPBJiYgzyVtiCDfVtzBX5pFNLM
Message-ID: <CAJZ5v0hz6b7Dtr_Q40y8yqQ+iOrzcobuALzSM+p7tyTKZaKScw@mail.gmail.com>
Subject: [GIT PULL] More ACPI support updates for v7.0-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21007-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70B4C1593D5
X-Rspamd-Action: no action

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.0-rc1-2

with top-most commit b89d8be0dcf9d734583f10d88b85256ec67dd0dd

 Merge branches 'acpi-battery', 'acpi-button' and 'acpi-driver'

on top of commit d84e173311c4f0b0300755e6445f3224d252eeed

 Merge tag 'acpi-6.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI support updates for 7.0-rc1.

These are mostly fixes and cleanups on top of the ACPI support updates
merged recently, including two new quirks, an ACPI CPPC library fix, and
fixes and cleanups of a few core ACPI device drivers:

 - Add an unused power resource handling quirk for THUNDEROBOT ZERO (Zhai
   Can)

 - Fix remaining for_each_possible_cpu() in the ACPI CPPC library to use
   online CPUs (Sean V Kelley)

 - Drop redundant checks from the ACPI notify handler and the driver
   remove callback in the ACPI battery driver (Rafael Wysocki)

 - Move the creation of the wakeup source during the ACPI button driver
   probe to an earlier point to avoid missing a wakeup event due to a
   race and clean up system wakeup handling and remove callback in that
   driver (Rafael Wysocki)

 - Drop unnecessary driver_data pointer clearing from the ACPI EC and
   SMBUS HC drivers and make the ACPI backlight (video) driver clear the
   device's driver_data pointer on remove (Rafael Wysocki)

 - Force enabling of PWM2 on the Yogabook YB1-X90 tablets (Yauhen
   Kharuzhy)

Thanks!


---------------

Rafael J. Wysocki (7):
      ACPI: battery: Drop redundant check from acpi_battery_notify()
      ACPI: button: Call device_init_wakeup() earlier during probe
      ACPI: battery: Drop redundant checks from acpi_battery_remove()
      ACPI: button: Tweak system wakeup handling
      ACPI: button: Tweak acpi_button_remove()
      ACPI: video: Clear driver_data pointer on remove
      ACPI: driver: Drop driver_data pointer clearing from two drivers

Sean V Kelley (1):
      ACPI: CPPC: Fix remaining for_each_possible_cpu() to use online CPUs

Yauhen Kharuzhy (1):
      ACPI: x86: Force enabling of PWM2 on the Yogabook YB1-X90

Zhai Can (1):
      ACPI: PM: Add unused power resource quirk for THUNDEROBOT ZERO

---------------

 drivers/acpi/acpi_video.c |  1 +
 drivers/acpi/battery.c    |  9 +--------
 drivers/acpi/button.c     | 20 ++++++++++++--------
 drivers/acpi/cppc_acpi.c  |  4 ++--
 drivers/acpi/ec.c         |  2 --
 drivers/acpi/power.c      | 13 +++++++++++++
 drivers/acpi/sbshc.c      |  2 --
 drivers/acpi/x86/utils.c  | 12 ++++++++++++
 8 files changed, 41 insertions(+), 22 deletions(-)

