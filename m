Return-Path: <linux-acpi+bounces-849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE517D3F66
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAC61C20A38
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53859219F0
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ho/NcSpk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EB21340
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 18:11:07 +0000 (UTC)
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E5ED6
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 11:11:03 -0700 (PDT)
Received: from localhost.localdomain ([89.207.171.96])
	by smtp.orange.fr with ESMTPSA
	id uzOEqlElA4FJ9uzOGqZu8v; Mon, 23 Oct 2023 20:11:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698084661;
	bh=t7dPTH86r3T7OE/Hsg6Sc2j1I/GQSk2tQP+zV+h/AG8=;
	h=From:To:Cc:Subject:Date;
	b=Ho/NcSpkN8htKg6u6eVgDyHecadbEki5RmVTf/e27i+9rzkCus3f+UCfSS9goXEH/
	 MtS56RnTgk9JiDkz5CF1PwQLwCcxaQ+QLVZnyRQTilGPwgN+7w2QHiLjrfsqUB7syG
	 4Rrn30bBmAOIbOoz89SbcM6iUj083q/XjFtHPQAYK+6nEJWrp4Wsqed1Yk1LBgCvuT
	 kooGzg8yEpkDajDH9H9kYqCzzmZ00AFIRftwkDe3oCYqpTM+zsS4pkMgADoWSH2PAV
	 1OECd7Ue4fxwdV2O8Y/j2EuTDNZ7vK5l+d8VVAt85PcUa8pW++df+qvAjg2EUFFGAe
	 uU6q1rt1ytUZA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Oct 2023 20:11:01 +0200
X-ME-IP: 89.207.171.96
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4] ACPI: sysfs: Fix some issues in create_of_modalias() and create_pnp_modalias()
Date: Mon, 23 Oct 2023 20:10:52 +0200
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


