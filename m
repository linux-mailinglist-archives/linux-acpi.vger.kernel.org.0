Return-Path: <linux-acpi+bounces-6839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B528892CFF5
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 13:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7994228478B
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0359190046;
	Wed, 10 Jul 2024 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uODWxSlq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4C18FC6F;
	Wed, 10 Jul 2024 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609218; cv=none; b=accq3j0/NQrNXmliaJGhaOjGoESpjC0uOXLQcAs4q20IEpgIdW1NmoZMvCVwdyVDj4t+G/O9NNhAFQ97X51RLB6xQX3SQ/RB6fmGU5RanfQ2K7DPfPJYRiMTTv+5KGSfdMa9SxzYYYp1S8vbQ0T4I8BupY0238oj6TdgaYRJecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609218; c=relaxed/simple;
	bh=blXk7Gxiy6zi/s23hPWH2LpaDxyx5UH/W2Mvnjfpj8E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LKk970Dzw9XsT5VRn+IYcJic64gxTXpVV2e4LHJmaei0M0llUAFpvAl2pyJSB2MfrPp/Io3T7dK5082C71Np2bKZnJpcLKRJhPyxr+hQS5HoSuyqtVun+4SP+DxqI+qnTS3sBYC4A4uOLrXD6b3QqtMrOJIDqe5cgNWWJggdxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uODWxSlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37131C32781;
	Wed, 10 Jul 2024 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720609218;
	bh=blXk7Gxiy6zi/s23hPWH2LpaDxyx5UH/W2Mvnjfpj8E=;
	h=From:Date:Subject:To:Cc:From;
	b=uODWxSlqjp1Mx29eQoZuRNfBPSzzgGAnktNC5o0kPaU2KvZ7VYAbaJ6XiCK4gPkPV
	 kf3m7eVDpvXpDjqr1GRY5OIEKJJU95/oNCd/w5nAwU9+E/U1eOGvsbBD/6fdg4j0HL
	 icO+kq1JyasExYr5s2dBKcyeUEJw/TB+OzcZ4a7fBpnP3YLFxAagEMyRw05Vcp72b3
	 6+A3H9ERiL1AKveP8DUgPU3N+NrXRxnLXkJWOYhk/WzpuUQd4H+egD6cGgLxsI7cLZ
	 0GUZDqVuJewd8cvWhxai/Bt8896UlNhuubyPLRO4wO2sbOy79CKjF8WhUs04ymoxKs
	 vI2sx+q0jwUsA==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d9dd8bc70dso25909b6e.2;
        Wed, 10 Jul 2024 04:00:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXY5BXKnV5XkyrwANOPBcMPdkC6m5b2KbePPzlZwkA97bCQPN+KRc6S2asE+dcPwA3AMKQo/pxt5icEv9GjFeorouWJZNbwPMuU/TCbYYea5AtA7WdjZS7F9ESbDuMSL+wNXlK6Vhs=
X-Gm-Message-State: AOJu0YxPk0QDP+beo14Iwfwl1x4fbyuFm2Ae17rCx55X89A+2mhC5KbV
	6czU3dIudsQGulwOivJrCMJUVET876pLHmUH091Pa/lp6/3JgeXc8CZLpZKcCHGsmMIpaHXTlhC
	AgYzoAALqxrppPCSwRpG1ZrPoReA=
X-Google-Smtp-Source: AGHT+IF4AJKvQ7FDe5vrNSw8ZG2GzVgfnY/oRHUXDz+U6RuTk7i8BTMvdVpzs4jA4w/bDAzoOqFFH/FjMDgJTxiN1m0=
X-Received: by 2002:a05:6870:8194:b0:25e:24d5:4d69 with SMTP id
 586e51a60fabf-25eae7caf98mr5643893fac.2.1720609217504; Wed, 10 Jul 2024
 04:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jul 2024 13:00:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iDKW7jLS=mD3dGqAdh8SuNsCe6Eq83DRoCEY5ATseG4A@mail.gmail.com>
Message-ID: <CAJZ5v0iDKW7jLS=mD3dGqAdh8SuNsCe6Eq83DRoCEY5ATseG4A@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.10-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.10-rc8

with top-most commit 233323f9b9f828cd7cd5145ad811c1990b692542

 ACPI: processor_idle: Fix invalid comparison with insertion sort for latency

on top of commit 22a40d14b572deb80c0648557f4bd502d7e83826

 Linux 6.10-rc6

to receive an ACPI fix for final 6.10.

This fixes the sorting of _CST output data in the ACPI processor idle
driver (Kuan-Wei Chiu).

Thanks!


---------------

Kuan-Wei Chiu (1):
      ACPI: processor_idle: Fix invalid comparison with insertion sort
for latency

---------------

 drivers/acpi/processor_idle.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

