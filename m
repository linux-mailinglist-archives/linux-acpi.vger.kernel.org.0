Return-Path: <linux-acpi+bounces-848-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C617D3F65
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FA11C20A2E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6534C97
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MFBZI8p7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D91CF80
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 17:32:19 +0000 (UTC)
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 10:32:16 PDT
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B888310DB
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 10:32:16 -0700 (PDT)
Received: from localhost.localdomain ([89.207.171.96])
	by smtp.orange.fr with ESMTPA
	id uyfSqiNV2aLS1uyfTqByU0; Mon, 23 Oct 2023 19:24:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698081884;
	bh=t7dPTH86r3T7OE/Hsg6Sc2j1I/GQSk2tQP+zV+h/AG8=;
	h=From:To:Cc:Subject:Date;
	b=MFBZI8p7FmZLlPFCzeqUapweAH47vcCK4oyUBogCqv7EhD1XnR6I6QzcFo4tbNaM/
	 9WoAIH9zWCABgwlyw+DoowNcv/UinyDoP2xX86rAW77+CpXkm6NCGxaBmrHi+t02W0
	 qeh4Ax+YLsbjbn2Pc3gqcgu60E+eySej/jW/0rKCUhEcrCCywNj8RS2QgOjXdptSkz
	 syd+ioJdbyJRyBluDc3kBs7PIoC1ScZYf137hks9+/XjQcboh4MP1dLRwA06HkKc7S
	 6Vx+Rg552JZnrz1IrgcHC3ocgZXZGNCq2GiHYAZRkQDdrVYfzm2tK5d1qjMPL0cmyV
	 YNOkBT5NZZB2A==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Oct 2023 19:24:44 +0200
X-ME-IP: 89.207.171.96
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4] ACPI: sysfs: Fix some issues in create_of_modalias() and create_pnp_modalias()
Date: Mon, 23 Oct 2023 19:24:37 +0200
Message-Id: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All issues have been introduced by the same commit, 8765c5ba1949 ("ACPI
/ scan: Rework modalias creation when "compatible" is present")

The first 2 patches fixe some issues related to string truncation checks
and to computation of the available space in the output buffer.

The 2 others are just some clean-ups.

Christophe JAILLET (4):
  ACPI: sysfs: Fix the check for a potential string truncation
  ACPI: sysfs: Fix a potential out-of-bound write in
    create_of_modalias()
  ACPI: sysfs: Remove some useless trailing NULL writes
  ACPI: sysfs: Remove some dead code

 drivers/acpi/device_sysfs.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.32.0


