Return-Path: <linux-acpi+bounces-4743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B089BD59
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74BD1C21D15
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CA85A0FA;
	Mon,  8 Apr 2024 10:36:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259958AB6;
	Mon,  8 Apr 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572582; cv=none; b=Mt3A5HWpcojEpEeu8UJtysxMWeqVsLQHmhYD8eFgzv1AAk64FIOy2A3AnZeBN5Ej+6/tXL3lDDYLJtBne3DwltiH6zKzagpkPkKonOLnUiE/ihntsJW94oASgNqAYp1Bb0a50x53SHZMtoN3FunB7L1gpJddoutWn/R7/bxVIGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572582; c=relaxed/simple;
	bh=deKK3P63sn6/PLUloI+/n2kyHiQ8mygbx/0lXN8v5aM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LhUFSppknSseVh3XxBxFsa+Xd1Z8DgIYtvo5jn3M56DT2ZfDm8qny4/WXrKzYsbR8ngJ3txqLCe0u3XK0gZb3TWFnGl6jzX0NKWa1vAHwcIR4KcFjXjE1uQ5AV/2qlavHKmDfSq4H8Ds0jbbx/miTl0WzW9t4j+VankK5pSQybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 233FA2F20243; Mon,  8 Apr 2024 10:26:45 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id C4E0A2F20226;
	Mon,  8 Apr 2024 10:26:42 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH v6.8.y 0/3 ]  ACPI: resource: Add IRQ override quirks (backport changes from v6.9-rc3)
Date: Mon,  8 Apr 2024 13:26:35 +0300
Message-Id: <20240408102638.197110-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support internal keyboard for the following models:

Asus ExpertBook (B1502CVA, B2502FBA),
Maibenben X565.

Successfully tested on the available Asus ExpertBook B1502CVA model.

[PATCH 6.8.y 1/3] ACPI: resource: Skip IRQ override on ASUS ExpertBook
[PATCH 6.8.y 2/3] ACPI: resource: Add IRQ override quirk for ASUS
[PATCH 6.8.y 3/3] ACPI: resource: Use IRQ override on Maibenben X565


