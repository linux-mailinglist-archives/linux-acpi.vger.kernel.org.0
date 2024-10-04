Return-Path: <linux-acpi+bounces-8557-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5765C990A4A
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 19:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3BC1F23C27
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D501D9A71;
	Fri,  4 Oct 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0ZlecNm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E01CACDA;
	Fri,  4 Oct 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063619; cv=none; b=uudBSAe7jR047NHBsuCIQkj7uDDc5sJC9HRcF0uDdlJene4MP3iPpfAXTEx1lWiUHT6DN80PrqBtYEAF2+i2GHv2R/4CVRDEPzDwzgUPCgDrjuwZ4Ja12aVgffv+fx0SkzYP40RjhNjiIEIIX6TCXKu2dpOIXorqK0U4ExBSG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063619; c=relaxed/simple;
	bh=h1nYm8NEPy7Smjifx3kUXv9T7YUzQH5JrPdypLWGo94=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OZoAXnA26PrtzO10XaJD0whXm9pc7S+2xQADeYipJxzRazhTwGW3vqch/wLZZsUYdx8AEF26zdQEPfEu4o7zCMOWUyuze1RO++nHf7PIJFN8VxRxowilYP/M3sO/bJZdgxH9RvpvfQ2y1r7iJK0h38USikZkosAqod8PSSsX8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0ZlecNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC44EC4CEC6;
	Fri,  4 Oct 2024 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728063619;
	bh=h1nYm8NEPy7Smjifx3kUXv9T7YUzQH5JrPdypLWGo94=;
	h=From:Date:Subject:To:Cc:From;
	b=q0ZlecNmg8esJ6sMtpBdjhdWiQzuHesZ3UCY5D+oMJqBW74tL8P/Q9CKhANiOmuk8
	 nzqI9/sAHGeE36uIVtvrD/pwhW3k3NrIP4cCfM3IJUpw8GZ8tXHFP0BEiZEAmtfTbr
	 uGg9OmC7dQQJcza85UuMialEzDG+7asu2B6D9xHPbPrmdKyDFgCUbX7Vwm7XlsxzhL
	 AkNu2gqR8gWlaSMSOAurtJgv4IXWn1UkLlNBDLDcY1Pj7SR2IjxjboYH8hzOdrYMhk
	 dY/ShjICaA5G7av05B1ti9JNyvOMYJu8RMCemFGzl/bgc75VtLXDZy3AqV/A6Op1LF
	 Uo+pjrq0hWhfg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e1c49f9b9aso990011eaf.2;
        Fri, 04 Oct 2024 10:40:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+rocu2+B5bHrRKp5jiBEidBudufZh4qW7WE0FUDS15YcdewBBKP0QVEbZr78c8EL8D3uz+OqvRE4=@vger.kernel.org, AJvYcCWpOsiQyUOWNUN9cZQLfTMOBMsfLPd4eyO3VsLaXA+1oiUXrzOSelurzwfP6zo/L34P+iWhvanYaYJKxKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGw9/kbO8EF2VNunC0xq3kTkySaoCozmbMEZThVr+eh6rUfJz
	LtABxdn0JrYs2Ahlnio3SA4dbqg6ZSXC7jkYJWjghjskDlNB2Z/kJTpKKYz8hjMRUb19GYBiM0C
	Q4wOWstFp+9mv2n8yfKFlh3DfYnE=
X-Google-Smtp-Source: AGHT+IH9+Wn4qVnoqyr7EuJuCz7EOG/6vxcUg31Lo2N8ui1LGyTQwA/opB8DrBW+WUb8Y5l80X+mG8jAlU4FTTjdNHw=
X-Received: by 2002:a05:6820:2283:b0:5e3:b6f9:1f8e with SMTP id
 006d021491bc7-5e7cc05c9dbmr2329688eaf.3.1728063618292; Fri, 04 Oct 2024
 10:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 19:40:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0izSML-nVycdK69DwRuqdixnvriqkMm2ZM1eYRiqddYMQ@mail.gmail.com>
Message-ID: <CAJZ5v0izSML-nVycdK69DwRuqdixnvriqkMm2ZM1eYRiqddYMQ@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.12-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.12-rc2

with top-most commit 3be5c171025baece9a0793170eb3b47ad08bf6c9

 Merge branches 'acpi-video' and 'acpi-battery'

on top of commit 9852d85ec9d492ebef56dc5f229416c925758edc

 Linux 6.12-rc1

to receive ACPI updates for 6.12-rc2.

These fix up the ACPI IRQ override quirk list and add two new entries
to it, add a new quirk to the ACPI backlight (video) driver, and fix
the ACPI battery driver.

Specifics:

 - Add a quirk for Dell OptiPlex 5480 AIO to the ACPI backlight (video)
   driver (Hans de Goede).

 - Prevent the ACPI battery driver from crashing when unregistering a
   battery hook and simplify battery hook locking in it (Armin Wolf).

 - Fix up the ACPI IRQ override quirk list and add quirks for Asus
   Vivobook X1704VAP and Asus ExpertBook B2502CVA to it (Hans de Goede).

Thanks!


---------------

Armin Wolf (2):
      ACPI: battery: Simplify battery hook locking
      ACPI: battery: Fix possible crash when unregistering a battery hook

Hans de Goede (5):
      ACPI: resource: Remove duplicate Asus E1504GAB IRQ override
      ACPI: resource: Loosen the Asus E1404GAB DMI match to also cover
the E1404GA
      ACPI: resource: Add Asus Vivobook X1704VAP to
irq1_level_low_skip_override[]
      ACPI: resource: Add Asus ExpertBook B2502CVA to
irq1_level_low_skip_override[]
      ACPI: video: Add backlight=native quirk for Dell OptiPlex 5480 AIO

---------------

 drivers/acpi/battery.c      | 28 +++++++++++++++++-----------
 drivers/acpi/resource.c     | 19 +++++++++++++------
 drivers/acpi/video_detect.c |  9 +++++++++
 3 files changed, 39 insertions(+), 17 deletions(-)

