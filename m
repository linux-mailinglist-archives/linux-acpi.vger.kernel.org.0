Return-Path: <linux-acpi+bounces-11298-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D18FAA3C2BD
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 15:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47EC17A7E35
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7441E0B67;
	Wed, 19 Feb 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B89An83R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8F1DA4E;
	Wed, 19 Feb 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976853; cv=none; b=UEzFrVJ2cKsRmt3pDuCspFOb08GpuwABYaLyjBXIwrk6Twd9pi7Rt7B5Nk76YCibH4c6OqCyLZWgzLAM+N8HpbAQBWaBlpny9Kb5EZ37QPj1ThSshcUKl4XO2YbS0nCkVGFOBC/0NA4pDuUP+OQ0XPy0CeCdQ3GEL0KkACn1rz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976853; c=relaxed/simple;
	bh=MSq6yBJo3yHg7PBDYZXTGexU8eot07i54QeTk6CAKqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toQJ6CUXi+uKUgBrQGy7+yJpl3Fhzy2L/GhOeXuiwNixpLjKk3YyhwuKVDGY1ODkMfuxegcEZK9X27TCK8AldXxf5Qn5oNHgFQWkmCu4c+J3Rvaj5EyeRXCTZtIdJa4VQJH5ZqMynQoKXOd/fbJSAZuFjAL4KrF+KuIwfHOxqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B89An83R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722DBC4CEEA;
	Wed, 19 Feb 2025 14:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739976852;
	bh=MSq6yBJo3yHg7PBDYZXTGexU8eot07i54QeTk6CAKqU=;
	h=From:To:Cc:Subject:Date:From;
	b=B89An83RfeW5wi3feXB0svrA2D8D75G8MB4JmEwq8HcQ+4Z2WSglqsWTPkxjB0hM7
	 gOpfrhsQ8yAuMNeOeefqAH+gofl8u0srEqWbuHdYZRyrUFge9GFTlwRZKL4CKGUgje
	 7wNypb5wQpheTQybd/mF8DLF6mji0vzGkUAEFbtm3TVrslCclGnGBplZnpdv3yBPDK
	 JX4oXx7qxpvINa0RXCbWhU7DmYE+ZAjTD4URbiphZj5elT+K73M7QEQ4W/N5QNKroa
	 VndNRToX2ldVyz/ptaYZBSNtb0MSnXdxumYT/ukhRtSZyGLS4t48JQcKSq9vLzxzaO
	 J9DF5a6KSZlUQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	Basavaraj.Natikar@amd.com,
	linus.walleij@linaro.org,
	rafael@kernel.org,
	Shyam-sundar.S-k@amd.com
Cc: linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2 0/2] Add LPS0 check() for pinctrl-amd
Date: Wed, 19 Feb 2025 08:53:11 -0600
Message-ID: <20250219145338.3306745-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

During suspend the pinctrl_amd driver disables the interrupts for
any GPIOs that are not marked as wake sources.

This however does not prevent them from changing the wake status
bit during suspend, it just stops the system from waking.

If the system wakes from hardware sleep for another reason (such
as plugging in the AC adapter) this wake bits might be active.

This could potentially cause problems with going back to hardware
sleep.  Add an extra debugging message when PM debugging is enabled
to help identify if this is happening.

Mario Limonciello (2):
  ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
  pinctrl: amd: Add an LPS0 check() callback

 drivers/pinctrl/pinctrl-amd.c | 28 ++++++++++++++++++++++++++++
 include/linux/acpi.h          |  7 +++++++
 2 files changed, 35 insertions(+)

-- 
2.43.0


