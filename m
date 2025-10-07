Return-Path: <linux-acpi+bounces-17645-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362B3BC137E
	for <lists+linux-acpi@lfdr.de>; Tue, 07 Oct 2025 13:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B60C1894003
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED46223DFB;
	Tue,  7 Oct 2025 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in8sbfq3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0061D54FE
	for <linux-acpi@vger.kernel.org>; Tue,  7 Oct 2025 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836737; cv=none; b=ElTP4j9JayXPmKqNyHn7pYB2K99qsK5KSPxg6zUCYaLxCLZW1YqtLQh8mGIAPPF1b+mUUBXxOp+P6AhotwcpwupCF9+uzu8MWL2pASsFjkKfz3qFp9XPlBDOGYhx9m//q8EdFOR5PAs8Erp715bFExJ4P6Uzb+2g0I56c1JcqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836737; c=relaxed/simple;
	bh=K2SLCERJg8GATRL03Frwnf95lX+xUj/t+ur2Sjhkbkg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L2PEh/OusWbRU2X28HxUbUv363gYcqqyi02mrRE0vKDKhiqlaGtZ1W0rw85DM2sUZJOvNJm3fHGFkUroNVGDV+Sgyjn4QyKJUrV9J/V40QJ3mlNeZv+ucXyECYYP9dzN5vjD7ubPe3LeDJu1KuO9mZqJqSMGZnV9Equ+w/h6qZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in8sbfq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2EBC4AF09
	for <linux-acpi@vger.kernel.org>; Tue,  7 Oct 2025 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759836736;
	bh=K2SLCERJg8GATRL03Frwnf95lX+xUj/t+ur2Sjhkbkg=;
	h=From:Date:Subject:To:Cc:From;
	b=in8sbfq3NgkuPT15ONH9uKN/ThZHjPiyAC7Uli3QjqYeNSJMEzSO9EPoj47LHn8y6
	 KyZheDnaTXPXMkgOLvNNtPNzerzP8lXFj/o7bnJ2wwfLSzN0qnzHlN0M4EUXdi5otH
	 Ph+HTs9tjGr9dE9HG3Q0T3D8hXSqyc8rixGM7AftXhi7siKJ2ptNhNFmo5l9L/EA3a
	 ReKMMQZ2TagRut+CSCbbw1J/OcUZr23lsUBYxIne1C/IpEfS+Es/th6OgdozeYlIhH
	 5OL4ehcQlb6qJSbm82AXsVB8Yc6bNXq3qCJZxn3TG00HlkQK0vSQU0qMbbqKOef1ci
	 SXHz5BkseLDyg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-43f64a5014aso3146128b6e.1
        for <linux-acpi@vger.kernel.org>; Tue, 07 Oct 2025 04:32:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx8Wf8y9qEGb3UXxaS2GJMbr/LDRAT4wRqMtFIJBJVV7uvkxV0Z
	FM9BqfM9NW2QwI/6vRHhb4RP05A2swKJcLC/o1ks1MqOC/wLH3n3bv8y1T9EHpHXTJrhlm4BqHV
	sWtfkUoFPYqx7d/bMpEbOTk0cyNE4adE=
X-Google-Smtp-Source: AGHT+IEXfQbSOAk2h/cZkQqJyZZCOIDMY2QXaQX4f5p5CvC466b9POcQG0v+QahF1fEkfQDoN0s+eX8ym/qatiQ4w9w=
X-Received: by 2002:a05:6808:144b:b0:43f:6f82:e16f with SMTP id
 5614622812f47-43fc178f8bamr8548033b6e.12.1759836736225; Tue, 07 Oct 2025
 04:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Oct 2025 13:32:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gb7Rvd_nOd5Z2r95WsenmWb-YZOSLW804+Nif0o+mZJA@mail.gmail.com>
X-Gm-Features: AS18NWDeJ8lC0jPNWuHr6YiSuK8oeCnM7YWSWNSelq2FFOjpj_2GKDMfKyghaH4
Message-ID: <CAJZ5v0gb7Rvd_nOd5Z2r95WsenmWb-YZOSLW804+Nif0o+mZJA@mail.gmail.com>
Subject: [GIT PULL] More ACPI support updates for v6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.18-rc1-2

with top-most commit dd68fd72e516d57e7f2e502113c9345a3bc277db

 Merge branches 'acpi-x86', 'acpi-battery', 'acpi-apei' and 'acpi-property'

on top of commit 679a16399af08088a83e1d30e01c31832f055ae7

 Merge tag 'acpi-6.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI support updates for 6.18-rc1.

These fix a driver bug, clean up two pieces of code and improve the
fwnode API consistency:

 - Add missing synchronization between interface updates in the ACPI
   battery driver (Rafael Wysocki)

 - Remove open coded check for cpu_feature_enabled() from
   acpi_processor_power_init_bm_check() (Mario Limonciello)

 - Remove redundant rcu_read_lock/unlock() under spinlock from
   ghes_notify_hed() in the ACPI APEI support code (pengdonglin)

 - Make the .get_next_child_node() callback in the ACPI fwnode backend
   skip ACPI devices that are not present for consistency with the
   analogous callback in the OF fwnode backend (Sakari Ailus)

Thanks!


---------------

Mario Limonciello (AMD) (1):
      x86/acpi/cstate: Remove open coded check for cpu_feature_enabled()

Rafael J. Wysocki (1):
      ACPI: battery: Add synchronization between interface updates

Sakari Ailus (1):
      ACPI: property: Return present device nodes only on fwnode interface

pengdonglin (1):
      ACPI: APEI: Remove redundant rcu_read_lock/unlock() under spinlock

---------------

 arch/x86/kernel/acpi/cstate.c |  2 +-
 drivers/acpi/apei/ghes.c      |  2 --
 drivers/acpi/battery.c        | 43 +++++++++++++++++++++++++++++--------------
 drivers/acpi/property.c       | 24 +++++++++++++++++++++++-
 4 files changed, 53 insertions(+), 18 deletions(-)

