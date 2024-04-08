Return-Path: <linux-acpi+bounces-4719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8253D89BD1B
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2EE282B81
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A79B535C8;
	Mon,  8 Apr 2024 10:29:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3338537E0;
	Mon,  8 Apr 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572188; cv=none; b=H+fpqbonmljyESBJscpAi9/t34xrDjFHcVTE4JkZxm53f4KYqSj6uN0gmNeoxSCaV3bt9ONYMXFw1FR9zAUBEl5OwGNI9FaBBJ5GQdZ/kIduv/BXSLKxxActAN2iVVsfkLBSUwiaiC3vS7gY6XU1w1IYg7+qqGMSOPfBMOwj6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572188; c=relaxed/simple;
	bh=7+KDPDrv6MWgHzFNzPBvQYxYwvdq/wuIhwiKmPPcUyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GqXqES5GNpUAR8gM8aZJclHhl1QQ4U0ZjJxhkyiRdvDM6P7gh7/qg+DeOpNQO/PvtoEqp3l9Crk3OKd/e7AbmGtAkufg1+gHKZ8e8lsBNLPPJrTU480lKFRDSA0Jb0tAmDMUTkH2QDD8agzsczVG74BbHLp4iUu9lzYW9gfwYPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id C6D9D2F2024C; Mon,  8 Apr 2024 10:29:44 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 935F92F2022C;
	Mon,  8 Apr 2024 10:29:42 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH v6.6.y 0/7 ]  ACPI: resource: Add IRQ override quirks (backport changes from v6.9-rc3)
Date: Mon,  8 Apr 2024 13:29:33 +0300
Message-Id: <20240408102940.197282-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support internal keyboard for the following models:

Asus ExpertBook (B1502CGA, B1502CVA, B2502FBA),
Asus Vivobook (E1504GA, E1504GAB),
Maibenben X565.

Successfully tested on the available Asus ExpertBook B1502CVA model.

[PATCH 6.6.y 1/7] ACPI: resource: Consolidate IRQ trigger-type override DMI
[PATCH 6.6.y 2/7] ACPI: resource: Drop .ident values from dmi_system_id
[PATCH 6.6.y 3/7] ACPI: resource: Add DMI quirks for ASUS Vivobook E1504GA
[PATCH 6.6.y 4/7] ACPI: resource: Skip IRQ override on ASUS ExpertBook
[PATCH 6.6.y 5/7] ACPI: resource: Skip IRQ override on ASUS ExpertBook
[PATCH 6.6.y 6/7] ACPI: resource: Add IRQ override quirk for ASUS
[PATCH 6.6.y 7/7] ACPI: resource: Use IRQ override on Maibenben X565


