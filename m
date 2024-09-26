Return-Path: <linux-acpi+bounces-8422-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD35986B20
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 05:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664CF1C21718
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 03:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DAB176AC2;
	Thu, 26 Sep 2024 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRVe/Mxo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9E610B;
	Thu, 26 Sep 2024 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319606; cv=none; b=mS6EuyGAzEObICiCAH6Oxrwyz6xoW5oqQKFajFKtFyqufrqzR5DqnVx3U0i2/oEzxSbP0g+oQx0rD6w8KENvOP2mIVsQ4SCrjiR5FyqKS3CD3baxJIKBkfTikRUMoXpF2Dgs7N8/GgADXGJMWnKh2Ht2NCEOZosg+O0KwLeexGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319606; c=relaxed/simple;
	bh=LLmiAXtsIyO+yfJ37Su7Obl5iZtlZD5rocWYHoUPqyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkt224Jvp+yJabDLB1gkhHIfNQmVn993PD5uksVujBj2crm7Tvx0PypPVm1cq79Sf+88kRoTcfS22tpuBzlBhnfDBMo5PuzZSRq47+XCI6dxYyCdOeIg0KBUCxX+yHbMvDUsyzFWCjRg+UVkWQT5WqtDI6n4UOyGOinCmghPtCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRVe/Mxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7AEC4CEC3;
	Thu, 26 Sep 2024 03:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727319606;
	bh=LLmiAXtsIyO+yfJ37Su7Obl5iZtlZD5rocWYHoUPqyY=;
	h=From:To:Cc:Subject:Date:From;
	b=bRVe/Mxo2PtejLMa9e6bXov+Wsma/g4O2GsMpaWYc21reyckhnRBIRKKCGl3cK2Zz
	 bcelVVguKkbpwebF7rfM8nNhJdRxTIh+I4dAcohpAb+bwipU11Qjl7KGbdHcRTPzut
	 JvoTLHM9iU6Or1WrFLESCXDbW/Gi9JJw2H0p2ZTWUBGYPrDHwja3Pk0wlrP3WBbkDa
	 WaQ+ds+qQZD01J8DvjQ8BZ6w85pNd8dpObUqN1NQksEVXmvp7xT4RqQNyJQ2UJ2m84
	 45XkC1y3+6m6wM/vkMuylBY5+hbSMoAnZ/3fGrxEeFvGWz4gdgdFzba1eYmZl4nbAt
	 yOcVmpKvuEs0w==
From: Mario Limonciello <superm1@kernel.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: platform-driver-x86@vger.kernel.org (open list:AMD PMF DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org (open list:ACPI),
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC 0/2] "custom" ACPI platform profile support
Date: Wed, 25 Sep 2024 21:59:53 -0500
Message-ID: <20240926025955.1728766-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

There are two major ways to tune platform performance in Linux:
 * ACPI platform profile
 * Manually tuning APU performance

Changing the ACPI platform profile is a "one stop shop" to change
performance limits and fan curves all at the same time.

On AMD systems the manual tuning methods typically involve changing
values of settings such as fPPT, sPPT or SPL.

The problem with changing these settings manually is that the definition
of the ACPI platform profile if supported by the hardware is no longer
accurate.  At best this can cause misrepresenting the state of the
platform to userspace and at worst can cause the state machine into an
invalid state.

The existence and continued development of projects such as ryzenadj which
manipulate debugging interfaces show there is a demand for manually tuning
performance.

Furthermore some systems (such as ASUS and Lenovo handhelds) offer an
ACPI-WMI interface for changing these settings. If using anything outside
that WMI interface the state will be wrong.  If using that WMI interface
the platform profile will be wrong.

This series introduces a "custom" ACPI platform profile and adds support
for the AMD PMF driver to use it when a user has enabled manual
adjustments.

If agreeable a similar change should be made to asus-armoury and any other
drivers that export the ability to change these settings but also a
platform profile.

Mario Limonciello (2):
  ACPI: Add support for a 'custom' profile
  platform/x86/amd: pmf: Add manual control support

 Documentation/ABI/testing/sysfs-amd-pmf       | 10 +++
 .../ABI/testing/sysfs-platform_profile        |  1 +
 drivers/acpi/platform_profile.c               |  1 +
 drivers/platform/x86/amd/pmf/Makefile         |  1 +
 drivers/platform/x86/amd/pmf/core.c           |  9 ++
 drivers/platform/x86/amd/pmf/manual.c         | 88 +++++++++++++++++++
 drivers/platform/x86/amd/pmf/pmf.h            |  5 ++
 drivers/platform/x86/amd/pmf/sps.c            |  4 +
 include/linux/platform_profile.h              |  1 +
 9 files changed, 120 insertions(+)
 create mode 100644 drivers/platform/x86/amd/pmf/manual.c

-- 
2.43.0


