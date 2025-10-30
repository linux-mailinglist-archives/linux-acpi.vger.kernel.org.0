Return-Path: <linux-acpi+bounces-18385-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85AC221A6
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 20:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAAE3AF013
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 19:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441A33374F;
	Thu, 30 Oct 2025 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aifjOcy5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2EC333445
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854336; cv=none; b=M8ImYfH2NaJQgIPPBPHtUa9CH6BlkFSi8Oew4e/4XAYDdHRUCJl92CvEEkC1d68uLvGBpProjOXdpZQaAYmEjUqnmpTvk9vQG1F9w1ShlXH5zcHXqxrTqWVZ/JPxIXiq9BlUAOmyk8IY7nMkp1pshrJ2KB2bafcsIsTjoZ9B8bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854336; c=relaxed/simple;
	bh=27Bt+XohUsCY6jPuadnGJYHmq2UygEPw3QOYlngYMe0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZPiV1UZwrAna705Wk3ZQu9S4LYsbG41C5r6Bw95uPr+H5WhqU8/zplqvGPB5HX1n24tqqx99XKr0kYPE+peIC0C70Tx3GhV99TqEdvrtgcL91ZlLIn0jCZ24qkLGTY3yjAIN+pZorPqG9zhPaJERE0lWWsr39jZNlRNkc+trHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aifjOcy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5634EC4CEF1
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761854336;
	bh=27Bt+XohUsCY6jPuadnGJYHmq2UygEPw3QOYlngYMe0=;
	h=From:Date:Subject:To:Cc:From;
	b=aifjOcy5p31rA4UaJkpaf61qn0EzeV7pjNxuprvvXuySfZHVhGmrHq6aAWud1w/q0
	 KjH8TtVkGCJUkahZrzDzxJDzK0pDjfQ5yOWK60SGWUAKHCVIy852/Ypep8uV9vDZf9
	 pWlFSM5cdF0XVmq5t3a4kN7f43T6PS8f08esYKOZGaQ6FueX3gPFPtsYxUMxcY5OVK
	 cD3R0ENYLDaCSVA8DU1YdPvBMfYFEYfbDbo6+obmfHV5Z92x3hHtFJH4s3O5os/2PV
	 aPrba+vxKzWBIOgGEfOstK9IpMrsuMK6hI38vrFWg4bPxk5UUTnCXvj00olv6iA7su
	 qqaSiYY8R508Q==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-373b7e07182so959013fac.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 12:58:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx1EoRIu3tlHEFvCuaqJ6kAiYBtFoEB+TbP1TswBM2je7nq4iqW
	whxSsHmjchyZRNVTRav7kWW8CHzQWxCpmwOCfOKi/npQyZc7X46TIEfd4B2utabtZ1AC57c4i94
	74DzjVkTPU4YJXWqJUmoJWNaj8MPir8Q=
X-Google-Smtp-Source: AGHT+IG3Lr6fvBnfKNJvXTlqKqqyJFVgcQM1Ir5oNAP54/iFD1uFwuwIGNg2P27LmaSU/D7Xbc6eAsFKXBttWKKDO0c=
X-Received: by 2002:a05:6808:2f1b:b0:43f:1daf:dad6 with SMTP id
 5614622812f47-44f95fe10demr480804b6e.49.1761854335647; Thu, 30 Oct 2025
 12:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 20:58:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gWU1sKjFQMcnhP17F4h6HbeX3Fvw4GQDqd6zbQknD4VQ@mail.gmail.com>
X-Gm-Features: AWmQ_bns_GLKZyutIK1RZWaosqCZigZYk56k68y3_xnWg2bKlpCF1jjtmgftj0o
Message-ID: <CAJZ5v0gWU1sKjFQMcnhP17F4h6HbeX3Fvw4GQDqd6zbQknD4VQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.18-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.18-rc4

with top-most commit 8907226bed1ebd10d069f6f70ff0aaa8840f3267

 Merge branches 'acpi-button', 'acpi-video' and 'acpi-fan'

on top of commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa

 Linux 6.18-rc3

to receive ACPI fixes for 6.18-rc4.

These fix three ACPI driver issues and add version checks to two ACPI
table parsers:

 - Call input_free_device() on failing input device registration as
   necessary (and mentioned in the input subsystem documentation) in the
   ACPI button driver (Kaushlendra Kumar)

 - Fix use-after-free in acpi_video_switch_brightness() by canceling
   a delayed work during tear-down (Yuhao Jiang)

 - Use platform device for devres-related actions in the ACPI fan driver
   to allow device-managed resources to be cleaned up properly (Armin
   Wolf)

 - Add version checks to the MRRM and SPCR table paresers (Tony Luck and
   Punit Agrawal)

Thanks!


---------------

Armin Wolf (2):
      ACPI: fan: Use ACPI handle when retrieving _FST
      ACPI: fan: Use platform device for devres-related actions

Kaushlendra Kumar (1):
      ACPI: button: Call input_free_device() on failing input device
registration

Punit Agrawal (1):
      ACPI: SPCR: Check for table version when using precise baudrate

Tony Luck (1):
      ACPI: MRRM: Check revision of MRRM table

Yuhao Jiang (1):
      ACPI: video: Fix use-after-free in acpi_video_switch_brightness()

---------------

 drivers/acpi/acpi_mrrm.c  |  3 +++
 drivers/acpi/acpi_video.c |  4 +++-
 drivers/acpi/button.c     |  4 +++-
 drivers/acpi/fan.h        |  7 ++++---
 drivers/acpi/fan_attr.c   |  2 +-
 drivers/acpi/fan_core.c   | 36 +++++++++++++++++++++++-------------
 drivers/acpi/fan_hwmon.c  | 11 +++++------
 drivers/acpi/spcr.c       |  2 +-
 8 files changed, 43 insertions(+), 26 deletions(-)

