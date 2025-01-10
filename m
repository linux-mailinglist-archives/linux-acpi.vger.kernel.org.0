Return-Path: <linux-acpi+bounces-10524-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD3A09CD9
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 22:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2993D188E3A5
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8991208965;
	Fri, 10 Jan 2025 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0xUpFeL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A32080DA;
	Fri, 10 Jan 2025 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736543672; cv=none; b=EjkBBy8zOBqBAWqY0xRYSSg21n42rJYwPKjoqSjLfUg7uZ1e349Z+2zqkVMbI5aNrRR4F4LyKDOlYefeJgxyjqzMFoGpEYy++crX22JPWEkZMsJQj41FJgKiIwsw5xyZtHbPmcnqT1fn9J/8bBSsuy/6bjfX7t1j+wrdDQNvLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736543672; c=relaxed/simple;
	bh=7hnTzDn30AqAgjejvXh5GiTjCJT28fwcQtwUBt9EVFs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Hah18CH1shsmCl02QCYAnqGXqG79nV0c/8IJE1OQBveE+cBqj3hWPjTdUiVdYI6F6KZH12LpIzqDDw8rrLd9t9Kc6PwbiCb6xM6L5lax/Ntpy4QSKnHma/SQuxxEmd9oZMR5X7cFn/sBhFjz/9lA0mKpSsZdJX0Ak2qSz6/6cbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0xUpFeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B92C4CEDD;
	Fri, 10 Jan 2025 21:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736543672;
	bh=7hnTzDn30AqAgjejvXh5GiTjCJT28fwcQtwUBt9EVFs=;
	h=From:Date:Subject:To:Cc:From;
	b=o0xUpFeLjgv3Ot2fd11PeCfYDLeVFk34zpAY/M6W7GpsMpuTcfSwZFoAacFjfTzvn
	 h9ep2JB9FRg1wGidL+kS+no2W+2jwEjiCdtf6vL2SGyfrMZ/hWfmmoFGF+4oMEIw9V
	 2StBTBK5TTbprtlTre0LDTT68PkdGg/Wbk6aEtjb3j22bEfXNypw7DtGtjlHwd0Iec
	 f+HA/exkKNvdj2BiEktuKmqm/X0DAYiirTuTjopAmURrCW1T8tqyQqGvfMZ7SmNhsm
	 efTHH1+Ul0pC21nk61v1LxNyePH3pjjL9RqFvfY+9bYKp897b2Z/2JSKrFb8aSgmRR
	 Js2WzLPGoL24Q==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29e149aff1dso792616fac.1;
        Fri, 10 Jan 2025 13:14:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+imWwjdJN4HBikciK8ipCmGeeIn6L7JaS1L5E7l1tQpu8Zf+jMH4N5yLFcJUa7l5a2xxemjw8yssO9Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCdWyWzm0vEIYKCtK15ERqY0lzfDoKshDgr/UFBxf9pjzG0rP
	HNe8y52XUtEf4Mgq17D+wGtmCmunQRLxgj6jiaF8GE0kg/K6gTlDam6XQ+FVRlEsKkP+OFhvPGe
	0cOTCIKw7yvZ7Y7Zti88LyYWLyTE=
X-Google-Smtp-Source: AGHT+IFSkBaR9Q3GScDFKtAyaOc2jOPiVOeXflBNmF6jo2hYdFoHAjPafuzpzfee4Kl4zfQJE0J6OG5nlIdAKgccczY=
X-Received: by 2002:a05:6871:2084:b0:29e:4578:5f74 with SMTP id
 586e51a60fabf-2aa0665bd45mr6932494fac.4.1736543671516; Fri, 10 Jan 2025
 13:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Jan 2025 22:14:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iDiC=NnXKBWt=Cx2jWr_Ke7M6Gfe-h3KXFvZPziDveCw@mail.gmail.com>
X-Gm-Features: AbW1kvaLs4IYDNARMD1OpJ5LV9u0NpBkj8iOyntHu4KEkhGAcCSMqdomQsmXxNM
Message-ID: <CAJZ5v0iDiC=NnXKBWt=Cx2jWr_Ke7M6Gfe-h3KXFvZPziDveCw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.13-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.13-rc7

with top-most commit cd4a7b2e6a2437a5502910c08128ea3bad55a80b

 ACPI: resource: acpi_dev_irq_override(): Check DMI match last

on top of commit 9d89551994a430b50c4fffcb1e617a057fa76e20

 Linux 6.13-rc6

to receive ACPI fixes for 6.13-rc7.

These add two more ACPI IRQ override quirks and update the code using
them to avoid unnecessary overhead (Hans de Goede).

Thanks!


---------------

Hans de Goede (3):
      ACPI: resource: Add Asus Vivobook X1504VAP to
irq1_level_low_skip_override[]
      ACPI: resource: Add TongFang GM5HG0A to irq1_edge_low_force_override[]
      ACPI: resource: acpi_dev_irq_override(): Check DMI match last

---------------

 drivers/acpi/resource.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

