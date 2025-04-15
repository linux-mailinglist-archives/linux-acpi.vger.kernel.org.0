Return-Path: <linux-acpi+bounces-13056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B24A8A4C0
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF32D7ADD73
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94429A3D6;
	Tue, 15 Apr 2025 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWseol79"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F241494A3;
	Tue, 15 Apr 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736245; cv=none; b=hDaD/5nWvgOeGoYIZ5Wf9q3l1YNDKUCT3r4dqU5Ci8b4CKkDLeP8SiSFjoxaIq4JoRx5zrv7eW40cF4gm+wiy7Ki1RqIzAJ9ez8nuczeSWka10EPc1Kz77ipLqjCycya1ljkNiljyWEir0TWY6c8o61xjf9bEDICTd/1/hIWaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736245; c=relaxed/simple;
	bh=alrqyRm48WLvuQGl7bdKf6c5+gS/YVlNrjKResCyAEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfxQxXWkW/cGcknNfWtMiwyr34Vm67Oze4SaLf/w3xJvKLg8K0YZ7XkxdYKyWJiaMSu7MBX9Ucgyo5fjiBO18K67e+KG63JsXO11eX9NTcoTmJ7vr76PQ186hT7QZuqgUicHqZgnAdoOiyI3yNygYTHo/B/JvkHqrvpZwe1lKJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWseol79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09765C4CEEC;
	Tue, 15 Apr 2025 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744736244;
	bh=alrqyRm48WLvuQGl7bdKf6c5+gS/YVlNrjKResCyAEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWseol79z9zlW3qeKH2e1414IzoPScAHm/xoOlgnJbs7ifNe0VjvhmbliVeuciJyP
	 NL3opYM7EzfJhQz6udIdKUWdB7WauReNmd//ID5vBSkjPqX266swTfdWguRgphuVds
	 TuyRe4P2FurS0SroE9syQ3twm5SR9ZAc+RTCZrnRp129b18vhv4eVDDraYUdh2TaaK
	 LKJ2vU2D+vRhXTJfOglrO8kgCMz+urdmTc3kB2dLUfGmnDuOrsPYAVoCQaNTSxMHO/
	 02jUSqqmmSAgy6rJBWWnrtVq4dTQ02RR8W9PboFpqxiJapMR0DzZga2E0Y4iei6J0/
	 6CFLAb01/d8nA==
Date: Tue, 15 Apr 2025 17:57:18 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-usb@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [GIT PULL] Immutable branch between LEDS, Base and USB due for the
 v6.16 merge window
Message-ID: <20250415165718.GC372032@google.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>

Enjoy!

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/ib-leds-base-usb-v6.16

for you to fetch changes up to 08ca89e98620c08d68b7e7aed6c9294698e214e1:

  usb: typec: tcpm: Use fwnode_get_child_node_count() (2025-04-10 10:12:28 +0100)

----------------------------------------------------------------
Immutable branch between LEDS, Base and USB due for the v6.16 merge window

----------------------------------------------------------------
Andy Shevchenko (4):
      device property: Split fwnode_get_child_node_count()
      leds: pwm-multicolor: Use fwnode_get_child_node_count()
      leds: ncp5623: Use fwnode_get_child_node_count()
      usb: typec: tcpm: Use fwnode_get_child_node_count()

 drivers/base/property.c                | 12 ++++++------
 drivers/leds/rgb/leds-ncp5623.c        |  5 ++---
 drivers/leds/rgb/leds-pwm-multicolor.c |  7 +++----
 drivers/usb/typec/tcpm/tcpm.c          |  6 ++----
 include/linux/property.h               |  7 ++++++-
 5 files changed, 19 insertions(+), 18 deletions(-)

-- 
Lee Jones [李琼斯]

