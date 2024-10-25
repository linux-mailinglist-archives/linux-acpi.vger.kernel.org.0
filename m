Return-Path: <linux-acpi+bounces-8964-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D469B08EB
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 17:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280721F23720
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5F16F824;
	Fri, 25 Oct 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOWkqLCt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE3167D80;
	Fri, 25 Oct 2024 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871541; cv=none; b=TpnlVyBCCZAInoEdOuS59M4VAL+fFb3q/ah6EHqPHHaI3XoVDq/kQv2xQsSHr4hObeG7ypxxIxojGTsmaGBMNqjU9pTqkXFNSvgkNX1UELBZqr8MWb2Kye83noPQZpFMjUkE/KP8TLzVSl+HFxpo+qO+MY9tpnWHA1FFgAUNJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871541; c=relaxed/simple;
	bh=kHyxwzFhn/mibEYLRBBTW9rb0KWPTWyrIkFj4ZBlYrQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n9OYHrmLxhv7V+WFYcv81SQnm8qvfSJ2CJwS10fr+NHKKOpcMVy9QD/NV/98dYma8VM//ZTVX83kS6t7yZch2NEvYGBD4qZCkWykLZDWEbIrhD3AM/CzHM/zT6e/NP6OvzBNJ6J/8h4x952n0hUyBPCl6XOnsqUkprQVFhPkJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOWkqLCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA9AC4CEC3;
	Fri, 25 Oct 2024 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729871540;
	bh=kHyxwzFhn/mibEYLRBBTW9rb0KWPTWyrIkFj4ZBlYrQ=;
	h=From:Date:Subject:To:Cc:From;
	b=qOWkqLCtqf/VBVL2nWTwUsAHugi5p7IIzeKYiz6XBjImBxwx7Rltu5XTOAyfbawd8
	 rupuBbmB+/2B6//LxVxRhGj5fheWT2DRZ/VH6SYRnDMzq2RyAfDMwRwGhOIzS1VJjk
	 H6qv57RmMv8A3p/RulUPv8tcQJIvJ7uMPMq2ZCU3YL6IhVr78sPbq16DHdBbh67Z89
	 zc2WEXdZnu2USBZdicCIZqMum4PiOspkCjCuhZAMXKdvT6QQetQs6LNmUsFPORsQ1T
	 U87w6uqc6uB/3MUpgp9vc3Xr3HsAxL2fGsmClADv0XeTcKNMPLhuPf/55N8LUNaljs
	 Za/X4r/qGpoxg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2884e7fadb8so1196530fac.2;
        Fri, 25 Oct 2024 08:52:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8s0zQ2wygsSuUWOg1A/mjV1R40mI2wMvPbu8jLH9++IE/H/VSnuthRv/Yx9o5Hs53ekzXhRNDZwPTT7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmCj6TuX0vwKuQHtf5KtBHy1V2oq2VovKxyh9/pC5BEMMJSij
	sdIy9Grhcq9fGY2f+hvnDv0IosnFa/h2lTt1ghYl4wfG+KooTPBKOpTtJ+c43n347Hig/Ua8piV
	SC4p0pEzAr4JSoOphfgibCqWf9oY=
X-Google-Smtp-Source: AGHT+IEfba0P9jTv5MINR9xdItFXkn01wsaMY8Xrns5b6161KAt1PdKXeHiK8AQiLJJbkOUJXbtRMWprJFg6/Ya8X7Y=
X-Received: by 2002:a05:6871:289:b0:25e:24a0:4c96 with SMTP id
 586e51a60fabf-28ccb7f39e7mr10728770fac.11.1729871539869; Fri, 25 Oct 2024
 08:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Oct 2024 17:52:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gqmA1PgKKhmZzBj0vBe4giC-wqxbdV-YrwOvnSELWuAw@mail.gmail.com>
Message-ID: <CAJZ5v0gqmA1PgKKhmZzBj0vBe4giC-wqxbdV-YrwOvnSELWuAw@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.12-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.12-rc5

with top-most commit 54774abb5549c619909b5c3e2605bc643e83d9a7

 Merge branches 'acpi-resource' and 'acpi-button'

on top of commit 42f7652d3eb527d03665b09edac47f85fb600924

 Linux 6.12-rc4

to receive ACPI updates for 6.12-rc5.

These fix an ACPI PRM (Platform Runtime Mechanism) issue and add two
new DMI quirks, one for an ACPI IRQ override and one for lid switch
detection:

 - Make acpi_parse_prmt() look for EFI_MEMORY_RUNTIME memory regions
   only to comply with the UEFI specification and make PRM use
   efi_guid_t instead of guid_t to avoid a compiler warning triggered
   by that change (Koba Ko, Dan Carpenter).

 - Add an ACPI IRQ override quirk for LG 16T90SP (Christian Heusel).

 - Add a lid switch detection quirk for Samsung Galaxy Book2 (Shubham
   Panwar).

Thanks!


---------------

Christian Heusel (1):
      ACPI: resource: Add LG 16T90SP to irq1_level_low_skip_override[]

Dan Carpenter (1):
      ACPI: PRM: Clean up guid type in struct prm_handler_info

Koba Ko (1):
      ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context

Shubham Panwar (1):
      ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix
initial lid detection issue

---------------

 drivers/acpi/button.c   | 11 +++++++++++
 drivers/acpi/prmt.c     | 29 +++++++++++++++++++++++------
 drivers/acpi/resource.c |  7 +++++++
 3 files changed, 41 insertions(+), 6 deletions(-)

